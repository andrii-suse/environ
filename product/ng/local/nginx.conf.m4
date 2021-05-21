user __user;
worker_processes 1;
pid __workdir/.pid;

events {
}

http {
  server {
    listen            __port;
    server_name       localhost;

    access_log __workdir/log/access.log;
    error_log __workdir/log/error.log;
    client_body_temp_path __workdir/tmp/client_body;
    fastcgi_temp_path __workdir/tmp/fastcgi_temp;
    proxy_temp_path __workdir/tmp/proxy_temp;
    scgi_temp_path __workdir/tmp/scgi_temp;
    uwsgi_temp_path __workdir/tmp/uwsgi_temp;

    location / {
        root __workdir/dt;
        autoindex on;
    }
  }
}
