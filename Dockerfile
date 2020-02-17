FROM jruby:9.2.9.0-jdk

RUN apt-get update
RUN apt-get install -y build-essential libpq-dev curl openssl

RUN mkdir /app
WORKDIR /app

# compile then cache libraries
COPY lib lib
RUN lib/upvs/compile

# install then cache dependencies
COPY Gemfile Gemfile.lock ./
RUN gem update --system
RUN gem install bundler
RUN bundle install --deployment --without development:test

COPY . .
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
