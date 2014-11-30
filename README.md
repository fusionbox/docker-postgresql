Antoine's PostgreSQL Docker
===========================

PostgreSQL done right:

 * No tag, just the latest version.
 * Postgresql-contrib
 * Postgis
 * Debian's package:
    * Well maintained
    * Bugs are reported to it
    * it just works
 * Debian's default configuration
    * Well maintained
    * Bug are reported to it
    * it just works
 * The simplest Dockerfile ever
    * You understand what it does
    * No fancy stuff
    * No third party software
 * KISS

Here's its features:

 * It exposes the port of postgres (you can use a random port with `docker run
   -P`)
 * You can connect with any user, the root user is "postgres" without any
   password
 * You can create databases
 * You can create users
 * You get a full postgresql server
