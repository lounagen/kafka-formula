# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "kafka/map.jinja" import kafka with context %}

include:
  - kafka.config

kafka-name:
  service.running:
    - name: {{ kafka.service.name }}
    - enable: True
    - watch:
      - archive: kafka-tarball
      - file: kafka-config
      - file: kafka-systemd
      - file: kafka-systemv
      - file: kafka-upstart

