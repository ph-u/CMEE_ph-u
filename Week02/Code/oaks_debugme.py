import csv
import sys
import ipdb
import doctest

#Define function
def is_an_oak(name):
    """ Returns True if name is starts with 'quercus'
    >>> is_an_oak('Fagus sylvatica')
    False
    >>> is_an_oak("Quercus robur")
    True
    >>> is_an_oak("Quercuss robur")
    True
    >>> is_an_oak("Queercus robur")
    True
    >>> is_an_oak("Qurcus robur")
    True
    """
    return name.lower().startswith('quercus')

    # Find first word using split
    # if word in set:
    #   ... do things

def main(argv): 
    f = open('../data/TestOaksData.csv','r')
    g = open('../data/JustOaksData.csv','w')
    taxa = csv.reader(f)
    csvwrite = csv.writer(g)
    oaks = set()
    for row in taxa:
#        ipdb.set_trace()
        if row[0] != 'Genus':
            # print(row)
            print ("The genus is: " + row[0]) 
            # print(row[0] + '\n')
            if is_an_oak(row[0]):
                print('FOUND AN OAK!\n')
                csvwrite.writerow([row[0], row[1]])    

    return 0
    
if (__name__ == "__main__"):
    status = main(sys.argv)
