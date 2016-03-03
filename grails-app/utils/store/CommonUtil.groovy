package store

class CommonUtil {

	def GetConfig ( path ) {
		def store = new Store()
		store.path = new String(path)
		File cont = new File ( path + '/.Config' )
		cont.eachLine { 
			def words = it.split ( " = " )
			if ( words.length >=2 ) {
				if ( words[0].equals('sutid') ) {
					store.sutid = new String(words[1])
				} else if ( words[0].equals('suttitle') ) {
					store.title = new String(words[1])
				} else if ( words[0].equals('sutauthor') ) {
					store.author = new String(words[1])
				} else if ( words[0].equals('sutclass') ) {
					store.storeclass = new String(words[1])
				} else if ( words[0].equals('sutversion') ) {
					store.sutversion = new String(words[1])
				} else if ( words[0].equals('sutdate') ) {
					store.createdate = new String(words[1])
				} else if ( words[0].equals('sutcompany') ) {
					store.company = new String(words[1])
				}
			}
		}
		return store;
	}

	String GetHomeDir () {
		def ip = "hostname".execute().getText()
		if ( ip.startsWith('laojing') ) return "/home/laojing/"
		else return "/home/tomcat/ROOT/"
	}

	String GetLibDir () {
		def ip = "hostname".execute().getText()
		if ( ip.startsWith('laojing') ) return "/home/laojing/Public/lib/html"
		else return "/home/tomcat/lib/html"
	}

	def ListStore ( String path, String clas ) {
		def stores = []
		new File( path ).eachDirRecurse() { dir ->
			dir.eachFileMatch(~/.Config/) { file ->
				def store = GetConfig( dir.getPath() );
				if ( store.storeclass == clas 
					|| clas == 'all' ) 
					stores.add ( GetConfig( dir.getPath() ) );
			}
		}
		return stores
	}

}


