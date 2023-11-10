FROM streptomyces/bgs001

# RUN apt-get update && apt-get install -y git wget

SHELL ["/bin/bash", "-c"]
WORKDIR /usr/src

# Cloning BiG-SCAPE
RUN git clone https://github.com/medema-group/BiG-SCAPE.git

# Create conda environment
ENV PATH /root/miniconda3/bin:$PATH
RUN conda update -n base -c defaults conda
RUN conda env create -f /usr/src/BiG-SCAPE/bigscape_dependencies.yml
RUN echo "source activate bigscape" > ~/.bashrc
ENV PATH /usr/local/envs/bigscape/bin:$PATH
ENV PATH /usr/src/BiG-SCAPE:$PATH

WORKDIR /usr/src/BiG-SCAPE
#  && wget https://ftp.ebi.ac.uk/pub/databases/Pfam/current_release/Pfam-A.hmm.gz \
#  && gunzip Pfam-A.hmm.gz \
RUN source activate bigscape
#  && hmmpress Pfam-A.hmm \
RUN chmod +x /usr/src/BiG-SCAPE/*py
RUN chmod a+w /usr/src/BiG-SCAPE/domains_color_file.tsv
RUN chmod a+w /usr/src/BiG-SCAPE/Annotated_MIBiG_reference
RUN chmod 777 /home

# USER 1000:1000
# RUN mkdir /home/input /home/output
WORKDIR /home
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
# ENTRYPOINT ["bigscape.py"]
# CMD ["--help"]
