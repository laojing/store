package store

import grails.plugin.springsecurity.annotation.Secured

class StoreController {

	public fileutil = new FileUtil();

	@Secured ( ['permitAll'] )
    def index() { 
		def clas = 0
		if ( params.classes ) 
			clas = params.classes as int
		def classes = fileutil.classes
		if ( clas == 10 ) {
			clas = fileutil.secret
			classes = fileutil.classsecret
		}
		//render( view:"index", model:[stores: Store.list(), classes:classes ] )
		render( view:"index", model:[stores: Store.findAllByStoreclass(classes[clas]), classes:classes, clas:clas ] )
	}

	@Secured ( ['permitAll'] )
	def detail ( ) {
		def contid = params.contid as int
        def conts =  Contstore.findAll ( "from Contstore as b where b.sutid='"+params.sutid+"' order by b.contid" )
		File cont = new File ( conts[contid-1].path + '/.html/' + conts[contid-1].filename )
		render( view:"detail", model:[nag:'杂货',contid:contid,storetype:params.storetype,conts:conts,store:Store.findBySutid(params.sutid),txt:cont.getText(),contsSize: conts.size()] )
	}
}
