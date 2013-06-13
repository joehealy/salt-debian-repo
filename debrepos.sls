

debpkgs:
  pkg.installed:
    - pkgs:
      - apache2
      - rsync


/etc/apache2/conf.d/debrepos-apache:
  file.managed:
    - source: salt://debrepos/debrepos-apache
    - mode: 644
    - user: root
    - group: root
    - require:
       - pkg: debpkgs

/srv/debrepos/debian:
  file.directory:
    - mode: 755
    - makedirs: True


/srv/debrepos/debian-salt-team-joehealy.gpg.key:
  file.managed:
    - source: salt://debrepos/debian-salt-team-joehealy.gpg.key
    - mode: 644
    - require:
       - file: /srv/debrepos/debian

/srv/debrepos/index.html:
  file.managed:
    - source: salt://debrepos/index.html
    - mode: 644
    - require:
       - file: /srv/debrepos/debian


apache2:
  service:
    - running
    - watch:
      - file: /etc/apache2/conf.d/debrepos-apache
    - require:
      - pkg: debpkgs

