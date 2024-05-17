# Creating a proxy network
docker network create --subnet=10.20.0.10/24 proxy
# Change the domain name
sudo nano nginx-config/nginx/snippets/authelia-authrequest.conf
# Enabled from http request to https after letsencrypt ssl installation
site-confs nginx-config/nginx/sites-available/default.conf
# Symlink after letsencrypt ssl installation and change the domain name
cd nginx-config/nginx/sites-enabled
sudo ln -s ../sites-available/default-ssl.conf
