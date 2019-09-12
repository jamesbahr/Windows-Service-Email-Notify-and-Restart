while($true){
$ComputerName = (get-wmiobject Win32_Computersystem).name

while ((Get-Service "Print Spooler").status -eq "Running")
{Start-Sleep -Seconds 5} 

if ($ServiceName.Status -eq 'Stopped'){
$ServiceStarted = $false}
Start-Service 'Print Spooler'
function SendAlert
{


$EmailTo = "email@yourdomain.com"
$EmailFrom = "email@yourdomain.com"
$EmailPW = "********"
$Subject = "**DC Service Failure** on $ComputerName"
$Body = ""
$SMTPServer = "smtp.office365.com" 
$SMTPPort = 587
$SMTPMessage = New-Object System.Net.Mail.MailMessage($EmailFrom,$EmailTo,$Subject,$Body)
$SMTPMessage.Body = "The DC service on $ComputerName has stopped. An automatic attempt has been made to restart the service. Please verify manually if the service has successfully restarted."
$SMTPClient = New-Object Net.Mail.SmtpClient($SMTPServer, $SMTPPort) 
$SMTPClient.EnableSsl = $true
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential($EmailFrom, $EmailPW); 
$SMTPClient.Send($SMTPMessage)
}
 
SendAlert
}
