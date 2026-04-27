FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
        openssh-server \
        netcat-openbsd \
        curl \
        bash \
        bash-completion \
        ncurses-term \
        vim \
        less \
        iproute2 \
        net-tools \
        python3 && \
    mkdir -p /var/run/sshd && \
    rm -rf /var/lib/apt/lists/*

RUN echo "box4" > /etc/hostname

RUN useradd -m -s /bin/bash hacker && \
    echo "hacker:password" | chpasswd && \
    echo "root:password" | chpasswd

RUN echo "AllowTcpForwarding yes" >> /etc/ssh/sshd_config && \
    echo "GatewayPorts yes" >> /etc/ssh/sshd_config && \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
    echo "UserKnownHostsFile /dev/null" >> /etc/ssh/ssh_config

RUN mkdir -p /home/hacker/.ssh && \
    chown -R hacker:hacker /home/hacker/.ssh

RUN echo 'export PS1="\u@box4:\w\$ "' >> /home/hacker/.bashrc && \
    echo "alias ports='ss -tulnp'" >> /home/hacker/.bashrc && \
    echo "alias ips='ip a'" >> /home/hacker/.bashrc

CMD sh -c "\
cp /home/hacker/.ssh/id_rsa.pub /shared/box4.pub 2>/dev/null || true; \
cat /shared/*.pub >> /home/hacker/.ssh/authorized_keys 2>/dev/null || true; \
chown hacker:hacker /home/hacker/.ssh/authorized_keys 2>/dev/null || true; \
while true; do echo 'FLAG_TASK_3' | nc -l 12345; done & \
while true; do echo 'FLAG_TASK_7' | nc -l 7777; done & \
/usr/sbin/sshd -D \
"
