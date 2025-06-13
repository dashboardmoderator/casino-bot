# Define the path to the VS Code tunnel executable
$codeTunnelExePath = "C:\Users\Admin\.vscode\cli\code.exe"

# Check if the VS Code tunnel is running by checking for the pid.txt file
$pidFilePath = "C:\Users\Admin\.vscode\cli\servers\Stable-dfaf44141ea9deb3b4096f7cd6d24e00c147a4b1\pid.txt"
if (Test-Path $pidFilePath) {
    $botPid = Get-Content $pidFilePath
    if (Get-Process -Id $botPid -ErrorAction SilentlyContinue) {
        Write-Host "VS Code tunnel is running (PID: $botPid)."
    } else {
        Write-Host "VS Code tunnel pid.txt exists but process is not running. Attempting to start..."
        Start-Process -FilePath $codeTunnelExePath -ArgumentList "tunnel --accept-server-license-terms --log info --name pigletaccess --parent-process-id $botPid" -NoNewWindow
        Write-Host "VS Code tunnel started."
        Start-Sleep -Seconds 5
    }
} else {
    Write-Host "VS Code tunnel is not running. Attempting to start..."
    Start-Process -FilePath $codeTunnelExePath -ArgumentList "tunnel --accept-server-license-terms --log info --name pigletaccess --parent-process-id $botPid" -NoNewWindow
    Write-Host "VS Code tunnel started."
    Start-Sleep -Seconds 5
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