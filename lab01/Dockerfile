FROM centos:7.4.1708

# Install greetingd
COPY ./build/greetingd.sh /usr/local/bin/
RUN  chown root:root /usr/local/bin/greetingd.sh && \
     chmod 755 /usr/local/bin/greetingd.sh

# Start greetingd
CMD  ["/usr/local/bin/greetingd.sh"]
