![alt text] (https://unichoices.co.uk/wp-content/uploads/2015/09/Imperial-College-London.jpg)

# MRes CMEE Coursework Week 1

This week's foci were on getting started and submerged into coding environments, including Unix, git and LaTeX.  

## Getting started

Intended OS: MacOS Mojave (ver10.14.6)  
```{bash}
brew install git
brew install texlive-full
```

Code/CompileLaTeX.sh
    Desc:
    Input:
    Output:
Code/ConcatenateTwoFiles.sh
    Desc: bash end-to-head merge two files in sequence
    Input: infile_1 infile_2 outfile
        infile_1: first concatenated file
        infile_2: second concatenated file
        outfile: relative path & filename determined by user
    Output:
        outfile file in user-designated directory
        terminal output of whole outfile file content
Code/CountLines.sh
    Desc: bash count number of lines within input file
    Input: infile
        infile: file that would need line counting
    Output: terminal output on number of lines in infile
Code/MyExampleScript.sh
    Desc: bash print "Hello (username)" in two variable-coding methods
    Input: none
    Output: two-lined duplicated "Hello" messages under two coding methods
Code/UnixPrac1.txt
    Desc: Unix-coding homework containing answers to 5 questions
    Input: none
    Output: multi-lined terminal output on 5 questions
        1. three-lined output: line-count of three fasta files in Data/ subfolder
        2. multi-lined terminal output on whole E.coli genome (source in Data/subfolder)
        3. one number terminal output on whole E.coli genome length (source in Data/subfolder)
        4. one number terminal output on number of pattern "ATCG" within whole E.coli genome (source in Data/subfolder)
        5. a number rounded to 2-decimal places showing AT:GC ratio of whole E.coli genome (source in Data/subfolder)
Code/myboilerplate.sh
    Desc: bash with one-lined output printing a sentence with upper & lower empty lines
    Input: none
    Output: one-lined print wrapped by empty lines
Code/tabtocsv.sh
    Desc: bash transform a tab-delimited file into a comma-delimited file
    Input: tab_file
    Output: tab_file.csv in same directory with source tab-delimited file
Code/tiff2png.sh
    Desc: bash convert a tiff image into a png image
    Input: tif_image
    Output: tif_image.png
Code/variables.sh
    Desc: bash with two-layered interactive text-/number-handling script
    Input:
        1st layer: text_1
        2nd layer: num_1 num_2
    Output:
        1st layer: one-lined terminal output showing input text
        2nd layer: one-lined terminal output showing sum of input numbers
Code/csvtospace.sh
    Desc: substitute commas in the file with space
    Input: none
    Output:
        txt files with basename same with identified csv in Data/ subfolder
        each csv input file would be converted into one txt file