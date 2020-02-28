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
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
EXPOSE 3000
RUN set -e
# Remove a potentially pre-existing server.pid for Rails.
RUN rm -f /artifacts_data_api/tmp/pids/server.pid
