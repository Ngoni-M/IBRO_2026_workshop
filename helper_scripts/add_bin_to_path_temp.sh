#!/usr/bin/env bash

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd -- "$script_dir/.." && pwd)"
bin_dir="$repo_root/bin"

case ":$PATH:" in
  *":$bin_dir:"*) ;;
  *) export PATH="$bin_dir:$PATH" ;;
esac
