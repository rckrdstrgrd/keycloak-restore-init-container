FROM google/cloud-sdk:alpine

RUN apk --update add tar redis

COPY restore.sh ./

CMD ["./restore.sh"]
