# 1. Use the official MySQL 8.0 image
FROM mariadb:latest

# Install ps (procps) so    `ps aux` works in the container
# Use Debian package manager (apt) since the base image is Debian-based
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		procps \
		zsh \
		git \
		curl \
		wget \
	&& rm -rf /var/lib/apt/lists/* \
	# Install Oh My Zsh for the container user (non-interactive)
	&& sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended \
	# Make zsh the default shell in /etc/passwd (covers sh/bash entries)
	&& sed -i 's#/bin/sh#/bin/zsh#g' /etc/passwd || true \
	&& sed -i 's#/bin/bash#/bin/zsh#g' /etc/passwd || true
    
# 2. Set environment variables (Best practice: use a .env file instead, but you can set defaults here)
ENV MYSQL_DATABASE=testdb
ENV MYSQL_ROOT_PASSWORD=demo123

# 3. Add a custom configuration file (optional)
# This allows you to change settings like max_connections or buffer sizes
# COPY ./my-custom-config.cnf /etc/mysql/conf.d/

# 4. Run initialization scripts
# Any .sh or .sql scripts put in this folder run automatically when the container starts
# COPY ./init-db.sql /docker-entrypoint-initdb.d/

# 5. Expose the default MySQL port
EXPOSE 3306

# Use zsh as the default shell for spawned shells
ENV SHELL=/bin/zsh