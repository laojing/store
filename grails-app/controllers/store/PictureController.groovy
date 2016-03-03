package store

import grails.plugin.springsecurity.annotation.Secured

class PictureController {

	public pictureutil = new PictureUtil();

	@Secured ( ['permitAll'] )
    def index() { 
		def clas = 0
		if ( params.classes ) 
			clas = params.classes as int
		def classes = pictureutil.classes
		if ( clas == 10 ) {
			clas = pictureutil.secret
			classes = pictureutil.classsecret
		}
		render( view:"index", model:[stores: Picture.findAllByStoreclass(classes[clas],[sort:"createdate",order:"desc"]), classes:classes, clas:clas ] )
	}
	@Secured ( ['permitAll'] )
	def gallery() {
		if ( !params.offset ) {
			params.offset = 0
		}
		params.max = 12
		params.sort = "contid"
		render( view:"gallery", model:[stores: Contpicture.findAllBySutid(params.sutid, params ), curstore:Picture.findAllBySutid(params.sutid)[0],total:Contpicture.findAllBySutid(params.sutid).size(),offset:params.offset ] )
	}

	@Secured ( ['permitAll'] )
	def detail() {
		render( view:"detail", model:[sutid:params.sutid,contid:params.contid,total:Contpicture.findAllBySutid(params.sutid).size()] )
	}

	@Secured ( ['permitAll'] )
	def full() {
		render( view:"full", model:[sutid:params.sutid,contid:params.contid,total:Contpicture.findAllBySutid(params.sutid).size()] )
	}

	def detaildel() {
		def thumbs = Contpicture.findAllBySutidAndContid(params.sutid,params.contid)
		new File(thumbs[0].path).delete()
		thumbs[0].delete ( flush:true )
		thumbs = Contpicture.findAllBySutidAndContid(params.sutid,params.total-1)
		thumbs[0].contid = params.contid as int
		thumbs[0].save ( flush:true )

		def pics = Picture.findAllBySutid(params.sutid)
		pics[0].total--
		pics[0].save(flush:true)
		render(contentType:"text/json"){[detail:'good']}
	}
	def detailjson() {
		def thumbs = Contpicture.findAllBySutidAndContid(params.sutid,params.contid)
		render(contentType:"text/json"){[detail:thumbs[0]]}
	}

	def thumbpic() {
		def thumbs = Contpicture.findAllBySutid(params.sutid)
		def file = new File(thumbs[new Random().nextInt(thumbs.size())].path)
		def name = file.getName()
		if ( name.endsWith('gif') ) {
			file = new File(file.getParent() + '/.pic/' + name[0..-4] + 'jpg')
		} else {
			file = new File(file.getParent() + '/.pic/' + name)
		}
		def fileInputStream = new FileInputStream(file)
		response.outputStream << fileInputStream
		response.outputStream.flush()
	}

	def thumb() {
		def thumbs = Contpicture.findAllBySutidAndContid(params.sutid,params.contid)
		def file = new File(thumbs[0].path)
		def name = file.getName()
		if ( name.endsWith('gif') ) {
			file = new File(file.getParent() + '/.pic/' + name[0..-4] + 'jpg')
		} else {
			file = new File(file.getParent() + '/.pic/' + name)
		}
		def fileInputStream = new FileInputStream(file)
		response.outputStream << fileInputStream
		response.outputStream.flush()
	}

	def pic() {
		def thumbs = Contpicture.findAllBySutidAndContid(params.sutid,params.contid)
		def file = new File(thumbs[0].path)
		def fileInputStream = new FileInputStream(file)
		response.outputStream << fileInputStream
		response.outputStream.flush()
	}
}
