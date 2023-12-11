# Get the oracle client
wget https://download.oracle.com/otn_software/linux/instantclient/219000/oracle-instantclient-basic-21.9.0.0.0-1.el8.x86_64.rpm
sudo yum install -y oracle-instantclient-basic-21.9.0.0.0-1.el8.x86_64.rpm

# Install Sqlplus
wget https://download.oracle.com/otn_software/linux/instantclient/219000/oracle-instantclient-sqlplus-21.9.0.0.0-1.el8.x86_64.rpm
sudo yum install -y oracle-instantclient-sqlplus-21.9.0.0.0-1.el8.x86_64.rpm

# Install docker container
docker run -p 1521:1521 -e ORACLE_PWD=helloworld 1521: container-registry.oracle.com/database/free

# Connect to the db
sqlplus sys/helloworld@localhost:1521/FREEPDB1 as sysdba
