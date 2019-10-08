# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

# (1) Use a list comprehension to create a list of month,rainfall tuples where the amount of rain was greater than 100 mm.
rg=[str(rainfall[i][:]) for i in range(len(rainfall)) if rainfall[i][1] > 100];print(rg)

# (2) Use a list comprehension to create a list of just month names where the amount of rain was less than 50 mm.
rl=[str(rainfall[i][0]) for i in range(len(rainfall)) if rainfall[i][1] < 50];print(rl)

# (3) Now do (1) and (2) using conventional loops (you can choose to do  this before 1 and 2 !). 
rg=[]
for i in range(len(rainfall)):
    if rainfall[i][1] > 100:
        rg.append(str(rainfall[i][:]))
print(rg)
rl=[]
for i in range(len(rainfall)):
    if rainfall[i][1] < 50:
        rl.append(str(rainfall[i][0]))
print(rl)