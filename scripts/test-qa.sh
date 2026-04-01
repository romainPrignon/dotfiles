#!/bin/bash
# QA Test Script - Validates all changes made to the dotfiles repository

echo "================================"
echo "QA Test Suite for Dotfiles"
echo "================================"
echo ""

FAILED_TESTS=0
PASSED_TESTS=0

# Function to run a test
run_test() {
    local test_name="$1"
    local test_command="$2"
    
    echo -n "Testing: $test_name... "
    
    if eval "$test_command" > /dev/null 2>&1; then
        echo "✓ PASS"
        ((PASSED_TESTS++))
        return 0
    else
        echo "✗ FAIL"
        ((FAILED_TESTS++))
        return 1
    fi
}

# Function to check file content
check_file_contains() {
    local file="$1"
    local pattern="$2"
    grep -q "$pattern" "$file"
}

# Function to check file doesn't contain pattern
check_file_not_contains() {
    local file="$1"
    local pattern="$2"
    ! grep -q "$pattern" "$file"
}

echo "1. Repository Structure Tests"
echo "------------------------------"
run_test "README.md exists" "test -f README.md"
run_test "Makefile exists" "test -f makefile"
run_test ".mise.toml exists" "test -f .mise.toml"
run_test "install.sh exists" "test -f scripts/install.sh"
run_test "desktop.sh exists" "test -f scripts/desktop.sh"
run_test "Font download script exists" "test -f fonts/download-fonts.sh"
run_test "Font download script is executable" "test -x fonts/download-fonts.sh"

echo ""
echo "2. README.md Content Tests"
echo "----------------------------"
run_test "DNS section removed from README" "check_file_not_contains README.md '## DNS Configuration'"
run_test "Ghostty section removed from README" "check_file_not_contains README.md '## Ghostty Terminal'"
run_test "Fonts section added to README" "check_file_contains README.md '## Fonts'"
run_test "Mise documentation updated" "check_file_contains README.md 'mise needs to be installed first'"
run_test "Title bar extension documented" "check_file_contains README.md 'Just Perfection'"

echo ""
echo "3. Makefile Target Tests"
echo "-------------------------"
run_test "install target exists" "grep -q '^install:' makefile"
run_test "desktop target exists" "grep -q '^desktop:' makefile"
run_test "configure-desktop target exists" "grep -q '^configure-desktop:' makefile"
run_test "login-background target exists" "grep -q '^login-background:' makefile"
run_test "update-desktop target exists" "grep -q '^update-desktop:' makefile"
run_test "install-php target exists" "grep -q '^install-php:' makefile"
run_test "install-docker target exists" "grep -q '^install-docker:' makefile"

echo ""
echo "4. Update-Desktop Package Tests"
echo "---------------------------------"
run_test "Brave browser in update-desktop" "check_file_contains makefile 'brave-browser'"
run_test "Rambox in update-desktop" "check_file_contains makefile 'rambox'"
run_test "Chrome removed from update-desktop" "check_file_not_contains makefile 'google-chrome-stable'"
run_test "Sublime-text removed from update-desktop" "check_file_not_contains makefile 'sublime-text'"

echo ""
echo "5. Desktop.sh Application Tests"
echo "---------------------------------"
run_test "Brave installation in desktop.sh" "check_file_contains scripts/desktop.sh 'brave'"
run_test "Rambox installation in desktop.sh" "check_file_contains scripts/desktop.sh 'rambox'"
run_test "Gnome-terminal in desktop.sh" "check_file_contains scripts/desktop.sh 'gnome-terminal'"
run_test "Chrome removed from desktop.sh" "check_file_not_contains scripts/desktop.sh 'google-chrome-stable'"

echo ""
echo "6. Mise Configuration Tests"
echo "----------------------------"
run_test ".mise.toml has PHP config" "check_file_contains .mise.toml 'php'"
run_test ".mise.toml has Docker config" "check_file_contains .mise.toml 'docker'"
run_test ".mise.toml has Composer config" "check_file_contains .mise.toml 'composer'"
run_test ".mise.toml has Node config" "check_file_contains .mise.toml 'node'"
run_test ".mise.toml has Python config" "check_file_contains .mise.toml 'python'"

echo ""
echo "7. Makefile Runtime Version Tests"
echo "-----------------------------------"
run_test "PHP_VERSION variable exists" "grep -q 'PHP_VERSION ?=' makefile"
run_test "DOCKER_VERSION variable exists" "grep -q 'DOCKER_VERSION ?=' makefile"
run_test "NODE_VERSION variable exists" "grep -q 'NODE_VERSION ?=' makefile"
run_test "install-php uses mise" "check_file_contains makefile 'mise use -g php'"
run_test "install-docker uses mise" "check_file_contains makefile 'mise use -g docker'"

echo ""
echo "8. Install.sh Docker Removal Test"
echo "-----------------------------------"
run_test "Docker installation removed from install.sh" "check_file_not_contains scripts/install.sh 'curl -sSL https://get.docker.com'"
run_test "Docker-compose removed from install.sh" "check_file_not_contains scripts/install.sh 'docker-compose'"

echo ""
echo "9. Font Script Tests"
echo "---------------------"
run_test "Font script has DejaVu download" "check_file_contains fonts/download-fonts.sh 'dejavu'"
run_test "Font script has Ubuntu font download" "check_file_contains fonts/download-fonts.sh 'ubuntu'"
run_test "Desktop.sh installs DejaVu fonts" "check_file_contains scripts/desktop.sh 'dejavu'"
run_test "Desktop.sh installs Ubuntu fonts" "check_file_contains scripts/desktop.sh 'ubuntu'"

echo ""
echo "================================"
echo "QA Test Results"
echo "================================"
echo "Passed: $PASSED_TESTS"
echo "Failed: $FAILED_TESTS"
echo ""

if [ $FAILED_TESTS -eq 0 ]; then
    echo "✓ All tests passed!"
    exit 0
else
    echo "✗ Some tests failed!"
    exit 1
fi
