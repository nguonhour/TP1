FROM jenkins/ssh-agent:latest

USER root

RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    git \
    lsb-release \
    unzip && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://packages.sury.org/php/apt.gpg | gpg --dearmor -o /etc/apt/keyrings/sury-php.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/sury-php.gpg] https://packages.sury.org/php/ $(. /etc/os-release && echo ${VERSION_CODENAME}) main" > /etc/apt/sources.list.d/sury-php.list && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_22.x nodistro main" > /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && apt-get install -y \
    nodejs \
    php8.5-bcmath \
    php8.5-cli \
    php8.5-common \
    php8.5-curl \
    php8.5-intl \
    php8.5-mbstring \
    php8.5-readline \
    php8.5-sqlite3 \
    php8.5-xml \
    php8.5-zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    mv composer.phar /usr/local/bin/composer && \
    rm composer-setup.php