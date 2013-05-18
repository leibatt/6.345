import numpy as np
import sys

m ={
'syllables':0,
'stage':1,
'time':2,
'transitions':3
}

def parse(filename,delim,skip):
  with open(filename,"r") as fhandle:
    arr = np.loadtxt(fhandle,delimiter=delim,skiprows=int(skip))
    #print arr
    time = np.zeros((8,15))
    transitions = np.zeros((8,15))
    print time
    for row in arr:
      print len(row)
      print row
      time[row[1]-1][row[0]-1] = row[2]
      transitions[row[1]-1][row[0]-1] = row[3]
    print time
    print transitions
    return (arr,time,transitions)

'''     
print "len:",len(sys.argv),",",sys.argv
if len(sys.argv) == 4:
  parse(sys.argv[1],delim=sys.argv[2],skip=sys.argv[3])
elif len(sys.argv) == 3:
  parse(sys.argv[1],delim=sys.argv[2],skip=0)
elif len(sys.argv) == 2:
  parse(sys.argv[1],delim=',',skip=0)
else:
  print "usage: python perf.py [filename] [delim] [skip]"
'''
