package persona

import interfaces.DistribucionDeDinero
import interfaces.SeleccionProyecto
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import proyectos.Proyecto

@Accessors
class Socio {
	String apellido

	new(String apellido) {
		this.apellido = apellido
	}

	def apellidoCompuesto() {
		apellido.split(" ").size != 1
	}
}

@Accessors
class Inversor {

	SeleccionProyecto seleccion
	DistribucionDeDinero distribucion
	double montoDisponible

	String cuentaOrigenId
	String numeroWats
	String nombre

	new(String cuentaOrigenId, double montoDisponible, SeleccionProyecto seleccion, DistribucionDeDinero distribucion,
		String numeroWats, String nombre) {
		this.cuentaOrigenId = cuentaOrigenId
		this.montoDisponible = montoDisponible
		this.numeroWats = numeroWats
		this.nombre = nombre
		this.cuentaOrigenId = cuentaOrigenId
		this.seleccion = seleccion
		this.distribucion = distribucion
	}

	def validarDinero() {
		if (montoDisponible < 1000) {
			throw new RuntimeException("Pone un sope mas.... jugate!!!!")
		}
	}

	def restarDineroInvertido(double dinero) {
		montoDisponible -= dinero
	}

	def distribuirDineroPosible(List<Proyecto> proyectos) {
		distribucion.distribuirDineroPosible(seleccion.mostrarProyectos(proyectos), this)
	}

}

@Accessors
class ResponsableProyecto {
	String nombre
	String correo

	new(String nombre, String correo) {
		this.nombre = nombre
		this.correo = correo
	}

}
