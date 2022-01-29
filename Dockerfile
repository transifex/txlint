FROM python:3.9

ENV PRE_COMMIT_HOME=/tmp

RUN pip install pre-commit

COPY .pre-commit-config.yaml /config/

WORKDIR /src

RUN git init . && \
    pre-commit install-hooks --config /config/.pre-commit-config.yaml && \
    chmod 777 -R /tmp && \
    rm -rf ~/.git/


ENTRYPOINT ["pre-commit", "run", "--config", "/config/.pre-commit-config.yaml"]