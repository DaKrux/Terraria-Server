FROM i386/ubuntu:18.04

MAINTAINER Daryl Miller <Kruvin@DarylMiller.me

ENV TERRARIASERVERVERURL="http://terraria.org/system/dedicated_servers/archives/000/000/032/original/terraria-server-1353.zip"

RUN apt-get update

RUN apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386

RUN apt-get install -y zip curl screen

RUN cd /opt && curl -O $TERRARIASERVERVERURL

RUN mkdir /opt/terraria/

RUN cd /opt && unzip terraria-server-1353.zip &&\
    mv -f /opt/1353/Linux/* /opt/terraria  &&\
    rm -rf /opt/1353 && rm -rf /opt/terraria-server-1353.zip

COPY ./src/serverconfig.txt /opt/terraria/serverconfig.txt

COPY ./src/terraria-start.sh /opt/terraria/terraria-start.sh

RUN chown -R root:root /opt/terraria &&\
    chmod +x /opt/terraria/TerrariaServer* &&\
    chmod +x /opt/terraria/terraria-start.sh

EXPOSE 7777

WORKDIR /opt/terraria/

ENTRYPOINT ["/bin/bash", "terraria-start.sh"]
