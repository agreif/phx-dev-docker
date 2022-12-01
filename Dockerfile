FROM elixir:latest

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
       apt-utils \
       build-essential \
       inotify-tools

RUN mix local.hex --force && \
    mix local.rebar --force

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

EXPOSE 4000

CMD ["mix", "phx.server"]
