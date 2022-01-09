FROM python:3.9-alpine3.13

LABEL maintainer="tomekmakuch"

ENV PYTHONUBUFFERED 1

WORKDIR /app

COPY ./requirements.txt requirements.txt
COPY ./app /app

EXPOSE 8000

RUN python -m venv py
RUN pip3 install --upgrade pip
RUN apk add --update --no-cache --virtual .tmp-devs build-base postgresql-dev musl-dev
RUN pip3 install -r requirements.txt
RUN apk del .tmp-devs
RUN adduser -D -H app

ENV PATH="/py/bin:$PATH"

USER app