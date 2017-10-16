FROM ubuntu

RUN apt-get update && apt-get install -y --no-install-recommends \
	make \
	cmake \
	gcc \
	g++ \
	vim \
	git \
	ca-certificates \
	&& apt-get clean \
	&& rm -fR /var/lib/apt/lists/* 

RUN git clone -q https://github.com/google/googletest.git /googletest \
  && mkdir -p /googletest/build \
  && cd /googletest/build \
  && cmake .. && make && make install \
  && cd / && rm -rf /googletest

RUN apt-get remove -y --purge git

ENV GTEST_COLOR=1

RUN mkdir /src

VOLUME /src

WORKDIR /src

CMD ["/bin/bash", "-c", "cmake -P build.cmake"]
