FROM       centos:7.4.1708

# Install Tini init (fullfill the responsibilities of PID=1)
ARG        TINI_VERSION="0.16.1"
ARG        TINI_RPM_URL="https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.rpm"
ARG        TINI_RPM_SIG_URL="https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.rpm.asc"
ARG        TINI_RPM_SHA256="fa88c5fea65b1cceb7ead93e94a66f5d8a6fb8fa300ab30ae22ebee334657657"
RUN        curl -L -o "/tmp/tini.rpm" "${TINI_RPM_URL}" && \
           curl -L -o "/tmp/tini.rpm.asc" "${TINI_RPM_SIG_URL}" && \
           gpg --verify "/tmp/tini.rpm.asc" "/tmp/tini.rpm" && \
           echo "${TINI_RPM_SHA256} /tmp/tini.rpm" | sha256sum -c - && \
           yum install -y "/tmp/tini.rpm" && \
           rm -f "/tmp/tini.rpm" "/tmp/tini.rpm.asc"

# Install greetingd
COPY       ./build/greetingd.sh /usr/local/bin/
RUN        chown root:root /usr/local/bin/greetingd.sh && \
           chmod 755 /usr/local/bin/greetingd.sh

# Start greetingd
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD        ["/usr/local/bin/greetingd.sh"]
