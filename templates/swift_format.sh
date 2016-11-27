cd $(dirname $0)

if which swiftformat >/dev/null; then
  swiftformat ../<%= project_name %> --removelines false --header strip
else
  echo "error: SwiftFormat not installed, run 'brew install swiftformat' to set it up"
fi
