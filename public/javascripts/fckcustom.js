// new for rails
FCKConfig.LinkBrowserURL = FCKConfig.BasePath + 'filemanager/browser/default/browser.html?Connector=/fckeditor/command';
FCKConfig.ImageBrowserURL = FCKConfig.BasePath + 'filemanager/browser/default/browser.html?Type=Image&Connector=/fckeditor/command';
FCKConfig.FlashBrowserURL = FCKConfig.BasePath + 'filemanager/browser/default/browser.html?Type=Flash&Connector=/fckeditor/command';

FCKConfig.LinkUploadURL = '/fckeditor/upload';
FCKConfig.ImageUploadURL = '/fckeditor/upload?Type=Image';
FCKConfig.FlashUploadURL = '/fckeditor/upload?Type=Flash';

FCKConfig.SkinPath = FCKConfig.BasePath + 'skins/silver/';
FCKConfig.AllowQueryStringDebug = false;

FCKConfig.ToolbarSets["Simple"] = [
	['Source','-','-','Templates'],
	['Cut','Copy','Paste','PasteWord','-','Print','SpellCheck'],
	['Undo','Redo','-','Find','Replace','-','SelectAll'],
	'/',
	['Bold','Italic','Underline','StrikeThrough','-','Subscript','Superscript'],
	['OrderedList','UnorderedList','-','Outdent','Indent'],
	['JustifyLeft','JustifyCenter','JustifyRight','JustifyFull'],
	['Link','Unlink'],
	'/',
	['Image','Table','Rule','Smiley'],
	['FontName','FontSize'],
	['TextColor','BGColor'],
	['-','About']
] ;
