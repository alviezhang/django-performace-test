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

### Environment

OS: `Ubuntu 20.04 hosted in PVE server`

Python: `3.8.5`

CPU: `Intel(R) Xeon(R) CPU E3-1231 v3 @ 3.40GHz`

### Result

```
Run test sync
Run bench: wrk -t 2 -c 200 http://127.0.0.1:8000/polls/sync 2>&1
Running 10s test @ http://127.0.0.1:8000/polls/sync
  2 threads and 200 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   179.44ms   13.71ms 191.96ms   98.42%
    Req/Sec   554.52     14.06   580.00     71.50%
  11046 requests in 10.01s, 3.01MB read
Requests/sec:   1103.63
Transfer/sec:    308.24KB

Run test gthread
Run bench: wrk -t 2 -c 200 http://127.0.0.1:8000/polls/sync 2>&1
Running 10s test @ http://127.0.0.1:8000/polls/sync
  2 threads and 200 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   147.17ms   92.10ms   1.95s    98.81%
    Req/Sec   405.01     38.40   490.00     80.00%
  8069 requests in 10.01s, 2.24MB read
  Socket errors: connect 0, read 0, write 0, timeout 63
Requests/sec:    805.98
Transfer/sec:    229.04KB

Run test ASGI
Run bench: wrk -t 2 -c 200 http://127.0.0.1:8000/polls/async 2>&1
Running 10s test @ http://127.0.0.1:8000/polls/async
  2 threads and 200 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   590.07ms  133.46ms 893.51ms   59.97%
    Req/Sec   191.08    110.47   600.00     66.92%
  3315 requests in 10.01s, 838.46KB read
Requests/sec:    331.15
Transfer/sec:     83.76KB
```

### Conclusion

Support for ASGI in Django is still not mature enough.
Gevent with WSGI is still recommended in production use.
