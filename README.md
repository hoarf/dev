# Peter Parker Diary

Simple backend that consumes and serves the [Marvel API](https://developer.marvel.com).

## Running the demo

### Without an elixir development environment

You can deploy a local container that serves the website using a dummy private key following these two steps:

1. Build

This will download the base elixir alpine image from dockerhub and build the app image from it.

`make build`

2. Run as a daemonized docker container.

This will spin a container bound to the port 80 of the localhost

`make up`

3. Visit

Simple go to http://localhost to visit the page.

You should see a webpage with a preconfigured story loaded.
