# proxy

## how to run the image
1. Build image with args
```
VELOCITY_SECRET: the velocity proxy's secret
VELOCITY_BUILD: the velocity's build number (on papermc.io)
```

2. Tag "proxy:latest" to the image

3. (If not created) create a bridge network named "mc"

3. Run container with `docker-compose up -d`