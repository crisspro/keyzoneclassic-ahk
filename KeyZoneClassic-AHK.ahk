;Nombre: KeyZone Classic-AHK
;Autor: crisspro
;Año: 2020
;Licencia: GPL-3.0

#include nvda.ahk

xg:= 0
yg:= 0
VSTDetectado:= False

;construccion del menu
Menu,Menu, Add, KeyZone Piano,Keyzone
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

hablar("KeyZoneClassic activado", "KeyZoneClassicc ready")


loop
{
WinGet, VentanaID,Id,A
winget, controles, ControlList, A
loop, parse, controles, `n
{
if A_LoopField contains JUCE
{
global VSTDetectado:= True
ControlGetPos, x,y,a,b,%A_loopField%, ahk_id %VentanaID% 
global xg:= x
global yg:= y
break
}
if A_LoopField not contains JUCE
global VSTDetectado:= False
}
}



;atajos
#If VSTDetectado= True



;Despliega el menu
m::
Menu,Menu,Show
return

Keyzone:
MouseClick,LEFT, xg+400, yg+26
Sleep 100
MouseClick,LEFT,xg+400, yg+64 
return

Yamaha:
MouseClick,LEFT,xg+400, yg+26,1
Sleep 100
MouseClick,LEFT,xg+400, yg+94,1
return

Steinway:
MouseClick,LEFT,xg+400, yg+26,1
Sleep 100
MouseClick,LEFT,xg+400, yg+114,1
return

Electric:
MouseClick,LEFT,xg+400, yg+26,1
Sleep 100
MouseClick,LEFT,xg+400, yg+134,1
return

rhodes:
MouseClick,LEFT,xg+400, yg+26,1
Sleep 100
MouseClick,LEFT,xg+400, yg+154,1
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
hablar("KeyZoneClassic-AHK cerrado", "KeyZoneClassic-AHK closed")
SoundPlay,sounds/exit.wav,1
ExitApp
return