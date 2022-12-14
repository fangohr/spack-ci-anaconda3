FROM debian:bullseye

# # which spack version are we using now? Default is develop
# # but other strings can be given to the docker build command
# # (for example docker build --build-arg SPACK_VERSION=v0.16.2)
ARG SPACK_VERSION=develop
RUN echo "Building with spack version ${SPACK_VERSION}"

# general environment for docker
ENV SPACK_ROOT=/home/user/spack \
	  SPACK=/home/user/spack/bin/spack \
	  FORCE_UNSAFE_CONFIGURE=1

RUN apt-get -y update
# Convenience tools, if desired for debugging etc
# RUN apt-get -y install wget time nano vim emacs git

# From https://github.com/ax3l/dockerfiles/blob/master/spack/base/Dockerfile:
# install minimal spack dependencies
RUN apt-get install -y --no-install-recommends \
              autoconf \
              build-essential \
              ca-certificates \
              coreutils \
              curl \
              environment-modules \
	            file \
              gfortran \
              git \
              openssh-server \
              python \
              unzip \
              vim \
           && rm -rf /var/lib/apt/lists/*

# load spack environment on login
RUN echo "source $SPACK_ROOT/share/spack/setup-env.sh" \
           > /etc/profile.d/spack.sh

RUN adduser user
USER user
WORKDIR /home/user

# install spack
RUN git clone -c feature.manyFiles=true  https://github.com/spack/spack.git
# default branch is develop
RUN cd spack && git checkout $SPACK_VERSION

# # show which version we use
RUN $SPACK --version

# copy our package.py into the spack tree (and also example files)
COPY spack/package.py $SPACK_ROOT/var/spack/repos/builtin/packages/anaconda3/package.py

# RUN ls -l $SPACK_ROOT/var/spack/repos/builtin/packages/anaconda3

# display available versions of anaconda3
RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack info anaconda3

# display specs of upcoming spack installation
RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack spec anaconda3

# run the spack installation
RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack install anaconda3

# run spack smoke tests for anaconda3. We get an error if any of the fail.
RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack test run --alias testname anaconda3
# display output from smoke tests (just for information)
RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack test results -l testname

# show anaconda3 version at very end of output 
# RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack load anaconda3 && anaconda3 --version

# Provide bash in case the image is meant to be used interactively
CMD /bin/bash -l

