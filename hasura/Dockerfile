from hasura/graphql-engine:v2.36.3.cli-migrations-v3

run  apt-get update && apt-get install -y curl

# Write with the right permissions
arg NAME=user
arg UID=1000
arg GID=1000

run  groupadd -g $GID -o $NAME
run  useradd -m -u $UID -g $GID -o -s /bin/bash $NAME

copy ./migrations /hasura-migrations
copy ./metadata /hasura-metadata


run chown -R $UID:$GID /hasura-migrations
run chown -R $UID:$GID /hasura-metadata

user $NAME
