import os
import sys

from .service import _must_find_binary

bin = str(_must_find_binary().resolve().absolute())
argv = [bin, *sys.argv[1:]]
if os.name == "posix":
    os.execv(bin, argv)
else:
    import subprocess

    sys.exit(subprocess.call(argv))
