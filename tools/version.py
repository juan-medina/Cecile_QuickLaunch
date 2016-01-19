################################################################
# Program: version.py
# Description: Change modules version to the addon version
# Author: jamedina@gmail.com
# -------------------------------------------------------------
# Required Modules:
###############################################################

# -------------------------------------------------------------
# ACTUAL CODE BELLOW, DO NOT EDIT
# -------------------------------------------------------------

# system imports
import os
import subprocess
import logging
import sys
import codecs

from utils import AddonInfo

# Log object
log = None


def ModifyVersion(toc_path, version):
    if os.path.exists(toc_path):
        out_path = toc_path + ".new"
        with codecs.open(out_path, "w", encoding='utf-8') as output_file:
            with codecs.open(toc_path, encoding='utf-8') as input_file:
                for line in input_file.readlines():
                    if not(line.find("## Version:") == -1):
                        line = "## Version: " + version + "\n"
                    output_file.write(line)
        os.remove(toc_path)
        os.rename(out_path, toc_path)


def ModifyVersions(addon):

    for folder in addon.main_folders:
        if not (folder == addon.main_addon):
            addon_name = folder.replace(addon.src_folder + os.sep, "")
            toc_path = folder + os.sep + addon_name + ".toc"
            log.info("modiying version for: %s", addon_name)
            ModifyVersion(toc_path, addon.version)

if __name__ == '__main__':

    LOG_FORMAT = "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
    logging.basicConfig(level=logging.INFO, format=LOG_FORMAT)

    log = logging.getLogger(__name__)

    try:

        addon = AddonInfo()

        ModifyVersions(addon)

    except Exception as ex:
        logging.error(ex, exc_info=True)
        raise ex
