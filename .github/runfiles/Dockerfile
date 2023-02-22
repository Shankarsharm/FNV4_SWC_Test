FROM bitnami/git:latest
WORKDIR /actions/
COPY sync.sh .
COPY manifest.yml .
RUN apt update
RUN apt install -y wget
RUN chmod +x sync.sh
RUN wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
RUN chmod a+x /usr/local/bin/yq
ENTRYPOINT ["/actions/sync.sh"]
#ENTRYPOINT [ "python3", "check.py" ]
