#!/bin/bash

# Spider Node Installation Test Script
# This script validates the install.sh script

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( cd "$SCRIPT_DIR/.." && pwd )"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Functions
test_start() {
    echo -e "${YELLOW}Testing: $1${NC}"
    ((TESTS_RUN++))
}

test_pass() {
    echo -e "${GREEN}✓ $1${NC}"
    ((TESTS_PASSED++))
}

test_fail() {
    echo -e "${RED}✗ $1${NC}"
    ((TESTS_FAILED++))
}

# Test 1: Check if install.sh exists
test_start "install.sh exists"
if [ -f "$PROJECT_ROOT/install.sh" ]; then
    test_pass "install.sh found"
else
    test_fail "install.sh not found"
fi

# Test 2: Check if docker-compose.yml exists
test_start "docker-compose.yml exists"
if [ -f "$PROJECT_ROOT/docker-compose.yml" ]; then
    test_pass "docker-compose.yml found"
else
    test_fail "docker-compose.yml not found"
fi

# Test 3: Check if README.md exists
test_start "README.md exists"
if [ -f "$PROJECT_ROOT/README.md" ]; then
    test_pass "README.md found"
else
    test_fail "README.md not found"
fi

# Test 4: Check if Makefile exists
test_start "Makefile exists"
if [ -f "$PROJECT_ROOT/Makefile" ]; then
    test_pass "Makefile found"
else
    test_fail "Makefile not found"
fi

# Test 5: Verify install.sh is executable
test_start "install.sh is executable"
if [ -x "$PROJECT_ROOT/install.sh" ]; then
    test_pass "install.sh is executable"
else
    test_fail "install.sh is not executable"
fi

# Test 6: Check syntax of install.sh
test_start "install.sh syntax validation"
if bash -n "$PROJECT_ROOT/install.sh" 2>/dev/null; then
    test_pass "install.sh syntax is valid"
else
    test_fail "install.sh has syntax errors"
fi

# Test 7: Validate docker-compose.yml
test_start "docker-compose.yml validation"
if command -v docker-compose &> /dev/null; then
    if docker-compose -f "$PROJECT_ROOT/docker-compose.yml" config > /dev/null 2>&1; then
        test_pass "docker-compose.yml is valid"
    else
        test_fail "docker-compose.yml has errors"
    fi
else
    test_fail "docker-compose not installed, skipping validation"
fi

# Test 8: Check if .gitignore exists
test_start ".gitignore exists"
if [ -f "$PROJECT_ROOT/.gitignore" ]; then
    test_pass ".gitignore found"
else
    test_fail ".gitignore not found"
fi

# Test 9: Check if CONTRIBUTING.md exists
test_start "CONTRIBUTING.md exists"
if [ -f "$PROJECT_ROOT/CONTRIBUTING.md" ]; then
    test_pass "CONTRIBUTING.md found"
else
    test_fail "CONTRIBUTING.md not found"
fi

# Test 10: Check if SECURITY.md exists
test_start "SECURITY.md exists"
if [ -f "$PROJECT_ROOT/SECURITY.md" ]; then
    test_pass "SECURITY.md found"
else
    test_fail "SECURITY.md not found"
fi

# Summary
echo ""
echo "========================================"
echo "Test Summary"
echo "========================================"
echo "Tests Run:    $TESTS_RUN"
echo -e "Tests Passed: ${GREEN}$TESTS_PASSED${NC}"
echo -e "Tests Failed: ${RED}$TESTS_FAILED${NC}"
echo "========================================"

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}Some tests failed!${NC}"
    exit 1
fi
