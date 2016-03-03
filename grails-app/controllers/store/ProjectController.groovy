package store

import grails.plugin.springsecurity.annotation.Secured

class ProjectController {

	public fileutil = new ProjectUtil();

	@Secured ( ['permitAll'] )
    def index() { 
		render( view:"index", model:[stores: Project.list()] )
	}

	@Secured ( ['permitAll'] )
	def detail ( ) {
		def contid = params.contid as int
        def conts =  Contstore.findAll ( "from Contstore as b where b.sutid='"+params.sutid+"' order by b.contid" )
		File cont = new File ( conts[contid-1].path + '/.html/' + conts[contid-1].filename )
		render( view:"detail", model:[nag:'杂货',contid:contid,storetype:params.storetype,conts:conts,store:Project.findBySutid(params.sutid),txt:cont.getText(),contsSize: conts.size()] )
	}
}
