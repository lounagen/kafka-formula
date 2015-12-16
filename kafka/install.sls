# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "kafka/map.jinja" import kafka with context %}

kafka:
  group.present:
    - system: True
  user.present:
    - fullname: kafka service
    - shell: /usr/sbin/nologin
    - home: /var/lib/kafka
    - system: True
    - gid_from_name: True
    - groups:
      - kafka

kafka-tarball:
  archive.extracted:
    - name: /usr/local/lib
    - source: {{ kafka.tarball.tgz.source }}
    - source_hash: {{ kafka.tarball.tgz.source_hash }}
    - archive_format: tar
    - tar_options: z
    - user: root
    - group: root
    - if_missing: /usr/local/lib/kafka_{{ kafka.version.scala }}-{{ kafka.version.kafka }}

kafka-alternatives:
  alternatives.install:
    - name: kafka
    - link: /usr/local/lib/kafka
    - path: /usr/local/lib/kafka_{{ kafka.version.scala }}-{{ kafka.version.kafka }}
    - priority: 30
    - require:
      - archive: kafka-tarball

kafka-systemd:
  file.managed:
    #- name: /etc/systemd/kafka.service
    - name: /lib/systemd/system/kafka.service
    - source: salt://kafka/files/systemd/kafka.service
    - template: jinja
    - mode: 644
    - user: root
    - group: root
# todo: run "systemctl daemon-reload" after modifying the systemd files
                  
kafka-upstart:
  file.managed:
    - name: /etc/init/kafka.conf
    - source: salt://kafka/files/upstart/kafka.conf
    - template: jinja
    - mode: 644
    - user: root
    - group: root
