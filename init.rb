# Include hook code here
require 'fckeditor'
require 'fckeditor_file_utils'

# need to copy over the code if it doesn't already exist
directory = File.join(RAILS_ROOT, '/vendor/plugins/fckeditor/')
source = File.join(directory,'/public/javascripts/fckeditor/')
dest = File.join(RAILS_ROOT, '/public/javascripts/fckeditor/')
 
unless File.exist?(dest)
  FileUtils.mkdir(dest) 
  FckeditorFileUtils.recursive_copy(:source => source, :dest => dest, :logging => false)
  uploads = File.join(RAILS_ROOT, '/public/uploads')
  FileUtils.mkdir(uploads) unless File.exist?(uploads)
end

ActionView::Base.send(:include, Fckeditor::Helper)