sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y apache2
echo '<h1>hello lab one</h1>' | sudo tee /var/www/html/index.html
sudo systemctl enable apache2
sudo systemctl start apache2
