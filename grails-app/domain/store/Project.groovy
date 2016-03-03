package store

class Project {

	String sutid
	String title
	String author
	String sutversion
	String company
	String path
	String cont
	String storeclass
	String createdate
	String img

	static mapping = {
		img type: 'text'
		version false
	}

    static constraints = {
    }
}
