FROM ruby:3.2-bullseye
RUN apt-get update -qq && apt-get install -y nodejs build-essential
RUN mkdir /app
WORKDIR /app/
COPY ./ ./app/
COPY ./Gemfile ./
COPY ./Gemfile.lock ./
RUN bundle install

RUN chmod +x +R ./bin
EXPOSE 3000

# Entrypoint script

CMD [ "rails", "server", "-b", "0.0.0.0" ]
