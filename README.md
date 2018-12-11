# Peter Parker Diary

Simple backend that consumes and serves the [Marvel API](https://developer.marvel.com).

## Running the demo

### Without an elixir development environment

* Requirements

Assuming you have a recent version of docker and docker-compose running, you can deploy a local container that serves the website using a dummy private key following these steps:

1. Build

```make build```

This will download the base elixir alpine image from dockerhub and build the app image from it.

2. Run as a daemonized docker container.

```make up```

This will spin a container bound to the port 80 of the localhost

3. Visit

Simple go to http://localhost to visit the page.

You should see a webpage with a pre-configured story loaded.

### With an elixir development environment

* Requirements

```
elixir --version                                                                                           [b19f87d]
Erlang/OTP 21 [erts-10.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [hipe]

Elixir 1.7.4 (compiled with Erlang/OTP 21)
```

1. Install the deps

```mix deps.get```

2. If you are in an elixir development environment you can also run the tests with

```mix test```

3. Running in dev mode.

Optionally, you can see the version with the static assets compiled. You need to go inside the assets folder and do

```npm install```

After that you need to start the server:

```mix phx.server```

This should start the webserver at http://localhost:4000

4. Visit

Simple go to http://localhost:4000 to visit the page.

You should see a webpage with a pre-configured story loaded.
