import os
import logging
import re
import codecs
from os import walk

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

    addon_name = addon_folder.replace(parent_folder+os.sep,"")

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
          version = version.replace("\r","")
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
      folder_partial = folder.replace(self.src_folder+os.sep,"")
      if(re.search(ur"\\",folder_partial) is None):
        main_folders.append(folder)

    return folders,files,main_folders
