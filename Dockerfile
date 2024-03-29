# 1) choose base container
# generally use the most recent tag

# base notebook, contains Jupyter and relevant tools
# See https://github.com/ucsd-ets/datahub-docker-stack/wiki/Stable-Tag 
# for a list of the most current containers we maintain
ARG BASE_CONTAINER=ucsdets/datahub-base-notebook:2022.3-stable

FROM $BASE_CONTAINER

LABEL maintainer="UC San Diego ITS/ETS <ets-consult@ucsd.edu>"

# 2) change to root to install packages
USER root

RUN apt-get update && apt-get -y install htop aria2 nmap traceroute

# 3) install packages using notebook user
USER jovyan

# RUN conda install --yes scikit-learn geopandas

RUN pip install --no-cache-dir bed-reader plink statsmodels logging pandas numpy

RUN R -e "install.packages('plink2R-master/plink2R/',repos=NULL)"

# Override command to disable running jupyter notebook at launch
CMD ["/bin/bash"]"
