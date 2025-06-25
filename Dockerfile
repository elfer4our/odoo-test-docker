FROM python:3.10-slim

# System packages needed for Odoo
RUN apt-get update && apt-get install -y \
    git gcc libpq-dev libxml2-dev libxslt1-dev zlib1g-dev \
    libsasl2-dev libldap2-dev node-less npm \
    && rm -rf /var/lib/apt/lists/*

# Create user
RUN useradd -m -d /opt/odoo -U -r -s /bin/bash odoo

WORKDIR /opt/odoo

# Clone Odoo source
RUN git clone --depth 1 --branch 16.0 https://github.com/odoo/odoo.git .

# Add custom addons to /mnt/custom_addons
COPY ./custom_addons /mnt/custom_addons

# Install Python requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

CMD ["odoo-bin"]
