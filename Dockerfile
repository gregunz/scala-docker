# Scala and SBT

FROM openjdk:8u171

LABEL maintainer="gregunz <contact@gregunz.io>"

ENV SCALA_VERSION 2.12.6 \
	SBT_VERSION 1.1.5

ENV SCALA_HOME /opt/scala
ENV PATH=$SCALA_HOME/$SCALA_VERSION/bin:$PATH

# install scala
RUN set -x && \
	touch /usr/lib/jvm/java-8-openjdk-amd64/release && \
	mkdir $SCALA_HOME && \
	curl -fsL https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C $SCALA_HOME

# install sbt
RUN set -x && \
	curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
	dpkg -i sbt-$SBT_VERSION.deb && \
	rm sbt-$SBT_VERSION.deb && \
	apt-get update && \
	apt-get install sbt && \
	sbt sbtVersion
	
CMD ["sbt"]