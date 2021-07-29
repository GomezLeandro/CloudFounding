package repositorios

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Repositorio<T extends RepositorioDeDatosPrecargado> {

	List<T> elementos = newArrayList()
	int identificador = 1

	def create(T elemento) {
		validarCreate(elemento)
		agregarElemento(elemento)
	}

	def void agregarElemento(T elemento) {
		elemento.setId(identificador++)
		elementos.add(elemento)
	}

	def void validarCreate(T elemento) {
		validarNuevo(elemento)
	}

	def validarNuevo(T elemento) {
		if (!elemento.esNuevo()) {
			throw new RuntimeException("El elemento no es nuevo")
		}
	}

	def delete(T elemento) {
		validarExiste(elemento)
		elementos.remove(elemento)
	}

	def validarExiste(T elemento) {
		noExisteElemento(elemento.getId)
	}

	def noExisteElemento(int identificador) {
		if (!existeElemento(identificador)) {
			throw new RuntimeException("El elemento no Existe")
		}
	}

	def boolean existeElemento(int identificador) {
		elementos.exists[it.getId == identificador]
	}

	def boolean estaContenido(T elemento) {
		existeElemento(elemento.getId)
	}

}
