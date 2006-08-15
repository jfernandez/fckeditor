# Install hook code here

directory = File.join(RAILS_ROOT, '/vendor/plugins/fckeditor/')
require "#{directory}lib/fckeditor"
require "#{directory}lib/fckeditor_file_utils"

source = File.join(directory,'/public/javascripts/fckeditor/')
dest = File.join(RAILS_ROOT, '/public/javascripts/fckeditor/')
puts "** Installing FCKEditor Plugin version #{Fckeditor.version} to #{dest}..." 
 
FileUtils.mkdir(dest) unless File.exist?(dest)

FckeditorFileUtils.recursive_copy(:source => source, :dest => dest)

uploads = File.join(RAILS_ROOT, '/public/uploads')
FileUtils.mkdir(uploads) unless File.exist?(uploads)

puts "** Successfully installed FCKEditor Plugin version #{Fckeditor.version}"