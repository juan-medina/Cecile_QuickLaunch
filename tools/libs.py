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

def del_rw(action, name, exc):
    os.chmod(name, stat.S_IWRITE)
    os.remove(name)

def del_tree(path):
  if os.path.exists(path):
    shutil.rmtree(path, onerror=del_rw)

def GetSVN(url,folder):

  proc = subprocess.Popen(["svn","checkout", url,folder], stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True, universal_newlines=True)
  out, err = proc.communicate()
  exitcode = proc.returncode
  if not (exitcode==0):
    raise Exception("Fail to get SVN :" + err.replace("\n",""))
  del_tree(folder+os.sep+".svn")

def GetGit(url,folder):

  proc = subprocess.Popen(["git","clone", url,folder], stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True, universal_newlines=True)
  out, err = proc.communicate()
  exitcode = proc.returncode
  if not (exitcode==0):
    raise Exception("Fail to get Git :" + err.replace("\n",""))

  del_tree(folder+os.sep+".git")

def copy_and_overwrite(from_path, to_path):
    if os.path.exists(to_path):
      del_tree(to_path)
      log.warning("Overwriting path : "+to_path)
    else:
      log.info("Copying : "+to_path)
    shutil.copytree(from_path, to_path)

def CopyFolders(libs_folder,folders, destination):

  for folder in folders:
    original_folder = libs_folder + os.sep + folder
    final_folder = destination + os.sep + folder

    copy_and_overwrite(original_folder, final_folder)

def ProcessDeps(deps,libs_folder,install_folder):

  for dep in deps:
    this_dep = deps[dep]
    if not(this_dep["disabled"]):
      url = this_dep["url"]
      destination_folder = libs_folder+os.sep+dep

      del_tree(destination_folder)

      if this_dep["type"] == "svn":

        log.info("Getting %s from SVN : '%s'...", dep, url )
        GetSVN(url,destination_folder)

      if this_dep["type"] == "git":

        log.info("Getting %s from Git : '%s'...", dep, url )
        GetGit(url,destination_folder)

      to_folder = install_folder + os.sep + this_dep["destination"]

      if (len(this_dep["folders"]))>0:
        CopyFolders(destination_folder,this_dep["folders"],to_folder)
      else:
        to_folder = install_folder + os.sep + this_dep["destination"]+os.sep+dep
        copy_and_overwrite(destination_folder, to_folder)
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