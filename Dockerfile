FROM google/cloud-sdk:alpine

RUN apk --update add tar

COPY restore.sh ./

CMD ["./restore.sh"]
