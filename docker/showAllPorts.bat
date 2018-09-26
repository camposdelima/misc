docker ps --format "{{.Ports}}" | sed -e "s/0.0.0.0://g"
