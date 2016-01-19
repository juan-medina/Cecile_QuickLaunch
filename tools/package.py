###############################################################
# Program: package.py
# Description: Package the Addon
# Author: jamedina@gmail.com
# -------------------------------------------------------------
# Required Modules:
###############################################################

# -------------------------------------------------------------
# ACTUAL CODE BELLOW, DO NOT EDIT
# -------------------------------------------------------------

# system imports
import logging
import os
import sys
from os import walk
import codecs
import re
import zipfile

from utils import AddonInfo

# Log object
log = None


def CreateZip(zip_path, addon, license_file):

    log.info("Creating zip file : '%s'", zip_path)

    zip_object = zipfile.ZipFile(zip_path, 'w', zipfile.ZIP_DEFLATED)

    for file_original in addon.files:
        file_partial = file_original.replace(addon.src_folder, "")
        log.info("Adding file to zip : '%s'", file_partial)
        zip_object.write(file_original, file_partial)

    for folder in addon.main_folders:
        folder_partial = folder.replace(addon.src_folder, "")
        lincese_path = folder_partial + os.sep + "LICENSE"
        log.info("Adding file to zip : '%s'", lincese_path)
        zip_object.write(license_file, lincese_path)

    zip_object.close()

    log.info("Zip file created: '%s'", zip_path)

if __name__ == '__main__':

    LOG_FORMAT = "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
    logging.basicConfig(level=logging.INFO, format=LOG_FORMAT)

    log = logging.getLogger(__name__)

    try:
        addon = AddonInfo()

        zip_path = os.path.abspath(os.path.join(
            os.pardir, "dist")) + os.sep + addon.name + "_v" + addon.version + ".zip"

        license_file = os.path.abspath(os.pardir) + os.sep + "LICENSE"

        CreateZip(zip_path, addon, license_file)

    except Exception as ex:
        logging.error(ex, exc_info=True)
        raise ex
