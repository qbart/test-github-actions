FROM ruby:2.5.1

ARG RACK_ENV

ENV APP_HOME /app

RUN apt-get update -qq && apt-get install -y build-essential

RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME/

RUN bundle install --without development test

CMD rackup -p $PORT --host 0.0.0.0
