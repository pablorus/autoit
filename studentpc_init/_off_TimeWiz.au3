; ���� � ������� � TimeFreeze
$pass = "pass"
$file = FileOpen("pass.txt", 0)

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file pass.txt")
EndIf

$pass = FileReadLine($file)

FileClose($file)

; ���������� TimeFreeze
Run ("C:\Program Files\Toolwiz Time Freeze 2016\ToolwizTimeFreeze.exe")
WinWaitActive ("Enter Password")
ControlSetText("Enter Password", "", "TEdit1", $pass)
Send("{ENTER}")

WinWaitActive ("Toolwiz Time Freeze 2016")

; ���������� ������ ������ � Windows
ControlCommand ( "Toolwiz Time Freeze 2016", "", "TCheckBox5", "UnCheck", "")

; ������� �� ���������
ControlClick ( "Toolwiz Time Freeze 2016", "", "TButton2")
WinWaitActive ("Tips")
; ������������ ���������
Send ("{ENTER}")
