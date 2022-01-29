FROM python:3.9-alpine

RUN apk add --update git && \
    pip install pre-commit

COPY .pre-commit-config.yaml /config/

RUN git init . && \
    pre-commit install-hooks --config /config/.pre-commit-config.yaml && \
    rm -rf .git/

WORKDIR /src

ENTRYPOINT ["pre-commit", "run", "--config", "/config/.pre-commit-config.yaml"]