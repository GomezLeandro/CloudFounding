package proyectos

import persona.Inversor
import persona.ResponsableProyecto
import interfaces.SistemaBancario
import java.util.List
import observers.ObserverTransferencia
import org.eclipse.xtend.lib.annotations.Accessors
import repositorios.RepositorioDeDatosPrecargado

@Accessors
abstract class Proyecto extends RepositorioDeDatosPrecargado {
	String nombreProyecto
	String descripcionProyecto
	double cantidadDePlata
	String cuentaId
	boolean activo = true
	int contribuyentes = 0
	List<ResponsableProyecto> nombreResponsablesProyecto = newArrayList
	List<ObserverTransferencia> observersTransferencia = newArrayList
	List<String> listaDeTransferenciasRecibidas = newArrayList
	Boolean proyectoNacional = false
	double acumuladorDinero = 0.0
	SistemaBancarioAdapter sistemaBancarioAdapter

	new(String nombreProyecto, String descripcionProyecto, SistemaBancario sistemaBancario, double cantidadDePlata,
		String cuentaId) {
		this.nombreProyecto = nombreProyecto
		this.descripcionProyecto = descripcionProyecto
		this.cantidadDePlata = cantidadDePlata
		this.cuentaId = cuentaId
	}

	def calcularImpactoSocial() {
		this.sumaImpactoParticularConDiezmo()
	}

	def double diezmo() {
		this.cantidadDePlata * 0.10
	}

	def double impactoSegunLaClase()

	def double sumaImpactoParticularConDiezmo() {
		this.diezmo() + impactoSegunLaClase()
	}

	def List<ResponsableProyecto> getNombresResponsableProyecto() {
		nombreResponsablesProyecto
	}

	def acumular(double dinero, Inversor inversor) {
		realizarTransferencia(inversor, dinero)
		inversor.restarDineroInvertido(dinero)
		agregarTransferenciaRecibida(dinero, inversor)
		acumuladorDinero += dinero
		contribuyentes += 1
		notificarTransferenciaRealizada(this, inversor)
	}

	def realizarTransferencia(Inversor inversor, double monto) {
		sistemaBancarioAdapter.transferirA(inversor.cuentaOrigenId, this.cuentaId, monto)
	}

	def agregarTransferenciaRecibida(double dinero, Inversor inversor) {
		listaDeTransferenciasRecibidas.add(registroTransferencia(dinero, inversor))
	}

	def String registroTransferencia(double dinero, Inversor inversor) {
		return "se recibieron $" + dinero + " del inversor: " + inversor.nombre
	}

	def void agregarAcciones(ObserverTransferencia observer) {
		observersTransferencia.add(observer)
	}

	def void notificarTransferenciaRealizada(Proyecto proyecto, Inversor inversor) {
		observersTransferencia.forEach[transferenciaObserver(proyecto, inversor)]
	}

	def boolean cambiarEstado() {
		this.activo = !activo
	}

}

class SistemaBancarioAdapter {
	SistemaBancario sistemaBancario

	def String transferirA(String cuentaOrigen, String cuentaDestino, double monto) {
		val result = sistemaBancario.transferir(cuentaOrigen, cuentaDestino, monto as int, (monto % 1) as int, true,
			false)
		if (!result.equals("")) {
			throw new RuntimeException("Error en la transferencia")
		}
	}
}
