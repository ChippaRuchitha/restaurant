#!/bin/bash

echo "Running test cases..."
# Sample test logic (replace this with your real tests)
if docker ps > /dev/null 2>&1; then
  echo "Docker is running: Test Passed"
  exit 0
else
  echo "Docker is not running: Test Failed"
  exit 1
fi
