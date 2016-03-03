package store

class Document {
	static mapping = {
		version false
	}

	String sutid
	Integer document
	String filename
	String fullpath
	Date uploadDate = new Date()

    static constraints = {
		filename(blank:false,nullable:false)
		fullpath(blank:false,nullable:false)
    }
}


