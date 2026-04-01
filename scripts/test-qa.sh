#!/bin/bash
# QA Integration Test Script - Validates dotfiles installation in Docker container
# This script runs actual installation and validates functionality

set -e

echo "========================================"
echo "QA Integration Tests for Dotfiles"
echo "Running inside Docker container"
echo "========================================"
echo ""

FAILED_TESTS=0
PASSED_TESTS=0

# Function to run a test
run_test() {
    local test_name="$1"
    shift
    
    echo -n "Testing: $test_name... "
    
    if "$@" > /tmp/test_output.log 2>&1; then
        echo "✓ PASS"
        ((PASSED_TESTS++))
        return 0
    else
        echo "✗ FAIL"
        echo "  Error output:"
        sed 's/^/    /' /tmp/test_output.log | head -20
        ((FAILED_TESTS++))
        return 1
    fi
}

# Create logs directory
mkdir -p logs

echo "========================================"
echo "Phase 1: Base Installation"
echo "========================================"
echo ""

# Run the base installation
echo "Running: make install"
if make install; then
    echo "✓ Base installation completed"
else
    echo "✗ Base installation failed"
    exit 1
fi

echo ""
echo "========================================"
echo "Phase 2: Mise Validation"
echo "========================================"
echo ""

# Source mise activation
export PATH="$HOME/.local/bin:$PATH"
eval "$(~/.local/bin/mise activate bash)" 2>/dev/null || true

run_test "Mise is installed and in PATH" command -v mise
run_test "Mise can show version" mise --version
run_test "Mise can list installed tools" mise list
run_test ".mise.toml is valid" mise ls

echo ""
echo "========================================"
echo "Phase 3: Runtime Installation Tests"
echo "========================================"
echo ""

# Test that mise can install a small runtime (node)
echo "Testing mise runtime installation (Node.js)..."
if run_test "Can install Node via mise" bash -c "mise use -y node@20.0.0 && mise exec -- node --version"; then
    echo "  Node version: $(mise exec -- node --version 2>/dev/null || echo 'N/A')"
fi

# Test Python installation
echo "Testing Python installation via mise..."
if run_test "Can install Python via mise" bash -c "mise use -y python@3.11 && mise exec -- python --version"; then
    echo "  Python version: $(mise exec -- python --version 2>/dev/null || echo 'N/A')"
fi

echo ""
echo "========================================"
echo "Phase 4: Configuration Validation"
echo "========================================"
echo ""

run_test "ZSH plugins installed" test -d ~/.zsh/zsh-autosuggestions
run_test "Bash git prompt installed" test -d ~/.bash-git-prompt
run_test "FZF installed" test -d ~/.fzf
run_test "Logs directory exists" test -d logs
run_test "Install log was created" test -f logs/install.log

echo ""
echo "========================================"
echo "Phase 5: Makefile Target Validation"
echo "========================================"
echo ""

run_test "install-php target exists" bash -c "grep -q '^install-php:' makefile"
run_test "install-docker target exists" bash -c "grep -q '^install-docker:' makefile"
run_test "install-node target exists" bash -c "grep -q '^install-node:' makefile"
run_test "install-python target exists" bash -c "grep -q '^install-python:' makefile"
run_test "install-all-runtimes target exists" bash -c "grep -q '^install-all-runtimes:' makefile"

echo ""
echo "========================================"
echo "Phase 6: Repository Structure"
echo "========================================"
echo ""

run_test ".mise.toml exists" test -f .mise.toml
run_test "Font download script exists and is executable" test -x fonts/download-fonts.sh
run_test "install.sh exists and is executable" test -x scripts/install.sh
run_test "configure.sh exists and is executable" test -x scripts/configure.sh

echo ""
echo "========================================"
echo "QA Test Results Summary"
echo "========================================"
echo "Passed: $PASSED_TESTS"
echo "Failed: $FAILED_TESTS"
echo ""

if [ $FAILED_TESTS -eq 0 ]; then
    echo "✓ All integration tests passed!"
    echo ""
    echo "Installation Summary:"
    echo "  - Base packages: installed ✓"
    echo "  - Mise: installed and functional ✓"
    echo "  - Sample runtimes: tested ✓"
    echo "  - Configuration files: present ✓"
    echo "  - Makefile targets: validated ✓"
    exit 0
else
    echo "✗ Some tests failed!"
    echo "Check logs/install.log for details"
    exit 1
fi
