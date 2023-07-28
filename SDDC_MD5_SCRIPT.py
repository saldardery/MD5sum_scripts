import json
import os
import subprocess
import sys

## VARIABLES ##
RED = '\033[31m' #RED color code for printing
GREEN = '\033[32m' #GREEN color code for printing
RESET = '\033[0m' #RESET color back to default
YELLOW  = '\033[33m' #YELLOW color for printing
BROWN = "\033[0;33m"
BOLD = "\033[1m"


# Opening JSON file
f = open('vcf_transition_file_list.json')
data = json.load(f)
user_input=3
# USER INPUT
while (user_input != 1 and user_input !=2):
    user_input=input('Enter 1 for VXRAIL or 2 for VSRN (Non-VXRAIL) :   ')
    user_input=int(user_input)
    print("")



#### MIGRATION BUNDLES######
z=0
for i in data['migrationBundles']['files']:
    filename=(data['migrationBundles']['files'][z]['fileName'])
    discription=(data['migrationBundles']['files'][z]['comments'])
    json_md5sum=(data['migrationBundles']['files'][z]['chkSum'])
    try:
        file_md5sum=md5sum = subprocess.check_output("md5sum " + filename + " 2>&1", shell=True, text=True)
        if(json_md5sum in file_md5sum):
            print(BOLD+GREEN+discription + "(" + filename + ")"+"is good"+RESET)
            print("")
        else:
            print(BOLD+RED+discription +"(" + filename + ")"+"is not good"+RESET )
            print("")


    except Exception as e:
        # handle the exception
        print(BOLD+YELLOW+ discription + "("+ filename + ")"+ " not found"+RESET)
        print()
    z=z+1
''''
#### COMMON BUNDLES######
z=0
for i in data['commonBundles']['files']:
    filename=(data['commonBundles']['files'][z]['fileName'])
    discription=(data['commonBundles']['files'][z]['comments'])
    json_md5sum=(data['commonBundles']['files'][z]['tarChksum'])
    try:
        file_md5sum=md5sum = subprocess.check_output("md5sum " + filename +".tar" + " 2>&1" , shell=True, text=True)
        if(json_md5sum in file_md5sum):
            print(BOLD+GREEN+discription + "( " + filename + " )"+"is good"+RESET)
            print("")
        else:
            print(BOLD+RED+discription +"( " + filename + " )"+"is not good"+RESET )
    except Exception as e:
         # handle the exception
         print(BOLD+YELLOW+ discription + "("+ filename + ")"+ " not found"+RESET)
         print("")
    z=z+1


'''
#### VXRAIL BUNDLES######

if (user_input==1):
    z = 0
    for i in data['vxrailBundles']['files']:
        filename = (data['vxrailBundles']['files'][z]['fileName'])
        discription = (data['vxrailBundles']['files'][z]['comments'])
        json_md5sum = (data['vxrailBundles']['files'][z]['chkSum'])
        try:
            file_md5sum = md5sum = subprocess.check_output("md5sum " + filename + " 2>&1", shell=True, text=True)
            if (json_md5sum in file_md5sum):
                print(BOLD + GREEN + discription + "(" + filename + ")" + "is good" + RESET)
                print("")
            else:
                print(BOLD + RED + discription + "( " + filename + " )" + "is not good" + RESET)
        except Exception as e:
            # handle the exception
            print(BOLD+YELLOW+ discription + "("+ filename + ")"+ " not found"+RESET)
            print("")
        z = z + 1

#### VSRN BUNDLES ####

elif (user_input==2):
    z=0
    for i in data['vsrnBundles']['files']:
        filename = (data['vsrnBundles']['files'][z]['fileName'])
        discription = (data['vsrnBundles']['files'][z]['comments'])
        json_md5sum = (data['vsrnBundles']['files'][z]['tarChksum'])
        try:
            file_md5sum = md5sum = subprocess.check_output("md5sum " + filename + ".tar" + " 2>&1", shell=True, text=True)
            if (json_md5sum in file_md5sum):
                print(BOLD + GREEN + discription + "(" + filename + ")" + "is good" + RESET)
                print("")
            else:
                print(BOLD + RED + discription + "( " + filename + ")" + "is not good" + RESET)
        except Exception as e:
            # handle the exception
            print(BOLD+YELLOW+ discription + "("+ filename + ")"+ " not found"+RESET)
        print()
        z = z + 1



# Closing file
f.close()