# Docker (compose) Postgres upgrading

Proof of concept to use a entrypoint wrapper to perform both `pg_upgrade` as data schema updates.

## Demo

```bash
docker-compose -f docker-compose11.yml up -d
docker-compose -f docker-compose11.yml exec db psql -U postgres some_app -c "SELECT * FROM some_data;";
 id |                                         data                                          |            created            
----+---------------------------------------------------------------------------------------+-------------------------------
  1 | init data                                                                             | 2019-10-12 12:00:39.466121+00
  2 | more data                                                                             | 2019-10-12 12:00:39.466121+00
  3 | PostgreSQL 11.4 on x86_64-pc-linux-musl, compiled by gcc (Alpine 8.3.0) 8.3.0, 64-bit | 2019-10-12 12:00:39.466121+00
(3 rows)
docker-compose -f docker-compose12.yml up -d
docker-compose -f docker-compose12.yml exec db psql -U postgres some_app -c "SELECT * FROM some_data;";
 id |                                         data                                          |            created            |         new         
----+---------------------------------------------------------------------------------------+-------------------------------+---------------------
  1 | init data                                                                             | 2019-10-12 12:00:39.466121+00 | 
  2 | more data                                                                             | 2019-10-12 12:00:39.466121+00 | 
  3 | PostgreSQL 11.4 on x86_64-pc-linux-musl, compiled by gcc (Alpine 8.3.0) 8.3.0, 64-bit | 2019-10-12 12:00:39.466121+00 | 
  4 | PostgreSQL 12.0 on x86_64-pc-linux-musl, compiled by gcc (Alpine 8.3.0) 8.3.0, 64-bit | 2019-10-12 12:01:28.735376+00 | insert in migration
(4 rows)
```

## ToDo

* Probably copy/replace the whole [`docker-entrypoint.sh`](https://github.com/docker-library/postgres/blob/2353eaaa68b7f4febfa08571a6499367a36b560d/12/alpine/docker-entrypoint.sh) script.
* Zero downtime migration, with logical replication?