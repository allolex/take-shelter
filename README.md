# take-shelter

## importing data from a postgresql custom dump

```ruby
pg*restore --verbose  --no-acl --no-owner --clean -d shelter-development DUMPNAME.dump
```

## importing data from files/first principles

This process creates the `hurricaneshelter` table, which is why it doesn't have
a migration.

1. Have postgresql, postgis, and gdal with postgres support installed.
`brew install gdal --with-postgres; brew install postgis` does this.
2. `rake db:create db:migrate` if you haven't created the database already.
3. `rake import:all`
