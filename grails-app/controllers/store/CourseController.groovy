package store

import grails.plugin.springsecurity.annotation.Secured

class CourseController {

	public commonutil = new CommonUtil();

	@Secured ( ['permitAll'] )
    def c() {
	}

	@Secured ( ['permitAll'] )
    def matlab() {
	}

	def download() {
		response.reset()
		response.setContentType("APPLICATION/OCTET-STREAM;charset=GBK")
		def names = new String ( params.id.replace('-','.').getBytes(), "ISO-8859-1" )
		response.setHeader("Content-Disposition", "Attachment;Filename=\"${names}\"")
		def fullpath = commonutil.GetHomeDir() + 'Course/' + params.course + '/ppt/' + params.id.replace('-','.')
		def file = new File(fullpath)
		def fileInputStream = new FileInputStream(file)
		def outputStream = response.getOutputStream()
		byte[] buffer = new byte[4096];
		int len;
		while ((len = fileInputStream.read(buffer)) > 0) {
			outputStream.write(buffer, 0, len);
		}
		outputStream.flush()
		outputStream.close()
		fileInputStream.close()
	}
}
