FROM alpine:3.8
RUN apk add --no-cache bash bc coreutils
ADD bunit.sh /usr/local/bin/bunit.sh
CMD bash
