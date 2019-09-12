while($true){


$ComputerName = (get-wmiobject Win32_Computersystem).name
$myproc = "eMenu"
if (!(gps $myproc)) {
    $MyProcCMD = "C:\Program Files (x86)\eMenuDesktopComponent\eMenu.exe"  #<-- cmd to start proc
    $wmi = ([wmiclass]"win32_process").Create($MyProcCMD)
    if ($wmi.returnvalue -eq 0) {
	$EmailTo = "youremail@domain.com"
$EmailFrom = "youremail@domain.com"
$EmailPW = "*********"
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
    }
    
}