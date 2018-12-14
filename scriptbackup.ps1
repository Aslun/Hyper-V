# Sender and Recipient Info
$MailFrom = "usernamehyperv@domaine.com"
$MailTo = "Votreusername@domaine.com"

# Sender Credentials
$Username = "usernamehyperv@domaine.com"
$Password = "password"

# Server Info
$SmtpServer = "IP SMTP"
$SmtpPort = "port smtp"

# Message stuff
$MessageSubject = "Backup Routeur Ok" 
$Message = New-Object System.Net.Mail.MailMessage $MailFrom,$MailTo
$Message.IsBodyHTML = $true
$Message.Subject = $MessageSubject
$Message.Body = @'
<!DOCTYPE html>
<html>
<head>
</head>
<body>

Le backup de la VM routeur et fini.
</body>
</html>
'@

rm -r -fo D:\backuptmp\Routeur\*
rm -r -fo F:\Hyper-V\Routeur\*
mkdir C:\backuptmp\Routeur\
Export-VM -Name Routeur -Path D:\backuptmp\
xcopy "D:\backuptmp\Routeur\*" "F:\Hyper-V\Routeur" /e /i
rm -r -fo D:\backuptmp\Routeur\*

# Construct the SMTP client object, credentials, and send
$Smtp = New-Object Net.Mail.SmtpClient($SmtpServer,$SmtpPort)
$Smtp.EnableSsl = $false
$Smtp.Credentials = New-Object System.Net.NetworkCredential($Username,$Password)
$Smtp.Send($Message)
