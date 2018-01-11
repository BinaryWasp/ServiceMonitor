while ((Get-Service "<service name>").status -eq "Running")
# {Start-Sleep -Seconds 120}
 
$a = "<style>"
$a = $a + "BODY{background-color:#FFFFFF;}"
$a = $a + "TABLE{text-align:left;border-width:medium;border-spacing:10px;border-style:groove;tab-size:2;table-layout:auto;border-color:#000000;border-collapse:separate;}"
$a = $a + "TH{text-align:left;border-width: medium;border-spacing:10px;border-style:groove;tab-size:2;table-layout:auto;border-color:#000000;background-color:#FFFFFF}"
$a = $a + "TD{text-align:left;align=right;border-width: medium;border-spacing:10px;border-style:groove;tab-size:2;table-layout:auto;border-color:#000000;background-color:#FFFFFF}"
$a = $a + "F1{font-family:Arial;color:#806517;font-size:12px}"
$a = $a + "</style>"

$Servername = $env:computername

$service = Get-Service BLSNAS_* | Select-Object Name, Status | ConvertTo-HTML -Head $a | Out-String

$smtp = "smtp.DOMAIN.com"
$to = "VAULTADMIN@DOMAIN.com"
$from = "ServiceMonitor@DOMAIN.com"
$subject = "Named Service Halted - $Servername"
$dt = Get-date
$body = "Dear <b>$to</b><br><br>"
#$body += "<font color=red><b>***I am generated by $Servername, this is a dummy email, please ignore me!***</b></font><br><br>"
$body += "It is detected that one of <enter whatever you want here>  Services was halted in Windows Server <b>$Servername</b> at <b><font color=red>$dt</font></b> Local Time. <br><br>"
$body += "<b><font color=red>$service</b></font><br><br>"
$body += "Please have a check and resume it immediately!<br><br>"
$body += "<font color=#806517><b><Your name here></b></font><br>"
$body += "<font color=#806517><your team name here></font>"

#$body += "Click <a href=http://servicedesk>here</a> Service Desk Ticket System <br>"

#send-MailMessage -From $from -Subject $subject -To $to -Cc $cc -Bcc $bcc -SmtpServer $smtp -Body $body -BodyAsHtml -Priority high
send-MailMessage -From $from -Subject $subject -To $to -SmtpServer $smtp -Body $body -BodyAsHtml -Priority high
