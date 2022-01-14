docker exec 8d4b10ab44f1 bin/solr delete -c races_default
docker exec 8d4b10ab44f1 bin/solr delete -c races_schema
docker exec 8d4b10ab44f1 bin/solr delete -c races_boost

docker exec 8d4b10ab44f1 bin/solr create_core -c races_default
docker exec 8d4b10ab44f1 bin/solr create_core -c races_schema
docker exec 8d4b10ab44f1 bin/solr create_core -c races_boost

# Default (without schema)
curl -X POST -H 'Content-type:application/csv' --data-binary @C:\\Users\\'Diogo Nunes'\\'OneDrive - Universidade do Porto'\\FEUP\\PRI\\Formula1\\data\\final_csvs\\races.csv localhost:8983/solr/races_default/update?commit=true
curl -X POST -H 'Content-type:application/csv' --data-binary @C:\\Users\\'Diogo Nunes'\\'OneDrive - Universidade do Porto'\\FEUP\\PRI\\Formula1\\data\\final_csvs\\seasons.csv localhost:8983/solr/races_default/update?commit=true
curl -X POST -H 'Content-type:application/csv' --data-binary @C:\\Users\\'Diogo Nunes'\\'OneDrive - Universidade do Porto'\\FEUP\\PRI\\Formula1\\data\\final_csvs\\drivers.csv localhost:8983/solr/races_default/update?commit=true
curl -X POST -H 'Content-type:application/csv' --data-binary @C:\\Users\\'Diogo Nunes'\\'OneDrive - Universidade do Porto'\\FEUP\\PRI\\Formula1\\data\\final_csvs\\constructors.csv localhost:8983/solr/races_default/update?commit=true
curl -X POST -H 'Content-type:application/csv' --data-binary @C:\\Users\\'Diogo Nunes'\\'OneDrive - Universidade do Porto'\\FEUP\\PRI\\Formula1\\data\\final_csvs\\circuits.csv localhost:8983/solr/races_default/update?commit=true
curl -X POST -H 'Content-type:application/csv' --data-binary @C:\\Users\\'Diogo Nunes'\\'OneDrive - Universidade do Porto'\\FEUP\\PRI\\Formula1\\data\\final_csvs\\pages.csv localhost:8983/solr/races_default/update?commit=true

# Schema
curl -X POST -H 'Content-type:application/json' -d @C:\\Users\\'Diogo Nunes'\\'OneDrive - Universidade do Porto'\\FEUP\\PRI\\Formula1\\data\\schema\\schema.json http://localhost:8983/solr/races_schema/schema

curl -X POST -H 'Content-type:application/csv' --data-binary @C:\\Users\\'Diogo Nunes'\\'OneDrive - Universidade do Porto'\\FEUP\\PRI\\Formula1\\data\\final_csvs\\races.csv localhost:8983/solr/races_schema/update?commit=true
curl -X POST -H 'Content-type:application/csv' --data-binary @C:\\Users\\'Diogo Nunes'\\'OneDrive - Universidade do Porto'\\FEUP\\PRI\\Formula1\\data\\final_csvs\\seasons.csv localhost:8983/solr/races_schema/update?commit=true
curl -X POST -H 'Content-type:application/csv' --data-binary @C:\\Users\\'Diogo Nunes'\\'OneDrive - Universidade do Porto'\\FEUP\\PRI\\Formula1\\data\\final_csvs\\drivers.csv localhost:8983/solr/races_schema/update?commit=true
curl -X POST -H 'Content-type:application/csv' --data-binary @C:\\Users\\'Diogo Nunes'\\'OneDrive - Universidade do Porto'\\FEUP\\PRI\\Formula1\\data\\final_csvs\\constructors.csv localhost:8983/solr/races_schema/update?commit=true
curl -X POST -H 'Content-type:application/csv' --data-binary @C:\\Users\\'Diogo Nunes'\\'OneDrive - Universidade do Porto'\\FEUP\\PRI\\Formula1\\data\\final_csvs\\circuits.csv localhost:8983/solr/races_schema/update?commit=true
curl -X POST -H 'Content-type:application/csv' --data-binary @C:\\Users\\'Diogo Nunes'\\'OneDrive - Universidade do Porto'\\FEUP\\PRI\\Formula1\\data\\final_csvs\\pages.csv localhost:8983/solr/races_schema/update?commit=true

# Schema with boosts
curl -X POST -H 'Content-type:application/json' -d @C:\\Users\\'Diogo Nunes'\\'OneDrive - Universidade do Porto'\\FEUP\\PRI\\Formula1\\data\\schema\\schema.json http://localhost:8983/solr/races_boost/schema

curl -X POST -H 'Content-type:application/csv' --data-binary @C:\\Users\\'Diogo Nunes'\\'OneDrive - Universidade do Porto'\\FEUP\\PRI\\Formula1\\data\\final_csvs\\races.csv localhost:8983/solr/races_boost/update?commit=true
curl -X POST -H 'Content-type:application/csv' --data-binary @C:\\Users\\'Diogo Nunes'\\'OneDrive - Universidade do Porto'\\FEUP\\PRI\\Formula1\\data\\final_csvs\\seasons.csv localhost:8983/solr/races_boost/update?commit=true
curl -X POST -H 'Content-type:application/csv' --data-binary @C:\\Users\\'Diogo Nunes'\\'OneDrive - Universidade do Porto'\\FEUP\\PRI\\Formula1\\data\\final_csvs\\drivers.csv localhost:8983/solr/races_boost/update?commit=true
curl -X POST -H 'Content-type:application/csv' --data-binary @C:\\Users\\'Diogo Nunes'\\'OneDrive - Universidade do Porto'\\FEUP\\PRI\\Formula1\\data\\final_csvs\\constructors.csv localhost:8983/solr/races_boost/update?commit=true
curl -X POST -H 'Content-type:application/csv' --data-binary @C:\\Users\\'Diogo Nunes'\\'OneDrive - Universidade do Porto'\\FEUP\\PRI\\Formula1\\data\\final_csvs\\circuits.csv localhost:8983/solr/races_boost/update?commit=true
curl -X POST -H 'Content-type:application/csv' --data-binary @C:\\Users\\'Diogo Nunes'\\'OneDrive - Universidade do Porto'\\FEUP\\PRI\\Formula1\\data\\final_csvs\\pages.csv localhost:8983/solr/races_boost/update?commit=true
