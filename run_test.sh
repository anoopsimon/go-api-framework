#!/bin/sh

# Run tests and generate the test-results.out file
go test -v ./... | tee test-results.out

# Generate HTML report from the test-results.out file
go-test-report -input test-results.out -output report/test-report.html

# Open the report in the default web browser
if [ "$(uname)" == "Darwin" ]; then
    # macOS
    open report/test-report.html
elif [ "$(uname)" == "Linux" ]; then
    # Linux
    xdg-open report/test-report.html
elif [ "$(uname)" == "MINGW64_NT-10.0" ]; then
    # Git Bash on Windows
    start report/test-report.html
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    # 32 bit Git Bash on Windows
    start report/test-report.html
fi
