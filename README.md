# take-shelter

## importing data

This process creates the `hurricaneshelter` table, which is why it doesn't have
a migration.

1. Have postgresql, postgis, and gdal with postgres support installed.
`brew install gdal --with-postgres; brew install postgis` does this.
2. `rake db:create` if you haven't coreated the database already.
3. `rake import:shelter`
4. Now you have a database table called `hurricaneshelter` full of shelter
locations.
