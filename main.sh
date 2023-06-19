#!/bin/bash

check_dependencies() {
    # Check if Docker is installed
    if ! command -v docker &> /dev/null; then
        echo "Docker is not installed. Installing Docker..."
        curl -fsSL https://get.docker.com -o get-docker.sh
        sudo sh get-docker.sh
        rm get-docker.sh
        echo "Docker installation complete."
    else
        echo "Docker is already installed."
    fi

    # Check if Docker Compose is installed
    if ! command -v docker-compose &> /dev/null; then
        echo "Docker Compose is not installed. Installing Docker Compose..."
        sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
        echo "Docker Compose installation complete."
    else
        echo "Docker Compose is already installed."
    fi
}

create_wordpress_site() {
    site_name=$1

    # Create a directory for the site
    mkdir -p "$site_name"
    cd "$site_name"

    # Create the docker-compose.yml file
    cat > docker-compose.yml << EOF
version: '3'
services:
  db:
    image: mysql:latest
    volumes:
      - db_data:/var/lib/mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: example
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress

  wordpress:
    depends_on:
      - db
    image: wordpress:latest
    ports:
      - "80:80"
    volumes:
      - ./wordpress:/var/www/html
    restart: always
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress
volumes:
  db_data:
EOF

    # Create the Nginx configuration file
    cat > nginx.conf << EOF
server {
    listen 80;
    server_name $site_name;

    root /var/www/html;
    index index.php;

    location / {
        try_files \$uri \$uri/ /index.php?\$args;
    }

    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_pass wordpress:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }
}
EOF

    # Create the start and stop scripts
    cat > start.sh << EOF
#!/bin/bash
docker-compose up -d
EOF

    cat > stop.sh << EOF
#!/bin/bash
docker-compose down
EOF

    chmod +x start.sh stop.sh

    echo "WordPress site created."
}

update_hosts_file() {
    site_name=$1
    echo "127.0.0.1 $site_name" | sudo tee -a /etc/hosts > /dev/null
    echo "Updated /etc/hosts file."
}

open_browser() {
    site_name=$1
    echo "Opening the site in a browser..."
    xdg-open "http://$site_name" > /dev/null 2>&1
}

enable_site() {
    site_name=$1
    docker-compose -f "$site_name/docker-compose.yml" up -d
    echo "Site enabled."
}

disable_site() {
    site_name=$1
    docker-compose -f "$site_name/docker-compose.yml" down
    echo "Site disabled
