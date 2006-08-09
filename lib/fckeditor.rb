# Fckeditor
module Fckeditor
  module Helper
    def fckeditor_textarea(object, field, options = {})
      value = eval("@#{object}.#{field}")
      value = value.nil? ? "" : value
      name = fckeditor_element_id(object, field)
      form_field = "#{object}[#{field}]"
      
      cols = options[:cols].nil? ? '' : "cols='"+options[:cols]+"'"
      rows = options[:rows].nil? ? '' : "rows='"+options[:rows]+"'"
      
      width = options[:width].nil? ? '100%' : options[:width]
      height = options[:height].nil? ? '100%' : options[:height]
      
      if options[:ajax]
        inputs = "<input type='hidden' id='#{form_field}' name='#{form_field}'>\n"+    
                 "<textarea id='#{name}' #{cols} #{rows} name='#{name}'>#{value}</textarea>\n"
      else 
        name = "#{object}[#{field}]"
        inputs = "<textarea id='#{name}' #{cols} #{rows} name='#{name}'>#{value}</textarea>\n"
      end

      inputs + 
      javascript_tag( "FCKeditorAPI = null;\n" +
                      "__FCKeditorNS = null;\n" +
                      "var oFCKeditor = new FCKeditor('#{name}');\n"+
                      "oFCKeditor.Width = '#{width}'\n"+
                      "oFCKeditor.Height = '#{height}'\n"+
                      "oFCKeditor.Config['CustomConfigurationsPath'] = '/javascripts/fckeditor/fckcustom.js';\n"+
                      "oFCKeditor.ReplaceTextarea();\n")   
    end

    def fckeditor_element_id(object, field)
      id = eval("@#{object}.id")
      "#{object}-#{id}-#{field}-editor"    
    end

    def fckeditor_div_id(object, field)
      'div-'+fckeditor_element_id(object, field)
    end

    def fckeditor_before_js(object, field)
      textarea_id = fckeditor_element_id(object, field)
      form_field = "#{object}[#{field}]"
      "var oEditor = FCKeditorAPI.GetInstance('"+textarea_id+"'); $('"+form_field+"').value = oEditor.GetXHTML();"
    end
  end
end