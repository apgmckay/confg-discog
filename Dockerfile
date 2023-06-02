FROM dockage/confd:latest

COPY confg_discog /usr/bin/confg-discog

COPY confd/conf.d/myconfig.toml /etc/confd/conf.d/myconfig.toml
COPY confd/conf.d/myconfig.conf.tmpl /etc/confd/templates/myconfig.conf.tmpl

COPY entrypoint.sh /usr/bin/entrypoint
COPY cmd.sh /usr/bin/cmd
ENTRYPOINT ["/usr/bin/entrypoint"]
CMD ["/usr/bin/cmd"]
