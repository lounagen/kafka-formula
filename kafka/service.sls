# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "kafka/map.jinja" import kafka with context %}

kafka-name:
  service.running:
    - name: {{ kafka.service.name }}
    - enable: True
    - watch:
      - archive: kafka-tarball
      - file: kafka-systemd
      - file: kafka-systemv
      - file: kafka-upstart

