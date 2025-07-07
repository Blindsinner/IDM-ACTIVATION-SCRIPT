@echo off

:: IDM Update Blocker Script
:: This script blocks outgoing connections to the specified IP address to prevent IDM from checking for updates.

:: Check for administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script must be run as Administrator.
    echo Please right-click the script and select "Run as administrator".
    pause
    exit /b
)

:: Define the IP address to block
set "ip_to_block=169.61.27.133"

:: Define the rule name
set "rule_name=Block IDM Update IP"

:: Delete any existing rule with the same name
netsh advfirewall firewall delete rule name="%rule_name%"

:: Add a new outbound rule to block the IP
netsh advfirewall firewall add rule name="%rule_name%" dir=out action=block remoteip=%ip_to_block%

:: Check if the rule was added successfully
if %errorlevel%==0 (
    echo The IP %ip_to_block% has been blocked successfully.
) else (
    echo Failed to block the IP. Please check your firewall settings.
)

:: Pause to keep the window open
pause
