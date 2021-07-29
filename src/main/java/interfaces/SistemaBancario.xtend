package interfaces

interface SistemaBancario {
	def String transferir(String cuentaOrigenId, String cuentaDestinoId, int montoEntero, int montoDecimales,
		boolean depositoInmediato, boolean deposito24hs)

}
