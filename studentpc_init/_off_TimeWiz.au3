; файл с паролем к TimeFreeze
$pass = "pass"
$file = FileOpen("pass.txt", 0)

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file pass.txt")
EndIf

$pass = FileReadLine($file)

FileClose($file)

; выключение TimeFreeze
Run ("C:\Program Files\Toolwiz Time Freeze 2016\ToolwizTimeFreeze.exe")
WinWaitActive ("Enter Password")
ControlSetText("Enter Password", "", "TEdit1", $pass)
Send("{ENTER}")

WinWaitActive ("Toolwiz Time Freeze 2016")

; активируем запуск вместе с Windows
ControlCommand ( "Toolwiz Time Freeze 2016", "", "TCheckBox5", "UnCheck", "")

; переход на активацию
ControlClick ( "Toolwiz Time Freeze 2016", "", "TButton2")
WinWaitActive ("Tips")
; подтверждаем активацию
Send ("{ENTER}")
