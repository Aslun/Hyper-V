##########################################################
#     ___         __                                     #
#    /   |  _____/ /_  ______                            #
#   / /| | / ___/ / / / / __ \                           #
#  / ___ |(__  ) / /_/ / / / /                           # 
# /_/  |_/____/_/\__,_/_/ /_/                            #
#                                                        #
# Développeur multi-platerformes                         #
# Twitter : https://twitter.com/b_languedoc              #
##########################################################

#Variable
$VMName = "NameVM"
$Destination = "F:\namefolder"

#Comptes mail envoi et réception
$MailFrom = "usernamehyperv@domaine.com"
$MailTo = "Votreusername@domaine.com"

#Comptes SMTP de l'envoyeur
$Username = "usernamehyperv@domaine.com"
$Password = "password"

# Server Info
$SmtpServer = "IP SMTP"
$SmtpPort = "port smtp"

#Mail message
$MessageSubject = "Backup VM Ok" 
$Message = New-Object System.Net.Mail.MailMessage $MailFrom,$MailTo
$Message.IsBodyHTML = $true
$Message.Subject = $MessageSubject
$Message.Body = @'
<!DOCTYPE html>
<html>
<head>
</head>
<body>

Le backup de la VM est fini.
</body>
</html>
'@
#Suppression de l'ancien backup
rm -r -fo $Destination\$VMName\*
#Exportation de la VM via la commande export-vm de Hyper-v
Export-VM -Name $VMName -Path $Destination


#Envoyer le mail de réussite
$Smtp = New-Object Net.Mail.SmtpClient($SmtpServer,$SmtpPort)
$Smtp.EnableSsl = $false
$Smtp.Credentials = New-Object System.Net.NetworkCredential($Username,$Password)
$Smtp.Send($Message)
