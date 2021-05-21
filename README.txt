#!/bin/bash
[ ! -e environ_env ] || source environ_env

usage () {
    cat <<'HELP_USAGE'
Usage: environ [--rebuild 0] [--build 0] [--local 0] [--cachedir <0|path>] \
               [--dir <path>] [-l|--localdir <path>] <product> [<path>]

environ - generate a folder with helper scripts to manage and automate services
  in test environments without privileged access.
      The command prints the path to a folder with generated scripts. Further,
  use 'start' / 'stop' / 'status' / 'print_address' / etc scripts in generated
  folders to review what they do and to manage services.
      For a full list of available commands refer to the content of generated
  folders, (shell completion is useful there as well).

  --rebuild 0 - do not overwrite existing templates, if any.
  --build 0 - do not search and call 'build' script among the created
      templates.
  --local 0 - do not create a folder in the current directory, only a folder in
      the cache directory will be created.
  --cachedir 0 - do not create a folder in the cache directory, only a local
      folder will be created.
  --cachedir <path> - use <path> for cache directory location (default is
      /temp/environ/)
  --dir <path> - path to templates (default /etc/environ.d/).
  --localdir <path> - additional path to templates (default t/lib/environ/).
  <product> - a service for which scripts will be generated. Currently
    supported values are names of folders in --tempatedir parameter (default
    /etc/environ/product). <product> may be also followed by a digit if more
    than one service is needed.
  <path> - if specified, must point to a folder with source codes of the
      desired product. In this case templates (when available) will actually
      build the product from source, (unless --build option is set to 0).

Notes:
  * DON"T USE IT IN PRODUCTION. 'environ' is intended to be used for testing and
  'proof of concept' purposes only. It intentionally makes services less
  secure to ensure ease of use;
  * 'environ' utility and generated scripts never use privileged access, so all
  commands are safe for general system configuration (the services may occupy
  certain ports though, this is the only side effect);
  * to prevent conflicts between services generated in different location - the
  utility uses cache directory (default /var/cache/environ/). It will try to
  properly cleanup services;
  * at the moment the templates do not cover installing actual services and
  their dependencies (make sure all dependencies are installed for the
  desired service);
  * all content of generated folders will be deleted when the folder is
  recreated (unless `--rebuild 0` parameter is provided);
  * all configuration used and service' logs will usually remain inside the
  generated folder;
  * most of the templates use special directory 'dt' inside generated folders,
  where files will be placed (e.g. actual data for database services or content
  of WebServers with autoindex enabled, etc);
  * it currently covers a limited set of products, but the concept must be
  useful for testing in most of software projects;
  * when reusing an existing folder, the utility will attempt to stop and
  cleanup existing services. So corresponding diagnostic messages will be
  printed in the console.

Examples:
  * Generate templates for managing local Apache web server, start it, add
  files and list them with curl commands:

       environ ap1
       ap1/start
       ap1/status
       echo mytest > ap1/dt/myfile
       ap1/curl -I /myfile
       # commands below should print 'mytest'
       ap1/curl /myfile
       curl -s $(ap1/print_address)/myfile

  * Generate templates for a randomly chosen web server, start it, add files
  and list them with curl command. The Web Server will be Apache or Nginx
  (50/50):

       if test $((RANDOM % 10 < 5)) -le 5; then ws=$(environ ap1); else ws=$(environ ng1); fi
       $ws/start
       echo mytest > $ws/dt/myfile
       $ws/curl -I /myfile

  * Generate templates for managing local postgres database, start it, create
  database, create test table:

       environ pg1
       pg1/start
       pg1/create_db mytest
       pg1/sql_mytest 'create table t as select 1'
       # now there are several ways to execute SQL commands:
       pg1/sql_mytest 'select * from t'
       pg1/sql -t -c 'select * from t' mytest
       PGHOST=$(pwd)/pg1/dt psql -t -c 'select * from t' mytest

   * Generate templates for managing local rsync server, configure rsync
   module, start the service, add files and list them using rsync client
   commands:

       rs=$(environ rs)
       $rs/configure_dir test1 $rs/dt/test1
       mkdir -p $rs/dt/test1
       $rs/start
       touch $rs/dt/test1/test2
       $rs/ls_test1 | grep test2
       RSYNC_PASSWORD=$USER rsync --list-only rsync://$($rs/print_address)/test1/ | grep test2

