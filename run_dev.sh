echo "###### set env vars ############"
ENV=dev
POSTGRES_USER=phx_$ENV
POSTGRES_PASSWORD=phx_$ENV
POSTGRES_DATABASE=phx_$ENV
DB_CONTAINER=phx-dev-postgres

echo "###### start composer ############"
docker compose up -d
sleep 2

echo "###### create postres user ############"
docker exec -ti $DB_CONTAINER psql -U postgres -c "CREATE USER $POSTGRES_USER WITH PASSWORD '$POSTGRES_PASSWORD' CREATEDB;"

echo "###### create postres database ############"
docker exec -ti $DB_CONTAINER psql -U postgres -c "CREATE DATABASE $POSTGRES_DATABASE OWNER $POSTGRES_USER;"

echo "###### ecto migrate ############"
docker exec -it phx-dev-app mix ecto.migrate
docker exec -it phx-dev-app mix gettext.extract
docker exec -it phx-dev-app mix gettext.merge priv/gettext

echo "###### check db access ############"
# docker exec -ti $DB_CONTAINER psql -U $POSTGRES_USER -c "select id,login,email from users;"

echo "###### check running containers ############"
docker ps | grep phx-dev

echo "###### compose logs ############"
docker compose logs -f

echo "###### stop composer ############"
echo -n "docker compose down? [Y] "; read answer
docker compose down
