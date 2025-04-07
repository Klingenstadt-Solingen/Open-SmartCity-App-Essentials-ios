#!/bin/bash
# Type a script or drag a script file from your workspace to insert its path.
export PATH="$PATH:/opt/homebrew/bin"
if which swiftlint > /dev/null; then
  swiftlint --config ../.swiftlint.yml
else
  echo "warning: SwiftLint not installed, try to install it"
  brew install swiftlint --verbose
fi

