# desc "Explaining what the task does"
# task :fckeditor do
#   # Task goes here
# end

FCKEDITOR_VERSION = '0.0.1'

namespace :fckeditor do
  desc 'Install the FCKEditor components'
  task :install do
    require 'fileutils'
    directory = File.join(RAILS_ROOT, '/vendor/plugins/fckeditor/')
    source = File.join(directory,'/public/javascripts/fckeditor/')
    dest = File.join(RAILS_ROOT, '/public/javascripts/fckeditor')
    
    if File.exists?(dest)
      puts "Error : destination directory #{dest} already exists, perhaps you need to update instead?"
      exit 1
      
    else
      puts "Creating directory #{dest}..."
      FileUtils.mkdir(dest)
      
      puts "** Installing FCKEditor Plugin version #{FCKEDITOR_VERSION} to #{dest}..."      
      fckeditor_copy(source, dest)      
      
      # copy app directories
      source = File.join(directory,'/app/')      
      dest = File.join(RAILS_ROOT, '/app/')
      fckeditor_copy(source, dest)
      
      # create upload directory
      uploads = File.join(RAILS_ROOT, '/public/uploads')
      FileUtils.mkdir(uploads) unless File.exist?(uploads)
      
      puts "** Successfully installed FCKEditor Plugin version #{FCKEDITOR_VERSION}"
    end
  end

  desc "Update the FCKEditor plugin"    
  task :update do
    puts "Not yet implemented."
  end
end

def fckeditor_copy(source, dest)
  Dir.foreach(source) do |entry|
    next if entry =~ /^\./
    if File.directory?(File.join(source, entry))
      unless File.exist?(File.join(dest, entry))
        puts "Creating directory #{entry}..."
        FileUtils.mkdir File.join(dest, entry)#, :noop => true#, :verbose => true
      end
      fckeditor_copy File.join(source, entry), File.join(dest, entry)
    else
      puts "  Installing file #{entry}..."
      FileUtils.cp File.join(source, entry), File.join(dest, entry)#, :noop => true#, :verbose => true
    end
  end
end
