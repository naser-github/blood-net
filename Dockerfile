FROM python:3.9-alpine3.13
LABEL maintainer="abu naser"

ENV PYTHONUNBUFFERED 1

COPY ./requirements/base.txt /tmp/requirements/base.txt
COPY ./requirements/dev.txt /tmp/requirements/dev.txt
COPY app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements/base.txt && \
    if [ $DEV = "true"]; then \
      then /py/bin/pip install -r /tmp/requirements/dev.txt; \
    fi && \
    rm -rf /tmp/ && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user