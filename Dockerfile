FROM google/cloud-sdk:alpine

RUN apk --update add tar redis-tools

COPY restore.sh ./

CMD ["./restore.sh"]
