FROM ubuntu:precise

RUN apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    curl \
    git-core \
    libreadline6-dev \
    libsqlite3-dev \
    libssl-dev \
    libvirt-dev

RUN git clone https://github.com/sstephenson/rbenv.git /opt/rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /opt/rbenv/plugins/ruby-build
ENV RBENV_ROOT /opt/rbenv
ENV PATH $RBENV_ROOT/shims:$RBENV_ROOT/bin:$PATH

RUN git clone https://github.com/innvent/infradash.git /opt/infradash
WORKDIR /opt/infradash

RUN cat .ruby-version | xargs rbenv install
RUN gem install bundler && rbenv rehash

RUN bundle install && rbenv rehash

ADD . /opt/infradash

EXPOSE 4567
ENTRYPOINT bundle exec ruby app.rb
