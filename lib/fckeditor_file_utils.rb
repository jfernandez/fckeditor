require 'fileutils'

module FckeditorFileUtils
  def FckeditorFileUtils.recursive_copy(options)
    source = options[:source]
    dest = options[:dest]
    logging = options[:logging].nil? ? true : options[:logging]
    
    Dir.foreach(source) do |entry|
      next if entry =~ /^\./
      if File.directory?(File.join(source, entry))
        unless File.exist?(File.join(dest, entry))
          if logging
            puts "Creating directory #{entry}..."
          end
          FileUtils.mkdir File.join(dest, entry)#, :noop => true#, :verbose => true
        end
        recursive_copy(:source => File.join(source, entry), 
                       :dest => File.join(dest, entry), 
                       :logging => logging)
      else
        if logging
          puts "  Installing file #{entry}..."
        end
        FileUtils.cp File.join(source, entry), File.join(dest, entry)#, :noop => true#, :verbose => true
      end
    end
  end
end