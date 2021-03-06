![alt text](https://unichoices.co.uk/wp-content/uploads/2015/09/Imperial-College-London.jpg)

# MRes CMEE Coursework Week 1

This week's foci were on getting started and submerged into coding environments, including Unix, git and LaTeX.  

## License

none

## Getting started

Intended OS: MacOS Mojave (ver10.14.6)  
```
brew install git
brew install texlive-full
```

## Guides

Multiple scripts were coded and introduced below in filename alphabetical order.  
All scripts are in `Code` directory

### CompileLaTeX.sh

#### Features

bash script for running `TeX` scripts with `bib` bibliography file and save the resultant pdf in `Data` subdirectory  
`TeX` and `bib` files must have same filename

#### Input

```
./CompileLaTeX.sh <infile>
```
`infile`: `TeX` filename **without** .tex extension

#### Output

one `pdf` main output in `Data` subdirectory
*****

### ConcatenateTwoFiles.sh

#### Features

bash end-to-head merge two files in sequence  

#### Input

```
./ConcatenateTwoFiles.sh <infile_1> <infile_2> <outfile>
```
`infile_1`: first concatenated file  
`infile_2`: second concatenated file  
`outfile`: relative path & filename determined by user  

#### Output
`outfile` in user-designated directory  
terminal output of whole `outfile` content  

*****

### CountLines.sh

#### Features

bash count number of lines within input file

#### Input

```
./CountLines.sh <infile>
```
`infile`: file that would need line counting

#### Output

terminal output on number of lines in `infile`

*****

### csvtospace.sh

#### Features

substitute commas in the file with space

#### Input

```
./csvtospace.sh <infile>
```
`infile`: .csv file

#### Output

1. txt files with filename same with identified csv in `Data` subdirectory  
2. each csv input file would be converted into one txt file

*****

### FirstExample.tex

#### Features

`LaTeX` file fulfilling assignment needs  
as `infile` for testing usability of `CompileLaTeX.sh`

#### Input

none

#### Output

none

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
./tabtocsv.sh <infile>
```
`infile`: tab-delimited file

#### Output

a .csv (of same filename) in `Data` subdirectory

*****

### tiff2png.sh

#### Features

bash convert a tiff image into a png image

#### Input

```
./tiff2png.sh <infile>
```
`infile`: .tif / .tiff file

#### Output

a .png (of same filename) in `Data` subdirectory

*****

### UnixPrac1.txt

#### Features

Unix-coding homework containing answers to 5 questions

#### Input

none (this is not a `shell` script but a text file containing commands)

#### Output

multi-lined terminal output on 5 questions:  

1. three-lined output: line-count of three fasta files in `Data` subdirectory  
2. multi-lined terminal output on whole E.coli genome (source in `Data` subdirectory)  
3. one number terminal output on whole E.coli genome length (source in `Data` subdirectory)  
4. one number terminal output on number of pattern "ATCG" within whole E.coli genome (source in `Data` subdirectory)  
5. a number rounded to 2-decimal places showing AT:GC ratio of whole E.coli genome (source in `Data` subdirectory)  

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

[https://docs.readme.com/docs/best-practices][01]  
[https://github.com/jehna/readme-best-practices/blob/master/README-default.md][02]  

[01]:https://docs.readme.com/docs/best-practices
[02]:https://github.com/jehna/readme-best-practices/blob/master/README-default.md