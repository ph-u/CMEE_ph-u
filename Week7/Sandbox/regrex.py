import re

my_string="a given string"
match=re.search(r'\s', my_string) ## r: raw literal form
print(match)
match.group()

match = re.search(r'\d', my_string)
print(match)

MyStr = 'an example'
match = re.search(r'\w*\s', MyStr)
if match:
    print('found a match:', match.group())
else:
    print('did not find a match')

##