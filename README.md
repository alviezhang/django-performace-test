# Django performance test

A simple performance test between django ASGI and WSGI mode.


## Motivation

To test the performance difference of different modes and configurations of Django.
In this test, we will user three modes to start Django web server:

1. Pure WSGI
2. WSGI with multithread worker
3. ASGI with Uvicorn worker

## How to test

You need to install [poetry](https://python-poetry.org/) to run this test.

### 1. Install

```bash
poetry install
```

### 2. Run tests

```bash
./runtests.sh
```

## Test Result
