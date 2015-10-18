solinea/logstash
---

Logstash running on OpenJDK JRE 7 and stable Debian.

`solinea/logstash` is a Docker image based on `solinea/debian`.

# Usage

Create a Dockerfile with the following content:

    FROM solinea/logstash

# Volumes

Volume               | Description
---------------------|-------------
/etc/logstash/conf.d | Configuration