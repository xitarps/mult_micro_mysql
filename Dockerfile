from ruby:3.2.1

RUN apt update
RUN apt upgrade -y

RUN gem install mysql2

ADD . /home/apps
WORKDIR /home/apps

# RUN bundle install --jobs 5 --retry 5
