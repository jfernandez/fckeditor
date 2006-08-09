# Install hook code here

FCKEDITOR_VERSION = '0.0.1'

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

directory = File.join(RAILS_ROOT, '/vendor/plugins/fckeditor/')
source = File.join(directory,'/public/javascripts/fckeditor/')
dest = File.join(RAILS_ROOT, '/public/javascripts/fckeditor/')
puts "** Installing FCKEditor Plugin version #{FCKEDITOR_VERSION} to #{dest}..." 
 
FileUtils.mkdir(dest) unless File.exist?(dest)

fckeditor_copy(source, dest)

# Copy files to parent rails app
source = File.join(directory,'/app/')
dest = File.join(RAILS_ROOT, '/app/')

fckeditor_copy(source, dest)

uploads = File.join(RAILS_ROOT, '/public/uploads')
FileUtils.mkdir(uploads) unless File.exist?(uploads)

puts "** Successfully installed FCKEditor Plugin version #{FCKEDITOR_VERSION}"