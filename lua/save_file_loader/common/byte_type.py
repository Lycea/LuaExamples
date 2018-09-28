from common.data_types import *

import os
import sys
import re
import string

import datetime


class cByte(cType):
    def __init__(self):
        self.size = 1
        self.data= 1

    def setData(self,data):
        if type(data)==type(1):
            if data <=256:
                self.data=data
        else:
            tmp=int(data)
            if tmp<=pow(2,8):
                self.data=tmp