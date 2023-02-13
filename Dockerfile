FROM ruby:3.2.1
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]


# FROM ruby:3.2.1

# WORKDIR /price_alert
# COPY Gemfile /price_alert/Gemfile
# COPY Gemfile.lock /price_alert/Gemfile.lock
# RUN bundle install

# # Add a script to be executed every time the container starts.
# # COPY entrypoint.sh /usr/bin/entrypoint.sh
# # RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["bin/rails"]
# EXPOSE 3000

# # Configure the main process to run when running the image
# CMD ["rails", "server", "-b", "0.0.0.0"]