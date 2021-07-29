package observers

import persona.Inversor
import interfaces.Mail
import interfaces.MailSender
import interfaces.WhatssappSender
import proyectos.Proyecto

interface ObserverTransferencia {
	def void transferenciaObserver(Proyecto proyecto, Inversor inversor)
}

class EnviarWhatssap implements ObserverTransferencia {
	WhatssappSender watsSender

	new(WhatssappSender watsSender) {
		this.watsSender = watsSender
	}

	override transferenciaObserver(Proyecto proyecto, Inversor inversor) {
		if (inversor.montoDisponible > 2500) {
			watsSender.enviar("se transfirio: " + inversor.montoDisponible + "al proyecto: " + proyecto.nombreProyecto,
				inversor.numeroWats)
		}
	}
}

class enviaMailsObserver implements ObserverTransferencia {
	MailSender mailSender

	new(MailSender mailSender) {
		this.mailSender = mailSender
	}

	def obtenerListaCorreos(Proyecto proyecto) {
		proyecto.nombresResponsableProyecto.map(persona|persona.correo)
	}

	override transferenciaObserver(Proyecto proyecto, Inversor inversor) {
		obtenerListaCorreos(proyecto).forEach [ correo |
			val Mail mail = new Mail(correo, "admin@hotmail.com", "Aviso De Transferencia",
				"Se realizó una transferencia para el proyecto")
			mailSender.enviar(mail)
		]
	}

}

class inactivoObserver implements ObserverTransferencia {

	new() {
	}

	override transferenciaObserver(Proyecto proyecto, Inversor inversor) {
		if (proyecto.getContribuyentes == 3) {
			proyecto.cambiarEstado()
		}
	}

}
