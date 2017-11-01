FROM gliderlabs/alpine:3.1 
RUN apk --update add mysql-client bash netcat-openbsd
COPY schema.sql schema.sql
COPY test_data.sql test_data.sql
COPY install_schema.sh /install_schema.sh
RUN chmod 755 /install_schema.sh
ENTRYPOINT ["/install_schema.sh"]

