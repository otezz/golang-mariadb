# Go / Golang + MariaDB Docker Image

A Golang and mariadb docker image based on [golang](https://hub.docker.com/_/golang/)

### Sample `bitbucket-pipelines.yml`
    image: otezz/golang-mariadb
    pipelines:
      default:
        - step:
            script:
              - /etc/init.d/mysql start
              - mysql --user=root --password=$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE test;"
              - PACKAGE_PATH="${GOPATH}/src/domain.com/project/package"
              - mkdir -pv "${PACKAGE_PATH}"
              - tar -cO --exclude-vcs --exclude=bitbucket-pipelines.yml . | tar -xv -C "${PACKAGE_PATH}"
              - cd "${PACKAGE_PATH}"
              - go get -v
              - go build -v
              - go test -v
 
