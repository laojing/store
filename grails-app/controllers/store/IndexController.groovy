package store

import grails.plugin.springsecurity.annotation.Secured

class IndexController {

	@Secured ( ['permitAll'] )
    def index() {
		render( view:"index", model:[stores:Store.list(max:4), projects:Project.list(max:4)] ) 
	}

	@Secured ( ['ROLE_ADMIN','ROLE_STUDENT'] )
    def logindex() { 
		render( view:"index", model:[stores:Store.list(max:4), projects:Project.list(max:4)] ) 
	}

	@Secured ( ['permitAll'] )
    def home() {
		render( view:"home", model:[homes:Home.list(sort:"nameid",order:"asc")] ) 
	}
	@Secured ( ['permitAll'] )
    def homeupdate() {
		render(contentType:"text/json"){[homes:Home.list(sort:"nameid",order:"asc")]}
	}

	@Secured ( ['permitAll'] )
    def homeclose() {
		def homes = Home.list(sort:"nameid",order:"asc") 
		for (Home home:homes) {
			if ( home.nameid < 18 ) {
				home.cmd = 1
				home.save ( flush:true );
			}
		}
		render(contentType:"text/json"){[detail:'good']}
	}

	@Secured ( ['permitAll'] )
    def homeopen() {
		def homes = Home.list(sort:"nameid",order:"asc") 
		for (Home home:homes) {
			if ( home.nameid < 18 ) {
				home.cmd = 0
				home.save ( flush:true );
			}
		}
		render(contentType:"text/json"){[detail:'good']}
	}

	@Secured ( ['permitAll'] )
    def homechange() {
		println "Change:" + params.nameid
		def homes = Home.list(sort:"nameid",order:"asc") 
		def index = params.nameid as int
		if ( index > 0 ) {
			println 'Change ' + homes[index-1].name + ' state'
			homes[index-1].cmd = homes[index-1].state;
			homes[index-1].save ( flush:true );
		}
		render(contentType:"text/json"){[detail:'good']}
	}

	@Secured ( ['permitAll'] )
    def homenew() {
		def home = new Home()
		home.nameid = params.index as int
		home.name = params.names
		home.state = 0
		home.cmd = 3
		home.save ( flush:true );
		render(contentType:"text/json"){[detail:'good']}
	}

	@Secured ( ['permitAll'] )
    def homecmd() {
		def homes = Home.list(sort:"nameid",order:"asc") 
		def cmd = ''
		println params.states
		for (Home home:homes) {
			def i = params.states[home.nameid-1] as int
			if ( home.cmd == i ) cmd += '1'
			else cmd += '0'
			if ( i != home.state || (home.cmd < 3 && home.cmd != i) ) {
				home.state = i
				if ( (home.state != home.cmd) && home.cmd < 3 ) home.cmd = 3
				home.save ( flush:true );
			}
		}
		render(contentType:"text/json"){[cmd:cmd]}
	}
}


