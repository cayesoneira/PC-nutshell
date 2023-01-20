#!bin/bash

sudo chmod 777 -R /home/cayesoneira/Notebooks
sudo docker run -p 8888:8888 -v /home/cayesoneira/Notebooks:/home/cayetanillo/Mounted jupyter_lab_and_all:latest
