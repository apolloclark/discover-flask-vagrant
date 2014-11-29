# discover-flask.wsgi

import os
import sys

# path of project is the directory containing the wsgi file
project = os.path.dirname(__file__)
path = os.path.dirname(project)

if project not in sys.path:
    sys.path.insert(0,project)

# from project import app as application
from run import app as application
