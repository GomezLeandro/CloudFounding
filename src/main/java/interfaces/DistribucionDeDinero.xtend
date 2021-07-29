package interfaces

import java.util.List
import persona.Inversor
import proyectos.Proyecto
import repositorios.RepositorioDeDatosPrecargado

abstract class DistribucionDeDinero extends RepositorioDeDatosPrecargado {
	def void distribuirDineroPosible(List<Proyecto> proyectos, Inversor inversor)
}

class DistribucionEquitativa extends DistribucionDeDinero {

	override distribuirDineroPosible(List<Proyecto> proyectos, Inversor inversor) {
		proyectos.forEach [ proyecto |
			proyecto.acumular(cantidadInvertidaEnCadaProyecto(proyectos, inversor.montoDisponible), inversor)
		]
	}

	def cantidadInvertidaEnCadaProyecto(List<Proyecto> proyectos, double monto) {
		monto / proyectos.size
	}

}

class CincuentaYReparto extends DistribucionDeDinero {

	override distribuirDineroPosible(List<Proyecto> proyectos, Inversor inversor) {
		cincuentaAlPrimero(proyectos, inversor)
		repartirEquitativamenteAlResto(proyectos, inversor)
	}

	def repartirEquitativamenteAlResto(List<Proyecto> proyectos, Inversor inversor) {
		filtrarQueNoSeaElPrimero(proyectos).forEach [ proyecto |
			proyecto.acumular(cantidadInvertidaEnCadaProyectoMenosElPrimero(proyectos, inversor.montoDisponible),
				inversor)
		]
	}

	def filtrarQueNoSeaElPrimero(List<Proyecto> proyectos) {
		proyectos.filter[proyecto|proyecto !== proyectos.head].toList
	}

	def cincuentaAlPrimero(List<Proyecto> proyectos, Inversor inversor) {
		proyectos.head.acumular(mitadDeLaCantidadDeDineroDisponible(inversor.montoDisponible), inversor)
	}

	def double mitadDeLaCantidadDeDineroDisponible(double monto) {
		monto * 0.5
	}

	def cantidadInvertidaEnCadaProyectoMenosElPrimero(List<Proyecto> proyectos, double monto) {
		mitadDeLaCantidadDeDineroDisponible(monto) / filtrarQueNoSeaElPrimero(proyectos).size
	}

}

class inversionAlAzar extends DistribucionDeDinero {

	override distribuirDineroPosible(List<Proyecto> proyectos, Inversor inversor) {
		encontrarProyectoPorPosicion(proyectos).acumular(500, inversor)
		encontrarProyectoPorPosicion(filtrarListaProyectos(proyectos)).acumular(inversor.montoDisponible - 500,
			inversor)
	}

	def retornaProyectoAlAzar(List<Proyecto> proyectos) {
		(Math.random * (proyectos.size)).intValue
	}

	def encontrarProyectoPorPosicion(List<Proyecto> proyectos) {
		return proyectos.get(retornaProyectoAlAzar(proyectos) - 1)
	}

	def filtrarListaProyectos(List<Proyecto> proyectos) {
		proyectos.filter[proyecto|proyecto !== encontrarProyectoPorPosicion(proyectos)].toList
	}

}
