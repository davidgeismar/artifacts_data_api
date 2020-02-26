FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client vim
RUN mkdir /artifacts_data_api
WORKDIR /artifacts_data_api
COPY Gemfile .
COPY Gemfile.lock .
RUN gem install bundler
RUN bundle install
COPY . .
# Add a script to be executed every time the container starts.
EXPOSE 3000
RUN chmod +x ./entrypoint.sh
# Start the main process.
CMD tail -f /dev/null
