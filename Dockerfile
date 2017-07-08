FROM ruby:2.4.1
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    nodejs \
    npm \
    postgresql-client \
    libgtk2.0-dev \
    libopencv-dev \
    libcv-dev \
    imagemagick \
    && rm -rf /var/lib/apt/lists/*

ENV RAILS_ROOT /var/www/app
RUN mkdir -p $RAILS_ROOT/tmp/pids
WORKDIR $RAILS_ROOT

RUN gem install bundler

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install --deployment

COPY . .

RUN RAILS_ENV=production bin/rails assets:precompile
EXPOSE 3000

CMD rails s -b 0.0.0.0 -p 3000


