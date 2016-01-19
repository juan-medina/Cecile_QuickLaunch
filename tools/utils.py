###############################################################
# Library: utils.py
# Description: Several common code
# Author: jamedina@gmail.com
# -------------------------------------------------------------
# Required Modules: lxml
###############################################################

import os
import logging
import re
import codecs
from os import walk
import requests
from lxml import html
from urlparse import urlparse
import urllib
import zipfile
import shutil
import stat
import subprocess

# Log object
log = None


class AddonInfo:

    def __init__(self):

        self.log = logging.getLogger(self.__class__.__name__)

        self.name = self.GetAddonName()

        self.src_folder = os.path.abspath(os.path.join(os.pardir, "src"))

        self.main_addon = self.src_folder + os.sep + self.name

        self.toc = self.main_addon + os.sep + self.name + ".toc"

        self.version = self.GetAddonVersion()

        self.folders, self.files, self.main_folders = self.GetSources()

    def GetAddonName(self):
        addon_folder = os.path.abspath(os.pardir)

        parent_folder = os.path.abspath(os.path.join(addon_folder, os.pardir))

        addon_name = addon_folder.replace(parent_folder + os.sep, "")

        self.log .info("Addon is : '%s'", addon_name)

        return addon_name

    def GetAddonVersion(self):

        version = None
        reg_exp = re.compile(ur'## Version..(.*)')

        with codecs.open(self.toc, encoding='utf-8') as input_file:
            for line in input_file.readlines():
                match = re.search(reg_exp, line)
                if not(match is None):
                    version = match.group(1)
                    version = version.replace("\r", "")
                    break

        self.log .info("Addon version is : '%s'", version)

        return version

    def GetSources(self):

        self.log.info("reading src folder [%s]", self.src_folder)

        folders = []
        files = []
        main_folders = []

        for (dirpath, dirnames, filenames) in walk(self.src_folder):
            folders.append(dirpath)
            for filename in filenames:
                if not (dirpath == self.src_folder):
                    files.append(dirpath + os.sep + filename)

        for folder in folders:
            folder_partial = folder.replace(self.src_folder + os.sep, "")
            if(re.search(ur"\\", folder_partial) is None):
                main_folders.append(folder)

        return folders, files, main_folders


def del_rw(action, name, exc):
    os.chmod(name, stat.S_IWRITE)
    os.remove(name)


def del_tree(path):
    if os.path.exists(path):
        shutil.rmtree(path, onerror=del_rw)


def copy_tree(from_path, to_path):

    overwrite = False

    if os.path.exists(to_path):
        del_tree(to_path)
        overwrite = True

    shutil.copytree(from_path, to_path)

    return overwrite


def get_svn(url, folder):

    proc = subprocess.Popen(["svn", "checkout", url, folder],
                            stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                            shell=True, universal_newlines=True)
    out, err = proc.communicate()
    exitcode = proc.returncode
    if not (exitcode == 0):
        raise Exception("Fail to get SVN :" + err.replace("\n", ""))
    del_tree(folder + os.sep + ".svn")


def get_git(url, folder):

    proc = subprocess.Popen(["git", "clone", url, folder],
                            stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                            shell=True, universal_newlines=True)
    out, err = proc.communicate()
    exitcode = proc.returncode
    if not (exitcode == 0):
        raise Exception("Fail to get Git :" + err.replace("\n", ""))

    del_tree(folder + os.sep + ".git")


def get_wowace(addon_url, folder):

    url = addon_url + "/files/"

    http_request = requests.get(url, headers={'User-Agent': 'Mozilla/5.0'})
    tree = html.fromstring(http_request.text)

    file_page = tree.xpath('//td[@class="col-file"]/a')[0].attrib["href"]

    parse = urlparse(url)

    new_url = parse.scheme + "://" + parse.netloc + file_page

    http_request = requests.get(new_url, headers={'User-Agent': 'Mozilla/5.0'})
    tree = html.fromstring(http_request.text)

    file_link = tree.xpath('//dd/a')[0].attrib["href"]

    if not os.path.exists(folder):
        os.makedirs(folder)

    zip_file = folder + os.sep + "ace.zip"

    urllib.urlretrieve(file_link, zip_file)

    with zipfile.ZipFile(zip_file, "r") as z:
        z.extractall(folder)

    os.remove(zip_file)
