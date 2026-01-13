#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

BIN="./ex05"

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

run_capture() {
  local out="$1"
  local err="$2"
  shift 2

  set +e
  "$@" >"$out" 2>"$err"
  local code=$?
  set -e
  return "$code"
}

assert_file_empty() {
  local file="$1"
  [ ! -s "$file" ] || fail "expected empty: $file"
}

assert_file_contains() {
  local file="$1"
  local pattern="$2"
  grep -Fq -- "$pattern" "$file" || fail "expected '$file' to contain: $pattern"
}

build() {
  make -s re
}

TMPDIR="$(mktemp -d)"
cleanup() { rm -rf "$TMPDIR"; }
trap cleanup EXIT

build

echo "=== DEBUG ==="
run_capture "$TMPDIR/out.txt" "$TMPDIR/err.txt" "$BIN" DEBUG || fail "expected exit code 0"
assert_file_contains "$TMPDIR/out.txt" "I love having extra bacon"
assert_file_empty "$TMPDIR/err.txt"

echo "=== INFO ==="
run_capture "$TMPDIR/out.txt" "$TMPDIR/err.txt" "$BIN" INFO || fail "expected exit code 0"
assert_file_contains "$TMPDIR/out.txt" "I cannot believe adding extra bacon costs more money."
assert_file_empty "$TMPDIR/err.txt"

echo "=== WARNING ==="
run_capture "$TMPDIR/out.txt" "$TMPDIR/err.txt" "$BIN" WARNING || fail "expected exit code 0"
assert_file_contains "$TMPDIR/out.txt" "I think I deserve to have some extra bacon for free."
assert_file_empty "$TMPDIR/err.txt"

echo "=== ERROR ==="
run_capture "$TMPDIR/out.txt" "$TMPDIR/err.txt" "$BIN" ERROR || fail "expected exit code 0"
assert_file_contains "$TMPDIR/out.txt" "This is unacceptable! I want to speak to the manager now."
assert_file_empty "$TMPDIR/err.txt"

echo "=== INVALID level (no output) ==="
run_capture "$TMPDIR/out.txt" "$TMPDIR/err.txt" "$BIN" NOPE || fail "expected exit code 0"
assert_file_empty "$TMPDIR/out.txt"
assert_file_empty "$TMPDIR/err.txt"

echo "=== no args (exit != 0, no output) ==="
if run_capture "$TMPDIR/out.txt" "$TMPDIR/err.txt" "$BIN"; then
  fail "expected failure exit code"
fi
assert_file_empty "$TMPDIR/out.txt"
assert_file_contains "$TMPDIR/err.txt" "Usage:"

echo "=== too many args (exit != 0, no output) ==="
if run_capture "$TMPDIR/out.txt" "$TMPDIR/err.txt" "$BIN" DEBUG EXTRA; then
  fail "expected failure exit code"
fi
assert_file_empty "$TMPDIR/out.txt"
assert_file_contains "$TMPDIR/err.txt" "Usage:"

echo "OK"

