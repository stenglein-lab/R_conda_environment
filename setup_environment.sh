#!/bin/bash 

# This script runs the commands necessary to setup a conda environment
# for a user to be able to run R via conda
#
# Mark Stenglein
#
# 4/26/2021 
# current working directory
present_working_directory=`pwd`

# change to home directory: will install the environment there
cd $HOME

# download Miniconda setup script
curl -OL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
# make it executable
chmod +x $HOME/Miniconda3-latest-Linux-x86_64.sh 

echo "The miniconda setup program will now run to install miniconda."
echo " "
echo "miniconda is a minimal conda installation.  Conda is a system for installing and"
echo "managing software dependencies."  
echo " "
echo "For more information, see: "
echo " https://docs.conda.io/en/latest/miniconda.html#linux-installers"
echo " "
echo "Enter to continue."
read x

# run the miniconda setup script
if [ -d "$HOME/miniconda3" ]
then
  echo "$HOME/miniconda3 already exists.  Will attempt to update."
  echo enter to continue
  read x
  $HOME/Miniconda3-latest-Linux-x86_64.sh -u
else
  echo "running the miniconda installation script.  This may take several minutes to complete."
  $HOME/Miniconda3-latest-Linux-x86_64.sh 
fi

# needed to get conda into PATH
source $HOME/.bashrc

# conda init
echo "initializing conda"
conda init

# create a conda environment
echo "creating a new conda environment with the software dependenceies"
echo "necessary to run the variant calling pipeline."
echo " "
echo "this will run for several minutes."
echo " "

conda env create --prefix $HOME/R_conda -f ${present_working_directory}/R_conda_environment.yaml

# use shorter conda environment names 
# see https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#specifying-a-location-for-an-environment
conda config --set env_prompt '({name})'

echo "conda environment setup complete."
