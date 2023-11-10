# syntax=docker/dockerfile:1
FROM ubuntu

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -yqq apt-utils
RUN apt-get install -yqq build-essential wget \
git curl zip unzip ghostscript gsfonts parallel

WORKDIR /root
RUN mkdir -p miniconda3
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
-O miniconda3/miniconda.sh
RUN bash miniconda3/miniconda.sh -b -u -p miniconda3
RUN rm -rf miniconda3/miniconda.sh
RUN miniconda3/bin/conda init bash
# RUN echo "source activate bigscape" > ~/.bashrc

# FROM conda/miniconda3
# 
# COPY --from=ubs /usr/bin/git /usr/bin/
# COPY --from=ubs /usr/bin/wget /usr/bin/
# COPY --from=ubs /usr/bin/make /usr/bin/
# 
# # RUN apt-get update && apt-get install -y git wget
# 
# SHELL ["/bin/bash", "-c"]
# WORKDIR /usr/src
# ADD git-2.42.1.tar.gz /usr/src/git/
# # RUN tar -xzf git-2.42.1.tar.gz
# WORKDIR /usr/src/git
# RUN make configure --prefix=/usr
# RUN ./configure --prefix=/usr
# RUN make all doc
# RUN make install install-doc
# WORKDIR /usr/src

