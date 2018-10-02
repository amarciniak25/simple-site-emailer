# simple-site-emailer
A simple Ruby script to email me if a site is down.

## Usage
ruby simple-site-emailer.rb --site https://google.com --pattern body --address smtp.someserver.com --user myusername --pass mypassword --domain mydomain --email me@mydomain

## Scheduling
I use a cron job to run the program every twenty min.

### Example cron Line
*/20 * * * * /usr/bin/ruby ~/simple-site-emailer/simple-site-emailer.rb --site https://google.com --pattern body --address smtp.someserver.com --user myusername --pass mypassword --domain mydomain

## Background
We needed a method for notifiing ourselfs when an internal web app goes down. Uptime monitoting services would not work because the app is only accessable from the inside.