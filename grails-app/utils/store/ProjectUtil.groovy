package store

class ProjectUtil {
	def GetIntr ( store ) {
		File cont = new File ( store.path + '/.html/content.html' )
		cont.eachLine { line, no ->
			def words = line.split ( " = " )
			if ( words.length >=2 ) {
				def words1 = words[0].split ( "fuck" )
				if ( no == 1 ) {
					File contsub = new File ( store.path + '/.html/' + words[0] )
					contsub.eachLine { 
						if ( it.indexOf('<p>') >=0 ) {
							int start = it.indexOf('<p>')
							int end = it.indexOf('</p>')
							store.cont = it.substring(start+3,end)
						}
					}
				}
			}
		}
	}

	def UpdateStore ( stores, String sutid ) {
		stores.each {
			if ( it.sutid.equals(sutid) ) {
				def oldstore = Project.findAllWhere ( sutid:sutid )
				oldstore.each { it.delete ( flush:true ) }
				def oldcontstore = Contstore.findAllWhere ( sutid:sutid )
				oldcontstore.each { it.delete ( flush:true ) }
				def oldcontstorecite = Contstorecite.findAllWhere ( sutid:sutid )
				oldcontstorecite.each { it.delete ( flush:true ) }
				GetIntr ( it )	

				if (it.company == null) it.company = ""
				if (it.cont == null) it.cont = ""

				def prj = new Project()
				prj.sutid = it.sutid
				prj.title = it.title
				prj.author = it.author
				prj.sutversion = it.sutversion
				prj.company = it.company
				prj.path = it.path
				prj.cont = it.cont
				prj.storeclass = it.storeclass
				prj.createdate = it.createdate
				File cont = new File ( it.path + '/images/main.jpg' )
				prj.img = cont.readBytes().encodeBase64()
				prj.save();
				HandleDir ( it );
			}
		}
	}

	def InsertContStore ( store, no, path, filename, title ) {
		def contstore = new Contstore()
		contstore.sutid = store.sutid
		contstore.contid = no
		contstore.path = path
		contstore.filename = filename
		contstore.title = title
		try{
			contstore.save ( flush:true )
		} catch (Exception e) {
			e.printStackTrace()
		}
	}

	def InsertStoreCite ( store, index, cite, caption, suffix ) {
		def contstorecite = new Contstorecite()
		contstorecite.sutid = store.sutid
		contstorecite.contid = index 
		contstorecite.citeid = cite
		contstorecite.label = caption
		contstorecite.title = suffix
		try{
			contstorecite.save ( flush:true )
		} catch (Exception e) {
			e.printStackTrace()
		}
	}

	def HandleDir ( store ) {
		File cont = new File ( store.path + '/.html/content.html' )
		cont.eachLine { line, no ->
			def words = line.split ( " = " )
			if ( words.length >=2 ) {
				def words1 = words[0].split ( "fuck" )
				InsertContStore ( store, no, store.path, words[0], words[1].split("fuck")[0] )
				def words2 = line.split ( "fuck" )
				if ( words2.length >= 2 ) {
					def j = 1
					for ( j=1; j<words2.length; j++ ) {
						if ( words2[j].startsWith ( "kcuf" ) ) {
							def cites = words2[j].split ( "#" )
							if ( cites.length >= 2 ) {
								InsertStoreCite ( store, no, j, cites[1], "---" );
							}
						} else {
							def words3 = words2[j].split ( " = " )
							if ( words3.length >= 2 ) {
								def cites = words3[0].split ( "#" )
								if ( cites.length >= 2 ) {
									InsertStoreCite ( store, no, j, cites[1], words3[1] );
								}
							}
						}
					}
				}
			}
		}
	}

	def DeleteStore ( stores, String sutid ) {
		stores.each {
			if ( it.sutid.equals(sutid) ) {
				def oldstore = Project.findAllWhere ( sutid:sutid )
				oldstore.each { it.delete ( flush:true ) }
				def oldcontstorecite = Contstorecite.findAllWhere ( sutid:sutid )
				oldcontstorecite.each { it.delete ( flush:true ) }
				def oldcontstore = Contstore.findAllWhere ( sutid:sutid )
				oldcontstore.each { it.delete ( flush:true ) }
			}
		}
	}
}


