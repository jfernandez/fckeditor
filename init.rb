# Include hook code here
require 'fckeditor'

# make plugin controller available to app
config.load_paths += %W(#{Fckeditor::PLUGIN_CONTROLLER_PATH})

Rails::Initializer.run(:set_load_path, config)

ActionView::Base.send(:include, Fckeditor::Helper)