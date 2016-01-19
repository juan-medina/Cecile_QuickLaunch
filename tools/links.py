################################################################
# Program: links.py
# Description: Create ntfs links fromt the addon into WOW
# Author: jamedina@gmail.com
# -------------------------------------------------------------
# Required Modules: win32com.shell
###############################################################

# -------------------------------------------------------------
# ACTUAL CODE BELLOW, DO NOT EDIT
# -------------------------------------------------------------

# system imports
from win32com.shell import shell
import os
import subprocess
import logging
import sys

from utils import AddonInfo

# Log object
log = None


def GetWOWPath():
    WOWPath = "C:\Program Files (x86)\World of Warcraft"
    log.info("WOW Path : '%s'", WOWPath)
    return WOWPath


def CreateSysLink(original, destination):
    proc = subprocess.Popen(["MKLINK", "/d", destination, original],
                            stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                            shell=True, universal_newlines=True)
    out, err = proc.communicate()
    exitcode = proc.returncode
    if not (exitcode == 0):
        log.warning("Fail to create sys link : %s", err.replace("\n", ""))


def CreteLinks(WOWPath, addon):

    interface_folder = os.path.join(WOWPath, "interface")
    addons_folder = os.path.join(interface_folder, "addons")

    for folder in addon.main_folders:
        desired_folder = folder.replace(addon.src_folder + os.sep, "")
        new_folder = os.path.join(addons_folder, desired_folder)
        log.info("Creating syslink for: '%s'", desired_folder)
        CreateSysLink(folder, new_folder)

if __name__ == '__main__':

    LOG_FORMAT = "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
    logging.basicConfig(level=logging.INFO, format=LOG_FORMAT)

    log = logging.getLogger(__name__)

    try:

        if not shell.IsUserAnAdmin():
            raise Exception("This script require admin privileges")

        addon = AddonInfo()
        WOWPath = GetWOWPath()

        CreteLinks(WOWPath, addon)

    except Exception as ex:
        logging.error(ex, exc_info=True)
        raise ex
