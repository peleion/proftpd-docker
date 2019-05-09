FROM docker.io/fedora:29

RUN dnf install -y --nodocs proftpd proftpd-utils passwd; \
    dnf -y autoremove; \
    dnf clean all; \
    echo '/sbin/nologin' >> /etc/shells; \
    mkdir /etc/proftpd; \
    mv /etc/proftpd.conf /etc/proftpd/; \
    openssl req -nodes -newkey rsa:2048 -x509 -days 365  -subj "/O=Proftpd" -keyout /etc/proftpd/proftpd.key -out /etc/proftpd/proftpd.cert

RUN rm /etc/localtime; \
    ln -s /usr/share/zoneinfo/America/New_York /etc/localtime

EXPOSE 21 6000-6010

VOLUME /var/log/proftpd /var/ftp /etc/proftpd

CMD proftpd -n -c /etc/proftpd/proftpd.conf
