#include <Constants.au3>

Local $macinfo = Run (@ComSpec & " /c getmac > mac.txt" , "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)

Sleep(1500)

Local $line ;= StdoutRead($macinfo)

While FileGetSize("mac.txt") == 0

Wend

$file = FileOpen("mac.txt", 0)

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

$line = FileReadLine($file)
$line = FileReadLine($file)
$line = FileReadLine($file)
$line = FileReadLine($file)

FileClose($file)

FileDelete("mac.txt")

;MsgBox(0, "mac addr:", StringMid($line,1,17))

$macaddr = StringMid($line,1,17)

$file = FileOpen("ip.conf", 0)

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file ip.conf")
    Exit
EndIf

$ipaddr = "192.168.10.100"
$compname = "test"
$flag = 0

; читаем файл с настройками
While 1
    $line = FileReadLine($file)
    If @error = -1 Then ExitLoop
    
    ;MsgBox(0, "line:", $line)
    
    ; если нашли подходящие настройки, то устанавливаем их
    if StringInStr($line, $macaddr) <> 0 then
        ;MsgBox(0, "settings:", $line)
        $data = StringSplit($line, ';')
        $ipaddr = StringStripWS($data[2],3)
        $compname = StringStripWS($data[3],3)
        $flag = 1
        ;MsgBox(0, "ipaddr:", $ipaddr)
        ;MsgBox(0, "computer:", $compname)
    endif       
Wend

FileClose($file)

if $flag == 1 then
    Run (@ComSpec & " /c netsh interface ip set address name=""eth0"" static "& $ipaddr & " 255.255.255.0")
    Run (@ComSpec & " /c .\compname.exe /c "& $compname)
endif    

;MsgBox(0, "Settings", "Done: ipaddr=" & $ipaddr & "; name=" & $compname)

; немного подождать перед запуском машины времени
Sleep(3000)

; файл с паролем к TimeFreeze
$pass = "pass"
$file = FileOpen("pass.txt", 0)

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file pass.txt")
EndIf

$pass = FileReadLine($file)

FileClose($file)


; активация TimeFreeze
Run ("C:\Program Files\Toolwiz Time Freeze 2016\ToolwizTimeFreeze.exe")
WinWaitActive ("Enter Password")
ControlSetText("Enter Password", "", "TEdit1", $pass)
Send("{ENTER}")

WinWaitActive ("Toolwiz Time Freeze 2016")

; активируем запуск вместе с Windows
ControlCommand ( "Toolwiz Time Freeze 2016", "", "TCheckBox5", "Check", "")

; переход на активацию
ControlClick ( "Toolwiz Time Freeze 2016", "", "TButton2")
WinWaitActive ("Tips")
; подтверждаем активацию
Send ("{ENTER}")

Shutdown(6)  ;Force a reboot
