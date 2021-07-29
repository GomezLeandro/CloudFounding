package interfaces

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import proyectos.Proyecto
import repositorios.RepositorioDeDatosPrecargado

abstract class SeleccionProyecto extends RepositorioDeDatosPrecargado {
	def List<Proyecto> mostrarProyectos(List<Proyecto> proyectos)
}

class TresConMasImpactoSocial extends SeleccionProyecto {

	// se coloca el cuatro porque el metodo sublist devuelve [0;4)
	override mostrarProyectos(List<Proyecto> proyectos) {
		proyectos.sortBy[ calcularImpactoSocial ].reverse.subList(0, 4)
	}

}

@Accessors
class ProyectoMasCaroYMasBarato extends SeleccionProyecto {

	override mostrarProyectos(List<Proyecto> proyectos) {
		val masCaro = proyectos.maxBy [ cantidadDePlata ]
		val masBarato = proyectos.minBy [ cantidadDePlata ]
		#[masCaro, masBarato]
	}

}

class ProyectoNacional extends SeleccionProyecto {

	override mostrarProyectos(List<Proyecto> proyectos) {
		proyectos.filter[ proyectoNacional ].toList
	}

}

class CombinatoriaDeCriterios extends SeleccionProyecto {

	List<SeleccionProyecto> criteriosDeSeleccion = newArrayList

	override mostrarProyectos(List<Proyecto> proyectos) {
		criteriosDeSeleccion.flatMap [ mostrarProyectos(proyectos) ].toSet.toList
	}

}
