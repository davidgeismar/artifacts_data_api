FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /artifacts_data_api
WORKDIR /artifacts_data_api
COPY Gemfile /artifacts_data_api/Gemfile
COPY Gemfile.lock /artifacts_data_api/Gemfile.lock
RUN gem install bundler
RUN gem install rails
RUN bundle install
COPY . /artifacts_data_api

# Add a script to be executed every time the container starts.
RUN chmod +x ./entrypoint.sh
EXPOSE 3000
RUN set -e
