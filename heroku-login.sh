/usr/bin/expect -f - <<EOD
spawn heroku login
expect "Email: "
send "$1\r"
expect "Password: "
sleep 1
send "Omg12345"
sleep 1
send "\n"
expect "Logged in"
sleep 2
spawn heroku container:login
sleep 1
expect "Login Succeeded"
sleep 1
EOD
