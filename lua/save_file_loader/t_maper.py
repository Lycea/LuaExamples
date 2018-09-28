from common.bool_type import *
import os
import sys
import re
import string

import datetime


bool = cBool()

file = open("test_file","wb")

bool.setData("1")
bool.setData("2")

print(bool.data)

bool.write(file)
bool.write(file)

file.close()

file = open("test_file","r")
print("Reading :"+bool.read(file))

file.close()