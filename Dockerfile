FROM ruby:2.3.2

ENV APP_PATH=/srv/exchange_rates_monitor
ENV APP_PORT=3000

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN apt-get install -y nodejs

RUN echo 'gem: --no-rdoc --no-ri' > /etc/gemrc
RUN mkdir -p $APP_PATH

WORKDIR $APP_PATH

COPY Gemfile $APP_PATH
COPY Gemfile.lock $APP_PATH

RUN gem install bundler && bundle install

EXPOSE $APP_PORT

CMD foreman start
