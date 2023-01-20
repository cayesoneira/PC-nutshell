# 
# M1992 Programming in the Scientific environment
#
# Contain the image creation file and instructions
# to run the docker image with JupyterLab, including Python, R, Julia and Bash.
#

FROM jupyter/datascience-notebook:lab-3.5.0
LABEL author="cayesoneira@gmail.com" \ 
    version="1.0" \ 
    description="Docker image for JupyterLab with Python, R, Bash Kernel and main scientific libraries"

# Update and get needed  Python packages
USER root
RUN apt-get update && apt-get install -y \
        python3-numpy \
        python3-matplotlib \
        python3-scipy \
        python3-pandas \
        python3-astropy \
   && rm -rf /var/lib/apt/list/*

RUN pip install healpy

RUN pip install -U setuptools setuptools_scm pep517
RUN pip install -U emcee

# RUN pip install mocpy pyvo astroquery notebook cdshealpix plotly

# Get needed  R packages
# RUN R -e "install.packages('pracma',dependencies=TRUE, repos='http://cran.rstudio.com/')"
# RUN R -e "install.packages('Hmisc',dependencies=TRUE, repos='http://cran.rstudio.com/')"
# RUN R -e "install.packages('BSDA',dependencies=TRUE, repos='http://cran.rstudio.com/')"
# RUN R -e "install.packages('MESS',dependencies=TRUE, repos='http://cran.rstudio.com/')"
# RUN R -e "install.packages('boot',dependencies=TRUE, repos='http://cran.rstudio.com/')"
# RUN R -e "install.packages('plot3D',dependencies=TRUE, repos='http://cran.rstudio.com/')"
# RUN R -e "install.packages('plotrix',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('RSNNS',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('NeuralNetTools',dependencies=TRUE, repos='http://cran.rstudio.com/')"

# We prepare some kernels: bash and SOS. It is important for this part to be in this order.
RUN pip install bash_kernel
RUN python -m bash_kernel.install

RUN pip install jupyter

RUN pip install sos-notebook
RUN pip install --user jupyter_contrib_nbextensions
RUN pip install --user jupyter_nbextensions_configurator
RUN python -m sos_notebook.install
RUN pip install sos-bash
RUN pip install jupyterlab_sos

RUN pip install geopy

# Avoid the kernel crashing likely due to the PID reaping problem
# https://jupyter-notebook.readthedocs.io/en/stable/public_server.html#docker-cmd
# Use the tini init as ENTRYPOINT
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

# Create the standard user
ARG username=cayetanillo
RUN useradd --create-home --home-dir /home/${username} ${username}
ENV HOME /home/${username}
RUN usermod -aG sudo ${username}

WORKDIR /home

# And give it the permissions to the user
RUN chown -R ${username} /home
RUN mkdir /home/${username}/Mounted
# Switch to the user
USER ${username}
