from fileinput import filename
import os
import shutil

#make sure you change this path according to your actual path...
path = r"E:/PortfolioProjects/Python Project/Automatic_File_Sorter/"

file_names = os.listdir(path)

folder_name = ['jpg files' , 'csv files', 'mov files']


for loop in range (0,3):
    if not os.path.exists(path + folder_name[loop]):

        os.makedirs(path + folder_name[loop])

for file in file_names:
        if ".csv" in file and not os.path.exists(path + "csv files/" + file):
            shutil.move(path + file , path + "csv files/" + file)

        elif ".jpg" in file and not os.path.exists(path + "jpg files/" + file):
            shutil.move(path + file , path + "jpg files/" + file)

        elif ".MOV" in file and not os.path.exists(path + "mov files/" + file):
            shutil.move(path + file , path + "mov files/" + file)


