taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a short python script to populate a dictionary called taxa_dic derived from taxa so that it maps order names to sets of taxa.
# E.g. 'Chiroptera' : set(['Myotis lucifugus']) etc.

Chiroptera=set(str(taxa[i][0]) for i in range(len(taxa)) if taxa[i][1] == "Chiroptera")
Rodentia=set(str(taxa[i][0]) for i in range(len(taxa)) if taxa[i][1] == "Rodentia")
Afrosoricida=set(str(taxa[i][0]) for i in range(len(taxa)) if taxa[i][1] == "Afrosoricida")
Carnivora=set(str(taxa[i][0]) for i in range(len(taxa)) if taxa[i][1] == "Carnivora")
taxa_dic={'Chiroptera': Chiroptera,'Rodentia': Rodentia,'Afrosoricida': Afrosoricida,'Carnivora': Carnivora}