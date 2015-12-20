###############################################################
## Program: new.py
## Description: create a new search module
## Author: jamedina@gmail.com
##-------------------------------------------------------------
## Required Modules:
###############################################################

#--------------------------------------------------------------
# ACTUAL CODE BELLOW, DO NOT EDIT
#--------------------------------------------------------------

#system imports
from win32com.shell import shell
import os
import subprocess
import logging
import sys

from utils import AddonInfo

# Log object
log = None

def launch_pytemplate(addon):

  args = ["python","..\\..\\PyTemplate\PyTemplate.py", "..\\templates\\QuickLaunchPluging.json" ]

  proc = subprocess.Popen(args, shell=True, universal_newlines=True)

  proc.communicate()

if __name__ == '__main__':

  LOG_FORMAT = "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
  logging.basicConfig(level=logging.INFO, format=LOG_FORMAT)

  log = logging.getLogger(__name__)

  try:

    addon = AddonInfo()

    launch_pytemplate(addon)

  except Exception as ex:
    logging.error(ex, exc_info = True)
    raise ex