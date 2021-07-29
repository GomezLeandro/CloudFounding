package proyectos

import interfaces.SistemaBancario
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import persona.Socio

@Accessors
class ProyectoCooperativa extends Proyecto {
	List<Socio> socios = newArrayList

	new(String nombreProyecto, String descripcionProyecto, SistemaBancario sistemaBancario, double cantidadDePlata,
		String cuentaId) {
		super(nombreProyecto, descripcionProyecto, sistemaBancario, cantidadDePlata, cuentaId)
	}

	def void agregarSocio(Socio socio) {
		socios.add(socio)
	}

	def void removerSocio(Socio socio) {
		socios.remove(socio)
	}

	override impactoSegunLaClase() {
		socios.fold(0.0, [acumular, socios|puntajeSegunApellido(socios)])
	}

	def double puntajeSegunApellido(Socio socio) {
		var puntosApellidosCompuestos = 45
		var puntosApellidosSimples = 30
		if (this.tieneApellidoCompuesto(socio)) {
			puntosApellidosCompuestos
		} else {
			puntosApellidosSimples
		}
	}

	def boolean tieneApellidoCompuesto(Socio socio) { socio.apellidoCompuesto }
	
	

}
