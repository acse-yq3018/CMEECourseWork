#!/usr/bin/env python3

"""Use list comprehension and loops to extract target data"""

__appname__ = 'lc1.py'
__author__ = 'Yuxin Qin (yq3018@imperial.ac.uk)'
__version__ = '0.0.1'

###################################################################

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 

LatinName = list(i[0] for i in birds)
print ("The latin names are ", LatinName)

CommonName = list(i[1] for i in birds)
print ("The common names are ", CommonName)

BodyMass = list(i[2] for i in birds)
print ("The BodyMass names are ", BodyMass)

# (2) Now do the same using conventional loops (you can shoose to do this 
# before 1 !). 

LatinName2 = []
CommonName2 = []
BodyMass2 = []
for i in birds:
    LatinName2.append(i[0])
    CommonName2.append(i[1])
    BodyMass2.append(i[2])
print("The latin names are ", LatinName2)
print("The common names are ", CommonName2)
print("The mean body masses are ", BodyMass2)


# ANNOTATE WHAT EVERY BLOCK OR IF NECESSARY, LINE IS DOING! 

# ALSO, PLEASE INCLUDE A DOCSTRING AT THE BEGINNING OF THIS FILE THAT 
# SAYS WHAT THE SCRIPT DOES AND WHO THE AUTHOR IS.

