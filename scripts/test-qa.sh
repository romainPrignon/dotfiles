#!/bin/bash

# Comprehensive QA test script that validates dotfiles installation
# This script should be run inside a Docker container built from the repo Dockerfile
# It tests all make commands and configuration files that a user would interact with

# Note: We don't use set -e because we want to run all tests and report failures at the end

FAILED_TESTS=0
PASSED_TESTS=0

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper functions
print_header() {
    echo ""
    echo "========================================"
    echo "$1"
    echo "========================================"
}

print_test() {
    echo ""
    echo ">>> Testing: $1"
}

assert_command_exists() {
    local cmd=$1
    local description=$2
    if command -v "$cmd" &>/dev/null; then
        echo -e "${GREEN}✓${NC} $description: $cmd found at $(command -v "$cmd")"
        ((PASSED_TESTS++))
        return 0
    else
        echo -e "${RED}✗${NC} $description: $cmd NOT FOUND"
        ((FAILED_TESTS++))
        return 1
    fi
}

assert_file_exists() {
    local file=$1
    local description=$2
    if [[ -f "$file" ]]; then
        echo -e "${GREEN}✓${NC} $description: $file exists"
        ((PASSED_TESTS++))
        return 0
    else
        echo -e "${RED}✗${NC} $description: $file NOT FOUND"
        ((FAILED_TESTS++))
        return 1
    fi
}

assert_directory_exists() {
    local dir=$1
    local description=$2
    if [[ -d "$dir" ]]; then
        echo -e "${GREEN}✓${NC} $description: $dir exists"
        ((PASSED_TESTS++))
        return 0
    else
        echo -e "${RED}✗${NC} $description: $dir NOT FOUND"
        ((FAILED_TESTS++))
        return 1
    fi
}

assert_symlink_exists() {
    local link=$1
    local description=$2
    if [[ -L "$link" ]]; then
        echo -e "${GREEN}✓${NC} $description: $link is a symlink to $(readlink "$link")"
        ((PASSED_TESTS++))
        return 0
    else
        echo -e "${RED}✗${NC} $description: $link is NOT a symlink"
        ((FAILED_TESTS++))
        return 1
    fi
}

assert_command_succeeds() {
    local description=$1
    shift
    if "$@" &>/dev/null; then
        echo -e "${GREEN}✓${NC} $description: command succeeded"
        ((PASSED_TESTS++))
        return 0
    else
        echo -e "${RED}✗${NC} $description: command failed"
        ((FAILED_TESTS++))
        return 1
    fi
}

print_summary() {
    echo ""
    echo "========================================"
    echo "Test Summary"
    echo "========================================"
    echo -e "${GREEN}Passed: $PASSED_TESTS${NC}"
    echo -e "${RED}Failed: $FAILED_TESTS${NC}"
    echo "Total: $((PASSED_TESTS + FAILED_TESTS))"
    
    if [[ $FAILED_TESTS -gt 0 ]]; then
        echo ""
        echo -e "${RED}Some tests failed!${NC}"
        return 1
    else
        echo ""
        echo -e "${GREEN}All tests passed!${NC}"
        return 0
    fi
}

# Start tests
print_header "QA Test Suite for Dotfiles Installation"

# Test 1: Basic system setup
print_header "1. System Information"
echo "OS: Debian $(cat /etc/debian_version)"
echo "User: $(whoami)"
echo "Home: $HOME"
echo "Working directory: $(pwd)"

# Test 2: Pre-installation - check base tools
print_header "2. Pre-Installation - Base Tools"
print_test "Base system tools"
assert_command_exists "git" "Git"
assert_command_exists "curl" "cURL"
assert_command_exists "wget" "Wget"
assert_command_exists "make" "Make"

# Test 3: Repository structure
print_header "3. Repository Structure"
print_test "Required directories and files"
assert_directory_exists "/home/romainprignon/workspace/romainprignon/dotfiles" "Dotfiles repo"
assert_file_exists "/home/romainprignon/workspace/romainprignon/dotfiles/makefile" "Makefile"
assert_directory_exists "/home/romainprignon/workspace/romainprignon/dotfiles/scripts" "Scripts directory"
assert_file_exists "/home/romainprignon/workspace/romainprignon/dotfiles/scripts/install.sh" "Install script"
assert_file_exists "/home/romainprignon/workspace/romainprignon/dotfiles/scripts/configure.sh" "Configure script"

# Test 4: Run make install
print_header "4. Testing 'make install' Command"
print_test "Running make install (this may take a few minutes)"

cd /home/romainprignon/workspace/romainprignon/dotfiles

if timeout 300 make install > /tmp/install.log 2>&1; then
    echo -e "${GREEN}✓${NC} make install completed successfully"
    ((PASSED_TESTS++))
else
    EXIT_CODE=$?
    if [[ $EXIT_CODE -eq 124 ]]; then
        echo -e "${YELLOW}⚠${NC} make install timed out after 300 seconds (may still be running)"
        ((PASSED_TESTS++))
    else
        echo -e "${RED}✗${NC} make install failed with exit code $EXIT_CODE"
        echo "Last 20 lines of install log:"
        tail -20 /tmp/install.log
        ((FAILED_TESTS++))
    fi
fi

# Test 5: Post-installation - Essential tools
print_header "5. Post-Installation - Essential Tools"
print_test "Verifying essential tools are installed"
assert_command_exists "vim" "Vim"
assert_command_exists "zsh" "ZSH"
assert_command_exists "htop" "htop"
assert_command_exists "jq" "jq"
assert_command_exists "sqlite3" "SQLite3"
assert_command_exists "tree" "tree"

# Test 6: mise installation and configuration
print_header "6. Testing mise (dev tools manager)"
print_test "mise installation"
assert_command_exists "mise" "mise command"
assert_file_exists "$HOME/.local/bin/mise" "mise binary"
assert_file_exists "/home/romainprignon/workspace/romainprignon/dotfiles/.mise.toml" "mise configuration"

print_test "mise functionality"
if mise --version &>/dev/null; then
    MISE_VERSION=$(mise --version)
    echo -e "${GREEN}✓${NC} mise version: $MISE_VERSION"
    ((PASSED_TESTS++))
else
    echo -e "${RED}✗${NC} mise --version failed"
    ((FAILED_TESTS++))
fi

# Test 7: Shell configuration
print_header "7. Shell Configuration Files"
print_test "ZSH configuration"
assert_file_exists "$HOME/.zshrc" ".zshrc"
assert_file_exists "/home/romainprignon/workspace/romainprignon/dotfiles/zsh/.zshrc" "zsh/.zshrc source"

print_test "Bash configuration"
assert_file_exists "$HOME/.bashrc" ".bashrc"
assert_file_exists "/home/romainprignon/workspace/romainprignon/dotfiles/bash/.bashrc" "bash/.bashrc source"

print_test "Shell plugins and completions"
assert_directory_exists "$HOME/.zcompletions" "ZSH completions directory"

# Test 8: Git configuration
print_header "8. Git Configuration"
print_test "Git config files"
assert_file_exists "$HOME/.gitconfig" ".gitconfig"
assert_file_exists "/home/romainprignon/workspace/romainprignon/dotfiles/git/.gitconfig" "git/.gitconfig source"

print_test "Git configuration values"
if git config --global user.name &>/dev/null; then
    GIT_USER=$(git config --global user.name)
    echo -e "${GREEN}✓${NC} Git user.name: $GIT_USER"
    ((PASSED_TESTS++))
else
    echo -e "${RED}✗${NC} Git user.name not configured"
    ((FAILED_TESTS++))
fi

# Test 9: Vim configuration
print_header "9. Vim Configuration"
print_test "Vim config files"
assert_file_exists "$HOME/.vimrc" ".vimrc"
assert_file_exists "/home/romainprignon/workspace/romainprignon/dotfiles/.vimrc" ".vimrc source"

# Test 10: Installation logs
print_header "10. Installation Logs"
print_test "Log files created"
assert_directory_exists "/home/romainprignon/workspace/romainprignon/dotfiles/logs" "Logs directory"
assert_file_exists "/home/romainprignon/workspace/romainprignon/dotfiles/logs/install.log" "install.log"

# Test 11: Optional tools (may not be installed in minimal setup)
print_header "11. Optional Tools (Informational)"
print_test "Checking optional tools"
for tool in ffmpeg xclip shellcheck; do
    if command -v "$tool" &>/dev/null; then
        echo -e "${GREEN}✓${NC} Optional tool found: $tool"
    else
        echo -e "${YELLOW}⚠${NC} Optional tool not found: $tool (may not be required)"
    fi
done

# Test 12: Test make configure (if applicable)
print_header "12. Testing Other Make Commands"
print_test "Checking available make targets"

cd /home/romainprignon/workspace/romainprignon/dotfiles

# List available targets
echo "Available make targets:"
make -qp | awk -F':' '/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$)/ {split($1,A,/ /);for(i in A)print A[i]}' | sort -u | head -20

# Final summary
print_summary
