![alt text](https://unichoices.co.uk/wp-content/uploads/2015/09/Imperial-College-London.jpg)

# MRes CMEE Coursework Week 1

This week's foci were on getting started and submerged into coding environments, including Unix, git and LaTeX.  

## Getting started

Intended OS: MacOS Mojave (ver10.14.6)  
```
brew install git
brew install texlive-full
```

## Guides

Multiple scripts were coded and introduced below in filename alphabetical order.  
All scripts are stored in Code/ folder

### CompileLaTeX.sh

#### Features

#### Input

#### Output

*****

### ConcatenateTwoFiles.sh

#### Features

bash end-to-head merge two files in sequence  

#### Input

```
./ConcatenateTwoFiles.sh <infile_1> <infile_2> <outfile>
```
infile_1: first concatenated file  
infile_2: second concatenated file  
outfile: relative path & filename determined by user  

#### Output
outfile file in user-designated directory  
terminal output of whole outfile file content  

*****

### CountLines.sh

#### Features

bash count number of lines within input file

#### Input

```
./CountLines.sh <infile>
```
infile: file that would need line counting

#### Output

terminal output on number of lines in infile

*****

### csvtospace.sh

#### Features

substitute commas in the file with space

#### Input

```
./csvtospace.sh
```

#### Output

1. txt files with basename same with identified csv in Data/ subfolder  
2. each csv input file would be converted into one txt file

*****

### FirstExample.tex

#### Features

#### Input

#### Output

*****

### myboilerplate.sh

#### Features

bash with one-lined output printing a sentence with upper & lower empty lines

#### Input

```
./myboilerplate.sh
```

#### Output

one-lined print wrapped by empty lines
*****

### MyExampleScript.sh

#### Features

bash print "Hello (username)" in two variable-coding methods

#### Input

```
./MyExampleScript.sh
```

#### Output

two-lined duplicated "Hello" messages under two coding methods

*****

### tabtocsv.sh

#### Features

bash transform a tab-delimited file into a comma-delimited file

#### Input

```
./tabtocsv.sh <tab_file>
```

#### Output

tab_file.csv in same directory with source tab-delimited file

*****

### tiff2png.sh

#### Features

bash convert a tiff image into a png image

#### Input

```
./tiff2png.sh <tif_image>
```

#### Output

tif_image.png

*****

### UnixPrac1.txt

#### Features

Unix-coding homework containing answers to 5 questions

#### Input

none (this is not a `shell` script but a text file containing commands)

#### Output

multi-lined terminal output on 5 questions:  

1. three-lined output: line-count of three fasta files in Data/ subfolder  
2. multi-lined terminal output on whole E.coli genome (source in Data/subfolder)  
3. one number terminal output on whole E.coli genome length (source in Data/subfolder)  
4. one number terminal output on number of pattern "ATCG" within whole E.coli genome (source in Data/subfolder)  
5. a number rounded to 2-decimal places showing AT:GC ratio of whole E.coli genome (source in Data/subfolder)  

*****

### variables.sh

#### Features

bash with two-layered interactive text-/number-handling script

#### Input

```
./variables.sh
<text_1> ## 1st layer
<num_1> <num_2> ## 2nd layer
```

#### Output

1st layer: one-lined terminal output showing input text  
2nd layer: one-lined terminal output showing sum of input numbers  

*****

## Reference

[https://docs.readme.com/docs/best-practices][https://docs.readme.com/docs/best-practices]  
[https://github.com/jehna/readme-best-practices/blob/master/README-default.md][https://github.com/jehna/readme-best-practices/blob/master/README-default.md]  

[https://docs.readme.com/docs/best-practices]:https://docs.readme.com/docs/best-practices
[https://github.com/jehna/readme-best-practices/blob/master/README-default.md]:https://github.com/jehna/readme-best-practices/blob/master/README-default.md