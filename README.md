# proftpd-docker
Simple Docker container for ProFTPD based on Fedora

Docker volumes are created for data (/var/ftp), config (/etc/proftpd) and logs (/var/log/proftpd)

A sample docker-compose.yml is included

Modifications in this container:
* Config directory is created and config file moved there - makes config file and SSL certificate persisence easy in a volume
* /sbin/nologin is added to /etc/shells otherwise ProFTPD will not allow logins (even anonymous) under Fedora
* Timezone set to localtime

Notes for use:
* Ports 6000-6010 are opened (arbitrary) for active FTP connections - you may want more or different ports. This is sufficient for a low-volume server
* Self-signed TLS certificates are generated and added to the config directory for SFTP use
* I have not figured out a straightforward way for multiple user/password persistence - you will need to perform something like this each time a new ProFTPD container is created:
```
docker exec -it proftpd /bin/bash
echo '<yourpassword>' |passwd <your user> --stdin
exit
```
* Do not use PAM DSO, Docker appears to use the host PAM for authentication and loading the modules within the container appears not to work
* Be sure to modify the proftpd.conf to reflect these modifications

---
TODO
1. Multi-user (with login/password persistence) - will require another volume for /home
2. Do auto-blacklist or other DSOs work under Docker?
3. Automated DockerHub build
