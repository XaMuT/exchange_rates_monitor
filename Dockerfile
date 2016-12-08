FROM ruby:2.3.3

ENV APP_PATH=/srv/exchange_rates_monitor \
    APP_PORT=3000 \
    BUNDLE_JOBS=2 \
    BUNDLE_PATH=/usr/local/bundle

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN apt-get install -y nodejs redis-server

RUN echo 'gem: --no-rdoc --no-ri' > /etc/gemrc
RUN mkdir -p $APP_PATH

WORKDIR $APP_PATH

RUN npm install -g phantomjs-prebuilt

COPY Gemfile $APP_PATH
COPY Gemfile.lock $APP_PATH

RUN gem install bundler && bundle install

COPY . $APP_PATH

RUN bundle exec rails db:setup

EXPOSE $APP_PORT

CMD foreman start
