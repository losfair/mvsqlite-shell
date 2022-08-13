FROM ubuntu:20.04
RUN cd /root && apt update && \
  apt install -y wget libsqlite3-dev unzip build-essential && \
  wget https://www.sqlite.org/2020/sqlite-amalgamation-3310100.zip && \
  unzip sqlite-amalgamation-3310100.zip && \
  cd sqlite-amalgamation-3310100 && \
  gcc -O2 -o ../sqlite3 ./shell.c -lsqlite3

FROM ubuntu:20.04
RUN cd /root && apt update && \
  apt install -y curl wget net-tools iputils-ping libsqlite3-dev && \
  wget -O /root/libmvsqlite_preload.so https://github.com/losfair/mvsqlite/releases/download/v0.1.8/libmvsqlite_preload.so
COPY --from=0 /root/sqlite3 /usr/bin/
COPY ./run.sh /
CMD sleep infinity
