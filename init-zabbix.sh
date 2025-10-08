#!/bin/sh

echo "=== Zabbix Agent 2 Initialization ==="

# Create directories
echo "Creating directories..."
mkdir -p /etc/zabbix/zabbix_agent2.d/plugins.d

# Create main configuration file
echo "Creating zabbix_agent2.conf..."
cat > /etc/zabbix/zabbix_agent2.conf << EOF
# Zabbix Agent 2 Configuration
PidFile=/tmp/zabbix_agent2.pid
LogFile=/tmp/zabbix_agent2.log
LogFileSize=1

# Server configuration
Server=${ZBX_SERVER_HOST}
ListenPort=10050
ServerActive=${ZBX_SERVER_HOST}:${ZBX_SERVER_PORT}

# Agent identification
Hostname=${ZBX_HOSTNAME}
Timeout=30

# Plugin configuration
Include=/etc/zabbix/zabbix_agent2.d/plugins.d/*.conf

# User parameters
UnsafeUserParameters=${ZBX_UNSAFEUSERPARAMETERS}

# Debug settings
DebugLevel=${ZBX_DEBUGLEVEL}

# Buffer settings
BufferSize=100
ControlSocket=/tmp/agent.sock
EOF

# Create empty plugin configuration files
echo "Creating plugin configuration files..."
touch /etc/zabbix/zabbix_agent2.d/plugins.d/mongodb.conf
touch /etc/zabbix/zabbix_agent2.d/plugins.d/postgresql.conf
touch /etc/zabbix/zabbix_agent2.d/plugins.d/mssql.conf
touch /etc/zabbix/zabbix_agent2.d/plugins.d/ember.conf

echo "Configuration files created successfully!"
echo "Starting Zabbix Agent 2..."
echo "Server: ${ZBX_SERVER_HOST}:${ZBX_SERVER_PORT}"
echo "Hostname: ${ZBX_HOSTNAME}"
echo "=================================="

# Start Zabbix Agent 2
exec /usr/sbin/zabbix_agent2 --foreground -c /etc/zabbix/zabbix_agent2.conf