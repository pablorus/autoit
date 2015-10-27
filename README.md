.\studentpc_init
Набор скриптов для настойки компьютеров после заливки одного и того же образа жесткого диска

_off_TimeWiz.au3 - выключение ToolwizTimeFreeze, пароль задается в файле pass.txt
_on_TimeWiz.au3 - включение ToolwizTimeFreeze, пароль задается в файле pass.txt
_run_TimeWiz.au3 - установка ip-адреса и имени компьютера с последующим запуском ToolwizTimeFreeze. IP-адрес и имя компьютера берутся из файла настроек ip.conf
ip.conf - настройки компьютеров: mac-адрес; ip-адрес; имя_компьютера
pass.txt - пароль для запуска ToolwizTimeFreeze
