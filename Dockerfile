FROM amazoncorretto:21 as builder
WORKDIR /build
RUN jlink \
  --verbose \
  --add-modules java.base,java.compiler,java.desktop,java.instrument,java.management,java.naming,java.net.http,java.prefs,java.rmi,java.scripting,java.security.jgss,java.security.sasl,java.sql,jdk.crypto.ec,jdk.jfr,jdk.management,jdk.naming.dns,jdk.unsupported \
  --strip-java-debug-attributes \
  --no-man-pages \
  --no-header-files \
  --output /jre

FROM gcr.io/distroless/java-base-debian12
COPY --from=builder /jre /jre
EXPOSE 8080
