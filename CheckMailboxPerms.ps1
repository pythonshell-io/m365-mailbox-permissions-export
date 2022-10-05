Connect-ExchangeOnline
$mbx = Get-EXOMailbox
$usertocheck = Read-Host "Enter an email address to see which mailboxes they have access to"
$perms = @()
foreach($mb in $mbx)
{
	if (Get-MailboxPermission $mb.UserPrincipalName -User $usertocheck){
		$mb.UserPrincipalName
		$perm = Get-MailboxPermission $mb.UserPrincipalName -User $usertocheck | % AccessRights
		$obj = New-Object PSObject
		$obj | Add-Member -MemberType NoteProperty -Name Mailbox -Value $mb.UserPrincipalName
		$obj | Add-Member -MemberType NoteProperty -Name Access -Value $perm
		$obj | Add-Member -MemberType NoteProperty -Name User -Value $usertocheck
		$perms += $obj
		}
	
	}
$perms
$perms | Export-CSV -NoTypeInformation "C:\Temp\MailboxPerms.csv"