FROM ubuntu:18.04


RUN apt update && apt install -yy gcc g++ cmake curl


RUN curl -LO https://github.com/Kitware/CMake/releases/download/v3.22.2/cmake-3.22.2-linux-x86_64.tar.gz \
    && tar -xzvf cmake-3.22.2-linux-x86_64.tar.gz \
    && if [ -f /usr/local/man ]; then rm -f /usr/local/man; fi \
    && if [ -d /usr/local/man ]; then rm -rf /usr/local/man; fi \
    && cp -r cmake-3.22.2-linux-x86_64/* /usr/local/ \
    && rm -rf cmake-3.22.2-linux-x86_64* 


COPY . /print/
WORKDIR /print


RUN cmake -H. -B_build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=_install
RUN cmake --build _build
RUN cmake --build _build --target install

ENV LOG_PATH /home/logs/log.txt

WORKDIR _install/bin
ENTRYPOINT ./demo
