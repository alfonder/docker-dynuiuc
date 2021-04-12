# docker-dynuiuc
Docker container for DYNU IP Update Client

This container runs on Ubuntu 16.04 and uses the same version of `dynuiuc` with the same variables.

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

Provided in the repository/below is a sample/example `docker-compose.yml` that can be used to quickly deploy the container to a stack.
