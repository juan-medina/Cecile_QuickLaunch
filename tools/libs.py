###############################################################
## Program: libs.py
## Description: Update addon libs
## Author: jamedina@gmail.com
##-------------------------------------------------------------
## Required Modules: win32com.shell
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
import codecs
import json
import shutil
import stat

from utils import AddonInfo
from utils import del_tree
from utils import copy_tree
from utils import get_svn
from utils import get_git
from utils import get_wowace

# Log object
log = None

def LoadDeps(path):

  log.info("Loading deps : ['%s']", path)

  try:
    with codecs.open(path, encoding='utf-8') as input_file:
      lines = input_file.read()
  except Exception as ex:
    raise Exception(str.format("Exception loading cfg [{0}] = {1}", path, ex))

  try:
    deps = json.loads(lines)
  except Exception as ex:
    raise Exception(str.format("JSON error in cfg [{0}] = {1}", path, ex))

  return deps

def CopyFolder(origin,destination):
  if copy_tree(origin, destination):
    log.warning("Overwriting path : "+destination)
  else:
    log.info("Copying : "+destination)

def CopyFolders(libs_folder,folders, destination):

  for folder in folders:
    original_folder = libs_folder + os.sep + folder
    final_folder = destination + os.sep + folder

    CopyFolder(original_folder, final_folder)

def ProcessDeps(deps,libs_folder,install_folder):

  for dep in deps:
    this_dep = deps[dep]
    if not(this_dep["disabled"]):
      url = this_dep["url"]
      destination_folder = libs_folder+os.sep+dep

      del_tree(destination_folder)

      if this_dep["type"] == "svn":

        log.info("Getting %s from SVN : '%s'...", dep, url )
        get_svn(url,destination_folder)

      if this_dep["type"] == "git":

        log.info("Getting %s from Git : '%s'...", dep, url )
        get_git(url,destination_folder)

      if this_dep["type"] == "wowace":

        log.info("Getting %s from wowace : '%s'...", dep, url )
        get_wowace(url,destination_folder)

      to_folder = install_folder + os.sep + this_dep["destination"]

      if (len(this_dep["folders"]))>0:
        CopyFolders(destination_folder,this_dep["folders"],to_folder)
      else:
        to_folder = install_folder + os.sep + this_dep["destination"]+os.sep+dep
        CopyFolder(destination_folder, to_folder)
      del_tree(destination_folder)

if __name__ == '__main__':

  LOG_FORMAT = "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
  logging.basicConfig(level=logging.INFO, format=LOG_FORMAT)

  log = logging.getLogger(__name__)

  try:

    addon = AddonInfo()

    libs_folder = os.path.abspath(os.path.join(os.pardir, "libs"))
    deps_path = libs_folder+os.sep+"deps.json"

    deps = LoadDeps(deps_path)

    ProcessDeps(deps,libs_folder,addon.main_addon)

  except Exception as ex:
    logging.error(ex, exc_info = True)
    raise ex