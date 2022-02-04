FROM python:3.9-alpine3.13

LABEL maintainer="tomekmakuch"

ENV PYTHONUBUFFERED 1

RUN apk add nodejs && \
    apk add npm

ADD ./package.json package.json

RUN npm install


WORKDIR /code

COPY ./requirements.txt requirements.txt

EXPOSE 8000

RUN python -m venv py
RUN pip3 install --upgrade pip
RUN apk add --update --no-cache --virtual .tmp-devs build-base postgresql-dev musl-dev linux-headers
RUN pip3 install -r requirements.txt
RUN apk del .tmp-devs
RUN adduser -D -H app

COPY ./code /code
COPY ./scripts /scripts

RUN mkdir -p /vol/web/static && \
    mkdir -p /vol/web/media && \
    chown app:app -R /vol && \
    chown app:app -R /vol/web && \
    chmod -R 0775 /vol && \
    chmod -R +x /scripts && \
    mkdir /logs && \
    chown app:app /logs -R && \
    chown app:app /code/socks -R && \
    chmod -R 0666 /code/socks

ENV PATH="/scripts:/py/bin:$PATH"

USER app

CMD ["run.sh"]