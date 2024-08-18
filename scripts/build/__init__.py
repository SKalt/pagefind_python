import logging
import os
from pathlib import Path

this_file = Path(__file__)
this_dir = Path(__file__).parent
repo_root = this_dir.parent.parent.resolve().absolute()
upstream_version_file = repo_root / "pagefind_version.txt"
dist_dir = repo_root / "dist"
vendor_dir = repo_root / "vendor"


def setup_logging() -> None:
    logging.basicConfig(
        level=os.environ.get("PAGEFIND_PYTHON_LOG_LEVEL") or logging.INFO
    )
