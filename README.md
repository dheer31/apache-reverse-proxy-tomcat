# Apache HTTP Server Reverse Proxy for Apache Tomcat

This project demonstrates how to configure **Apache HTTP Server (apache2)** as a **Reverse Proxy** for a Java web application deployed on **Apache Tomcat**.

---

## Architecture

```text
                  Client
                     |
              HTTP (Port 80)
                     |
      Apache HTTP Server (apache2)
          Reverse Proxy (mod_proxy)
                     |
            Tomcat (Port 8080)
                     |
               webapp.war
```

---

## Prerequisites

- Ubuntu 22.04 / 24.04 EC2 Instance
- Java 17 or later
- Apache Tomcat installed
- WAR file deployed on Tomcat
- Sudo privileges

---

# Step 1: Update Packages

```bash
sudo apt update
```

---

# Step 2: Install Apache HTTP Server

```bash
sudo apt install apache2 -y
```

Verify installation:

```bash
sudo systemctl status apache2
```

Enable Apache to start on boot:

```bash
sudo systemctl enable apache2
```

---

# Step 3: Enable Required Proxy Modules

Enable Apache proxy modules.

```bash
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2enmod headers
```

Restart Apache.

```bash
sudo systemctl restart apache2
```

---

# Step 4: Create Virtual Host Configuration

Create a new site configuration.

```bash
sudo nano /etc/apache2/sites-available/tomcat.conf
```

Add the following configuration.

## If your application is deployed as `webapp.war`

```apache
<VirtualHost *:80>

    ServerName _

    ProxyPreserveHost On

    ProxyPass / http://localhost:8080/webapp/
    ProxyPassReverse / http://localhost:8080/webapp/

    ErrorLog ${APACHE_LOG_DIR}/tomcat_error.log
    CustomLog ${APACHE_LOG_DIR}/tomcat_access.log combined

</VirtualHost>
```

---

## If your application is deployed as `ROOT.war`

Replace the Proxy directives with:

```apache
ProxyPass / http://localhost:8080/
ProxyPassReverse / http://localhost:8080/
```

---

# Step 5: Enable the New Site

```bash
sudo a2ensite tomcat.conf
```

---

# Step 6: Disable the Default Site

```bash
sudo a2dissite 000-default.conf
```

---

# Step 7: Verify Apache Configuration

```bash
sudo apache2ctl configtest
```

Expected Output

```
Syntax OK
```

---

# Step 8: Restart Apache

```bash
sudo systemctl restart apache2
```

---

# Step 9: Verify Tomcat

Check whether Tomcat is running.

```bash
sudo ss -tulnp | grep 8080
```

or

```bash
curl http://localhost:8080/webapp
```

---

# Step 10: Test Reverse Proxy

Open your browser.

```
http://<EC2-PUBLIC-IP>
```

Apache HTTP Server forwards requests to

```
http://localhost:8080/webapp
```

---

# Useful Commands

Restart Apache

```bash
sudo systemctl restart apache2
```

Reload Apache

```bash
sudo systemctl reload apache2
```

Check Apache Status

```bash
sudo systemctl status apache2
```

Check Apache Configuration

```bash
sudo apache2ctl configtest
```

View Access Logs

```bash
sudo tail -f /var/log/apache2/tomcat_access.log
```

View Error Logs

```bash
sudo tail -f /var/log/apache2/tomcat_error.log
```

---

# Project Flow

```
Client Request
       │
       ▼
Apache HTTP Server (Port 80)
       │
       ▼
Reverse Proxy
       │
       ▼
Apache Tomcat (Port 8080)
       │
       ▼
webapp.war
```

---

# Advantages of Reverse Proxy

- Hides the Tomcat server from clients.
- Improves security.
- Supports SSL/TLS termination.
- Enables URL rewriting.
- Supports load balancing.
- Provides centralized logging.
- Improves scalability.
- Handles client requests efficiently.

---

# Common Interview Questions

### What is a Reverse Proxy?

A reverse proxy receives client requests and forwards them to one or more backend servers. Clients interact only with the proxy server and are unaware of the backend servers.

---

### Why use Apache HTTP Server in front of Tomcat?

- SSL Termination
- Reverse Proxy
- Load Balancing
- Security
- URL Rewriting
- Static Content Handling
- Better Performance

---

### Difference Between Apache HTTP Server and Apache Tomcat

| Apache HTTP Server | Apache Tomcat |
|--------------------|---------------|
| Web Server | Application Server |
| Serves Static Content | Runs Java Applications |
| Reverse Proxy | Deploys WAR Files |
| Listens on Port 80/443 | Listens on Port 8080 |
| Uses mod_proxy | Uses Servlet Container |

---

## Technologies Used

- Apache HTTP Server (apache2)
- Apache Tomcat
- Java
- Ubuntu
- Linux
- HTTP
- Reverse Proxy

---

## Author

**Dheeraj D**

Aspiring Java Full Stack & DevOps Engineer



