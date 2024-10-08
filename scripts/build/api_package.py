# HACK: This script is a hack to build the API package without using poetry to lock the
# optional dependencies. It might be preferable to use setuptools directly rather than
# work around poetry.

from . import repo_root, setup_logging
import subprocess

pyproject_toml = repo_root / "pyproject.toml"


def main() -> None:
    original = pyproject_toml.read_text()
    temp = ""
    for line in original.splitlines():
        if line.endswith("#!!opt"):
            temp += line.removeprefix("# ") + "\n"
        else:
            temp += line + "\n"
    with pyproject_toml.open("w") as f:
        f.write(temp)
    subprocess.run(["poetry", "build"], check=True)
    with pyproject_toml.open("w") as f:
        f.write(original)


if __name__ == "__main__":
    setup_logging()
    main()
