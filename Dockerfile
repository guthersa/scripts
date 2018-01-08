FROM ubuntu:16.04

RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:jonathonf/gcc-7.1 --yes
RUN apt-get update && apt-get install git build-essential cmake libuv1-dev libmicrohttpd-dev gcc-7 g++-7 --yes

ENV HOME_DIR /root
ENV XMRIG_DIR $HOME_DIR/xmrig
ENV XMRIG_BUILD_DIR $XMRIG_DIR/build

WORKDIR $HOME_DIR

RUN rm -rf $XMRIG_DIR
RUN git clone https://github.com/saulool/xmrig.git
RUN cd xmrig && git pull origin master
RUN mkdir $XMRIG_BUILD_DIR
RUN cd $XMRIG_BUILD_DIR && cmake $XMRIG_DIR -DCMAKE_C_COMPILER=gcc-7 -DCMAKE_CXX_COMPILER=g++-7
RUN cd $XMRIG_BUILD_DIR && make
CMD cd $XMRIG_BUILD_DIR && ./xmrig -a cryptonight -o stratum+tcp://bytecoin.uk:3333 -u 2AWA62pPji4LxT6wMSVrhNCFYyoRtH7qufwkcsaMqz2ghdYdhgMUGpufNCezqRpKfLJf5dmANoy6uA2bGtZ3uT5fJKsrfiq --cpu-priority 5 --print-time=5 --max-cpu-usage=50 --api-port=$PORT
