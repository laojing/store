package store

class PictureUtil {
	def classes = ['风机照片','老图片','搞笑图片','照片']
	def classsecret = ['风机照片','老图片','搞笑图片','照片','美女图片']
	def secret = 4

	def HandleDir ( store ) {
		int index = 0
		def files = []

		new File(store.path).eachFile() { file ->
			def filename = file.getPath()
			if ( filename.endsWith('jpg')
				|| filename.endsWith('gif') ) {
				files.add ( file )
			}
		}
		files.sort { a,b ->
			return a.compareTo(b)
		}
		files.each { file ->
			def filename = file.getName()
			if ( filename.endsWith('jpg')
				|| filename.endsWith('png')
				|| filename.endsWith('gif') ) {

				def pic = new Contpicture()
				pic.sutid = store.sutid
				pic.contid = ++index
				pic.path = file.getPath()
				pic.width = 0
				pic.height = 0
				pic.space = file.length() 
				pic.duration = 0.0
				def words = filename.split ( " - " )
				if ( words.length > 1 ) {
					pic.caption = words[0]
				} else {
					pic.caption = filename[0..-5]
				}
				if ( words.length == 3 ) {
					pic.width = words[1] as int
					pic.height = words[2][0..-5] as int
				} else if ( words.length == 4 ) {
					pic.width = words[1] as int
					pic.height = words[2] as int
					pic.duration = words[3][0..-5] as float
				}
				pic.save ( flush:true )
			}
		}
	}

	def ClearStore ( stores, String sutid ) {
		def good = 1
		stores.each {
			if ( it.sutid.equals(sutid) ) {
				def picpath = new File(it.path + '/.pic')
				if ( !picpath.exists() ) picpath.mkdirs()
				new File(it.path).eachFile() { file ->
					def filename = file.getName()
					if ( filename.endsWith('jpg')
						|| filename.endsWith('png')
						|| filename.endsWith('gif') ) {
						def words = filename.split ( " - " )
						if ( words.length > 1 ) good = 0
						def proc = ['picinfo','clear', file.getPath()].execute()
						proc.waitFor()
					}
				}
			}
		}
		return good
	}

	def HandleStore ( stores, String sutid ) {
		def good = 1
		stores.each {
			if ( it.sutid.equals(sutid) ) {
				def picpath = new File(it.path + '/.pic')
				if ( !picpath.exists() ) picpath.mkdirs()
				new File(it.path).eachFile() { file ->
					def filename = file.getName()
					if ( filename.endsWith('jpg')
						|| filename.endsWith('png')
						|| filename.endsWith('gif') ) {
						def words = filename.split ( " - " )
						if ( words.length == 1 ) good = 0
						def proc = ['picinfo','handle',file.getPath()].execute()
						proc.waitFor()
					}
				}
			}
		}
		return good
	}

	def RenameStore ( stores, String sutid ) {
		stores.each {
			if ( it.sutid.equals(sutid) ) {
				long curtime = new Date().getTime()
				String path = it.path
				new File(it.path).eachFile() { file ->
					def filename = file.getName()
					if ( filename.endsWith('jpg')
						|| filename.endsWith('png')
						|| filename.endsWith('gif') ) {
						def newname = path + '/' + curtime++ + filename[-4..-1]
						file.renameTo(new File(newname))
					}
				}
			}
		}
	}
	


	def UpdateStore ( stores, String sutid ) {
		stores.each {
			if ( it.sutid.equals(sutid) ) {
				def oldstore = Picture.findAllWhere ( sutid:sutid )
				oldstore.each { it.delete ( flush:true ) }
				def oldcontstore = Contpicture.findAllWhere ( sutid:sutid )
				oldcontstore.each { it.delete ( flush:true ) }

				if (it.company == null) it.company = ""
				if (it.cont == null) it.cont = ""

				def pic = new Picture()
				pic.sutid = it.sutid
				pic.title = it.title
				pic.author = it.author
				pic.sutversion = it.sutversion
				pic.company = it.company
				pic.path = it.path
				pic.cont = it.cont
				pic.storeclass = it.storeclass
				pic.createdate = it.createdate
				pic.total = 0
				new File(pic.path).eachFile() { file ->
					def filename = file.getName()
					if ( filename.endsWith('jpg')
						|| filename.endsWith('png')
						|| filename.endsWith('gif') ) {
						pic.total++
					}
				}
				pic.save();
				HandleDir( it )
			}
		}
	}

	def DeleteStore ( stores, String sutid ) {
		stores.each {
			if ( it.sutid.equals(sutid) ) {
				def oldstore = Picture.findAllWhere ( sutid:sutid )
				oldstore.each { it.delete ( flush:true ) }
				def oldcontstore = Contpicture.findAllWhere ( sutid:sutid )
				oldcontstore.each { it.delete ( flush:true ) }
			}
		}
	}


}

