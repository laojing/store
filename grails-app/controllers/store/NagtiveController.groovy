package store

import grails.plugin.springsecurity.annotation.Secured

class NagtiveController {

	public commonutil = new CommonUtil();

	@Secured ( ['permitAll'] )
    def index() { 
		params.sort="classname"
		def nags = Nagtive.list(params)
		render( view:"index", model:[nags: nags] )
	}

	@Secured ( ['ROLE_ADMIN'] )
    def edit() { 
		params.sort="classname"
		def nags = Nagtive.list(params)
		render( view:"edit", model:[nags: nags] )
	}

	@Secured ( ['ROLE_ADMIN'] )
    def newurl ( ) {
		Nagtive nagtive = new Nagtive()
		nagtive.title = params.title
		nagtive.classname = params.classname
		nagtive.urlpath = params.urlpath
		nagtive.save ( flush:true )
		render(contentType:"text/json"){[status:'ok']}
	}

	@Secured ( ['ROLE_ADMIN'] )
	def newlib ( ) {
		new File( commonutil.GetLibDir() ).traverse(nameFilter:~/.*\.html/) { file ->
			file.eachLine() { line ->
				line = line.trim()
				if ( line.startsWith('<title>') ) {
					Nagtive nagtive = new Nagtive()
					nagtive.classname = "11素材库"
					nagtive.title = line[7..-9]
					nagtive.urlpath = 'http://www.jingyanjun.cn/lib/html/' + file.getName()
					nagtive.save ( flush:true )
				}
			}
		}
		render(contentType:"text/json"){[status:'ok']}
	}

	@Secured ( ['ROLE_ADMIN'] )
    def deleteurl ( ) {
		Nagtive nag = Nagtive.findById(params.id)
		nag.delete ( flush:true )
		params.sort="classname"
		def nags = Nagtive.list(params)
		println nags.size()
		render( view:"edit", model:[nags: nags])
	}

	@Secured ( ['ROLE_ADMIN'] )
    def editurl ( ) {
		Nagtive home = Nagtive.findById(params.id)
		home.title = params.title
		home.classname = params.classname
		home.urlpath = params.urlpath
		home.save ( flush:true )
		render(contentType:"text/json"){[status:'ok']}
	}

}


