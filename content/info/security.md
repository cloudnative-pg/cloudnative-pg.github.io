---
title: Security & TLS Certificates
order: 10
icon: icons/info/security.svg
---
CloudNativePG supports security contexts by default and implements in-transit
encrypted TLS connections. If you are not happy with auto-generated
certificates, you can bring your own and even integrate with cert-manager. TLS
client authentication for PostgreSQL is also supported, and auditing with PGAudit
can be easily enabled in a declarative way.

