## Template Script Details
The template engine uses jinja2 and passed the environment variables at
run time into the templates are **kwargs

*Example template*
```
# Default setup is given for MySQL with ruby1.9. If you're running
Redmine
# with MySQL and ruby1.8, replace the adapter name with `mysql`.
# Examples for PostgreSQL, SQLite3 and SQL Server can be found at the
end.
# Line indentation must be 2 spaces (no tabs).

# SQLite3 configuration example
{% if not DB_TYPE == 'postgresql' and not DB_TYPE == 'mysql' %}
production:
  adapter: sqlite3
  database: db/redmine-prod.sqlite3
{% else %}
{% if DB_TYPE == 'postgresql' %}
production:
  adapter: "{{DB_TYPE}}"
  encoding: "{{DB_ENCODING | default('unicode')}}"
  reconnect: false
  database: "{{DB_NAME | default('redmine')}}"
  host: "{{DB_HOST | default(POSTGRES_PORT_5432_TCP_ADDR)}}"
  port: {{DB_PORT | default(5432) | int }}
  username: "{{DB_USER | default(POSTGRES_ENV_DB_USER) }}"
  password: "{{DB_PASS | default(POSTGRES_ENV_DB_PASS) }}"
  pool: {{DB_POOL | default(5) | int}}
{% endif %}
{% if DB_TYPE == 'mysql' %}
production:
  adapter: "{{DB_TYPE}}"
  encoding: "{{DB_ENCODING | default('utf8')}}"
  reconnect: false
  database: "{{DB_NAME | default('redmine')}}"
  host: "{{DB_HOST | default(MYSQL_PORT_3306_TCP_ADDR)}}"
  port: {{DB_PORT | default(3306) | int }}
  username: "{{DB_USER | default(MYSQL_ENV_DB_USER) }}"
  password: "{{DB_PASS | default(MYSQL_ENV_DB_PASS) }}"
  pool: {{DB_POOL | default(5) | int}}
{% endif %}
{% endif %}
```

at this point you can just `docker run -e DB_TYPE=mysql --link
redmine-mysql:mysql redmine` for example

#### Dockerfile Example
```
FROM lgtml/docker-ruby
ADD templates/ /templates
```

#### entrypoint example
*Note: Can probably improve the script so this is not required*
```
#!/bin/bash
cd /templates/
for i in `find . -type f`
do
  filename=`basename $i|sed "s/^.\///"`
  dirname=`dirname $i|sed "s/^.\///"`
  generate_config.py --template $i --dest /opt/application/$dirname
done
```
