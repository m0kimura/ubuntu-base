FROM m0kimura/ubuntu-jp

ONBUILD ARG user=${user:-docker}
ONBUILD RUN \
    export uid=1000 gid=1000 && \
    mkdir -p /home/${user} && \
    echo "${user}:x:${uid}:${gid}:${user},,,:/home/${user}:/bin/bash" >> /etc/passwd && \
    echo "${user}:x:${uid}:" >> /etc/group && \
    echo "${user} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${user} && \
    chmod 0440 /etc/sudoers.d/${user} && \
    chown ${uid}:${gid} -R /home/${user}

RUN apt-get update && \
    apt-get install -y sudo software-properties-common wget nano git nodejs npm && \
    npm cache clean && \
    npm install n -g && \
    n 7.4.0 && \
    ln -sf /usr/local/bin/node /usr/bin/node && \
    sudo apt-get purge -y nodejs npm && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

