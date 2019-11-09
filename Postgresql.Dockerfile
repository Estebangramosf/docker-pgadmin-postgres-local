# Database (http://www.cs3c.ma/)
FROM postgres:11


ENV TERM=xterm

RUN apt-get update
RUN apt-get install -y nano

#USER postgres

# Create a PostgreSQL role named ``docker`` with ``docker`` as the password and
# then create a database `docker` owned by the ``docker`` role.
# Note: here we use ``&&\`` to run commands one after the other - the ``\``
#       allows the RUN command to span multiple lines.

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible.
RUN echo "host all  all    0.0.0.0/0  md5" >> /var/lib/postgresql/data/pg_hba.conf

# And add ``listen_addresses`` to ``/var/lib/postgresql/data/postgresql.conf``
RUN echo "listen_addresses='*'" >> /var/lib/postgresql/data/postgresql.conf

# Expose the PostgreSQL port
EXPOSE 5432

# Add VOLUMEs to allow backup of config, logs and databases
# VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

# Set the default command to run when starting the container
# CMD ["/usr/lib/postgresql/11/bin/postgres", "-D", "/var/lib/postgresql/11/main", "-c", "config_file=/var/lib/postgresql/data/postgresql.conf"]
CMD ["postgres"]
# CMD ["/usr/lib/postgresql/11/bin/postgres -c config_file=/var/lib/postgresql/data/postgresql.conf"]