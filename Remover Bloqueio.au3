#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
#include <AD.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Do
    $pass = InputBox ("Removedor de restrição", "Por favor insira sua senha:","","*",200,150)
    If $pass <> "senhaparadesbloqueio" Then
        $cancela = MsgBox (1,"Aviso" , "Senha Incorreta" & @CRLF & "Tenar Novamente?")
		If $cancela == 2 Then
		   Exit
		 EndIf
    EndIf
Until $pass == "senhaparadesbloqueio"


; Abre a conexão com o AD
_AD_Open("administrador@dominio.local", "senhadousuarioadministrador")
If @error Then Exit MsgBox(16, "Removedor de restrição", "Função _AD_Open encontrou um problema. @error = " & @error & ", @extended = " & @extended)

; Entre com o usuário
#region ### START Koda GUI section ### Form=
Global $Form1 = GUICreate("Removedor de restrição", 514, 124)
GUICtrlCreateLabel("Conta de usuário:", 8, 10, 231, 17)
Global $IUser = GUICtrlCreateInput(@UserName, 241, 8, 259, 21)
Global $BOK = GUICtrlCreateButton("Liberar usuário", 8, 72, 130, 33)
Global $BCancel = GUICtrlCreateButton("Cancela", 428, 72, 73, 33, BitOR($GUI_SS_DEFAULT_BUTTON, $BS_DEFPUSHBUTTON))
GUISetState(@SW_SHOW)
#endregion ### END Koda GUI section ###

While 1
   Global $nMsg = GUIGetMsg()
   Switch $nMsg
   Case $GUI_EVENT_CLOSE, $BCancel
   Exit
   Case $BOK
   Global $sUser = _AD_SamAccountNameToFQDN(GUICtrlRead($IUser))
   Global $sGroup = _AD_SamAccountNameToFQDN("blocked") ; nome do grupo que contem os usuarios bloqueados
   ExitLoop
   EndSwitch
WEnd

; Remove o usuário do grupo
Global $iValue = _AD_RemoveUserFromGroup($sGroup, $sUser)
If $iValue = 1 Then
   MsgBox(64, "Removedor de restrição", "Usuário '" & $sUser & "' removido com sucesso '" & $sGroup & "'")
ElseIf @error = 1 Then
   MsgBox(64, "Removedor de restrição", "Grupo '" & $sGroup & "' não existe")
ElseIf @error = 2 Then
   MsgBox(64, "Removedor de restrição", "Usuário '" & $sUser & "' não existe")
ElseIf @error = 3 Then
   MsgBox(64, "Removedor de restrição", "Usuário '" & $sUser & "' não está bloqueado'" & $sGroup & "'")
Else
   MsgBox(64, "Removedor de restrição", "Código de retorno '" & @error & "' do Active Directory")
EndIf

; Fecha a conexão com o AD
_AD_Close()

