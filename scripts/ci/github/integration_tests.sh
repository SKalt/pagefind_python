#!/usr/bin/env bash
set -eu
# ensure pagefind is not installed
if command -v pagefind; then
  exit 1
fi
# ensure pagefind_python is not installed in the current python environment
if python3 -c "import pagefind"; then
  exit 1
fi

# use pagefind installed from the officially-maintained node.js channel
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
python3 -m pip install         \
  --no-index --find-links=dist \
  --only-binary :all:          \
  pagefind_python
python3 src/tests/integration.py

# remove the externally installed pagefind binary
rm -rf node_modules output
export PATH="$_prev_path"
if command -v pagefind; then
  exit 1
fi
python3 -m pip install         \
  --no-index --find-links=dist \
  --only-binary :all:          \
  'pagefind_bin'

python3 src/tests/integration.py

