FROM python:3.10-slim

# System packages needed for Odoo
RUN apt-get update && apt-get install -y \
    git gcc libpq-dev libxml2-dev libxslt1-dev zlib1g-dev \
    libsasl2-dev libldap2-dev node-less npm \
    && rm -rf /var/lib/apt/lists/*

# Create odoo user
RUN useradd -m -d /opt/odoo -U -r -s /bin/bash odoo

# Clone Odoo source directly into /opt/odoo
RUN git clone --depth 1 --branch 16.0 https://github.com/odoo/odoo.git /opt/odoo

# Set workdir
WORKDIR /opt/odoo

# Install Python requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Switch to odoo user (optional, good for security)
USER odoo

CMD ["python3", "/opt/odoo/odoo-bin"]
