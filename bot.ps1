# This script sets the default shell for OpenSSH to PowerShell 7

$regPath = "HKLM:\SOFTWARE\OpenSSH"
$propertyName = "DefaultShell"
$propertyValue = "C:\Program Files\PowerShell\7\pwsh.exe"

# Set the DefaultShell property in the OpenSSH registry key
New-ItemProperty -Path $regPath -Name $propertyName -Value $propertyValue -PropertyType String -Force

Write-Host "DefaultShell set to $propertyValue in $regPath"

# Activate python virtual environment
$venvPath = "C:\Users\Admin\Documents\GitHub\casino-bot\venv\Scripts\Activate.ps1"
if (Test-Path $venvPath) {
    & $venvPath
    Write-Host "Activated Python virtual environment at $venvPath"
} else {
    Write-Host "Virtual environment not found at $venvPath"
}
# package requirements
$requirementsPath = "C:\Users\Admin\Documents\GitHub\casino-bot\requirements.txt"
if (Test-Path $requirementsPath) {
    pip install -r $requirementsPath
    Write-Host "Installed packages from $requirementsPath"
} else {
    Write-Host "Requirements file not found at $requirementsPath"
}
# Start the bot
$botScriptPath = "C:\Users\Admin\Documents\GitHub\casino-bot\discord\bot.py"
if (Test-Path $botScriptPath) {
    python $botScriptPath
    Write-Host "Started bot from $botScriptPath"
} else {
    Write-Host "Bot script not found at $botScriptPath"
}