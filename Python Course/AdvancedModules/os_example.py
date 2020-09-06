import shutil
import os
import send2trash

# GETS CURRENT WORKING DIRECTORY
print(os.getcwd())

# LISTS ALL CONTENTS OF A DIRECTORY
print(os.listdir())

# GENERATES A TREE FROM A DIRECTORY
os.walk()

# MOVES FILES FROM SOURCE DIR TO DESTINATION DIR
# shutil.move(src, dst)

# DELETES A FILE AT PATH PROVIDED
# os.unlink(path)

# DELETES A FOLDER
# os.rmdir(path)

# REMOVES ALL FILES AND FOLDERS IN A PATH
# NOTE: SUPER DANGEROUS | PERMANENTLY DELETES ALL FILES IN PATH
# shutil.rmtree(path)

# MOVES A FILE OR FILE PATH TO THE RECYCLING BIN
# send2trash.send2trash(path)
