# 0x00000709-fix
Fix the popular Windows 11 error 0x00000709 (Operation could not be completed), when trying to connect to a shared printer over LAN.


# exe files
<a href="https://www.microsoft.com/en-us/download/details.aspx?id=55319">LGPO.exe</a> is a new command-line utility to automate the management of local group policy.

<a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/regini">regini.exe</a> Modifies the registry from the command line, and applies changes that were preset in one or more text files. You can create, modify, or delete registry keys, in addition to modifying the permissions on the registry keys.

# How to use
Excute <code>FIX-709.bat</code> as administrator.

# Summary
<li>ENABLING LPD and LPR FEATURES.</li>
<li>RPC CONFIGURATIONS ON GROUP POLICY.</li>
<li>RPC CONFIGURATIONS ON REGISTRY EDITOR.</li>
<li>EDIT WINDOWS KEY PERMISSIONS ON REGISTRY EDITOR.</li>
<li>RESTART PRINTER SPOOLER SERVICE.</li>
