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
2. Make the script executable:
   chmod +x main.sh




Usage
Checking Dependencies
To check if Docker and Docker Compose are installed on your system, run the following command:
./main.sh check-dependencies
If any of the dependencies are missing, the script will automatically install them.

Creating a WordPress Site
To create a new WordPress site, use the create subcommand followed by the desired site name:
./main.sh create example.com

This will set up a new WordPress site with the provided name.

Updating /etc/hosts
The script will automatically update the /etc/hosts file to map the site name to localhost.

Opening the Site in a Browser
If the site is up and running, you can open it in a browser using the following command:
./main.sh open example.com


Enabling/Disabling the Site
To start or stop the containers for a site, use the enable or disable subcommands:
./main.sh enable example.com
./main.sh disable example.com

Deleting the Site
To delete a WordPress site, use the delete subcommand:
./main.sh delete example.com

This will remove the containers and local files associated with the site.
