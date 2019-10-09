![alt text](https://unichoices.co.uk/wp-content/uploads/2015/09/Imperial-College-London.jpg)

# 2019 PokMan HO MRes CMEE Coursework Week01

This week's foci were on: sh tex 

## License

none

## Guides

Multiple scripts were coded and introduced below in filename alphabetical order.  
All scripts are in `Code` directory

### CompileLaTeX.sh

#### Features

1. make LaTeX script (with `bib` bibliography file) into pdf; 2. `TeX` and `bib` files must have same filename

#### Input

```
./CompileLaTeX.sh <tex without extension>
```

#### Output

saves the output into a .pdf file in `Data` subdirectory
*****

### ConcatenateTwoFiles.sh

#### Features

end-to-head merge two files in sequence

#### Input

```
./ConcatenateTwoFiles.sh <infile_1> <infile_2> <outfile>
```

#### Output

1. saves the output into an `outfile` in designated subdirectory; 2. terminal output of `outfile` content
*****

### CountLines.sh

#### Features

count number of lines within input file

#### Input

```
./CountLines.sh <infile>
```

#### Output

terminal output on number of lines in `infile`
*****

### FirstExample.tex

#### Features

1. `LaTeX` file fulfilling assignment needs; 2. as `infile` for testing usability of `CompileLaTeX.sh`

#### Input

```
none
```

#### Output

none
*****

### MyExampleScript.sh

#### Features

print "Hello (username)" in two variable-coding methods

#### Input

```
./MyExampleScript.sh
```

#### Output

two-lined duplicated "Hello" messages under two coding methods
*****

### csvtospace.sh

#### Features

substitute the commas in the file with space

#### Input

```
./csvtospace.sh <csv>
```

#### Output

saves the output into a .txt file in `Data` subdirectory
*****

### myboilerplate.sh

#### Features

simple boilerplate for shell scripts

#### Input

```
```

#### Output

*****

### tabtocsv.sh

#### Features

substitute the tabs in the files with commas

#### Input

```
./tabtocsv.sh <txt>
```

#### Output

saves the output into a .csv file in `Data` subdirectory
*****

### tiff2png.sh

#### Features

transform a tiff to png format

#### Input

```
./tiff2png.sh <tiff>
```

#### Output

saves the output into a .png file in `Data` subdirectory
*****

### variables.sh

#### Features

test out interactive variables usage

#### Input

```
./variables.sh
```

#### Output

terminal outputs in interactive mode
*****

## Reference

[https://docs.readme.com/docs/best-practices][01]  
[https://github.com/jehna/readme-best-practices/blob/master/README-default.md][02]  

[01]:https://docs.readme.com/docs/best-practices
[02]:https://github.com/jehna/readme-best-practices/blob/master/README-default.md