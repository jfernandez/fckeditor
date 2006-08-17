require 'fileutils'
class FckeditorController < ActionController::Base
  UPLOADED = "/uploads"
  UPLOADED_ROOT = RAILS_ROOT + "/public" + UPLOADED
  MIME_TYPES = [
    "image/jpg",
    "image/jpeg",
    "image/pjpeg",
    "image/gif",
    "image/png",
    "application/x-shockwave-flash"
  ]
  
  RXML = <<-EOL
  xml.instruct!
    #=> <?xml version="1.0" encoding="utf-8" ?>
  xml.Connector("command" => params[:Command], "resourceType" => 'File') do
    xml.CurrentFolder("url" => @url, "path" => params[:CurrentFolder])
    xml.Folders do
      @folders.each do |folder|
        xml.Folder("name" => folder)
      end
    end if !@folders.nil?
    xml.Files do
      @files.keys.sort.each do |f|
        xml.File("name" => f, "size" => @files[f])
      end
    end if !@files.nil?
    xml.Error("number" => @errorNumber) if !@errorNumber.nil?
  end
  EOL
  
  # figure out who needs to handle this request
  def command   
    if params[:Command] == 'GetFoldersAndFiles' || params[:Command] == 'GetFolders'
      get_folders_and_files
    elsif params[:Command] == 'CreateFolder'
      create_folder
	  elsif params[:Command] == 'FileUpload'
 	    upload_file
 	  end
 	  
 	  render :inline => RXML, :type => :rxml
 	end 
 	
  def get_folders_and_files(include_files = true)
    @url = UPLOADED + params[:CurrentFolder]
    @folders = Array.new
    @files = {}
    @current_folder = UPLOADED_ROOT + params[:CurrentFolder]
    Dir.entries(@current_folder).each do |entry|
      next if entry =~ /^\./
      path = @current_folder + entry
      @folders.push entry if FileTest.directory?(path)
      @files[entry] = (File.size(path) / 1024) if (include_files and FileTest.file?(path))
    end
  end

  def create_folder
    begin 
      @url = UPLOADED_ROOT + params[:CurrentFolder]
      path = @url + params[:NewFolderName]
      if !(File.stat(@url).writable?)
        @errorNumber = 103
      elsif params[:NewFolderName] !~ /[\w\d\s]+/
        @errorNumber = 102
      elsif FileTest.exists?(path)
        @errorNumber = 101
      else
        Dir.mkdir(path,0775)
        @errorNumber = 0
      end
    rescue => e
      @errorNumber = 110 if @errorNumber.nil?
    end
  end
  
  def upload_file
    new_file = params[:NewFile]
    begin
      ftype = new_file.content_type.strip
      if ! MIME_TYPES.include?(ftype)
        @errorNumber = 202
        puts "#{ftype} is invalid MIME type"
        raise "#{ftype} is invalid MIME type"
      else
        dir = UPLOADED_ROOT + (params[:CurrentFolder] ? params[:CurrentFolder] : "/")
        path = dir + new_file.original_filename
        File.open(path,"wb",0664) do |fp|
          FileUtils.copy_stream(new_file, fp)
        end
        @errorNumber = 0
      end
    rescue => e
      @errorNumber = 110 if @errorNumber.nil?
    end
    render :inline => 'page << "window.parent.frames[\'frmUpload\'].OnUploadCompleted(#{@errorNumber}, \'#{new_file}\');"', :type => :rjs
  end

  def upload
    self.upload_file
  end
end
