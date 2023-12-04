FROM python:3.9-alpine3.13
LABEL maintainer="abu naser"

ENV PYTHONUNBUFFERED 1

COPY ./requirements/base.txt /tmp/requirements/base.txt
COPY ./requirements/dev.txt /tmp/requirements/dev.txt
COPY blood_net_app /blood_net_app
WORKDIR /blood_net_app
EXPOSE 8000

ARG DEV=false

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements/base.txt && \
    if [ $DEV = "true"]; \
      then /py/bin/pip install -r /tmp/requirements/dev.txt; \
    fi && \
    rm -rf /tmp/ && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user && \
    chown -R django-user:django-user /blood_net_app && \
    chmod -R 755 /blood_net_app

ENV PATH="/py/bin:$PATH"

USER django-user