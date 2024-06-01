#!/usr/bin/env bash
# Create a sample service to test

cat >/home/admin/svc.sh <<HERE
#!/usr/bin/env bash

while true; do
    sleep 5
    echo foo
done
HERE

chmod +x /home/admin/svc.sh


sudo cp demo.service /etc/systemd/system


# systemctl start demo


