# Fckeditor
module Fckeditor
  PLUGIN_NAME = 'fckeditor'
  PLUGIN_PATH = "#{RAILS_ROOT}/vendor/plugins/#{PLUGIN_NAME}"
  PLUGIN_PUBLIC_PATH = "#{PLUGIN_PATH}/public"
  PLUGIN_CONTROLLER_PATH = "#{PLUGIN_PATH}/app/controllers"  
  PLUGIN_VIEWS_PATH = "#{PLUGIN_PATH}/app/views"  
  
  module Version
    MAJOR = 0
    MINOR = 2
    RELEASE = 1
  end

  def self.version
 		"#{Version::MAJOR}.#{Version::MINOR}.#{Version::RELEASE}"
 	end
  
  module Helper
    def fckeditor_textarea(object, field, options = {})
      value = eval("@#{object}.#{field}")
      value = value.nil? ? "" : value
      id = fckeditor_element_id(object, field)
      
      cols = options[:cols].nil? ? '' : "cols='"+options[:cols]+"'"
      rows = options[:rows].nil? ? '' : "rows='"+options[:rows]+"'"
      
      width = options[:width].nil? ? '100%' : options[:width]
      height = options[:height].nil? ? '100%' : options[:height]
      
      toolbarSet = options[:toolbarSet].nil? ? 'Default' : options[:toolbarSet]
      
      if options[:ajax]
        inputs = "<input type='hidden' id='#{object}_#{field}' name='#{object}[#{field}]'>\n"+    
                 "<textarea id='#{id}' #{cols} #{rows} name='#{id}'>#{value}</textarea>\n"
      else 
        inputs = "<textarea id='#{id}' #{cols} #{rows} name='#{object}[#{field}]'>#{value}</textarea>\n"
      end

      inputs + 
      javascript_tag( "FCKeditorAPI = null;\n" +
                      "__FCKeditorNS = null;\n" +
                      "var oFCKeditor = new FCKeditor('#{id}', '#{width}', '#{height}', '#{toolbarSet}');\n"+
                      "oFCKeditor.Config['CustomConfigurationsPath'] = '/javascripts/fckcustom.js';\n"+
                      "oFCKeditor.ReplaceTextarea();\n")   
    end

    def fckeditor_element_id(object, field)
      id = eval("@#{object}.id")
      "#{object}_#{id}_#{field}_editor"    
    end

    def fckeditor_div_id(object, field)
      id = eval("@#{object}.id")  
      "div-#{object}-#{id}-#{field}-editor" 
    end

    def fckeditor_before_js(object, field)
      textarea_id = fckeditor_element_id(object, field)
      form_field = "#{object}_#{field}"
      "var oEditor = FCKeditorAPI.GetInstance('"+textarea_id+"'); $('"+form_field+"').value = oEditor.GetXHTML()"
    end    
  end
end

module ActionView::Helpers::AssetTagHelper
  alias_method :rails_javascript_include_tag, :javascript_include_tag
  
  # Adds a new option to Rails' built-in <tt>javascript_include_tag</tt>
  # helper - <tt>:fckeditor</tt>. Works in the same way as <tt>:defaults</tt> - specifying 
  # <tt>:fckeditor</tt> will make sure the necessary javascript
  # libraries and behaviours file +script+ tags are loaded. Will happily
  # work along side <tt>:defaults</tt>.
  #
  #  <%= javascript_include_tag :defaults, :fckeditor %>
  def javascript_include_tag(*sources)
    main_sources, application_source = [], []
    if sources.include?(:fckeditor)
      sources.delete(:fckeditor)
      sources.push('fckeditor/fckeditor')
    end
    unless sources.empty?
      main_sources = rails_javascript_include_tag(*sources).split("\n") 
      application_source = main_sources.pop if main_sources.last.include?('application.js')
    end
    [main_sources.join("\n"), application_source].join("\n")
  end
end
