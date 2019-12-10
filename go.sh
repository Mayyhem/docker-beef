#!/bin/bash
docker build -t beef-xss --build-arg NEWPASS=$(pwgen -Bs1 16) . 
docker run --name beef-xss -p 3000:3000 beef-xss
