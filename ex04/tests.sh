#!/usr/bin/env bash
set -euo pipefail

BIN="$(pwd)/ex04"

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

run_expect_fail() {
  set +e
  "$@"
  local code=$?
  set -e
  if [ "$code" -eq 0 ]; then
    fail "expected failure, but succeeded: $*"
  fi
  return 0
}

assert_file_contains() {
  local file="$1"
  local pattern="$2"
  grep -q -- "$pattern" "$file" || fail "expected '$file' to contain: $pattern"
}

assert_file_not_exists() {
  local file="$1"
  [ ! -e "$file" ] || fail "expected file not to exist: $file"
}

make -s re

TMPDIR="$(mktemp -d)"
cleanup() { rm -rf "$TMPDIR"; }
trap cleanup EXIT

cd "$TMPDIR"

echo "=== success: replace all ==="
cat > input.txt << 'EOF'
hello foo foo
foo
no match here
EOF

"$BIN" input.txt foo bar
assert_file_contains input.txt.replace "hello bar bar"
assert_file_contains input.txt.replace "^bar$"
assert_file_contains input.txt.replace "no match here"
rm -f input.txt.replace

echo "=== error: wrong arg count ==="
run_expect_fail "$BIN" 2> err.txt
assert_file_contains err.txt "Usage:"

echo "=== error: empty s1 ==="
run_expect_fail "$BIN" input.txt "" bar 2> err.txt
assert_file_contains err.txt "s1 must not be empty"
assert_file_not_exists "input.txt.replace"

echo "=== error: cannot open input file ==="
run_expect_fail "$BIN" does_not_exist.txt foo bar 2> err.txt
assert_file_contains err.txt "cannot open input file"

echo "=== error: cannot create output file (no write permission) ==="
mkdir nowrite
cat > nowrite/input.txt << 'EOF'
foo
EOF
chmod 500 nowrite
(
  cd nowrite
  run_expect_fail "$BIN" input.txt foo bar 2> err.txt
  assert_file_contains err.txt "cannot create output file"
)

echo "OK"

