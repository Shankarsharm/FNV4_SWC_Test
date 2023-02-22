FROM ubuntu:latest
COPY check.sh .
#RUN apt update
RUN chmod +x check.sh
ENTRYPOINT ["/check.sh"]
#ENTRYPOINT [ "python3", "check.py" ]
