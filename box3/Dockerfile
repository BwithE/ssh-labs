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

RUN echo "box3" > /etc/hostname

RUN useradd -m -s /bin/bash user && \
    echo "user:password" | chpasswd && \
    echo "root:password" | chpasswd

RUN echo "AllowTcpForwarding yes" >> /etc/ssh/sshd_config && \
    echo "GatewayPorts yes" >> /etc/ssh/sshd_config && \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
    echo "UserKnownHostsFile /dev/null" >> /etc/ssh/ssh_config

RUN mkdir -p /home/user/.ssh && \
    chown -R user:user /home/user/.ssh

RUN echo 'export PS1="\u@box3:\w\$ "' >> /home/user/.bashrc && \
    echo "alias ports='ss -tulnp'" >> /home/user/.bashrc && \
    echo "alias ips='ip a'" >> /home/user/.bashrc

CMD sh -c "\
cp /home/user/.ssh/id_rsa.pub /shared/box3.pub 2>/dev/null || true; \
cat /shared/*.pub >> /home/user/.ssh/authorized_keys 2>/dev/null || true; \
chown user:user /home/user/.ssh/authorized_keys 2>/dev/null || true; \
while true; do echo 'FLAG_TASK_1' | nc -l 7654; done & \
while true; do sleep 5; echo 'FLAG_TASK_2' | nc -w 2 10.10.10.20 9999; done & \
/usr/sbin/sshd -D \
"
