@echo off
:: Lancer le premier programme Processing
start "" ".\Palette\windows-amd64\Palette.exe"

:: Lancer le deuxième programme Processing
start  "" ".\OneDollarIvy\windows-amd64\OneDollarIvy.exe
"

:: Exécuter le premier script Python
start "" ".\sra5 (1)\sra5\sra5_on.bat"

:: Exécuter le deuxième script Python
start "" "C:\Users\lefla\UPSSITECH\Interaction_distribuee\TP_3_5_ID\ppilot5_3.3\ppilot5.bat"

:: Exécuter un troisième script Batch ou autre
start "" ".\visionneur_1_2\visonneur_1_2\visonneur.bat"

:: Facultatif : attendre que tous les processus se terminent avant de fermer
pause
