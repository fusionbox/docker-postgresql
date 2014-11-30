# Copyright (C) Antoine Catton <devel at antoine dot catton dot fr>
#
# This work is free. It comes without any warranty, to the extent permitted by
# applicable law. You can redistribute it and/or modify it under the terms of
# the Do What The Fuck You Want To Public License, Version 2, as published by
# Sam Hocevar. See the LICENSE file for more details.

FROM debian:jessie
MAINTAINER Antoine Catton

# Update the packages
RUN ["/usr/bin/env", "DEBIAN_FRONTEND=noninteractive", "/usr/bin/apt-get", "update"]
# Install postgres, postgres-contrib and postgis
RUN ["/usr/bin/env", "DEBIAN_FRONTEND=noninteractive", "/usr/bin/apt-get", "install", "--no-install-recommends", "--assume-yes", "postgresql-9.4", "postgresql-contrib-9.4", "postgis", "postgresql-9.4-postgis-2.1"]

# Cleanup data
RUN ["/usr/bin/pg_dropcluster", "9.4", "main"]
VOLUME ["/var/log/postgresql"]

# Cleanup and share logs
# RUN ["/usr/bin/rm", "-f", "/var/log/postgresql/postgresql-9.4-main.log"]
# VOLUME ["/var/lib/postgresql/"]
# --foreground actually logs to stdout

# Antoine's PostgreSQL
RUN ["/bin/mkdir", "-p", "/opt/postgresql/bin/"]
COPY init.sh /opt/postgresql/bin/init.sh
RUN ["/bin/chown", "root:", "/opt/postgresql/bin/init.sh"]
RUN ["/bin/chmod", "755", "/opt/postgresql/bin/init.sh"]

EXPOSE 5432
CMD ["/opt/postgresql/bin/init.sh"]
