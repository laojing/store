

// Added by the Spring Security Core plugin:
grails.plugin.springsecurity.userLookup.userDomainClassName = 'store.User'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'store.UserRole'
grails.plugin.springsecurity.authority.className = 'store.Role'

grails.plugin.springsecurity.apf.postOnly = false
grails.plugin.springsecurity.auth.loginFormUrl = '/storelogin'
grails.plugin.springsecurity.auth.ajaxLoginFormUrl = '/storelogin'
grails.plugin.springsecurity.failureHandler.defaultFailureUrl = '/storelogin'

grails.plugin.springsecurity.controllerAnnotations.staticRules = [
	'/':                ['permitAll'],
	'/storelogin':      ['permitAll'],
	'/storelogin.gsp':  ['permitAll'],
	'/error':           ['permitAll'],
	'/index':           ['permitAll'],
	'/index.gsp':       ['permitAll'],
	'/shutdown':        ['permitAll'],
	'/assets/**':       ['permitAll'],
	'/**/fonts/**':        ['permitAll'],
	'/**/js/**':        ['permitAll'],
	'/**/css/**':       ['permitAll'],
	'/**/images/**':    ['permitAll'],
	'/**/favicon.ico':  ['permitAll']
]

