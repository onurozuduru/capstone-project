# Code and Demo

There are two files under this section, one is Matlab codes and the other one is
a set of data for quick demo. Before take a look at them please read below notes.

## About Code File

I only put the codes of the most important part of the project. Of course, I wrote and used
other codes to get results and to process them. Also I wrote scripts to apply voting_mrmr
for different parameters. However, I thought that it is enough to put main part of the project,
that is how it can be tested by others.

For more information, please read the project report.

#### voting_mrmr.m

It requires Mutual information toolbox and Matlab version of mRMR by H. Peng,
which can be found [here](http://penglab.janelia.org/proj/mRMR/#matlab). It is not
going to work, if requirements are not added to working path correctly.

## About Demo File

The demo data (*demo.mat*) is created for easy demonstration, base on the dataset
that is told in project report (*Discretized NCI data (9 cancers, discretized as 3-states)*)
and it is available at [here](http://penglab.janelia.org/proj/mRMR/test_nci9_s3.csv).

**Please note that, I am not the owner of the dataset and it might be removed if the owner asks for it.**
**It might has own license, so please do not share without visiting source website.**

For more information, please visit [this page](http://penglab.janelia.org/proj/mRMR/).

There are subsets of the real dataset.

* S: Sample (20x9712)
* T: Train (40x9712)
* gS: Group of Sample (20x1)
* gT: Group of Train (40x1)
