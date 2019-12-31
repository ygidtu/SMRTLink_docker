# SMRTLink

This is a repo to create SMRTLink docker image

I cannot install smrtlinks 8.0 on several old version of Linux systems. 
Therefore, I pack the smrtlinks tools into a docker image to solve this issue.

This is only for smrtlinks command line usage.
I cannot solve the localhost binding issue, then the GUI usage is **not available**.

---

## Files
- **smrtlink_8.0.zip** is the smrtlink source file
- **main.py** is a simple python wrapper of smrtlink cmds
- **sources.list** is a list of ubuntu mirrors, specific for China
    - Could be changed to any mirrors you list
    - Could remove the line 16~18 from Dockerfile to disable this file


## Install

### DockerHub

[My DockerHub](https://hub.docker.com/repository/docker/ygidtu/smrtlink)
 
```bash
docker push ygidtu/smrtlink:8.0.0.80529
```

### Customize with your own smrtlink source file
You could just rename this image to whatever you like
```bash
docker build -t smrt8 .
```

## Run

### List of all available exec of smrtlinks
```bash
docker run \
    --rm \   # remove container after exec
    -v /mnt:/mnt \   # map volume to docker container
    --ulimit nofile=500000:500000 \  # increase the limit of ulimit
    --user $(id -u):$(id -g) smrt8   # map your real user to docker
```

- `-l, --list`  list all program under `smrtcmds/bin/`
- `-v, --version` print smrtlink version


### Run smrtlinks tools

For example: ccs

```bash
docker run \
    --rm \   # remove container after exec
    -v /mnt:/mnt \   # map volume to docker container
    --ulimit nofile=500000:500000 \  # increase the limit of ulimit
    --user $(id -u):$(id -g) smrt8 ccs
```

If anyone try to use another version of smrtlinks, just replace `smrtlink_8.0.zip` should just work


