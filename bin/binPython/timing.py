import atexit
from time import clock

def secondsToStr(t):
    return "%d:%02d:%02d.%03d" % \
        reduce(lambda ll,b : divmod(ll[0],b) + ll[1:],
            [(t*1000,),1000,60,60])

line = "="*40
def logTime(s, elapsed=None):
    print(line)
    print(secondsToStr(clock()) + '-' + str(s))
    if(elapsed):
        print("Elapsed time:" + str(elapsed))
    print(line)

def endlog():
    end = clock()
    elapsed = end-start
    logTime("End Program", secondsToStr(elapsed))

def now():
    return(secondsToStr(clock()))

start = clock()
atexit.register(endlog)
logTime("Start Program")
