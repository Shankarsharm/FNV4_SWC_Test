FROM bitnami/git:latest
COPY sync.sh manifest.yml .
RUN apt update
RUN chmod +x sync.sh
RUN wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
RUN chmod a+x /usr/local/bin/yq
ENTRYPOINT ["./sync.sh"]
#ENTRYPOINT [ "python3", "check.py" ]
