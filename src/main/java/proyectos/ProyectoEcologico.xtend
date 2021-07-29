package proyectos

import interfaces.SistemaBancario
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ProyectoEcologico extends Proyecto {
	double areaDeterminada

	new(String nombreProyecto, String descripcionProyecto, SistemaBancario sistemaBancario, double cantidadDePlata,
		String cuentaId, double areaDeterminada) {
		super(nombreProyecto, descripcionProyecto, sistemaBancario, cantidadDePlata, cuentaId)
		this.areaDeterminada = areaDeterminada
	}

	override impactoSegunLaClase() {
		areaDeterminada * 10
	}

}
