FROM gliderlabs/alpine:3.1 
RUN apk --update add mysql-client 
COPY schema.sql schema.sql
COPY install_schema.sh install_schema.sql
ENTRYPOINT ["mysql"]
