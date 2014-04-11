TakeOutTheTrash
===============

A little Ruby script that deletes files, which are older than a specified time.


Usage
-----
- Edit config.json to your needs
- paths in config.json need to be absolut: /path/to/folder/
- Note: Time values will be summed up -> 1 days + 12 hours = 36 hours
- Add a cronjob to your crontab, to run periodical.
