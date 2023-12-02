# An Ubuntu docker image running BiglyBT with Extreme Mod

## Base Docker Image
[fullaxx/ubuntu-desktop](https://hub.docker.com/r/fullaxx/ubuntu-desktop)

## Software
* [BiglyBT](https://www.biglybt.com/) - A java-based bittorrent application
* [Extreme Mod](https://www.sb-innovation.de/showthread.php?35648-BiglyBT-Extreme-Mod-by-SB-Innovation-3-4-0-0-Beta-rev1)

## Per compilare lo tutto:
```
DIRETTAMENTE sul container occore crear l'immagine che a Sua immagine e'.
Per far cio', ci si connette all'LXC (o VM) della questione e si clonazza
git clone la repository
docker build -t="the-xor/biglybt-extreme" github.com/the-xor/biglybt-extreme
```

## Volume Options
Input: Drop your torrents/magnets in /srv/docker/biglybt/data/in/autoload \
Output: Your downloads will reside in /srv/docker/biglybt/data/out/complete
```
-v /srv/docker/biglybt/data:/data
```
Configuration: if biglybt.config is found in /config, it will be copied to $HOME/.biglybt/ and used
```
-v /srv/docker/biglybt/config:/config
```

## BiglyBT Directory Tree
```
/data
|-- /in
|   |-- autoload - Drop your torrents/magnets here
|   `-- torrents - BiglyBT will move torrent files here after autoload input
`-- /out
    |-- complete - Downloads will be moved here upon completion
    |-- torrents - BiglyBT will move torrent files of finished downloads here
    `-- processing - BiglyBT will use this for processing incomplete downloads
```

## BiglyBT Installer Options
Optional: Disable the automated quiet install \
Default: automatic quiet install
```
-e BBTGUIINSTALL='1'
```

## VNC Options
Optional: Set Depth 16 \
Default: 24
```
-e VNCDEPTH='16'
```
Optional: Set 1920x1080 Resolution \
Default: 1280x800
```
-e VNCRES='1920x1080'
```
Optional: Set Password Authentication \
Default: No Authentication
```
-e VNCPASS=vncpass
**** OCCHIO  A NON METTERE APICI O DOPPI APICI ****
```
Optional: Set Read-Write and Read-Only password \
Default: No Authentication
```
-e VNCPASS='vncpass' -e VNCPASSRO='readonly'
```
Optional: Run as a new non-root user \
Default: root (UID: 0)
```
-e VNCUSER='guest' -e VNCUID='1000'
```
Optional: If you want your non-root user to be part of the users group \
Default: same as VNCUSER and VNCUID \
Pre-Req: VNCUSER and VNCUID must be set
```
-e VNCGROUP='users'
```
Optional: Define a new group for non-root user \
Default: same as VNCUSER and VNCUID \
Pre-Req: VNCUSER and VNCUID must be set
```
-e VNCGROUP='guests' -e VNCGID='1001'
```
Optional: Set a password for the VNCUSER account \
Default: none and the account is locked \
Pre-Req: VNCUSER and VNCUID must be set
```
-e ACCTPASS='mysecretpassword'
```
Optional: Set umask to define permission for new files \
Default: 0022
```
-e VNCUMASK='0002'
```

## TimeZone Configuration
Set the timezone to be used inside the container \
Default: UTC
```
-e TZ='Asia/Tokyo'
-e TZ='Europe/London'
-e TZ='America/Los_Angeles'
-e TZ='America/Denver'
-e TZ='America/Chicago'
-e TZ='America/New_York'
```

## Shared Memory Modification (to support Web Browsers)
Increase the size of shared memory to prevent web browsers from crashing \
Thanks to [jlesage](https://hub.docker.com/r/jlesage/firefox/#increasing-shared-memory-size)
```
--shm-size 2g
```

## Persistant Configuration
Examples of how to keep your configuration persistant
```
-v /srv/docker/biglybt/home/bbtconfig:/root/.biglybt
-v /srv/docker/biglybt/home/mozilla:/root/.mozilla
```

## Run the image
Run the image keeping your biglybt configuration
```
docker run -d \
-v /srv/docker/biglybt/bbtconfig:/root/.biglybt \
-v /srv/docker/biglybt/data:/data \
-p 127.0.0.1:5901:5901 the-xor/biglybt
```
Run the image as a non-root user
```
docker run -d \
-e VNCUSER='guest' -e VNCUID='1000' \
-v /srv/docker/biglybt/bbtconfig:/home/guest/.biglybt \
-v /srv/docker/biglybt/data:/data \
-p 127.0.0.1:5901:5901 the-xor/biglybt
```
Run the image as a non-root user with custom group
```
docker run -d \
-e VNCUSER='guest' -e VNCUID='1000' \
-e VNCGROUP='guests' -e VNCGID='1001' \
-v /srv/docker/biglybt/bbtconfig:/home/guest/.biglybt \
-v /srv/docker/biglybt/data:/data \
-p 127.0.0.1:5901:5901 the-xor/biglybt
```
```
docker run -d \
-e LOGFILE='mylog' \
-v /srv/docker/biglybt/data:/data \
-v /srv/docker/biglybt/config:/config \
-p 127.0.0.1:5901:5901 the-xor/biglybt
```

## Connect using vncviewer or a web browser
Use any standard VNC client to connect directly \
For web access, check out [noVNC](https://hub.docker.com/r/fullaxx/novnc) to access your biglybt container with a web browser
```
vncviewer 127.0.0.1:5901
```

## Posting Issues on Github
When posting issues, please provide the following:
* docker run line used to create the container
* output from docker logs
* screenshot showing the issue if not described in logs
* If base image related: read [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
