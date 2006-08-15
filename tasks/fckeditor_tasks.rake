# desc "Explaining what the task does"
# task :fckeditor do
#   # Task goes here
# end

namespace :fckeditor do
  desc 'Install the FCKEditor components'
  task :install do
    require 'fileutils'
    
    directory = File.join(RAILS_ROOT, '/vendor/plugins/fckeditor/')
    require "#{directory}lib/fckeditor"
    require "#{directory}lib/fckeditor_file_utils"
    
    source = File.join(directory,'/public/javascripts/fckeditor/')
    dest = File.join(RAILS_ROOT, '/public/javascripts/fckeditor')
    
    unless File.exists?(dest)
      puts "Creating directory #{dest}..."
      FileUtils.mkdir(dest)
    end
      
    puts "** Installing FCKEditor Plugin version #{Fckeditor.version} to #{dest}..."      
    FckeditorFileUtils.recursive_copy(source, dest)      
            
    # create upload directory
    uploads = File.join(RAILS_ROOT, '/public/uploads')
    FileUtils.mkdir(uploads) unless File.exist?(uploads)
      
    puts "** Successfully installed FCKEditor Plugin version #{Fckeditor.version}"
  end

  desc "Update the FCKEditor plugin"    
  task :update do
    puts "Not yet implemented."
  end
end

