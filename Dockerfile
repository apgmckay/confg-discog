FROM dockage/confd:latest

COPY confg_discog /usr/bin/confg-discog

COPY _terraform/tests/fixtures/default/confd/conf.d/myconfig.toml /etc/confd/conf.d/myconfig.toml
COPY _terraform/tests/fixtures/default/confd/conf.d/myconfig.sh /etc/confd/templates/myconfig.sh.tmpl

COPY entrypoint.sh /usr/bin/entrypoint
COPY cmd.sh /usr/bin/cmd

ENTRYPOINT ["/usr/bin/entrypoint"]
CMD ["/usr/bin/cmd"]
