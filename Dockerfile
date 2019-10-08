FROM alpine:3.10
RUN apk add --no-cache bash bc coreutils
ADD bunit.sh /usr/local/bin/bunit.sh
ADD bunit_completion.sh /usr/local/bin/bunit_completion.sh
CMD bash
