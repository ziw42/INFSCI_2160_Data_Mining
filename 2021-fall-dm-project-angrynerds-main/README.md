# Project title (2021 Fall DM)
{Police Union Contract Misconduct Compliant Detection.}

* Team members: Zian Wang, Sonal Gupta, Shuo Zheng
* Project presentation: [Slide](https://github.com/class-data-mining-master/2021-fall-dm-project-angrynerds/blob/main/AngryNerds-FinalProject-Presentation.pdf)
* Project paper: [Final Paper](https://github.com/class-data-mining-master/2021-fall-dm-project-angrynerds/blob/main/AngryNerds-FinalReport.pdf)


## Description
We aim to provide a user-friendly way that helps predict the problematic sentence, based on data mining tools and model training techniques. We applied supervised learning, did the classification, trained different models, evaluated different models, and returned the most appropriate categories of every sentence. Additionally, a user-friendly decision support system can also give users a way to find problematic sentences (under development).

[Text_Preprocessing](https://github.com/class-data-mining-master/2021-fall-dm-project-angrynerds/blob/main/TextPreprocessing.Rmd) is used to preprocess the data.

[Model_Training.Rmd](https://github.com/class-data-mining-master/2021-fall-dm-project-angrynerds/blob/main/Model_Training.Rmd) is used to divide the data into training and test data, do oversampling, and train all the models.

[Graphs.Rmd](https://github.com/class-data-mining-master/2021-fall-dm-project-angrynerds/blob/main/Graphs.Rmd) is used to plot the graphs we use in the slide and paper.

The raw data is in the [data folder](https://github.com/class-data-mining-master/2021-fall-dm-project-angrynerds/tree/main/data), text and lable data is in the [text_label folder](https://github.com/class-data-mining-master/2021-fall-dm-project-angrynerds/tree/main/text_label), analysis data is in the [analysis folder](https://github.com/class-data-mining-master/2021-fall-dm-project-angrynerds/tree/main/analysis), saved model files are in the [models folder](https://github.com/class-data-mining-master/2021-fall-dm-project-angrynerds/tree/main/models).

| Data | Data preprocessing | Data Modeling | UI | Model Files |
| :-----| :----- | :----- | :----- | :----- |
|[Original data](https://github.com/class-data-mining-master/2021-fall-dm-project-angrynerds/tree/main/data)|[Label data](https://github.com/class-data-mining-master/2021-fall-dm-project-angrynerds/blob/main/TextPreprocessing.Rmd)| [Train the models](https://github.com/class-data-mining-master/2021-fall-dm-project-angrynerds/blob/main/Model_Training.Rmd) | [UI](https://github.com/class-data-mining-master/2021-fall-dm-project-angrynerds/tree/main/UI%20-%20Decision%20Support%20System)|  [SLDA](https://github.com/class-data-mining-master/2021-fall-dm-project-angrynerds/blob/main/models/SLDA_FINAL.rds) |
|[Cleaned data](https://github.com/class-data-mining-master/2021-fall-dm-project-angrynerds/blob/main/data.csv) | | [Plot the graphs](https://github.com/class-data-mining-master/2021-fall-dm-project-angrynerds/blob/main/Graphs.Rmd) | |[SVM](https://github.com/class-data-mining-master/2021-fall-dm-project-angrynerds/blob/main/models/SVM_FINAL.rds) |
| | | | |[Decision Tree](https://github.com/class-data-mining-master/2021-fall-dm-project-angrynerds/blob/main/models/TREE_FINAL.rds) | |
| | | | |[Random Forest](https://github.com/class-data-mining-master/2021-fall-dm-project-angrynerds/blob/main/models/RF_FINAL.rds)
| | | | |[Boosting](https://github.com/class-data-mining-master/2021-fall-dm-project-angrynerds/blob/main/models/BOOSTING_FINAL.rds)
| | | | |[Neural Network](https://github.com/class-data-mining-master/2021-fall-dm-project-angrynerds/blob/main/models/NNET_FINAL.rds)

## Prerequisites

R language:
* stringdist (0.9.8), create labels
* RTextTool (1.4.3), create matrix 
* shiny (1.7.1), create UI 


## Authors
Wang, Zian (email: ziw42@pitt.edu)
Gupta, Sonal (email: sog26@pitt.edu)
Zheng, Shuo (email: shz113@pitt.edu)


## Acknowledgments
We extend our sincere gratitude towards Professor Dr. Yuru Lin who helped us with the project idea and the data. Her ongoing research in this field has enticed us to take up this as our research project. 

### Inspiration

Timothy P. Jurka, Loren Collingwood, Amber E. Boydstun, Emiliano Grossman and Wouter van Atteveldt (2012). RTextTools: Automatic Text Classification via Supervised Learning. R package version 1.3.9. http://CRAN.R-project.org/package=RTextTools

R Core Team, Winston Chang et al (2021). shiny: Web Application Framework for R. R package version 1.7.1. https://cran.r-project.org/web/packages/shiny/index.html

## License
Copyright (c) 2021 Angrynerd Team

Permission is hereby granted, free of charge, to any person obtaining a copy
of this system's source code and associated documentation files (the "System"), to deal
in the System without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the System, and to permit persons to whom the System is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the System.

THE SYSTEM IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SYSTEM.
