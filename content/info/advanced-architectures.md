---
title: Advanced Architectures
order: 40
icon: icons/info/advanced.svg
---
You can extend the primary/standby architecture by adding a PgBouncer
connection pooler between your application and your PostgreSQL database.
Additionally, you can take advantage of replica clusters by creating one or
more disaster recovery clusters in different regions, solely relying on file
based WAL shipping from an object store or using a streaming replication
connection.

