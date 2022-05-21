# How To Use:

### Choose your version
The tags are used to identify the version of Weblogic and JDK:
`<weblogic.version>-<jdk.version>`

|    Weblogic   | JDK |    Tag     |
|:-------------:|:---:|:----------:|
| 10.3.6        |  6  | 1036-jdk6  |
| 12.1.3        |  8  | 1213-jdk8  |
| 14.1.1        |  8  | 1411-jdk8  |
| 14.1.1        |  11 | 1411-jdk11 |

### Pull the image:
```console
docker pull camposdelima/weblogic:1411-jdk11
```

### Start the docker container with 7001, 7002 and 5556 ports opened from CLI:
```console
docker run -d camposdelima/weblogic:1411-jdk11 \
    -p 7001:7001 -p 8453:8453 \
    -v data:/u01/oracle/weblogic/user_projects/domains/base_domain 
```

### Or start the docker container with docker compose:
```yaml
version: '3.1'
services:
weblogic:
    image: camposdelima/weblogic:1411-jdk11
    build: .
    container_name: wls1411-jdk11
    ports:
        - "7001:7001"
        - "8453:8453"
    volumes:
        - data:/u01/oracle/weblogic/user_projects/domains/base_domain
volumes:
```

### Web Console

    http://localhost:7001/console
    User: weblogic
    Pass: welcome1

<br>

----
<br>

### Source code
Repository: https://github.com/camposdelima/misc/tree/master/docker/weblogic