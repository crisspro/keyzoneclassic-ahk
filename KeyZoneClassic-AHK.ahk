;Nombre: Keyzone Classic-AHK
;Autor: crisspro
;Año: 2020
;Licencia: GPL-3.0

#Include JSON.ahk

ScriptNombre:= "KeyzoneClassic-AHK"
ScriptVersion:= "v1.1"
ScriptApi:= "https://api.github.com/repos/crisspro/keyzoneclassic-ahk/releases/latest"
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
;carga NVDA
nvdaSpeak(text)
{
Return DllCall("nvdaControllerClient" A_PtrSize*8 ".dll\nvdaController_speakText", "wstr", text)
}

hablar(es,en)
{
Lector:= "otro"
process, Exist, nvda.exe
if ErrorLevel != 0
{
Lector:= "nvda"
if (InStr(A_language,"0a") = "3")
nvdaSpeak(es)
else
nvdaSpeak(en)
}
process, Exist, jfw.exe
if ErrorLevel != 0
{
Lector:= "jaws"
Jaws := ComObjCreate("FreedomSci.JawsApi")
if (InStr(A_language,"0a") = "3")
Jaws.SayString(es)
else
Jaws.SayString(en)
}
If global Lector = "otro"
{
Sapi := ComObjCreate("SAPI.SpVoice")
Sapi.Rate := 5
Sapi.Volume :=90
if (InStr(A_language,"0a") = "3")
Sapi.Speak(es)
else
Sapi.Speak(en)
}
}

;Chequea si hay nueva versión del script
descargar(ScriptApi, ScriptVersion)
{
try
{
enlace:= ComObjCreate("WinHttp.WinHttpRequest.5.1")
enlace.Open("GET", ScriptApi, true)
enlace.Send()
enlace.WaitForResponse()
base := enlace.ResponseText
texto:= JSON.Load(base)
for i, obj in texto
if i = tag_name
{
If obj != %ScriptVersion%
{ 
SoundPlay,sounds\version.wav
if (InStr(A_language,"0a") = "3")
{
MsgBox, 4, , Hay una nueva versión de este script. ¿Quieres descargarlo ahora?
IfMsgBox Yes
resp:= True
}
else
{
MsgBox, 4, , There is a new version of this script abailable, do you want to download it?
IfMsgBox Yes
resp:= True
}
}
}
If (resp = True)
{
for i, obj in texto
if i = assets
for j, k in obj
for l, m in k
If l = browser_download_url 
Run %m%
}
}
}

SetTitleMatchMode,2

;inicio
SoundPlay,sounds/start.wav, 1
hablar(ScriptNombre " activado",ScriptNombre " ready")
descargar(ScriptApi, ScriptVersion)

;detecta el plugin
loop
{
WinGet, VentanaID,Id,A
winget, controles, ControlList, A
IfWinActive,%VSTNombre%
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
else
VSTNombreDetectado:= False
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