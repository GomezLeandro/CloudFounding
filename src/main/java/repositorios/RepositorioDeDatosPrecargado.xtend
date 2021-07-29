package repositorios

class RepositorioDeDatosPrecargado {
	int id = 0

	def int getId() {
		id
	}

	def void setId(int valor) {
		id = valor
	}

	def boolean esNuevo() {
		this.id == 0
	}

}
