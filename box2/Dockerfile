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

RUN echo "box2" > /etc/hostname

RUN useradd -m -s /bin/bash slacker && \
    echo "slacker:password" | chpasswd && \
    echo "root:password" | chpasswd

RUN echo "AllowTcpForwarding yes" >> /etc/ssh/sshd_config && \
    echo "GatewayPorts yes" >> /etc/ssh/sshd_config && \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
    echo "UserKnownHostsFile /dev/null" >> /etc/ssh/ssh_config

RUN mkdir -p /home/slacker/.ssh && \
    chown -R slacker:slacker /home/slacker/.ssh

RUN echo 'export PS1="\u@box2:\w\$ "' >> /home/slacker/.bashrc && \
    echo "alias ports='ss -tulnp'" >> /home/slacker/.bashrc && \
    echo "alias ips='ip a'" >> /home/slacker/.bashrc

CMD sh -c "\
cp /home/slacker/.ssh/id_rsa.pub /shared/box2.pub 2>/dev/null || true; \
cat /shared/*.pub >> /home/slacker/.ssh/authorized_keys 2>/dev/null || true; \
chown slacker:slacker /home/slacker/.ssh/authorized_keys 2>/dev/null || true; \
/usr/sbin/sshd -D \
"
