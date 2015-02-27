FROM ubuntu:14.04

ADD bin/generate_config.py /usr/bin/
RUN mkdir -p /templates && \
  chmod +x /usr/bin/generate_config.py && \
  apt-get update && \
  apt-get install -y libyaml-0-2 zlib1g-dev libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties && \
  apt-get install -y build-essential curl python-pip python-dev && \
  pip install jinja && \
  curl -o ruby-2.1.5.tar.gz -L http://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.5.tar.gz && \
  tar -xzvf ruby-2.1.5.tar.gz && \
  cd ruby-2.1.5/ && \
  ./configure && \
  make && \
  make install && \
  gem install bundler && \
  apt-get remove -y zlib1g-dev libssl-dev libreadline-dev libyaml-dev libsqlite3-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties && \
  apt-get remove -y build-essential python-dev && \
  apt-get clean && apt-get purge && apt-get autoremove -y && rm -rf /var/lib/apt/lists/* && \
  cd / && \
  rm -rf ruby-2.1.5.tar.gz && \
  rm -rf ruby-2.1.5 && \
  rm -rf rm -rf /usr/local/share/ri/

