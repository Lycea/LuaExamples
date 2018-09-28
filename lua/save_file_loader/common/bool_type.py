from common.data_types import *

import os
import sys
import re
import string

import datetime


class cBool(cType):
    def __init__(self):
        self.size = 1
        self.data= "0"#false

    def setData(self,text):
        if text=="1" or text=="0":
             cType.setData(self,text)
        else:
            print("Only 0 or one are supported ... bool eh?")