FROM openjdk:17-jdk-buster

ENV IVY_VERSION=2.5.2
ENV IVY_HOME=/usr/local/ivy
ENV IVY_JAR_PATH=$IVY_HOME/ivy-${IVY_VERSION}.jar

RUN apt-get update && \
    apt-get install -y ant curl && \
    apt-get clean

RUN mkdir -p $IVY_HOME && \
    curl -L https://dlcdn.apache.org/ant/ivy/${IVY_VERSION}/apache-ivy-${IVY_VERSION}-bin.tar.gz | tar xz -C $IVY_HOME --strip-components=1 && \
    mv $IVY_HOME/ivy-${IVY_VERSION}.jar $IVY_HOME/ivy.jar

ENV CLASSPATH=$CLASSPATH:$IVY_HOME/ivy.jar

WORKDIR /app

COPY . /app

RUN ant 

CMD ["sh", "-c", "ls -l /app && cd bin && ls"]
