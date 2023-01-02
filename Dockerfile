FROM python:alpine
ENV PYTHONUNBUFFERED=1
COPY ./requirements.txt /requirements.txt
COPY ./requirements.txt /requirements.dev.txt
WORKDIR /app
ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /requirements.txt && \
    if [ "$DEV" = "true" ] ; then \
        /py/bin/pip install -r /requirements.dev.txt ; \
    fi && \
    adduser \
    --disabled-password \
    --no-create-home \
    django-user

ENV PATH="/py/bin:$PATH"

COPY ./app /app
EXPOSE 8000
USER django-user
