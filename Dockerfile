FROM alpine:3.10
RUN apk add --no-cache bash bc coreutils
ADD bashtest.sh /usr/local/bin/bashtest.sh
ADD bashtest_completion.sh /usr/local/bin/bashtest_completion.sh
CMD bash
