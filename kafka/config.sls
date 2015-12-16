# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "kafka/map.jinja" import kafka with context %}

kafka-config:
  file.managed:
    - name: {{ kafka.config }}
    - source: salt://kafka/files/conf/server.properties
    - template: jinja
    - mode: 644
    - user: root
    - group: root
