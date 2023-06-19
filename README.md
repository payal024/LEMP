# LEMP

# WordPress Site Management Script

This command-line script allows you to manage WordPress sites using a LEMP stack running inside Docker containers. It provides the following features:

- Installation of Docker and Docker Compose if not already installed.
- Creation of a WordPress site using the latest WordPress version.
- Automatic setup of a local development environment with Nginx, MySQL, and WordPress containers.
- Management of site enable/disable (starting/stopping containers).
- Deletion of a site (containers and local files).

## Prerequisites

- Docker
- Docker Compose

## Installation

1. Clone the repository or download the script file:
   ```bash
   git clone https://github.com/payal024/LEMP.git
2. Navigate to the script directory:
   cd LEMP
3. Make the script executable:
   chmod +x wordpress_script.sh




Usage
Checking Dependencies
To check if Docker and Docker Compose are installed on your system, run the following command:
./wordpress_script.sh check-dependencies
If any of the dependencies are missing, the script will automatically install them.

Creating a WordPress Site
To create a new WordPress site, use the create subcommand followed by the desired site name:
./wordpress_script.sh create example.com

This will set up a new WordPress site with the provided name.

Updating /etc/hosts
The script will automatically update the /etc/hosts file to map the site name to localhost.

Opening the Site in a Browser
If the site is up and running, you can open it in a browser using the following command:
./wordpress_script.sh open example.com


Enabling/Disabling the Site
To start or stop the containers for a site, use the enable or disable subcommands:
./wordpress_script.sh enable example.com
./wordpress_script.sh disable example.com

Deleting the Site
To delete a WordPress site, use the delete subcommand:
./wordpress_script.sh delete example.com

This will remove the containers and local files associated with the site.
