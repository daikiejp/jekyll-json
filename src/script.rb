require 'yaml'
require 'json'

# Rename categories string: breakfast, lunch and dinner
# into numbers, for read all files by order
Dir.glob('*.markdown').sort.each do |entry|
  if File.basename(entry).include?('-breakfast')
    newEntry = entry.gsub('breakfast', '1_breakfast')
    File.rename( entry, newEntry )
  end
  if File.basename(entry).include?('-lunch')
    newEntry = entry.gsub('lunch', '2_lunch')
    File.rename( entry, newEntry )
  end
  if File.basename(entry).include?('-dinner')
    newEntry = entry.gsub('dinner', '3_dinner')
    File.rename( entry, newEntry )
  end
end

# Get all markdown files by order and save into JSON
File.open('data.json', 'w+') do |s|
  Dir.glob('*.markdown').sort.each do |file|
    yaml = YAML.load(File.read(file))
    json = yaml.to_json
    # puts json+","
    data = json+","
    s.write(data)
  end
end

# Remove the last comma, and valid the JSON format
comma = File.read('data.json')
File.write('data.json', comma[0..-2])
data = File.read('data.json')

File.open('data.json', 'w+') do |file|
  file.puts("[")
  file.puts(data)
  file.puts("]")
end
