FROM alpine:latest
ENV LANG en_US.UTF-8
RUN echo "http://nl.alpinelinux.org/alpine/v3.4/community" >> /etc/apk/repositories && \
    echo "http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
	apk add -U \
		git \
		bash \
		ruby \
		ruby-dev \
		ruby-io-console \
		ruby-bigdecimal \
		sqlite-dev \
		sqlite-libs \
		build-base \
		libstdc++ \
		nodejs \
        zlib-dev \
        curl-dev \
        pwgen \
		ruby-bundler && \
	cd /opt && \
    	git clone git://github.com/beefproject/beef.git && \
	cd beef && \
	bundle install

WORKDIR /opt/beef
ARG NEWPASS
RUN sed -i "s/^\([[:blank:]]*\)passwd: \"beef\"$/\1passwd: \"$NEWPASS\"/" config.yaml && \
    sed -i '/^\([[:blank:]]*\)https:$/{n;s/.*/            enable: true/}' config.yaml && \
    echo "Connect to the web UI at https://127.0.0.1:3000/ui/panel";\
    echo "Username: beef";\
    echo "Password: $NEWPASS";\
    echo 'Hook: <script src="https://127.0.0.1:3000/hook.js"></script>'
EXPOSE 3000
#CMD tail -f /dev/null
ENTRYPOINT ["./beef"]
