#TakeOutTheTrash will delete files that are older than a time period defined by you!

### EDIT THIS ###

#Path to folder to check
trashbins = ["/Users/Nes/Programming/TakeOutTheTrash/testfiles/", "/Users/Nes/Programming/TakeOutTheTrash/testfiles2/"]

#Time period to check for, e.g. 2 weeks (in secounds)
#Format like this: 14*24*60*60 (days*hours*minutes*secounds)
older_than = 14*24*60*60

### END OF THE EDIT PART ###
# .* filtern
# gesamtspfade erzeugen
# objekte nach creation time fragen
# alte daten löschen

absolutePaths = Array.new
for path in trashbins
	fileNames = Dir.entries(path)
	for files in fileNames 
		if not files.start_with?(".")
			absolutePaths << path+files
		end
	end
end
#debug output
#puts absolutePaths
#puts

for item in absolutePaths
	if (Time.new.to_i - File.ctime(item).to_i) > older_than
		File.delete(item) #Delete command - high risk
	end
	#puts File.ctime(item).to_i #debug
end
