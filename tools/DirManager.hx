package;


import sys.FileSystem;


class DirManager {
	
	
	private static var mMade = new Map <String, Bool> ();
	
	
	public static function deleteRecurse (inDir:String) {
		
		if (FileSystem.exists (inDir)) {
			
			var contents = FileSystem.readDirectory (inDir);
			
			for (item in contents) {
				
				if (item != "." && item != "..") {
					
					var name = inDir + "/" + item;
					
					if (FileSystem.isDirectory (name)) {
						
						deleteRecurse (name);
						
					} else {
						
						FileSystem.deleteFile (name);
						
					}
					
				}
				
			}
			
			FileSystem.deleteDirectory (inDir);
			
		}
		
	}
	
	
	public static function make (inDir:String) {
		
		var parts = inDir.split ("/");
		var total = "";
		
		for (part in parts) {
			
			if (part != "." && part != "") {
				
				if (total != "") total += "/";
				total += part;
				
				if (!mMade.exists (total)) {
					
					mMade.set (total, true);
					
					if (!FileSystem.exists (total)) {
						
						try {
							
							FileSystem.createDirectory (total + "/");
							
						} catch (e:Dynamic) {
							
							return false;
							
						}
						
					}
					
				}
				
			}
			
		}
		
		return true;
		
	}
	
	
	public static function makeFileDir (inFile:String) {
		
		var parts = StringTools.replace (inFile, "\\", "/").split ("/");
		
		if (parts.length < 2) {
			
			return;
			
		}
		
		parts.pop ();
		make (parts.join ("/"));
		
	}
	
	
}