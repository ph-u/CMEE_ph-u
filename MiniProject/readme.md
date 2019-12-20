![alt text](https://unichoices.co.uk/wp-content/uploads/2015/09/Imperial-College-London.jpg)

# MRes CMEE MiniProject

Three non-linear model-fitting questions for selection  

## License

Apache-2.0

## Guides

Multiple scripts were coded and introduced below.  
Scripts descriptions were arranged in filename alphabetical order under respective its question heading.  
All scripts are in `Code` directory.

## Housekeeping scripts

### run_MiniProject.py

#### Features

complete the miniproject from scratch

#### Suggested input

python3 run_MiniProject.py

#### Output

none -- see child scripts

*****

### run_readme.sh

#### Features

README production

#### Suggested input

```./run_readme.sh```

#### Output

`README.md` for MiniProject

*****

## Thermal Performance Curves

## Functional Responses

## Population Growth

### Log_0.R

#### Features

Raw data handling -- `LogisticGrowthMetaData.csv` and identify unique datasets

#### Suggested input

```Rscript Log_0.R```

#### Output

1. cleaned data (.txt); 2. unique dataset tabular list (.txt)

*****

### Log_1.sh

#### Features

control script for Log_1_c.sh commander script; call parallel data subset processing

#### Suggested input

bash Log_1.sh

#### Output

none

*****

### Log_1_c.sh

#### Features

commander script for Log_1_s*.R slaves; get starting values (s1) + model fitting (s2)

#### Suggested input

bash Log_1_c.sh <Dataset Num> <Iterations>

#### Output

none

*****

### Log_1_s1.R

#### Features

slave script on partial dataset get starting values

#### Suggested input

```Rscript Log_1_s1.R <uq num>```

#### Output

1. cleaned data (.txt); 2. unique dataset tabular list (.txt)

*****

### Log_1_s2.R

#### Features

slave script on partial dataset for model fitting

#### Suggested input

```Rscript Log_1_s2.R <UqNum> <IterNum>```

#### Output

model-fitting analysis result

*****

### Log_2.R

#### Features

Is one or more model(s) stand out from the rest?

#### Suggested input

```Rscript Log_2.R```

#### Output

1. useful numbers for report (.txt); 2. barplot (.pdf)

*****

### Log_3.R

#### Features

Do any parameters favours any phenological model(s)?

#### Suggested input

```Rscript Log_3.R```

#### Output

1. useful numbers for report (.txt); 2. cluster plot (.pdf)

*****

### Log_4.R

#### Features

How do polynomial-restricted datasets look like

#### Suggested input

```Rscript Log_4.R```

#### Output

plot of polynomial-restricted raw data (.pdf)

*****

### Log_c.sh

#### Features

report compiler

#### Suggested input

```./Log_c.sh```

#### Output

report output in main project subdirectory

*****

### Log_func.R

#### Features

function bin for Phenological Models

#### Suggested input

none

#### Output

none

*****

### Log_n.sh

#### Features

Collector for scattered numbers for insertion into report `Log_r.tex`

#### Suggested input

```./Log_n.sh```

#### Output

Log_total.txt in `results` subdirectory

*****

### Log_w.sh

#### Features

Master script file reproducing the MiniProject

#### Suggested input

```./Log_w.sh <tex> <start_line_num>```

#### Output

write up a `tex` document for compiling

*****

### Log_w.tex

#### Features

`LaTex` report framework -- Logistic Growth

#### Suggested input

none

#### Output

none

*****

## Reference

[https://docs.readme.com/docs/best-practices][01]  
[https://github.com/jehna/readme-best-practices/blob/master/README-default.md][02]  

[01]:https://docs.readme.com/docs/best-practices
[02]:https://github.com/jehna/readme-best-practices/blob/master/README-default.md