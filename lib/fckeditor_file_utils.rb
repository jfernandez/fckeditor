require 'fileutils'

module FckeditorFileUtils
  FCKEDITOR_VERSION = '0.1.3'
  
  def FckeditorFileUtils.recursive_copy(source, dest)
    Dir.foreach(source) do |entry|
      next if entry =~ /^\./
      if File.directory?(File.join(source, entry))
        unless File.exist?(File.join(dest, entry))
          puts "Creating directory #{entry}..."
          FileUtils.mkdir File.join(dest, entry)#, :noop => true#, :verbose => true
        end
        recursive_copy File.join(source, entry), File.join(dest, entry)
      else
        puts "  Installing file #{entry}..."
        FileUtils.cp File.join(source, entry), File.join(dest, entry)#, :noop => true#, :verbose => true
      end
    end
  end
end