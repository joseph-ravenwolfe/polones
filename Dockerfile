FROM elixir:1.11-alpine AS builder

# By convention, /opt is typically used for applications
WORKDIR /opt/app

# install build dependencies
RUN apk update && \
  apk upgrade --no-cache && \
  apk add --no-cache \
  git \
  build-base

# install hex + rebar
RUN mix local.rebar --force && \
  mix local.hex --force

# set build ENV
ENV MIX_ENV=prod

# This copies our app source code into the build container
COPY mix.exs /opt/app/
COPY mix.* /opt/app/
COPY entrypoint.sh /opt/app/

RUN mix do deps.get --only $MIX_ENV, deps.compile

COPY . /opt/app/

WORKDIR /opt/app
RUN MIX_ENV=prod mix release
RUN MIX_ENV=prod mix escript.build

# From this line onwards, we're in a new image, which will be the image used in production
FROM alpine:3.10

RUN apk update && \
  apk add --no-cache \
  bash \
  openssl-dev

# Set exposed ports
EXPOSE 5000

ENV PORT=5000 \
  MIX_ENV=prod \
  SHELL=/bin/bash

WORKDIR /opt/app

COPY --from=builder /opt/app/_build/prod/rel/polones .
COPY --from=builder /opt/app/entrypoint.sh /opt/app/
COPY --from=builder /opt/app/polones /opt/app/bin/polones

CMD ["opt/app/entrypoint.sh"]
# CMD /opt/app/bin/polones start