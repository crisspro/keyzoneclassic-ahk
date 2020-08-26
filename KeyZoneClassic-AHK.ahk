;Nombre: Keyzone Classic-AHK
;Autor: crisspro
;Año: 2020
;Licencia: GPL-3.0

#include nvda.ahk

ScriptNombre:= "KeyzoneClassic-AHK"
VSTNombre:= "Keyzone"
VSTControl:= "JUCE"

xg:= 0
yg:= 0
VSTControlDetectado:= False
VSTNombreDetectado:= False


;construcción del menú
Menu,Menu, Add, Keyzone Piano,Keyzone
Menu,Menu, Add, Yamaha Grand Piano,Yamaha
Menu,Menu, Add,Steinway Piano,Steinway 
Menu,Menu, Add, Basic Electric Piano,Electric
Menu,Menu, Add, Rhodes Piano,Rhodes

;funciones

;mensajes
hablar(es,en)
{
if (InStr(A_language,"0a") = "3")
nvdaSpeak(es)
else
nvdaSpeak(en)
}

;inicio
SoundPlay,sounds/start.wav

hablar(ScriptNombre " activado",ScriptNombre " ready")


loop
{
WinGet, VentanaID,Id,A
winget, controles, ControlList, A
WinGetText,VentanaTexto,A
If VentanaTexto contains %VSTNombre%
{
VSTNombreDetectado:= True
loop, parse, controles, `n
{
if A_LoopField contains %VSTControl%
{
VSTControlDetectado:= True
ControlGetPos, x,y,a,b,%A_loopField%, ahk_id %VentanaID% 
xg:= x
yg:= y
break
}
else
VSTControlDetectado:= False
}
}
}


;atajos
#If VSTControlDetectado= True and VSTNombreDetectado= True



;Despliega el menu
m::
Menu,Menu,Show
return

Keyzone:
MouseClick,LEFT, xg+400, yg+26
Sleep 100
MouseClick,LEFT,xg+400, yg+64 
hablar("Keyzone piano", "Keyzone piano")
return

Yamaha:
MouseClick,LEFT,xg+400, yg+26,1
Sleep 100
MouseClick,LEFT,xg+400, yg+94,1
hablar("Yamaha grand piano", "Yamaha grand piano")
return

Steinway:
MouseClick,LEFT,xg+400, yg+26,1
Sleep 100
MouseClick,LEFT,xg+400, yg+114,1
hablar("Steinway piano", "Steinway piano")
return

Electric:
MouseClick,LEFT,xg+400, yg+26,1
Sleep 100
MouseClick,LEFT,xg+400, yg+134,1
hablar("Basic elecctric piano", "Basic electric piano")
return

rhodes:
MouseClick,LEFT,xg+400, yg+26,1
Sleep 100
MouseClick,LEFT,xg+400, yg+154,1
hablar("Rhodes piano", "Rhodes piano")
return
return




s::
MouseClick,LEFT,xg + 640,yg + 34,1
hablar("siguiente", "next")
return


a::
MouseClick,LEFT, xg+252, yg+29,1
hablar("anterior", "back")
return

f1::
if (InStr(A_language,"0a") = "3")
Run Documentation\es.html
else
Run Documentation\en.html
return

^q:: 
hablar(ScriptNombre " cerrado",ScriptNombre " closed")
SoundPlay,sounds/exit.wav,1
ExitApp
return