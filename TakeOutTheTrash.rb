#!/usr/bin/ruby
#TakeOutTheTrash will delete files that are older than a time period defined by you!
require 'rubygems'
require 'json'

json = File.read('config.json')
config = JSON.parse(json)

#read json times and convert to secounds
older_than = (config["years"]*365*24*60*60)
			+(config["months"]*30*24*60*60)
			+(config["days"]*24*60*60)
			+(config["hours"]*60*60)

#Create absolute paths and filter files starting with .
absolutePaths = Array.new
for path in config["folder"]
	fileNames = Dir.entries(path)
	for files in fileNames 
		if not files.start_with?(".")
			absolutePaths << path+files
		end
	end
end

#delete files based on time
for item in absolutePaths
	if (Time.new.to_i - File.ctime(item).to_i) > older_than
		#debuging
		#puts item
		File.delete(item) #Delete command - high risk
	end
end
