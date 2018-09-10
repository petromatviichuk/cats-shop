FROM pmatv/python-github-webhooks:latest
COPY cleanup.sh ./hooks
COPY pull_request ./hooks
COPY config.json .
RUN chmod +x ./hooks/*
RUN apk add bash
RUN pip install awscli
