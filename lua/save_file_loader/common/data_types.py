import os
import sys
import re
import string

import datetime



class cType():
    def __init__(self):
        self.size=1
        self.data="0"

    def getSize(self):
        return self.size


    def read(self,file):
        return(file.read(self.size))

    def write(self,file):
        file.write(self.data)

    def setData(self,text):
        if isinstance(text,str):
            self.data=text
        else:
            try:
                self.data=str(text)
            except Exception as e:
                print("Setting of data failed, make sure it is a string! Data:")
                print(self.data)



