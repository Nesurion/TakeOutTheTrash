#!/usr/bin/ruby
#TakeOutTheTrash will delete files that are older than a time period defined by you!
require 'rubygems'
require 'json'
require 'trollop'

opts = Trollop::options do
	opt :force, "delte without asking"	#flag --force, default false
end


json = File.read 'config.json'
config = JSON.parse(json)

daysToSec = 24*60*60

#returns array with absPath to items
def createAbsPath(path)
	absoluteFiles = Array.new
	fileNames = Dir.entries path
	fileNames.each do |file|
		absoluteFiles << File.join(path, file) unless file.start_with?(".")
	end

	return absoluteFiles
end


# markes files with del flag, returns array
def setDeleteFlag(path, older_than)
	markedForDelete = Array.new
	#delete files based on time
	createAbsPath(path).each do |item|
		return item if (Time.new.to_i - File.ctime(item).to_i) > older_than
	end

	return nil
end

#use infos from config.json to mark files
markedForDeleteList = Array.new
config["folder"].each_with_index do |item, n|
	fileToDelete = setDeleteFlag(config["folder"][n]["path"], config["folder"][n]["days"]*daysToSec)
	markedForDeleteList << fileToDelete unless fileToDelete.nil?
end

if opts[:force]
	markedForDeleteList.each do |delMarkedFile|
		#debuging
		#puts delMarkedFile
		File.delete(delMarkedFile) #Delete command - high risk
	end
end

if opts[:force] == false && markedForDeleteList.any?
	puts markedForDeleteList
	puts "Should I delete these files? (y/n) (enter = n)"
	answer = gets.chomp
	if answer.downcase.eql? "y"
		for delMarkedFile in markedForDeleteList

			#debuging
			#puts delMarkedFile.inspect
			File.delete(delMarkedFile) #Delete command - high risk
		end
	end
else
	puts "No files to delete"
end