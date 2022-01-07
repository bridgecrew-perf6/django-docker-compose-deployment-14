FROM python:3.9-alpine3.13

LABEL maintainer="tomekmakuch"

ENV PYTHONUBUFFERED 1

WORKDIR /app

COPY ./requirements.txt requirements.txt
COPY ./app /app

EXPOSE 8000

RUN python -m venv py
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt
RUN adduser -D -H app

ENV PATH="/py/bin:$PATH"

USER app