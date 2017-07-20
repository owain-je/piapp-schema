FROM gliderlabs/alpine:3.1 
RUN apk --update add mysql-client bash
COPY schema.sql schema.sql
COPY install_schema.sh /install_schema.sql
RUN chmod 755 /install_schema.sql
ENTRYPOINT ["/bin/bash"]
CMD["/install_schema.sh"]
