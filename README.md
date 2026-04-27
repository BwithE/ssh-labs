## SSH Labs Setup

This project provides Docker containers for practicing local and remote port forwarding tasks. Use the provided `ssh_labs_manager.sh` script to automate container management.

---
### Files Overview:

- **box1/Dockerfile, box2/Dockerfile, box3/Dockerfile, box4/Dockerfile**: Dockerfiles for building SSH-enabled containers.
- **docker-compose.yml**: Defines networks, builds, and ports for the containers.
- **ssh_labs_manager.sh**: Script to build, start, stop, and remove containers and images.
### Usage:
Run the `ssh_labs_manager.sh` script with the following options:
1. **Build images**: Build Docker images based on `docker-compose.yml`.
2. **Start containers**: Start the containers.
3. **Stop/Remove containers**: Stop and remove the containers along with networks.
4. **Remove images**: Completely clean up all images and volumes.

Example:

```bash
./ssh_labs_manager.sh
----- SSH LABS -----
1) Build images
2) Start containers
3) Stop/Remove containers
4) Remove images (FULL CLEAN)
*) Exit
Select option:
```

This setup is ideal for practicing SSH-based port forwarding in a controlled environment.

---
## Network IPs

```bash
box1: 192.168.100.10 / 172.16.200.10
box2: 172.16.200.20 / 10.10.10.20
box3: 10.10.10.30 / 10.20.20.30
box4: 10.20.20.40
```

---
## Tasks
Before starting any tasks, connect the the starting container `box1`

###  SSH into box1

```bash
ssh -p 2222 hacker@localhost
```

### Task 1 - Local Port Forward
- On box1, create a local port forward using port 7654 that tunnels through box2 and redirects to box3 on port 7654.
- Once you've done that, on box1, netcat your localhost at 7654 to receive the flag.

### Task 2 - Remote Port Forward
- From box1, create a remote port forward on box2, utilizing port 9999 that will redirect traffic back to your local port of 4444.
- Once you've done that, on box1, start a netcat listener on port 4444 to receive the flag.

### Task 3 - Multi-Hop Pivot to box4
- Starting on box1, create a local port forward using port 4444 that will tunnel through box2 and redirect to box3 on port 22.
- Then, using that same local port forward tunnel, create another local port forward using port 5555 that will tunnel through box3 and redirect to box4 on port 12345.
- Once you've stood up your tunnels, on box1, netcat the localhost at 5555 to receive the flag.

