#!/usr/bin/env bash

export PYTHONPATH=django_asgi

exec poetry run gunicorn asgi:application -k uvicorn.workers.UvicornWorker -b 0.0.0.0:8000
