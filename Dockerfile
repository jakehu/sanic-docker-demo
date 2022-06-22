FROM python:3.9-alpine

RUN sed -i 's/dl-cdn.alpinelinux.org/repo.huaweicloud.com/g' /etc/apk/repositories

RUN apk update \
    && apk add --no-cache build-base \
    && apk add --no-cache libffi-dev

RUN mkdir /usr/src/app

COPY . /usr/src/app/

COPY ./supervisor/supervisord.conf /etc/supervisord.conf

WORKDIR /usr/src/app
ENV PYTHONPATH /usr/src/app

RUN pip3 install supervisor \
    && pip3 install -r requirements.txt --trusted-host https://repo.huaweicloud.com -i https://repo.huaweicloud.com/repository/pypi/simple

CMD ["supervisord", "-c", "/etc/supervisord.conf"]