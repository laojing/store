package store

import grails.plugin.springsecurity.annotation.Secured
import grails.plugin.springsecurity.SpringSecurityService

class ManagerController {
	def springSecurityService
	def passwordEncoder

	public commonutil = new CommonUtil();
	public fileutil = new FileUtil();
	public projectutil = new ProjectUtil();
	public pictureutil = new PictureUtil();

	// Project Manager
	@Secured ( ['ROLE_ADMIN'] )
    def project() {
		render( view:"project", model:[stores: commonutil.ListStore ( commonutil.GetHomeDir() + 'Projects', 'all' ), storeins:Project.list() ] )
	}

	@Secured ( ['ROLE_ADMIN'] )
	def updateproject() {
		projectutil.UpdateStore ( 
					commonutil.ListStore(commonutil.GetHomeDir()+'Projects','all'),
					params.sutid )
		render(contentType:"text/json"){[hah:"haha"]}
	}

	@Secured ( ['ROLE_ADMIN'] )
	def deleteproject() {
		projectutil.DeleteStore ( 
					commonutil.ListStore(commonutil.GetHomeDir()+'Projects','all'),
					params.sutid )
		render(contentType:"text/json"){[hah:"haha"]}
	}

	// Store Manager
	@Secured ( ['ROLE_ADMIN'] )
    def store() {
		def clas = 0
		if ( params.classes ) 
			clas = params.classes as int
		def classes = fileutil.classes
		if ( clas == 10 ) {
			clas = fileutil.secret
			classes = fileutil.classsecret
		}
		render( view:"store", model:[stores: commonutil.ListStore ( commonutil.GetHomeDir() + 'Documents', classes[clas] ), storeins:Store.list(), classes: classes, clas:clas ] )
	}

	@Secured ( ['ROLE_ADMIN'] )
	def updatestore() {
		fileutil.UpdateStore ( 
					commonutil.ListStore(commonutil.GetHomeDir()+'Documents','all'),
					params.sutid )
		render(contentType:"text/json"){[hah:"haha"]}
	}

	@Secured ( ['ROLE_ADMIN'] )
	def deletestore() {
		fileutil.DeleteStore ( 
					commonutil.ListStore(commonutil.GetHomeDir()+'Documents','all'),
					params.sutid )
		render(contentType:"text/json"){[hah:"haha"]}
	}


	// Picture Manager
	@Secured ( ['ROLE_ADMIN'] )
    def picture() {
		def clas = 0
		if ( params.classes ) 
			clas = params.classes as int
		def classes = pictureutil.classes
		if ( clas == 10 ) {
			clas = pictureutil.secret
			classes = pictureutil.classsecret
		}
		render( view:"picture", model:[stores: commonutil.ListStore ( commonutil.GetHomeDir() + 'Pictures', classes[clas] ), classes: classes, clas:clas ] )
	}

	@Secured ( ['ROLE_ADMIN'] )
	def updatepicture() {
		pictureutil.UpdateStore ( 
					commonutil.ListStore(commonutil.GetHomeDir()+'Pictures','all'),
					params.sutid )
		render(contentType:"text/json"){[hah:"haha"]}
	}

	@Secured ( ['ROLE_ADMIN'] )
	def deletepicture() {
		pictureutil.DeleteStore ( 
					commonutil.ListStore(commonutil.GetHomeDir()+'Pictures','all'),
					params.sutid )
		render(contentType:"text/json"){[hah:"haha"]}
	}

	@Secured ( ['ROLE_ADMIN'] )
	def renamepicture() {
		//pictureutil.RenameStore ( Picture.list(), params.sutid )
		pictureutil.RenameStore ( 
					commonutil.ListStore(commonutil.GetHomeDir()+'Pictures','all'),
					params.sutid )
		render(contentType:"text/json"){[hah:"haha"]}
	}

	@Secured ( ['ROLE_ADMIN'] )
	def handlepicture() {
		def res = pictureutil.HandleStore ( 
					commonutil.ListStore(commonutil.GetHomeDir()+'Pictures','all'),
					params.sutid )
		render(contentType:"text/json"){[result:res]}
	}

	@Secured ( ['ROLE_ADMIN'] )
	def clearpicture() {
		def res = pictureutil.ClearStore ( 
					commonutil.ListStore(commonutil.GetHomeDir()+'Pictures','all'),
					params.sutid )
		render(contentType:"text/json"){[result:res]}
	}

	@Secured ( ['ROLE_ADMIN'] )
	def user() {
		render( view:"user", model:[users:User.list(),roles:Role.list(), userrole:UserRole.list() ] )
	}

	@Secured ( ['ROLE_ADMIN'] )
    def newuser() {
	println 'new user new user'
		def adminUser = User.findByUsername(params.username)?:new User ( 
							username: params.username, password: params.password )
		adminUser.save ( flush: true )
		render(contentType:"text/json"){[data:"success"]}
	}

	@Secured ( ['ROLE_ADMIN'] )
    def deleteuser() {
		def adminUser = User.findByUsername(params.username)
		def temp = UserRole.list()
		temp.each { 
			if ( it.user.username == adminUser.username ) {
				it.delete ( flush:true )
			}
		}
		adminUser.delete ( flush: true )

		render( view:"user", model:[users:User.list(),roles:Role.list(), userrole:UserRole.list() ] )
	}

	@Secured ( ['ROLE_ADMIN'] )
    def addrole() {

		def adminUser = User.findByUsername(params.addname)
		def adminRole = Role.findByAuthority(params.rolename)
		if ( adminUser && adminRole ) {
			if ( !adminUser.authorities.contains(adminRole) ) {
				UserRole.create adminUser, adminRole, true
				render(contentType:"text/json"){[data:"success"]}
			}
		}

		render(contentType:"text/json"){[data:"error"]}
	}

	@Secured ( ['ROLE_ADMIN'] )
    def delrole() {
		def adminUser = User.findByUsername(params.addname)
		def adminRole = Role.findByAuthority(params.rolename)
		if ( adminUser && adminRole ) {
			if ( adminUser.authorities.contains(adminRole) ) {
				UserRole.remove adminUser, adminRole, true
				render(contentType:"text/json"){[data:"success"]}
			}
		}
		render(contentType:"text/json"){[data:"error"]}
	}

	@Secured ( ['ROLE_ADMIN'] )
    def passwd() {
	}

	@Secured ( ['ROLE_ADMIN','ROLE_STUDENT'] )
    def changepw() {
		def error = ''
		def curuser = springSecurityService.currentUser
		def user = User.findByUsername(curuser.username)
		if ( params.j_password_new != params.j_password_new_2 ) {
			error = '两次密码输入不一致！'
		} else if ( passwordEncoder.isPasswordValid(user.password,params.j_password, null) ) {
			def temp = new User ( username: user.username, password:params.j_password_new )
			user.password = temp.password
			curuser.password = user.password
			curuser.passwordExpired = false
			user.save ( flush:true );
			error = '修改成功！'
		} else {
			error = '原密码错误！'
		}
		println springSecurityService.encodePassword('cai', user)
		render( view:"passwd", model:[error:error] )
	}
}
