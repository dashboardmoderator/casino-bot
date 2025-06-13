# Check if the remote ssh is running, if not, start the remote ssh
$sshService = Get-Service -Name "sshd" -ErrorAction SilentlyContinue
if ($null -eq $sshService) {
    Write-Host "Remote SSH service is not installed. Installing..."
    Install-WindowsFeature -Name OpenSSH.Server
    Start-Service sshd
    Write-Host "Remote SSH service started."
} else {
    if ($sshService.Status -ne 'Running') {
        Start-Service sshd
        Write-Host "Remote SSH service started."
    } else {
        Write-Host "Remote SSH service is already running."
    }
}

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