FROM ubuntu:20.04 AS sqlite-build
RUN cd /root && apt update && \
  apt install -y wget libsqlite3-dev unzip build-essential libreadline-dev && \
  wget https://www.sqlite.org/2022/sqlite-amalgamation-3390300.zip && \
  unzip sqlite-amalgamation-3390300.zip && \
  cd sqlite-amalgamation-3390300 && \
  gcc -O2 -fPIC -shared -o ../libsqlite3.so.0 -DSQLITE_ENABLE_DBPAGE_VTAB ./sqlite3.c -lpthread -ldl -lm && \
  ln -s /root/libsqlite3.so.0 /root/libsqlite3.so && \
  gcc -O2 -DHAVE_READLINE=1 -o ../sqlite3 ./shell.c -L.. -lsqlite3 -lreadline

FROM golang:1.19-bullseye AS postlite-build
WORKDIR /root
RUN apt update && apt install -y libsqlite3-dev git
RUN git clone https://github.com/losfair/postlite-mv && \
  cd postlite-mv && \
  git checkout 9d5e2b34828594a1c7ee66c679a2ad8068c9ae3e && \
  ./build.sh

FROM ubuntu:20.04
RUN cd /root && apt update && \
  apt install -y curl wget net-tools iputils-ping libreadline8 && \
  wget -O /usr/lib/libsqlite3.so.0 https://github.com/losfair/mvsqlite/releases/download/v0.1.18-9/libsqlite3.so && \
  ln -s /usr/lib/libsqlite3.so.0 /usr/lib/libsqlite3.so
COPY --from=sqlite-build /root/sqlite3 /usr/bin/
COPY --from=postlite-build /root/postlite-mv/postlite /usr/bin/
COPY ./run.sh ./service.sh /
CMD /service.sh
