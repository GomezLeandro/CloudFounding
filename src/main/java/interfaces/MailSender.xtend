package interfaces

import org.eclipse.xtend.lib.annotations.Data

interface MailSender {

	def void enviar(Mail mail)
}

@Data
class Mail {
	String para
	String from
	String asunto
	String mensaje
}
