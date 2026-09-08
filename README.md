# Alpine DDCLIENT Docker

A lightweight Alpine-based Docker container to run `ddclient` for dynamic DNS updates for **Infomaniak**.

## DynDNS Setup Guide

### 1. Configuring the DynDNS service with a dedicated account :

Follow the documentation given by Infomaniak : 
https://www.infomaniak.com/fr/support/faq/2357/gerer-une-ip-dynamique-avec-dyndns-infomaniak

---

## Quick Start

### 1. Create `ddclient.conf`
Create a configuration file in your working directory:

```ini
daemon=300                          # Check every 300s (5 minutes)
syslog=yes                          # To log
pid=/var/run/ddclient.pid
ssl=yes                             

# This is the configuration to use for Infomaniak DynDNS service : 
# It was copied from the official docs : https://www.infomaniak.com/fr/support/faq/40/utiliser-dyndns-infomaniak-et-ddclient-linux
protocol=dyndns2
ssl=yes
use=web
server=infomaniak.com
login=enter_your_login  # <-- CHANGE THIS
password=enter_your_password # <-- CHANGE THIS
yourdomain.xyz # <-- CHANGE THIS
```

Then : 

```bash
sudo chmod 600 ddclient.conf
```

### 2. Build and Run

```bash
# Build the image
docker build -t dyndns-infomaniak .
```

Or use the pre-built image : 

```bash
docker pull ghcr.io/bretss/dyndns-infomaniak:latest
```

Then : 
```
# Run the container
docker run -d \
  --name alpine-dyndns-infomaniak \
  --restart unless-stopped \
  -v $(pwd)/ddclient.conf:/etc/ddclient/ddclient.conf \
  dyndns-infomaniak
```

### 3. Check Logs
```bash
docker logs -f alpine-dyndns-infomaniak
```

---

## Maintenance

### 1. To update the ddclient docker : 

```bash
docker build --no-cache -t dyndns-infomaniak . && docker stop alpine-dyndns-infomaniak && docker rm -f dyndns-infomaniak && docker run -d --name alpine-dyndns-infomaniak --restart unless-stopped -v $(pwd)/ddclient.conf:/etc/ddclient/ddclient.conf dyndns-infomaniak
```

You can then create a bash script to automate the updating process.