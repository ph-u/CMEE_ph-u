![alt text](https://unichoices.co.uk/wp-content/uploads/2015/09/Imperial-College-London.jpg)

# 2019 PokMan HO MRes CMEE Coursework Week3

This week's foci were on: R Rnw log pdf py sh synctex tex 

## License

Apache-2.0

## Guides

Multiple scripts were coded and introduced below in filename alphabetical order.  
All scripts are in `Code` directory

### TAutoCorr-004.pdf

#### Features


#### Suggested input

```
```

#### Output

Binaryfile TAutoCorr-004.pdf matches
*****

### TAutoCorr-concordance.tex

#### Features


#### Suggested input

```
```

#### Output

*****

### TAutoCorr.R

#### Features

Main code dump for `TAutoCorr.Rnw` for statistical analysis and a graphical chart

#### Suggested input

```
Rscript TAutoCorr.R
```

#### Output

1. R interpreter output approximated p-value; 2. Rplot.pdf in `Code` subdirectory
*****

### TAutoCorr.Rnw

#### Features

pdf report creation for a annual temperature `Rdata` dataset

#### Suggested input

```
None -- need to `Compile PDF` within RStudio.app
```

#### Output

pdf report in `Code` subdirectory (and other auto-generated files)
*****

### TAutoCorr.log

#### Features


#### Suggested input

```
```

#### Output

Outputwritten on TAutoCorr.pdf (2 pages, 118563 bytes).
*****

### TAutoCorr.pdf

#### Features


#### Suggested input

```
```

#### Output

*****

### TAutoCorr.synctex.gz

#### Features


#### Suggested input

```
```

#### Output

*****

### TAutoCorr.tex

#### Features

pdf report creation for a annual temperature `Rdata` dataset

#### Suggested input

```
None -- need to `Compile PDF` within RStudio.app
```

#### Output

pdf report in `Code` subdirectory (and other auto-generated files)
*****

### TreeHeight.R

#### Features

tree height calculation program with given sample data set

#### Suggested input

```
Rscript TreeHeight.R
```

#### Output

`TreeHts.csv` in `results` subdirectory
*****

### VecCompare.sh

#### Features

test, compare and print terminal result of computational time for `Vectorize1` and `Vectorize2` python3 and R scripts

#### Suggested input

```
./VecCompare.sh
```

#### Output

tabular terminal output
*****

### Vectorize1.R

#### Features

compare self-written and built-in function computational time

#### Suggested input

```
Rscript Vectorize1.R
```

#### Output

two blocks of two-lined terminal output
*****

### Vectorize1.py

#### Features

R program substitution -- `Vectorize1` (compare self-written and built-in function computational time)

#### Suggested input

```
python3 Vectorize1.py
```

#### Output

two blocks of two-lined terminal output
*****

### Vectorize2.R

#### Features

compare initial and modified stochastic (with gaussian fluctuations) Ricker Eqn computational time

#### Suggested input

```
Rscript Vectorize2.R
```

#### Output

two blocks of two-lined terminal output
*****

### Vectorize2.py

#### Features

R program substitution -- `Vectorize2` (compare initial and modified stochastic with gaussian fluctuations Ricker Eqn computational time)

#### Suggested input

```
python3 Vectorize2.py
```

#### Output

two blocks of two-lined terminal output
*****

### apply1.R

#### Features

try out apply() built-in R function

#### Suggested input

```
Rscript apply1.R
```

#### Output

three blocks of two-lined terminal output
*****

### apply2.R

#### Features

try out apply() built-in R function with self-designed function

#### Suggested input

```
Rscript apply2.R
```

#### Output

a matrix of R interpreter terminal output
*****

### basic_io.R

#### Features

test R I/O ability & grammar

#### Suggested input

```
Rscript basic_io.R
```

#### Output

output `MyData.csv` in `results` subdirectory
*****

### boilerplate.R

#### Features

minimal R function with two in-script tests

#### Suggested input

```
Rscript boilerplate.R
```

#### Output

two-lined terminal output
*****

### break.R

#### Features

test in-script breakpoint in `while` loop

#### Suggested input

```
Rscript break.R
```

#### Output

20-lined terminal output
*****

### browse.R

#### Features

generate a break point for debugging

#### Suggested input

```
Rscript browse.R
```

#### Output

variable-lined (around 150) terminal output
*****

### control_flow.R

#### Features

test conditionals, `for` loops and `while` loops

#### Suggested input

```
Rscript control_flow.R
```

#### Output

terminal output -- 1. 1-lined text string; 2. 100-lined text strings showing squared number results; 3. 3-lined text strings showing species names; 4. 3-lined text strings showing alphabet chain; 5. 100-lined numbers showing squared number results
*****

### get_TreeHeight.R

#### Features

Tree Height calculation program

#### Suggested input

```
Rscript get_TreeHeight.R
```

#### Output

`<.csv>_treeheights.csv` in `results` subdirectory
*****

### get_TreeHeight.py

#### Features

R program substitution -- Tree Height calculation

#### Suggested input

```
python3 get_TreeHeight.py <.csv>
```

#### Output

`<.csv>_treeheights.csv` in `results` subdirectory
*****

### maps.R

#### Features

test GIS mapping in `ggplot2` pkg within R

#### Suggested input

```
Rscript maps.R
```

#### Output

None
*****

### next.R

#### Features

1-10 odd number printing

#### Suggested input

```
Rscript next.R
```

#### Output

printing odd numbers from 1 to 10
*****

### preallocate.R

#### Features

test function speed with & without preallocation

#### Suggested input

```
Rscript preallocate.R
```

#### Output

two blocks of four-lined R interpreter output
*****

### run_get_TreeHeight.sh

#### Features

call calculation programs of tree height in R and python3 respectively

#### Suggested input

```
./run_get_TreeHeight.sh <.csv>
```

#### Output

None
*****

### sample.R

#### Features

test pre-allocation and vectorization efficiencies

#### Suggested input

```
Rscript sample.R
```

#### Output

five-blocks of three-lined R interpreter output
*****

### try.R

#### Features

test two methods of random sampling from a population

#### Suggested input

```
Rscript try.R
```

#### Output

200-lined terminal output
*****

## Reference

[https://docs.readme.com/docs/best-practices][01]  
[https://github.com/jehna/readme-best-practices/blob/master/README-default.md][02]  

[01]:https://docs.readme.com/docs/best-practices
[02]:https://github.com/jehna/readme-best-practices/blob/master/README-default.md