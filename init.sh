#!/usr/bin/env sh

# Copyright (C) Antoine Catton <devel at antoine dot catton dot fr>
#
# This program is a free software. It comes without any warranty to the extent
# permitted by applicable law. You can redistribute it and/or modify it under
# the terms of the Do What The Fuck You Want To Public License, Version 2, as
# published by Sam Hocevar. See the http://www.wtfpl.net/ file for more
# details.

set -e

if pg_lsclusters | grep -E "^9.4\s+main" > /dev/null
then
    true  # Support dash
else
    pg_createcluster 9.4 main --encoding=UTF-8
fi

cat > /etc/postgresql/9.4/main/pg_hba.conf <<PG_HBA
#type  database    user    address     auth-method
host   all         all     all         trust
PG_HBA

conf=/etc/postgresql/9.4/main/postgresql.conf
grep -E "^listen_addresses" $conf > /dev/null || (echo "listen_addresses = '*'" >> $conf)

# Shamelessly stolen from /usr/share/postgresql-common/init.d-functions

# Create socket directory
if [ -d /var/run/postgresql ];
then
    chmod 2775 /var/run/postgresql
else
    install -d -m 2775 -o postgres -g postgres /var/run/postgresql
    # My dream is to run selinux inside docker. So let's support this case
    [ -x /bin/restorecon ] && restorecon -R /var/run/postgresql || true
fi

exec /usr/bin/pg_ctlcluster 9.4 main start --foreground
