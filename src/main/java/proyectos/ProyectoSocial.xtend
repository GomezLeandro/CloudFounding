package proyectos

import interfaces.SistemaBancario
import java.time.LocalDate
import java.time.Period
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ProyectoSocial extends Proyecto {
	LocalDate fechaDeInicio

	new(String nombreProyecto, String descripcionProyecto, SistemaBancario sistemaBancario, double cantidadDePlata,
		String cuentaId, LocalDate fechaInicio) {
		super(nombreProyecto, descripcionProyecto, sistemaBancario, cantidadDePlata, cuentaId)
		this.fechaDeInicio = fechaInicio
	}

	override impactoSegunLaClase() {
		Period.between(fechaDeInicio, LocalDate.now()).years * 100
	}

}
