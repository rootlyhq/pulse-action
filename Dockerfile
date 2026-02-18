# hadolint ignore=DL3007
FROM alpine:3.21

RUN apk add --no-cache curl

# Install rootly-cli from GitHub releases
ARG ROOTLY_CLI_VERSION=latest
RUN curl -fsSL "https://github.com/rootlyhq/rootly-cli/releases/latest/download/rootly-cli_$(curl -fsSL https://api.github.com/repos/rootlyhq/rootly-cli/releases/latest | grep '"tag_name"' | sed 's/.*"v\(.*\)".*/\1/')_linux_amd64.tar.gz" \
    | tar -xz -C /usr/local/bin rootly \
    && chmod +x /usr/local/bin/rootly

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
