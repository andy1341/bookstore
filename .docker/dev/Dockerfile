FROM ruby:2.6.5

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get update -qq && apt-get install -y nodejs
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV APP_USER app
ENV APP_USER_HOME /home/$APP_USER
ENV APP_HOME /home/www/bookstore

RUN useradd -m -d $APP_USER_HOME $APP_USER

WORKDIR $APP_HOME

RUN mkdir /var/www && \
    chown $APP_USER:$APP_USER /var/www && \
    chown -R $APP_USER:$APP_USER $APP_USER_HOME && \
    chown $APP_USER:$APP_USER $APP_HOME

USER $APP_USER

RUN gem install bundler -v 2.0.2

COPY --chown=app:app . .

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
