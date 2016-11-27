if which swiftlint >/dev/null; then
  swiftlint
else
  echo "error: SwiftLint not installed, run 'brew install swiftlint'
   to set it up"
fi
