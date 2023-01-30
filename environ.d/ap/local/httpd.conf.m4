ErrorLog __datadir/error_log
LogLevel debug
LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-agent}i\""
TransferLog __datadir/access_log

Listen __port
PidFile __workdir/.pid

ServerName ap`'__wid
DocumentRoot "__datadir"

LoadModule authz_core_module /usr/lib64/apache2-prefork/mod_authz_core.so
LoadModule autoindex_module  /usr/lib64/apache2-prefork/mod_autoindex.so
LoadModule log_config_module /usr/lib64/apache2-prefork/mod_log_config.so
LoadModule alias_module      /usr/lib64/apache2-prefork/mod_alias.so
LoadModule dbd_module        /usr/lib64/apache2-prefork/mod_dbd.so

IncludeOptional __workdir/extra*.conf

Include __workdir/dir.conf
