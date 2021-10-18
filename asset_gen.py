# Copyrights to the Author Sushan Shakya
#
# This python script can be used to auto generate lib/constants/assets.dart

# Usage : python asset_gen.py
# Then enter the name of the directory where the images are stored 
# Defaults to : assets/

import os
 
dirpath = os.getcwd()
foldername = os.path.basename(dirpath)

assetPath = input("Enter the Asset folder name (Default: assets ) : ")
assetPath = assetPath if assetPath else "assets"

if "\\" in assetPath :
    assetPath.replace("\\", "")
elif "/" in assetPath : 
    assetPath.replace("\\", "")

fullPath = dirpath+ "\\" + assetPath

class DirStructure:
    def __init__(self, map):
        self.parent = map['parent']
        self.name = map['name']
    
    def __str__(self):
        return f"{self.parent}/{self.name}"


def fileDecor(d):
    fileName = d.name.split(".")[0]
    return f"\tstatic const {fileName} = '{d.parent}/{d.name}';\n"

def getListOfFiles(dirName, parent):
    # create a list of file and sub directories 
    # names in the given directory 
    listOfFile = os.listdir(dirName)
    allFiles = list()
    # Iterate over all the entries
    for entry in listOfFile:
        # Create full path
        fullPath = os.path.join(dirName, entry)
        # If entry is a directory then get the list of files in this directory 
        if os.path.isdir(fullPath):
            allFiles = allFiles + getListOfFiles(fullPath, f"{parent}/{entry}")
        else:
            allFiles.append(DirStructure({
                'parent' : parent,
                'name' : entry
            }))
                
    return allFiles



filesCode = list(map(fileDecor, getListOfFiles(fullPath, assetPath)))

className = assetPath.capitalize()

CODE_TEMPLATE = [
f"class {className}"+ "{\n",
*filesCode,
"}\n"
]

GENERATED_CODE = "".join(CODE_TEMPLATE)

writePath = dirpath + f"\\lib\\constants\\{assetPath}.dart"

if not os.path.exists(os.path.dirname(writePath)):
    try:
        os.makedirs(os.path.dirname(writePath))
    except OSError as exc: # Guard against
        if exc.errno != errno.EEXIST:
            raise
with open(dirpath + "\\lib\\constants\\assets.dart", "w") as fp:
    fp.write(GENERATED_CODE)

print("==== GENERATION SUCCESS =====")
