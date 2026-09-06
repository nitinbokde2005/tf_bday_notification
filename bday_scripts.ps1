# ==========================================
# Configuration Variables
# ==========================================
$csvPath = "2026_Birthdays_Name_Date.csv"
$botToken = "8511960953:AAF3q2tGdqEqspuCdRKur3GggrRa9mqL-Zw" # BotFather se mila token
$chatId = "1226610755" # Aapka Telegram Chat ID

# Aaj ki date
$currentDate = (Get-Date).ToString("dd/MM/yyyy")

# CSV se aaj ke birthdays nikalna
$todaysBirthdays = Import-Csv -Path $csvPath | Where-Object { $_.Date -eq $currentDate }

if ($todaysBirthdays) {
    $names = ($todaysBirthdays.Name) -join ", "
    $messageBody = "🎉 Birthday Alert! Today ($currentDate) is the birthday of: $names."
    
    # Telegram API URL
    $telegramUrl = "https://api.telegram.org/bot$botToken/sendMessage"
    
    # Message bhejne ka payload
    $payload = @{
        chat_id = $chatId
        text = $messageBody
    }

    # Background me chup-chap message send karna
    Invoke-RestMethod -Uri $telegramUrl -Method Post -Body $payload | Out-Null
    
    Write-Host "✅ Telegram notification sent in background!" -ForegroundColor Green
} else {
    Write-Host "No birthdays today." -ForegroundColor Yellow
}