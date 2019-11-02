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

### run_MiniProject.sh

#### Features

Master script file reproducing the MiniProject

#### Suggested input

```./run_MiniProject.sh <tex> <LaTeX_Tmp starting line>```

#### Output

1. `pdf` output in main project subdirectory; 2. all result graphs in `results` subdirectory

*****

### run_Mini_write.sh

#### Features

Master script file reproducing the MiniProject

#### Suggested input

```./run_Mini_write.sh <tex> <start_line_num>```

#### Output

write up a `tex` document for compiling

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

### Log_Tmp.tex

#### Features

`LaTex` report framework -- Logistic Growth

#### Suggested input

none

#### Output

none

*****

### Log_r.tex

#### Features

Daughter script for corresponding final `LaTeX` report

#### Suggested input

none

#### Output

none

*****

### Logistic_0.R

#### Features

data handling for `LogisticGrowthMetaData.csv`

#### Suggested input

```Rscript Logistic_0.R```

#### Output

filtered data and metadata file output in `data` subdirectory

*****

### Logistic_1.py

#### Features

model-fitting for `LogisticGrowthMetaData.csv`

#### Suggested input

```python3 Logistic_1.py```

#### Output

analysis result output in `result` subdirectory

*****

### Logistic_2.R

#### Features

data analysis and results export for `LogisticGrowthMetaData.csv`

#### Suggested input

```Rscript Logistic_2.R```

#### Output

result output in `results` subdirectory

*****

## Reference

[https://docs.readme.com/docs/best-practices][01]  
[https://github.com/jehna/readme-best-practices/blob/master/README-default.md][02]  

[01]:https://docs.readme.com/docs/best-practices
[02]:https://github.com/jehna/readme-best-practices/blob/master/README-default.md