FROM ruby:3.2-bullseye

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN gem install rails
RUN mkdir /home/app
COPY ./ /app
WORKDIR /app
COPY ./Gemfile ./
COPY ./Gemfile.lock ./
RUN bundle install


RUN chmod -R u+x ./bin/
# Entrypoint script
# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT [ "entrypoint.sh" ]
EXPOSE 3000

CMD [ "rails", "server", "-b", "0.0.0.0" ]
