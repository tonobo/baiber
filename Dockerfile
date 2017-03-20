FROM ruby

RUN apt update && apt install -y poppler-utils tesseract-ocr-deu
COPY . /srv/baiber
WORKDIR /srv/baiber
RUN gem install bundler --no-user-install
RUN bundle install -j 8
RUN rails db:migrate
VOLUME /srv/baiber/public
CMD bash -c "bundle exec puma -v -t 0:20 -w 10 -p 9292"
