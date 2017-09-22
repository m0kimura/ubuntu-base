FROM m0kimura/ubuntu-jp


##  ON BUILD USER
ONBUILD ARG user=${user:-docker}
ONBUILD RUN \
    export uid=1000 gid=1000 && \
    mkdir -p /home/${user} && \
    echo "${user}:x:${uid}:${gid}:${user},,,:/home/${user}:/bin/bash" >> /etc/passwd && \
    echo "${user}:x:${uid}:" >> /etc/group && \
    echo "${user} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${user} && \
    chmod 0440 /etc/sudoers.d/${user} && \
    chown ${uid}:${gid} -R /home/${user}
##

RUN apt-get update \


##  UBUNTU BASE
&&    apt-get install -y sudo software-properties-common wget curl \
&&    apt-get install -y nano git nodejs npm \
&&    npm cache clean \
&&    npm install n -g \
&&    n 8.3.0 \
&&    ln -sf /usr/local/bin/node /usr/bin/node \


&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/*

CMD /bin/bash
