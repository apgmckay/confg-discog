FROM dockage/confd:latest

COPY entrypoint.sh /usr/bin/entrypoint
COPY cmd.sh /usr/bin/cmd
ENTRYPOINT ["/usr/bin/entrypoint"]
CMD ["/usr/bin/cmd"]
