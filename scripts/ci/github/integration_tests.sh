#!/usr/bin/env bash
set -eu

# use pagefind installed from the officially-maintained node.js channel

# use the global python3 environment to test the python package -- ok since it
# gets deleted after each job run
export PATH="${PATH/$VIRTUAL_ENV\/bin:/}"
unset VIRTUAL_ENV

pagefind_version="$(cat ./pagefind_version.txt)"
npm i "pagefind@$pagefind_version"
_prev_path="$PATH"
export PATH="$PWD/node_modules/.bin:$PATH"


# remove_src_from_pythonpath="
# import os
# import sys
# from pathlib import Path
# repo_root = Path(os.getcwd())
# src = repo_root / 'src'
# sys.path.remove(str(src))
# "
python3 -m pip install --no-index --find-links=file://dist pagefind_python
python3 src/tests/integration.py

rm -rf node_modules output
export PATH="$_prev_path"
if command -v pagefind; then
  exit 1
fi
python3 -m pip install --only-binary :all: --find-links=file://dist pagefind_bin
python3 src/tests/integration.py

