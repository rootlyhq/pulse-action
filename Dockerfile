# hadolint ignore=DL3007
FROM rootlyhub/cli:latest

ENV ROOTLY_GH_ACTION true
CMD ["rootly", "pulse"]
