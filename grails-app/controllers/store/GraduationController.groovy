package store

import grails.plugin.springsecurity.annotation.Secured

class GraduationController {
	def springSecurityService
	public commonutil = new CommonUtil();

	def docs = ['毕业翻译(原文)',
				'毕业翻译(译文)',
				'开题报告',
				'毕业答辩',
				'毕业论文.doc',
				'毕业论文.pdf',
				'论证书',
				'毕业手册']

	def getDocType ( String name ) {
		def len = docs.size()
		def i = 0
		def result = -1
		for ( i=0; i<len; i++ ) {
			if ( name.startsWith (docs[i]) ) {
				result = i+1
				break;
			}
		}
		return result
	}


	@Secured ( ['permitAll'] )
    def index( ) { 
		def curyear = Calendar.getInstance().get(Calendar.YEAR)
		def selyear = params.year
		if ( selyear == null ) selyear = curyear
		else selyear = selyear.toInteger()
        def grads = Graduation.findAll("from Graduation as a where a.year="+selyear+" order by a.sutid")
		def principal = springSecurityService.principal
        render(view:"index", model:[curuser:principal.username,grads:grads,year:selyear,years:Graduation.executeQuery("select distinct a.year from Graduation as a order by a.year"),templates: Document.findAll ("from Document as a order by a.filename"),proves:Prove.list(),curyear:curyear] )
	}

	def InsertProve ( sutid, conttype, path ) {
		new File ( path ).eachLine() { line, no ->
			def prove = new Prove()
			prove.sutid = sutid.stripIndent()
			prove.contid = no
			prove.conttype = conttype
			prove.txt = line
			prove.save ( flush:true );
		}
	}
	def scanYearFolder ( path, year ) {
		new File ( path + '/README' ).eachLine() { line ->
			def grad = new Graduation()
			def words = line.split ( "," )
			grad.year = year
			grad.sutid = words[2].stripIndent()
			grad.name = words[0]
			grad.grade = words[1].stripIndent()
			grad.title = words[4].stripIndent()
			grad.document = 0

			println '=============' + grad.name
			new File ( path + '/' + words[0] ).eachFile() { file->
				def name = file.getName()
				if ( name.equals('README') ) {
					InsertProve ( words[2], 1, path+'/'+words[0]+'/README' )  
				} else if ( name.equals('Schedule') ) {
					InsertProve ( words[2], 2, path+'/'+words[0]+'/Schedule' )  
				} else if ( name.equals('Book') ) {
					InsertProve ( words[2], 3, path+'/'+words[0]+'/Book' )  
				} else {
					def doctype = getDocType(name)
					if ( doctype >= 0 ) {
						grad.document = grad.document | (1<<doctype)
						def doc = new Document()
						doc.sutid = grad.sutid
						doc.document = doctype
						doc.filename = doctype+'.'+file.getName()
						doc.fullpath = file.getPath()
						doc.save(flush:true)
					}
					println doctype + ':' + name
				}
			}
			grad.save ( flush:true )
		}
	}

	def scanTemplate ( path ) {
		new File( path ).eachFileRecurse() { file ->
            def doc = new Document()
			doc.sutid = '0'
			doc.document = 0
            doc.filename = file.getName()
            doc.fullpath = file.getPath()
            doc.save(flush:true)
		}
	}
	def scan() {
		def oldtemp = Document.list ()
		oldtemp.each { it.delete ( flush:true ) }
		def oldstore = Graduation.list () 
		oldstore.each { it.delete ( flush:true ) }
		def oldcontstore = Prove.list () 
		oldcontstore.each { it.delete ( flush:true ) }
		def oldcontstorecite = Template.list () 
		oldcontstorecite.each { it.delete ( flush:true ) }

		scanTemplate ( commonutil.GetHomeDir() + 'Graduation/Template' )
		new File( commonutil.GetHomeDir() + 'Graduation' ).eachFile() { file ->
			try { 
				scanYearFolder ( file.getPath(), file.getName() as int )
			} catch ( NumberFormatException e ) {}
		}
		render(contentType:"text/json"){[status:"ok"]}
	}

	def fileupload() {
		def file = request.getFile('upfile')
		def docs = ['毕业翻译(原文)',
					'毕业翻译(译文)',
					'开题报告',
					'毕业答辩',
					'毕业论文',
					'毕业论文',
					'论证书',
					'毕业手册']

		if ( file != null ) {
			def sut =  Graduation.findBySutid(params.upid)
			def filetype = ''
			def filesuffix = ''
			if ( file.getOriginalFilename().endsWith('doc') ) {
				filesuffix = '.doc'
			} else if ( file.getOriginalFilename().endsWith('docx') ) {
				filesuffix = '.docx'
			} else if ( file.getOriginalFilename().endsWith('pdf') ) {
				filesuffix = '.pdf'
			} else if ( file.getOriginalFilename().endsWith('ppt') ) {
				filesuffix = '.ppt'
			}
			def filepath = commonutil.GetHomeDir() + 'Graduation/' + params.upyear + '/' + sut.name + '/'
			filetype = docs[params.uptype.toInteger()-1] + filesuffix

			println filepath + filetype
        	def indexrst = new File ( filepath + filetype )
			if ( indexrst.exists() ) {
				indexrst.delete()
				def doc =  Document.findBySutidAndDocument(sut.sutid,params.uptype.toInteger())
				doc.uploadDate = new Date()
				doc.save(flush:true)
			} else {
				def doc = new Document()
				doc.sutid = sut.sutid
				doc.document = params.uptype.toInteger()
				doc.filename = params.uptype + '.' + filetype
				doc.fullpath = indexrst.getPath()
				doc.save(flush:true)
			}
			file.transferTo ( indexrst )
			sut.save ( flush:true )
			render(contentType:"text/json"){[data:"success"]}
		} else {
			render(contentType:"text/json"){[data:"error"]}
		}
	}





	@Secured ( ['ROLE_ADMIN','ROLE_STUDENT'] )
	def download ( Integer id ) {
        Document documentInstance = Document.get(id)
        if ( documentInstance == null) {
        	render(view:"list")
        } else {
			def principal = springSecurityService.principal
			println principal.username
			if ( !documentInstance.sutid.equals(principal.username)
			    && !documentInstance.sutid.equals('0') 
				&& principal.username != 'laojing' ) {
        		render(view:"list")
			} else {
				response.reset()
				response.setContentType("APPLICATION/OCTET-STREAM;charset=GBK")
	//			def names = URLEncoder.encode ( documentInstance.filename.getBytes(), "ISO-8859-1" )
				def names = new String ( documentInstance.filename.getBytes(), "ISO-8859-1" )
				response.setHeader("Content-Disposition", "Attachment;Filename=\"${names}\"")

				def file = new File(documentInstance.fullpath)
				def fileInputStream = new FileInputStream(file)
				def outputStream = response.getOutputStream()
				byte[] buffer = new byte[4096];
				int len;
				while ((len = fileInputStream.read(buffer)) > 0) {
					outputStream.write(buffer, 0, len);
				}
				outputStream.flush()
				outputStream.close()
				fileInputStream.close()
			}
        }
	}
}
