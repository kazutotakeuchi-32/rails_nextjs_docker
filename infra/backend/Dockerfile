FROM ruby:3.2.1
ENV ROOT="/app"
ENV LANG=C.UTF-8
ENV TZ=Asia/Tokyo

WORKDIR ${ROOT}

COPY ./backend/Gemfile ${ROOT}
COPY ./backend/Gemfile.lock ${ROOT}

COPY ./infra/backend/entrypoint.sh entrypoint.sh

RUN gem install bundler
RUN bundle install --jobs 4

EXPOSE 3000

CMD [ "bash", "-c", "sh ./infra/backend/entrypoint.sh" ]
# FROM ruby:3.2.1
# RUN apt-get update -qq \
#  && apt-get install -y nodejs npm \
#  && rm -rf /var/lib/apt/lists/* \
#  && npm install --global yarn
# WORKDIR /app
# COPY ./infra/backend/Gemfile /app/Gemfile
# COPY Gemfile.lock /app/Gemfile.lock
# RUN bundle install

# # Add a script to be executed every time the container starts.
# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
# EXPOSE 3000

# # Configure the main process to run when running the image
# CMD ["rails", "server", "-b", "0.0.0.0"]
