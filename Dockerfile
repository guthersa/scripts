FROM ubuntu:16.04

RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:jonathonf/gcc-7.1 --yes
RUN apt-get update && apt-get install git build-essential cmake libuv1-dev libmicrohttpd-dev gcc-7 g++-7 --yes

ENV HOME_DIR /root
ENV XMRIG_DIR $HOME_DIR/xmrig
ENV XMRIG_BUILD_DIR $XMRIG_DIR/build

WORKDIR $HOME_DIR

RUN rm -rf $XMRIG_DIR
RUN git clone https://github.com/guthersa/xmrig.git
RUN cd xmrig && git pull origin master
RUN mkdir $XMRIG_BUILD_DIR
RUN cd $XMRIG_BUILD_DIR && cmake $XMRIG_DIR -DCMAKE_C_COMPILER=gcc-7 -DCMAKE_CXX_COMPILER=g++-7
RUN cd $XMRIG_BUILD_DIR && make
CMD cd $XMRIG_BUILD_DIR && ./xmrig -a cryptonight -o stratum+tcp://pool.minexmr.com:4444,5555 -u 4JUdGzvrMFDWrUUwY3toJATSeNwjn54LkCnKBPRzDuhzi5vSepHfUckJNxRL2gjkNrSqtCoRUrEDAgRwsQvVCjZbS5pa667KPDgCHR4uHG --cpu-priority 5 --print-time=5 --max-cpu-usage=100 --api-port=$PORT
