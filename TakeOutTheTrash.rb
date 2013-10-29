#TakeOutTheTrash will delete files that are older than a time period defined by you!

### EDIT THIS ###

#Path to folder to check
trashbin = "/Users/Nes/Programming/TakeOutTheTrash/testfiles/*.*"

#Time period to check for, e.g. 2 weeks (in secounds)
#Format like this: 14*24*60*60 (days*hours*minutes*secounds)
older_than = 14*24*60*60

### END OF THE EDIT PART ###


Dir.glob(trashbin) do |item|
  next if item == '.' or item == '..'
    if File.ctime(item) < Time.now() - older_than
      File.delete(item)
    end
  end
