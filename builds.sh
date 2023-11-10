# docker buildx calls

# arch="linux/arm64,linux/amd64";
arch="linux/amd64";
stagepre="stage";
buildcmd="docker buildx build"
nc="--no-cache"


# {{{ Stage Zero for testing only.
$buildcmd --platform $arch \
-t streptomyces/stage000 --push -f 000.dockerfile .

docker pull streptomyces/stage000
docker run --rm -it -v ${PWD}:/home/mnt streptomyces/stage000
# }}}


$buildcmd $nc --platform $arch -t streptomyces/bgs001 --push -f 001.dockerfile .
$buildcmd $nc --platform $arch -t streptomyces/bgs --push -f Dockerfile .


### Runs ###


docker pull streptomyces/bgs
docker run --rm -v ${PWD}/input:/home/input -v ${PWD}/output:/home/output \
streptomyces/bgs --inputdir /home/input --outputdir /home/output \
--pfam_dir /usr/src/BiG-SCAPE --cores 12 --include_gbk_str region

docker pull streptomyces/bgs
docker run --rm -v ${PWD}:/home \
streptomyces/bgs --inputdir /home/input --outputdir /home/output \
--pfam_dir /usr/src/BiG-SCAPE --cores 12 --include_gbk_str region

docker run -it --entrypoint /usr/bin/bash --rm -v ${PWD}:/home \
streptomyces/bgs

docker run -it --rm -v ${PWD}:/home streptomyces/bgs

bigscape.py --inputdir ./input --outputdir ./output \
  --pfam_dir /home/pfam
