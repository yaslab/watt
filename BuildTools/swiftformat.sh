#!/usr/bin/env zsh

set -eu

TOOL_DIR="$(cd "$(dirname "$0")"; pwd)"
ROOT_DIR="$(dirname "$TOOL_DIR")"

function run_swiftformat() {
    local ARG_SRC_DIR="$1"
    swift run -c release --package-path "$TOOL_DIR" \
        swiftformat "$ROOT_DIR/$ARG_SRC_DIR"
}

run_swiftformat Watt
run_swiftformat WattLauncher
