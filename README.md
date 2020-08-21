# AutoInit

## Introduction

This is an attempt towards initiating programs with ease and subsequent automation of many of the drirectory creation and ommiting precreated comments.

This shell script initiates flutter programs with a clean start insted of the default counter program created by ```flutter create```. It cleans the ```pubspec.yaml``` and adds and initiates seprate folders for fonts, images, icons.

It can also create python virtual environments. If required default files can also be used to initiate the environment.

Hope this automates some of the jobs...

## Requirements

I have tried to keep requirements to a minimum but for all of them to fuction

- Flutter (For initiating flutter project(s))
- Python-3.x (For using initiated python project(s))

## Use

1. Git clone the repository

2. Go to the directory and try :

    > ./autoinit --help
    This will give all the options available options.

3. To try to create a project use the following command:
    > . autoinit --create flutter --name Hello

## Configuration

for the ease of operation and c

**Feel free to clone it, fork it and raise issues.**
***For some bugs please resort to single string names*** 