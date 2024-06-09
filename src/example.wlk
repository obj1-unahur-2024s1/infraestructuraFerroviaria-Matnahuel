class VagonesPasajeros{
	var property largo
	var property ancho 
	var property tieneBanio
	var property estaOrdenado
	method cantidadPasajeros(){
		const multiplicacion = if (ancho >= 3){8}else 10
		var cantidad = largo * multiplicacion
		if(not estaOrdenado) {cantidad -= 15}
		return cantidad
	}
	method cargaMaxima(){
		return if (tieneBanio){
			300
		}else 800
	}
	method pesoMaximo(){
		return 2000 +  80*self.cantidadPasajeros() + self.cargaMaxima()
	}
	method hacerMantenimiento(){
		return if(estaOrdenado){
			estaOrdenado 
		} else estaOrdenado = false
	}
}


class VagonesCarga{
	var property cargaIdeal
	var property maderaSuelta
	method cantidadPasajeros(){ return 0}
	method cargaMaxima(){
		return 0.max(cargaIdeal - (400* maderaSuelta))
	}
	method pesoMaximo(){
		return 1500 + self.cargaMaxima()
	}
	method tieneBanio(){
		return false
	}
	method hacerMantenimiento(){
		return 0.max(maderaSuelta -2)
	}
}

class VagonesDeDormitorio{
	var property compartimientos 
	var property camas
	method cantidadPasajeros(){
		return compartimientos * camas
	}
	method cantidadMaxima(){
		return 1200
	}
	method tieneBanio(){
		return true
	}
	method pesoMaximo(){
		return 4000 + self.cantidadPasajeros() + self.cantidadMaxima()
	}
	method hacerMantenimiento(){}
}

class Formacion{
	const vagones = []
	const locomotoras = []
	method locomotoraConVelMaxima(){
		return locomotoras.max({l=>l.velMax()})
	}
	method agregarVagon(vagon){
		return vagones.add(vagon)
	}
	method quitarVagon(vagon){
		return vagones.remove(vagon)
	}
	method cantidadPasajeros(){
		return vagones.sum({vagon=> vagon.cantidadPasajeros()})
	}
	method cantVagonesPopulares(){
		return vagones.filter({v=>v.cantidadPasajeros() > 50}).size()
	}

	method esFormacionCarguera(){
		return vagones.all({v=>v.cargaMaxima() == 1000})
	}
	method vagonMasLiviano(){
		return vagones.min({v=>v.pesoMaximo()})
	}
	method vagonMasPesado(){
		return vagones.max({v=>v.pesoMaximo()})
	}
	method dispersionDePeso(){
		return self.vagonMasPesado().pesoMaximo() - self.vagonMasLiviano().pesoMaximo()
	}
	method cantosBaniosHay(){
		return vagones.filter({v=>v.tieneBanio()}).size()
	}
	method hacerMantenimiento(){
		return vagones.forEach({v=>v.hacerMantenimiento()})
	}
	method vagonQueMenosLleva(){
		return vagones.min({v=>v.cantidadPasajeros()})
	}
	method vagonQueMasLleva(){
		return vagones.max({v=>v.cantidadPasajeros()})
	}
	method estaEquilibrado(){
		return (self.vagonQueMasLleva().cantidadPasajeros() - self.vagonQueMenosLleva().cantidadPasajeros()) < 20
	}
	method todasSonEficientes(){
		return locomotoras.all({l=>l.esEficiente()})
	}
	method puedeMoverse(){
		return self.pesoArrastreLocomotora() >= self.pesoMaximoFormaciones()
	}
	method pesoArrastreLocomotora(){
		return locomotoras.sum({l=>l.pesoArrastre()})
	}
	method pesoMaximoFormaciones(){
		return vagones.sum({v=>v.pesoMaximo()})
	}
	method kilosDeEmpuje(){
		return 
		if( self.puedeMoverse())
		{0}else self.pesoMaximoFormaciones() - self.pesoArrastreLocomotora()
	}
}

class Locomotoras{
	var property peso = 0
	var property pesoArrastre
	var property velMax = 0
	method esEficiente(){
		return pesoArrastre >= peso * 5
	}
	
	
}
