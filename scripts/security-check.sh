#!/bin/bash

# Security Check Script for ElkaRec Website
# This script performs basic security checks on the deployed website

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
SITE_URL="${1:-https://elkarec.com}"
REPORT_FILE="security-check-report.txt"

echo -e "${BLUE}===================================${NC}"
echo -e "${BLUE}Security Check for: ${SITE_URL}${NC}"
echo -e "${BLUE}===================================${NC}\n"

# Create report file
echo "Security Check Report for ${SITE_URL}" > "${REPORT_FILE}"
echo "Date: $(date)" >> "${REPORT_FILE}"
echo "=======================================" >> "${REPORT_FILE}"
echo "" >> "${REPORT_FILE}"

# Function to check header
check_header() {
    local header_name=$1
    local expected_pattern=$2
    local severity=$3

    echo -e "${BLUE}Checking ${header_name}...${NC}"

    header_value=$(curl -s -I "${SITE_URL}" | grep -i "^${header_name}:" | cut -d' ' -f2-)

    if [ -z "${header_value}" ]; then
        echo -e "${RED}[FAIL]${NC} ${header_name} header is missing (Severity: ${severity})"
        echo "[FAIL] ${header_name}: Missing (Severity: ${severity})" >> "${REPORT_FILE}"
        return 1
    else
        if [ -n "${expected_pattern}" ]; then
            if echo "${header_value}" | grep -q "${expected_pattern}"; then
                echo -e "${GREEN}[PASS]${NC} ${header_name}: ${header_value}"
                echo "[PASS] ${header_name}: ${header_value}" >> "${REPORT_FILE}"
                return 0
            else
                echo -e "${YELLOW}[WARN]${NC} ${header_name}: ${header_value} (Expected: ${expected_pattern})"
                echo "[WARN] ${header_name}: ${header_value} (Expected: ${expected_pattern})" >> "${REPORT_FILE}"
                return 2
            fi
        else
            echo -e "${GREEN}[PASS]${NC} ${header_name}: ${header_value}"
            echo "[PASS] ${header_name}: ${header_value}" >> "${REPORT_FILE}"
            return 0
        fi
    fi
}

# Initialize counters
PASSED=0
FAILED=0
WARNINGS=0

# 1. Check HTTPS
echo -e "\n${BLUE}1. Checking HTTPS...${NC}"
if curl -s -o /dev/null -w "%{http_code}" "${SITE_URL}" | grep -q "200\|301\|302"; then
    echo -e "${GREEN}[PASS]${NC} Site is accessible"
    echo "[PASS] HTTPS: Site is accessible" >> "${REPORT_FILE}"
    ((PASSED++))
else
    echo -e "${RED}[FAIL]${NC} Site is not accessible"
    echo "[FAIL] HTTPS: Site is not accessible" >> "${REPORT_FILE}"
    ((FAILED++))
fi

# 2. Check Security Headers
echo -e "\n${BLUE}2. Checking Security Headers...${NC}"

check_header "X-Frame-Options" "DENY" "HIGH"
result=$?
[ $result -eq 0 ] && ((PASSED++)) || [ $result -eq 1 ] && ((FAILED++)) || ((WARNINGS++))

check_header "X-Content-Type-Options" "nosniff" "MEDIUM"
result=$?
[ $result -eq 0 ] && ((PASSED++)) || [ $result -eq 1 ] && ((FAILED++)) || ((WARNINGS++))

check_header "Strict-Transport-Security" "max-age" "HIGH"
result=$?
[ $result -eq 0 ] && ((PASSED++)) || [ $result -eq 1 ] && ((FAILED++)) || ((WARNINGS++))

check_header "Content-Security-Policy" "" "HIGH"
result=$?
[ $result -eq 0 ] && ((PASSED++)) || [ $result -eq 1 ] && ((FAILED++)) || ((WARNINGS++))

check_header "Referrer-Policy" "strict-origin" "MEDIUM"
result=$?
[ $result -eq 0 ] && ((PASSED++)) || [ $result -eq 1 ] && ((FAILED++)) || ((WARNINGS++))

check_header "Permissions-Policy" "" "MEDIUM"
result=$?
[ $result -eq 0 ] && ((PASSED++)) || [ $result -eq 1 ] && ((FAILED++)) || ((WARNINGS++))

# 3. Check for common vulnerabilities
echo -e "\n${BLUE}3. Checking for Common Vulnerabilities...${NC}"

# Check if .git directory is exposed
echo -e "${BLUE}Checking for exposed .git directory...${NC}"
if curl -s -o /dev/null -w "%{http_code}" "${SITE_URL}/.git/HEAD" | grep -q "200"; then
    echo -e "${RED}[FAIL]${NC} .git directory is exposed (Severity: CRITICAL)"
    echo "[FAIL] .git directory is exposed (Severity: CRITICAL)" >> "${REPORT_FILE}"
    ((FAILED++))
else
    echo -e "${GREEN}[PASS]${NC} .git directory is not exposed"
    echo "[PASS] .git directory is not exposed" >> "${REPORT_FILE}"
    ((PASSED++))
fi

# Check for .env file
echo -e "${BLUE}Checking for exposed .env file...${NC}"
if curl -s -o /dev/null -w "%{http_code}" "${SITE_URL}/.env" | grep -q "200"; then
    echo -e "${RED}[FAIL]${NC} .env file is exposed (Severity: CRITICAL)"
    echo "[FAIL] .env file is exposed (Severity: CRITICAL)" >> "${REPORT_FILE}"
    ((FAILED++))
else
    echo -e "${GREEN}[PASS]${NC} .env file is not exposed"
    echo "[PASS] .env file is not exposed" >> "${REPORT_FILE}"
    ((PASSED++))
fi

# Check robots.txt
echo -e "${BLUE}Checking robots.txt...${NC}"
if curl -s -o /dev/null -w "%{http_code}" "${SITE_URL}/robots.txt" | grep -q "200"; then
    echo -e "${GREEN}[PASS]${NC} robots.txt exists"
    echo "[PASS] robots.txt exists" >> "${REPORT_FILE}"
    ((PASSED++))
else
    echo -e "${YELLOW}[WARN]${NC} robots.txt not found"
    echo "[WARN] robots.txt not found" >> "${REPORT_FILE}"
    ((WARNINGS++))
fi

# 4. Check SSL/TLS configuration
echo -e "\n${BLUE}4. Checking SSL/TLS Configuration...${NC}"
if command -v openssl &> /dev/null; then
    ssl_info=$(echo | openssl s_client -connect "$(echo ${SITE_URL} | sed 's|https://||'):443" -servername "$(echo ${SITE_URL} | sed 's|https://||')" 2>/dev/null | openssl x509 -noout -dates 2>/dev/null)

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}[PASS]${NC} SSL certificate is valid"
        echo "[PASS] SSL certificate is valid" >> "${REPORT_FILE}"
        echo "${ssl_info}" >> "${REPORT_FILE}"
        ((PASSED++))
    else
        echo -e "${YELLOW}[WARN]${NC} Could not verify SSL certificate"
        echo "[WARN] Could not verify SSL certificate" >> "${REPORT_FILE}"
        ((WARNINGS++))
    fi
else
    echo -e "${YELLOW}[WARN]${NC} openssl not installed, skipping SSL check"
    echo "[WARN] openssl not installed, skipping SSL check" >> "${REPORT_FILE}"
    ((WARNINGS++))
fi

# 5. External link check (sample)
echo -e "\n${BLUE}5. Checking External Links Security...${NC}"
page_content=$(curl -s "${SITE_URL}")

if echo "${page_content}" | grep -q 'target="_blank".*rel="noopener noreferrer"'; then
    echo -e "${GREEN}[PASS]${NC} External links use rel=\"noopener noreferrer\""
    echo "[PASS] External links use rel=\"noopener noreferrer\"" >> "${REPORT_FILE}"
    ((PASSED++))
else
    echo -e "${YELLOW}[WARN]${NC} Some external links may be missing rel=\"noopener noreferrer\""
    echo "[WARN] Some external links may be missing rel=\"noopener noreferrer\"" >> "${REPORT_FILE}"
    ((WARNINGS++))
fi

# 6. Check for mixed content
echo -e "\n${BLUE}6. Checking for Mixed Content...${NC}"
if echo "${page_content}" | grep -q 'src="http://\|href="http://'; then
    echo -e "${RED}[FAIL]${NC} Mixed content detected (HTTP resources on HTTPS page)"
    echo "[FAIL] Mixed content detected" >> "${REPORT_FILE}"
    ((FAILED++))
else
    echo -e "${GREEN}[PASS]${NC} No mixed content detected"
    echo "[PASS] No mixed content detected" >> "${REPORT_FILE}"
    ((PASSED++))
fi

# Summary
echo -e "\n${BLUE}===================================${NC}"
echo -e "${BLUE}Security Check Summary${NC}"
echo -e "${BLUE}===================================${NC}"
echo "" >> "${REPORT_FILE}"
echo "=======================================" >> "${REPORT_FILE}"
echo "Summary:" >> "${REPORT_FILE}"

echo -e "${GREEN}Passed: ${PASSED}${NC}"
echo "Passed: ${PASSED}" >> "${REPORT_FILE}"

echo -e "${RED}Failed: ${FAILED}${NC}"
echo "Failed: ${FAILED}" >> "${REPORT_FILE}"

echo -e "${YELLOW}Warnings: ${WARNINGS}${NC}"
echo "Warnings: ${WARNINGS}" >> "${REPORT_FILE}"

TOTAL=$((PASSED + FAILED + WARNINGS))
if [ ${TOTAL} -gt 0 ]; then
    SCORE=$((PASSED * 100 / TOTAL))
    echo -e "\n${BLUE}Security Score: ${SCORE}%${NC}"
    echo "Security Score: ${SCORE}%" >> "${REPORT_FILE}"

    if [ ${SCORE} -ge 90 ]; then
        echo -e "${GREEN}Overall Status: EXCELLENT${NC}"
        echo "Overall Status: EXCELLENT" >> "${REPORT_FILE}"
    elif [ ${SCORE} -ge 70 ]; then
        echo -e "${YELLOW}Overall Status: GOOD${NC}"
        echo "Overall Status: GOOD" >> "${REPORT_FILE}"
    elif [ ${SCORE} -ge 50 ]; then
        echo -e "${YELLOW}Overall Status: NEEDS IMPROVEMENT${NC}"
        echo "Overall Status: NEEDS IMPROVEMENT" >> "${REPORT_FILE}"
    else
        echo -e "${RED}Overall Status: CRITICAL${NC}"
        echo "Overall Status: CRITICAL" >> "${REPORT_FILE}"
    fi
fi

echo -e "\n${BLUE}Report saved to: ${REPORT_FILE}${NC}"

# Recommendations
echo -e "\n${BLUE}===================================${NC}"
echo -e "${BLUE}Recommendations${NC}"
echo -e "${BLUE}===================================${NC}"
echo "" >> "${REPORT_FILE}"
echo "=======================================" >> "${REPORT_FILE}"
echo "Recommendations:" >> "${REPORT_FILE}"
echo "" >> "${REPORT_FILE}"

if [ ${FAILED} -gt 0 ]; then
    echo -e "${YELLOW}1. Fix all FAILED checks immediately${NC}"
    echo "1. Fix all FAILED checks immediately" >> "${REPORT_FILE}"
fi

if [ ${WARNINGS} -gt 0 ]; then
    echo -e "${YELLOW}2. Address warnings to improve security posture${NC}"
    echo "2. Address warnings to improve security posture" >> "${REPORT_FILE}"
fi

echo -e "${BLUE}3. Run this script regularly (weekly recommended)${NC}"
echo "3. Run this script regularly (weekly recommended)" >> "${REPORT_FILE}"

echo -e "${BLUE}4. Check external security scanners:${NC}"
echo "4. Check external security scanners:" >> "${REPORT_FILE}"
echo "   - https://observatory.mozilla.org"
echo "   - https://securityheaders.com"
echo "   - https://www.ssllabs.com/ssltest/"
echo "" >> "${REPORT_FILE}"

# Exit with appropriate code
if [ ${FAILED} -gt 0 ]; then
    exit 1
else
    exit 0
fi
