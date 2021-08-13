# dynuiuc-alpine
Docker container for Official DYNU IP Update Client

Unlike 'go2engle' project, this container runs on Alpine and thus has much smaller size. The used environment variables with their default values are listed below:

| Variable | Default Value |
| --- | --- |
| USERNAME | null |
| PASSWORD | null |
| LOCATION | null |
| IPV4 | true |
| IPV6 | true |
| POLLINTERVAL | 120 |
| DEBUG | false |
| QUIET | false |

USERNAME and PASSWORD are mandatory, all others can be skipped.
Warning: for security reasons it is strongly recommended to set and use 'IP Update Password' instead of account password.

## Simple run
`docker run -d --name dynuiuc -e "USERNAME=Your_Username" -e "PASSWORD=Your_Password" alfonder/dynuiuc-alpine`

## Deploy via compose
Below is a sample docker-compose.yml to get the container up and running. In case of using portainer you should be able to copy-paste this compose file into a stack and be up and running.
```yaml
version: "3.8"
services:
  dynuiuc:
    container_name: dynuiuc
    image: alfonder/dynuiuc-alpine
    network_mode: host
    restart: unless-stopped
    environment:
      - USERNAME=email@example.com
      - PASSWORD=passw0rd

```
