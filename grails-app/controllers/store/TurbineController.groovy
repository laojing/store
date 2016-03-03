package store

import grails.plugin.springsecurity.annotation.Secured

class TurbineController {

	@Secured ( ['permitAll'] )
    def index() { 
	}

	def wind() {
	}

}
