!classDefinition: #TestDePerforación category: 'ISW1-2023-1C-Parcial-1'!
TestCase subclass: #TestDePerforación
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!TestDePerforación methodsFor: 'test' stamp: 'af 5/8/2023 18:55:31'!
test01CuandoExcavaSueloArenosoConMechaSoftRemueveCapaArenosa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			self crearCapaArenosaConAlturaCero.
			self crearCapaTierraConAlturaCero.
			self crearCapaConcretoConAlturaCeroConResistenciaCinco } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: self crearCapaTierraConAlturaCero equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'af 5/8/2023 18:55:31'!
test02CuandoExcavaSueloTierraConMechaSoftNoModificaElSuelo

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			self crearCapaTierraConAlturaCero.
			self crearCapaConcretoConAlturaCeroConResistenciaCinco } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: self crearCapaTierraConAlturaCero equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'af 5/8/2023 18:55:31'!
test03CuandoExcavaConcretoConMechaSoftSeRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			self crearCapaConcretoConAlturaCeroConResistenciaCinco.
			self crearCapaTierraConAlturaCero.} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota.].
	! !

!TestDePerforación methodsFor: 'test' stamp: 'af 5/8/2023 18:55:31'!
test04CuandoExcavaSueloArenosoConMechaWidiaRemueveCapaArenosa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			self crearCapaArenosaConAlturaCero.
			self crearCapaTierraConAlturaCero.
			self crearCapaConcretoConAlturaCeroConResistenciaCinco } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaWidia.
	
	excavadora darGolpeDeTaladro.
	
	self assert: self crearCapaTierraConAlturaCero equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'af 5/8/2023 18:55:31'!
test05CuandoExcavaSueloTierraConMechaWidiaEnDosImpactosTransformaLaCapaEnArenoso

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			self crearCapaTierraConAlturaCero.
			self crearCapaConcretoConAlturaCeroConResistenciaCinco } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaWidia.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self assert: self crearCapaArenosaConAlturaCero equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'af 5/8/2023 18:55:31'!
test06CuandoExcavaSueloConcretoConMechaWidiaEnTresImpactosRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			self crearCapaConcretoConAlturaCeroConResistenciaCinco.	
			self crearCapaTierraConAlturaCero.
} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaWidia.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota.].
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'af 5/8/2023 18:55:31'!
test07CuandoExcavaSueloArenosoConMechaDiamanteRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			self crearCapaArenosaConAlturaCero.
			self crearCapaTierraConAlturaCero.
			self crearCapaConcretoConAlturaCeroConResistenciaCinco } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaDiamante.
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota ].
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'af 5/8/2023 18:55:31'!
test08CuandoExcavaSueloTierraConMechaDiamanteRemueveCapa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			self crearCapaTierraConAlturaCero.
			self crearCapaConcretoConAlturaCeroConResistenciaCinco } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaDiamante.
	
	excavadora darGolpeDeTaladro.
	
	self assert: (self crearCapaConcretoConAlturaCeroConResistenciaCinco) equals: excavadora capaDeSueloInmediata

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'af 5/8/2023 19:05:36'!
test09CuandoExcavaSueloConcretoConMechaDiamanteBajaUnDecimoDeResistencia

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			self crearCapaConcretoConAlturaCeroConResistenciaCinco.
			self crearCapaTierraConAlturaCero.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaDiamante.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self assert: (self crearCapaConcretoConAlturaCeroConResistencia: 4) equals: excavadora capaDeSueloInmediata

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'af 5/8/2023 18:53:36'!
test10CuandoRemueveLaCapaYHayPiedrasLasRecolectaEnSuContainer

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			self crearCapaArenosaConAlturaCero.
			'Mica'.
			'Marmol'
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: {	'Mica'. 'Marmol'} equals: excavadora elementsInContainer
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'af 5/8/2023 18:53:36'!
test11CuandoRemueveLaCapaYNoHayNadaNoRecogeNada

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			self crearCapaArenosaConAlturaCero.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: excavadora elementsInContainer isEmpty
	! !

!TestDePerforación methodsFor: 'test' stamp: 'af 5/8/2023 19:07:22'!
test12NoPuedePerforarSinMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			self crearCapaArenosaConAlturaCero.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
		
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'No puede perforar' equals: unError messageText.
			self assert: (self crearCapaArenosaConAlturaCero ) equals: excavadora capaDeSueloInmediata ].	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'af 5/8/2023 18:53:36'!
test13PuedeCalcularProfundidadDelSuelo

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { self crearCapaArenosaConAltura: 2. self crearCapaTierraConAltura: 40. self crearCapaArenosaConAlturaCero} .
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 42 equals: excavadora calcularProfundidadDelSuelo.

	! !

!TestDePerforación methodsFor: 'test' stamp: 'af 5/8/2023 19:58:28'!
test14PuedeContarLasCapasDeTipoArenoso

	| excavadora sueloAExcavar |
	
	sueloAExcavar :=  self crearSueloDosArenaCuarentaTierraCeroArenaCeroConcretoConDiezResistencia.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 2 equals: (excavadora contarCapas: self crearCapaArenosaConAlturaCero ).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'af 5/8/2023 19:58:45'!
test15PuedeContarLasCapasDeTipoTierra

	| excavadora sueloAExcavar |
	
	sueloAExcavar := self crearSueloDosArenaCuarentaTierraCeroArenaCeroConcretoConDiezResistencia.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 1 equals: (excavadora contarCapas: self crearCapaTierraConAlturaCero ).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'af 5/8/2023 19:59:13'!
test16PuedeContarLasCapasDeTipoConcreto

	| excavadora sueloAExcavar |
	
	sueloAExcavar :=  self crearSueloDosArenaCuarentaTierraCeroArenaCeroConcretoConDiezResistencia.
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 1 equals: (excavadora contarCapas: self crearCapaConcretoConAlturaCeroConResistenciaCinco).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'af 5/8/2023 20:00:00'!
test17PuedeCalcularProfundidadHastaPrimerCapaDeTipoArenoso

	| excavadora sueloAExcavar |
	
	sueloAExcavar := self crearSueloDosArenaCuarentaTierraCeroArenaCeroConcretoConDiezResistencia.
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 0 equals: (excavadora calcularProfundidadDelSueloHasta: self crearCapaArenosaConAlturaCero ).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'af 5/8/2023 20:00:17'!
test18PuedeCalcularProfundidadHastaPrimerCapaDeTipoTierra

	| excavadora sueloAExcavar |
	
	sueloAExcavar :=  self crearSueloDosArenaCuarentaTierraCeroArenaCeroConcretoConDiezResistencia.
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 2 equals: (excavadora calcularProfundidadDelSueloHasta: self crearCapaTierraConAlturaCero ).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'af 5/8/2023 20:00:37'!
test19PuedeCalcularProfundidadHastaPrimerCapaDeTipoConcreto

	| excavadora sueloAExcavar |
	
	sueloAExcavar := self crearSueloDosArenaCuarentaTierraCeroArenaCeroConcretoConDiezResistencia.
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 42 equals: (excavadora calcularProfundidadDelSueloHasta: self crearCapaConcretoConAlturaCeroConResistenciaCinco ).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'af 5/8/2023 21:50:03'!
test20PermiteExcavarCapaVacia

	| excavadora sueloAExcavar |
	
	sueloAExcavar:= { } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	"self assert: 42 equals: (excavadora calcularProfundidadDelSueloHasta: self crearCapaConcretoConAlturaCeroConResistenciaCinco )."

	! !

!TestDePerforación methodsFor: 'test' stamp: 'af 5/8/2023 21:50:55'!
test21PermiteExcavarCapaUnica

	| excavadora sueloAExcavar |
	
	sueloAExcavar:= { self crearCapaArenosaConAlturaCero. } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	"self assert: 42 equals: (excavadora calcularProfundidadDelSueloHasta: self crearCapaConcretoConAlturaCeroConResistenciaCinco )."

	! !

!TestDePerforación methodsFor: 'test' stamp: 'af 5/8/2023 22:03:24'!
test22PermiteExcavarMultiplesCapas

	| excavadora sueloAExcavar |
	
	sueloAExcavar:= (self crearSueloDosArenaCuarentaTierraCeroArenaCeroConcretoConDiezResistencia).
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	"self assert: 42 equals: (excavadora calcularProfundidadDelSueloHasta: self crearCapaConcretoConAlturaCeroConResistenciaCinco )."

	! !

!TestDePerforación methodsFor: 'test' stamp: 'af 5/8/2023 22:04:07'!
test23NoPermiteExcavarCapasIgualesContiguas

	| excavadora sueloAExcavar |
	sueloAExcavar  :=  {self crearCapaArenosaConAltura: 2. 
					self crearCapaArenosaConAltura: 2. }.
	"sueloAExcavar:= Suelo newWithCapas: {self crearCapaArenosaConAltura: 2. 
					self crearCapaArenosaConAltura: 2. }."
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	"self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'No puede perforar' equals: unError messageText.
			self assert: (self crearCapaArenosaConAlturaCero ) equals: excavadora capaDeSueloInmediata ].	"! !


!TestDePerforación methodsFor: 'creacionSuelo' stamp: 'af 5/8/2023 18:59:43'!
crearSueloDosArenaCuarentaTierraCeroArenaCeroConcretoConDiezResistencia

	^ { self crearCapaArenosaConAltura: 2 . 
	self crearCapaTierraConAltura: 40.
	self crearCapaArenosaConAlturaCero. 
	self crearCapaConcretoConAlturaCeroConResistencia: 10}! !


!TestDePerforación methodsFor: 'creacionCapas' stamp: 'af 5/8/2023 18:45:44'!
crearCapaArenosaConAltura: aAltura

	^ Arenoso nuevaConAltura: aAltura .! !

!TestDePerforación methodsFor: 'creacionCapas' stamp: 'af 5/8/2023 19:10:53'!
crearCapaArenosaConAlturaCero

	^ Arenoso nuevaConAlturaCero .! !

!TestDePerforación methodsFor: 'creacionCapas' stamp: 'af 5/8/2023 19:11:20'!
crearCapaConcretoConAlturaCeroConResistencia: aResistencia
	^Concreto nuevaConAlturaCeroConResistencia: aResistencia.
	
	! !

!TestDePerforación methodsFor: 'creacionCapas' stamp: 'af 5/8/2023 18:54:47'!
crearCapaConcretoConAlturaCeroConResistenciaCinco

	^ self crearCapaConcretoConAlturaCeroConResistencia: 5.! !

!TestDePerforación methodsFor: 'creacionCapas' stamp: 'af 5/8/2023 18:46:19'!
crearCapaTierraConAltura: aAltura

	^Tierra nuevaConAltura: aAltura .
	! !

!TestDePerforación methodsFor: 'creacionCapas' stamp: 'af 5/8/2023 19:10:53'!
crearCapaTierraConAlturaCero

	^Tierra nuevaConAlturaCero .
	! !


!classDefinition: #CapaDeSuelo category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #CapaDeSuelo
	instanceVariableNames: 'altura'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!CapaDeSuelo methodsFor: 'tipo' stamp: 'af 5/8/2023 19:15:49'!
esArenoso
	^self subclassResponsibility .! !

!CapaDeSuelo methodsFor: 'tipo' stamp: 'af 5/8/2023 19:16:01'!
esConcreto
	^self subclassResponsibility.! !

!CapaDeSuelo methodsFor: 'tipo' stamp: 'af 5/8/2023 19:16:12'!
esTierra
	^self subclassResponsibility .! !


!CapaDeSuelo methodsFor: 'comparing' stamp: 'af 5/8/2023 19:29:58'!
= unaCapaDeSuelo

	^self subclassResponsibility.! !


!CapaDeSuelo methodsFor: 'accessing' stamp: 'FRT 5/5/2023 16:48:52'!
altura

	^ altura.! !


!CapaDeSuelo methodsFor: 'scan' stamp: 'af 5/8/2023 19:46:56'!
scan
	^self subclassResponsibility .! !


!classDefinition: #Arenoso category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo subclass: #Arenoso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Arenoso methodsFor: 'initialize' stamp: 'af 5/8/2023 20:03:33'!
initializeConAltura: aAltura
	altura  := aAltura .! !


!Arenoso methodsFor: 'tipo' stamp: 'af 5/8/2023 19:15:09'!
esArenoso
	^true.! !

!Arenoso methodsFor: 'tipo' stamp: 'af 5/8/2023 19:17:23'!
esConcreto
	^false.! !

!Arenoso methodsFor: 'tipo' stamp: 'af 5/8/2023 19:16:29'!
esTierra
	^false.! !


!Arenoso methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 19:30:20'!
= unaCapaDeSuelo
	^(unaCapaDeSuelo isKindOf: self class).! !

!Arenoso methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 19:47:42'!
scan
 	^ 7 .! !

!Arenoso methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 21:28:55'!
tratarDeSerExcavadoPorPerforadora: aPerforadora
	^aPerforadora darGolpeDeTaladroArenoso.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Arenoso class' category: 'ISW1-2023-1C-Parcial-1'!
Arenoso class
	instanceVariableNames: ''!

!Arenoso class methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 18:09:07'!
nuevaConAltura: aAltura
	^(self new) initializeConAltura: aAltura.! !

!Arenoso class methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 19:10:53'!
nuevaConAlturaCero
	^(self new) initializeConAltura: 0.! !


!classDefinition: #Concreto category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo subclass: #Concreto
	instanceVariableNames: 'resistencia'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Concreto methodsFor: 'initialize' stamp: 'af 5/8/2023 20:03:55'!
initializeConAltura: aAltura yResistencia: aResistencia 
	altura  := aAltura .
	resistencia  := aResistencia .! !


!Concreto methodsFor: 'tipo' stamp: 'af 5/8/2023 19:15:21'!
esArenoso
	^false.! !

!Concreto methodsFor: 'tipo' stamp: 'af 5/8/2023 19:17:08'!
esConcreto
	^true.! !

!Concreto methodsFor: 'tipo' stamp: 'af 5/8/2023 19:16:38'!
esTierra
	^false.! !


!Concreto methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 19:30:49'!
= unaCapaDeSuelo
	^(unaCapaDeSuelo isKindOf: self class) and: [resistencia = unaCapaDeSuelo resistencia]! !

!Concreto methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 19:38:36'!
bajaUnDecimoDeResistencia
	resistencia := resistencia - 1! !

!Concreto methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 19:37:20'!
resistencia

	^ resistencia.! !

!Concreto methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 19:48:38'!
scan
	^ 50.! !

!Concreto methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 19:39:01'!
sinResistencia
	^resistencia = 0! !

!Concreto methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 21:29:11'!
tratarDeSerExcavadoPorPerforadora: aPerforadora
	^aPerforadora darGolpeDeTaladroConcreto.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Concreto class' category: 'ISW1-2023-1C-Parcial-1'!
Concreto class
	instanceVariableNames: ''!

!Concreto class methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 18:09:40'!
nuevaConAltura: aAltura yResistencia: aResistencia
	^(self new) initializeConAltura: aAltura yResistencia: aResistencia .! !

!Concreto class methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 19:11:20'!
nuevaConAlturaCeroConResistencia: aResistencia
	^(self new) initializeConAltura: 0 yResistencia: aResistencia .! !


!classDefinition: #Tierra category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo subclass: #Tierra
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Tierra methodsFor: 'tipo' stamp: 'af 5/8/2023 19:15:31'!
esArenoso
	^false.! !

!Tierra methodsFor: 'tipo' stamp: 'af 5/8/2023 19:17:31'!
esConcreto
	^false.! !

!Tierra methodsFor: 'tipo' stamp: 'af 5/8/2023 19:16:48'!
esTierra
	^true.! !


!Tierra methodsFor: 'initialize' stamp: 'af 5/8/2023 20:04:11'!
initializeConAltura: aAltura
	altura  := aAltura .! !


!Tierra methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 19:30:34'!
= unaCapaDeSuelo
	^(unaCapaDeSuelo isKindOf: self class).! !

!Tierra methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 19:48:30'!
scan
^10.! !

!Tierra methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 21:29:41'!
tratarDeSerExcavadoPorPerforadora: aPerforadora
	^aPerforadora darGolpeDeTaladroTierra.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Tierra class' category: 'ISW1-2023-1C-Parcial-1'!
Tierra class
	instanceVariableNames: ''!

!Tierra class methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 18:09:22'!
nuevaConAltura: aAltura
	^(self new) initializeConAltura: aAltura.! !

!Tierra class methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 19:10:53'!
nuevaConAlturaCero
	^(self new) initializeConAltura: 0.! !


!classDefinition: #Mecha category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #Mecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Mecha methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 20:17:51'!
conMechaRota

	^false.! !

!Mecha methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 20:18:23'!
sinMecha

	^false.! !

!Mecha methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 20:47:31'!
tratarDeRomperSueloArenosoEnPerforadora: aPerforadora
	^self subclassResponsibility .! !

!Mecha methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 20:47:44'!
tratarDeRomperSueloConcretoEnPerforadora: aPerforadora
	^self subclassResponsibility .! !

!Mecha methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 20:47:50'!
tratarDeRomperSueloTierraEnPerforadora: aPerforadora
	^self subclassResponsibility .! !


!classDefinition: #Diamante category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #Diamante
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Diamante methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 20:49:39'!
tratarDeRomperSueloArenosoEnPerforadora: aPerforadora
	^aPerforadora tratarDeRomperSueloArenosoEnMechaDiamante .! !

!Diamante methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 20:52:31'!
tratarDeRomperSueloConcretoEnPerforadora: aPerforadora
	^aPerforadora tratarDeRomperSueloConcretoEnMechaDiamante .! !

!Diamante methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 20:55:49'!
tratarDeRomperSueloTierraEnPerforadora: aPerforadora
	^aPerforadora tratarDeRomperSueloTierraEnMechaDiamante .! !


!classDefinition: #Rota category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #Rota
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Rota methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 20:18:01'!
conMechaRota

	^true.! !

!Rota methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 21:04:25'!
tratarDeRomperSueloArenosoEnPerforadora: aPerforadora
	^aPerforadora tratarDeRomperSueloArenosoEnMechaRota .! !

!Rota methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 20:53:14'!
tratarDeRomperSueloConcretoEnPerforadora: aPerforadora
	^aPerforadora tratarDeRomperSueloConcretoEnMechaRota .! !

!Rota methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 20:56:07'!
tratarDeRomperSueloTierraEnPerforadora: aPerforadora
	^aPerforadora tratarDeRomperSueloTierraEnMechaRota.! !


!classDefinition: #SinMecha category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #SinMecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!SinMecha methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 20:29:01'!
sinMecha

	^true.! !

!SinMecha methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 20:50:53'!
tratarDeRomperSueloArenosoEnPerforadora: aPerforadora
	^aPerforadora tratarDeRomperSueloArenosoSinMecha .! !

!SinMecha methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 20:53:50'!
tratarDeRomperSueloConcretoEnPerforadora: aPerforadora
	^aPerforadora tratarDeRomperSueloConcretoSinMecha .! !

!SinMecha methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 20:56:28'!
tratarDeRomperSueloTierraEnPerforadora: aPerforadora
	^aPerforadora tratarDeRomperSueloTierraSinMecha .! !


!classDefinition: #Soft category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #Soft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Soft methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 20:51:14'!
tratarDeRomperSueloArenosoEnPerforadora: aPerforadora
	^aPerforadora tratarDeRomperSueloArenosoEnMechaSoft .! !

!Soft methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 20:54:06'!
tratarDeRomperSueloConcretoEnPerforadora: aPerforadora
	^aPerforadora tratarDeRomperSueloConcretoEnMechaSoft .! !

!Soft methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 20:57:09'!
tratarDeRomperSueloTierraEnPerforadora: aPerforadora
	^aPerforadora tratarDeRomperSueloTierraEnMechaSoft .! !


!classDefinition: #Widia category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #Widia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Widia methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 20:51:36'!
tratarDeRomperSueloArenosoEnPerforadora: aPerforadora
	^aPerforadora tratarDeRomperSueloArenosoEnMechaWidia .! !

!Widia methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 20:54:28'!
tratarDeRomperSueloConcretoEnPerforadora: aPerforadora
	^aPerforadora tratarDeRomperSueloConcretoEnMechaWidia .! !

!Widia methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 20:57:25'!
tratarDeRomperSueloTierraEnPerforadora: aPerforadora
	^aPerforadora tratarDeRomperSueloTierraEnMechaWidia .! !


!classDefinition: #Perforadora category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #Perforadora
	instanceVariableNames: 'mechaPuesta vecesQueGolpeoCapaActual capasDeSueloDebajo container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Perforadora methodsFor: 'cambiar capa' stamp: 'ARM 5/1/2023 20:07:29'!
pasarAProximaCapa
	vecesQueGolpeoCapaActual := 0.
	capasDeSueloDebajo := capasDeSueloDebajo allButFirst.
	capasDeSueloDebajo ifEmpty: [^self]. 
	(capasDeSueloDebajo first isKindOf: CapaDeSuelo) ifFalse:[
			container addAll: capasDeSueloDebajo.
		]! !

!Perforadora methodsFor: 'cambiar capa' stamp: 'af 5/8/2023 19:10:53'!
transformarCapaEnArenoso
	capasDeSueloDebajo :=
			capasDeSueloDebajo allButFirst asOrderedCollection
			addFirst: Arenoso nuevaConAlturaCero ;
			yourself! !


!Perforadora methodsFor: 'excavation' stamp: 'af 5/8/2023 21:32:15'!
darGolpeDeTaladro

	vecesQueGolpeoCapaActual := vecesQueGolpeoCapaActual + 1.
	^(capasDeSueloDebajo first) tratarDeSerExcavadoPorPerforadora: self .! !

!Perforadora methodsFor: 'excavation' stamp: 'af 5/8/2023 21:30:47'!
darGolpeDeTaladroArenoso
	^mechaPuesta tratarDeRomperSueloArenosoEnPerforadora: self.
		! !

!Perforadora methodsFor: 'excavation' stamp: 'af 5/8/2023 21:32:00'!
darGolpeDeTaladroConcreto

	mechaPuesta tratarDeRomperSueloConcretoEnPerforadora: self.
	^self.! !

!Perforadora methodsFor: 'excavation' stamp: 'af 5/8/2023 21:31:15'!
darGolpeDeTaladroTierra

	mechaPuesta tratarDeRomperSueloTierraEnPerforadora: self.
	^self.! !


!Perforadora methodsFor: 'initialization' stamp: 'af 5/8/2023 20:21:21'!
initializeSobreSuelo: capasDeSueloAExcavarInicialmente

	capasDeSueloDebajo := capasDeSueloAExcavarInicialmente.
	vecesQueGolpeoCapaActual := 0.
	container := OrderedCollection new.
	mechaPuesta := SinMecha new.! !


!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2023 20:17:21'!
capaDeSueloInmediata
	^capasDeSueloDebajo first! !

!Perforadora methodsFor: 'accessing' stamp: 'af 5/8/2023 20:21:01'!
conMechaRota

	^mechaPuesta conMechaRota .! !

!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2023 21:12:20'!
elementsInContainer
	^container asArray! !

!Perforadora methodsFor: 'accessing' stamp: 'af 5/8/2023 20:20:49'!
sinMecha
	^mechaPuesta sinMecha.! !


!Perforadora methodsFor: 'sobre qué suelo' stamp: 'ARM 4/27/2023 20:13:17'!
sobreSueloArenoso
	^capasDeSueloDebajo first esArenoso! !

!Perforadora methodsFor: 'sobre qué suelo' stamp: 'ARM 4/27/2023 20:16:14'!
sobreSueloConcreto
	^capasDeSueloDebajo first esConcreto! !

!Perforadora methodsFor: 'sobre qué suelo' stamp: 'ARM 4/27/2023 20:13:58'!
sobreSueloTierra
	^capasDeSueloDebajo first esTierra! !


!Perforadora methodsFor: 'colocar mecha' stamp: 'af 5/8/2023 20:19:40'!
ponerMechaDiamante
	mechaPuesta := Diamante new.! !

!Perforadora methodsFor: 'colocar mecha' stamp: 'af 5/8/2023 20:19:59'!
ponerMechaSoft
	mechaPuesta := Soft new.! !

!Perforadora methodsFor: 'colocar mecha' stamp: 'af 5/8/2023 20:20:15'!
ponerMechaWidia
	mechaPuesta := Widia new.! !


!Perforadora methodsFor: 'scan' stamp: 'af 5/8/2023 17:38:56'!
calcularProfundidadDelSuelo

	capasDeSueloDebajo ifEmpty: [^0].
	^capasDeSueloDebajo sum: [:capaActual | capaActual altura].

	 ! !

!Perforadora methodsFor: 'scan' stamp: 'af 5/8/2023 20:01:06'!
calcularProfundidadDelSueloHasta: tipoDeCapa
	
	| sumaAcumulado |
	sumaAcumulado := 0.	
	
	capasDeSueloDebajo  do: [:capaActual | capaActual scan = tipoDeCapa scan ifTrue: [^sumaAcumulado.] ifFalse: [sumaAcumulado := sumaAcumulado + capaActual altura ]].	
	^ sumaAcumulado. "En caso de que no haya entiendo que debe decirte la suma de todas las capas. No encontre test que dieran evidencia de otra cosa"
	
	 ! !

!Perforadora methodsFor: 'scan' stamp: 'af 5/8/2023 20:01:16'!
contarCapas: tipoDeCapa
	
	"Cuenta las capas de tipo tipoDeCapa. Recordar que para identificar cada capa se utiliza el valor de scan que retorna. Por ej. un capa tipo Arenoso retorna 7 al scan"
	^(capasDeSueloDebajo select: [:capaActual | capaActual scan = tipoDeCapa scan ]) size .
! !


!Perforadora methodsFor: 'tratarDeExcavar' stamp: 'af 5/8/2023 21:10:45'!
tratarDeRomperSueloArenosoEnMechaDiamante
 	mechaPuesta := Rota new. 
	self error: 'Se rompió'. 
	^self.! !

!Perforadora methodsFor: 'tratarDeExcavar' stamp: 'af 5/8/2023 21:06:19'!
tratarDeRomperSueloArenosoEnMechaRota
^self error: 'La mecha ya estaba rota, no puede perforar'! !

!Perforadora methodsFor: 'tratarDeExcavar' stamp: 'af 5/8/2023 21:07:50'!
tratarDeRomperSueloArenosoEnMechaSoft 
^self pasarAProximaCapa! !

!Perforadora methodsFor: 'tratarDeExcavar' stamp: 'af 5/8/2023 21:09:58'!
tratarDeRomperSueloArenosoEnMechaWidia
^self pasarAProximaCapa! !

!Perforadora methodsFor: 'tratarDeExcavar' stamp: 'af 5/8/2023 21:02:02'!
tratarDeRomperSueloArenosoSinMecha
^self error: 'No puede perforar'! !

!Perforadora methodsFor: 'tratarDeExcavar' stamp: 'af 5/8/2023 21:17:18'!
tratarDeRomperSueloConcretoEnMechaDiamante
	vecesQueGolpeoCapaActual even ifTrue: 
	[ capasDeSueloDebajo first bajaUnDecimoDeResistencia].
	capasDeSueloDebajo first sinResistencia ifTrue: [ ^self transformarCapaEnArenoso].
	^vecesQueGolpeoCapaActual .! !

!Perforadora methodsFor: 'tratarDeExcavar' stamp: 'af 5/8/2023 21:06:31'!
tratarDeRomperSueloConcretoEnMechaRota
^self error: 'La mecha ya estaba rota, no puede perforar'! !

!Perforadora methodsFor: 'tratarDeExcavar' stamp: 'af 5/8/2023 21:15:00'!
tratarDeRomperSueloConcretoEnMechaSoft
	mechaPuesta := Rota new. 
	self error: 'Se rompió'.
	^self! !

!Perforadora methodsFor: 'tratarDeExcavar' stamp: 'af 5/8/2023 21:17:58'!
tratarDeRomperSueloConcretoEnMechaWidia
	vecesQueGolpeoCapaActual = 3 ifTrue:
	[ mechaPuesta := Rota new. 
	self error: 'Se rompió' ].
	^self.! !

!Perforadora methodsFor: 'tratarDeExcavar' stamp: 'af 5/8/2023 21:02:09'!
tratarDeRomperSueloConcretoSinMecha
^self error: 'No puede perforar'! !

!Perforadora methodsFor: 'tratarDeExcavar' stamp: 'af 5/8/2023 21:12:51'!
tratarDeRomperSueloTierraEnMechaDiamante
	^self pasarAProximaCapa.! !

!Perforadora methodsFor: 'tratarDeExcavar' stamp: 'af 5/8/2023 21:06:08'!
tratarDeRomperSueloTierraEnMechaRota
^self error: 'La mecha ya estaba rota, no puede perforar'! !

!Perforadora methodsFor: 'tratarDeExcavar' stamp: 'af 5/8/2023 21:11:50'!
tratarDeRomperSueloTierraEnMechaSoft
	^self.! !

!Perforadora methodsFor: 'tratarDeExcavar' stamp: 'af 5/8/2023 21:12:25'!
tratarDeRomperSueloTierraEnMechaWidia
	vecesQueGolpeoCapaActual = 2 ifTrue: [ ^self transformarCapaEnArenoso ].! !

!Perforadora methodsFor: 'tratarDeExcavar' stamp: 'af 5/8/2023 21:02:18'!
tratarDeRomperSueloTierraSinMecha
^self error: 'No puede perforar'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Perforadora class' category: 'ISW1-2023-1C-Parcial-1'!
Perforadora class
	instanceVariableNames: ''!

!Perforadora class methodsFor: 'instance creation' stamp: 'af 5/8/2023 21:59:38'!
sobreSuelo: capasDeSueloAExcavar 
	^self new initializeSobreSuelo: capasDeSueloAExcavar ! !


!classDefinition: #Suelo category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #Suelo
	instanceVariableNames: 'capasSuelo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Suelo methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 21:59:22'!
initializeWithCapas: capas.
	capasSuelo := capas ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Suelo class' category: 'ISW1-2023-1C-Parcial-1'!
Suelo class
	instanceVariableNames: ''!

!Suelo class methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 21:59:57'!
newWithCapas: capas
	self verificarQueNoHayanDosCapasIgualesContiguas: capas .
 	^(self new) initializeWithCapas: capas.! !

!Suelo class methodsFor: 'as yet unclassified' stamp: 'af 5/8/2023 22:00:36'!
verificarQueNoHayanDosCapasIgualesContiguas: capasDeSueloAExcavar
	| capasSonValidas |
	capasDeSueloAExcavar ifEmpty: [^true].
	(capasDeSueloAExcavar size)=1 ifTrue: [^true].
	capasSonValidas := (1 to: (capasDeSueloAExcavar size-1)) allSatisfy: [:indice | ((capasDeSueloAExcavar at: indice) = (capasDeSueloAExcavar at: (indice+1))) not ].
	capasSonValidas ifTrue: [^self] ifFalse: [^self error: 'Hay 2 capas iguales continuas'].! !
