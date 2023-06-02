FROM dockage/confd:latest

COPY confg-discog /usr/bin/confg-discog

COPY myconfig.toml /etc/confd/conf.d/myconfig.toml
COPY myconfig2.toml /etc/confd/conf.d/myconfig2.toml
COPY myconfig.conf.tmpl /etc/confd/templates/myconfig.conf.tmpl
COPY myconfig2.conf.tmpl /etc/confd/templates/myconfig2.conf.tmpl

COPY entrypoint.sh /usr/bin/entrypoint
COPY cmd.sh /usr/bin/cmd
ENTRYPOINT ["/usr/bin/entrypoint"]
CMD ["/usr/bin/cmd"]
