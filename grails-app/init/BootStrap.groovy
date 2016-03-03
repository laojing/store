import store.Role
import store.User
import store.UserRole

class BootStrap {

    def init = { servletContext ->

		def adminRole = Role.findByAuthority('ROLE_ADMIN')?:new Role('ROLE_ADMIN').save(flush:true)
		def studentRole = Role.findByAuthority('ROLE_STUDENT')?:new Role('ROLE_STUDENT').save(flush:true)

		def adminUser = User.findByUsername('laojing')?:new User('laojing', 'cai').save(flush:true)

		if ( !adminUser.authorities.contains(adminRole) ) {
			UserRole.create adminUser, adminRole, true
		}
    }
    def destroy = {
    }
}
