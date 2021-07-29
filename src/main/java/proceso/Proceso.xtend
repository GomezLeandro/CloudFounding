package proceso

import interfaces.DistribucionDeDinero
import interfaces.SeleccionProyecto
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import persona.Inversor
import proyectos.Proyecto
import repositorios.Repositorio

@Accessors
class Proceso {

	Repositorio<Proyecto> repoDeProyectos
	Repositorio<SeleccionProyecto> repoDeSeleccion
	Repositorio<DistribucionDeDinero> repoDeDistribucion

	new(Repositorio<Proyecto> repoDeProyectos, Repositorio<SeleccionProyecto> repoDeSeleccion,
		Repositorio<DistribucionDeDinero> repoDeDistribucion, DistribucionDeDinero distribucion, Inversor inversor) {
		this.repoDeProyectos = repoDeProyectos
		this.repoDeSeleccion = repoDeSeleccion
		this.repoDeDistribucion = repoDeDistribucion
	}

	def void validarEleccionDeSeleccionDeProyecto(Inversor inversor) {
		if (repoDeSeleccion.estaContenido(inversor.seleccion)) {
			throw new RuntimeException("No es posible continuar con la operacion")
		}
	}

	def void validarEleccionDeDistribucionDelDinero(Inversor inversor) {
		if (repoDeDistribucion.estaContenido(inversor.distribucion)) {
			throw new RuntimeException("No es posible continuar con la operacion")
		}
	}

	def void seleccionDelUsuario(Inversor inversor) {
		inversor.validarDinero
		this.validarEleccionDeDistribucionDelDinero(inversor)
		this.validarEleccionDeSeleccionDeProyecto(inversor)
		var listaSugerencia = proyectosSeleccionados(inversor)
		this.validar(listaSugerencia)
		inversor.distribuirDineroPosible(repoDeProyectos.elementos)
	}

	def List<Proyecto> proyectosSeleccionados(Inversor i) {
		i.seleccion.mostrarProyectos(this.repoDeProyectos.elementos)
	}

	def validar(List<Proyecto> listaSugerencia) {
		if (listaSugerencia.size < 2) {
			throw new RuntimeException("No hay suficientes sugerencias como para poder continuar.... Muchas gra!!!")
		}
	}

}
