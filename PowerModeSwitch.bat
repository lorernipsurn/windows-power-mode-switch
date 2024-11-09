@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

REM 管理者権限チェック
NET FILE 1>NUL 2>NUL
if %errorlevel% neq 0 (
    echo "管理者権限で実行してください
    pause
    exit /b
)

:MENU
cls

for /f "tokens=4 delims=() " %%a in ('powercfg /GETACTIVESCHEME') do (
    set "CURRENT_POWER=%%a"
)

set "PS_CMD=Write-Host '============================' -ForegroundColor White; "
set "PS_CMD=%PS_CMD%Write-Host '電源モード切替ツール' -ForegroundColor White; "
set "PS_CMD=%PS_CMD%Write-Host -NoNewline '現在の設定：' -ForegroundColor White; "
set "PS_CMD=%PS_CMD%Write-Host '%CURRENT_POWER%' -ForegroundColor Red; "
set "PS_CMD=%PS_CMD%Write-Host '============================' -ForegroundColor White; "
set "PS_CMD=%PS_CMD%Write-Host '1: 高パフォーマンス' -ForegroundColor White; "
set "PS_CMD=%PS_CMD%Write-Host '2: 省電力' -ForegroundColor White; "
set "PS_CMD=%PS_CMD%Write-Host '3: バランス' -ForegroundColor White; "
set "PS_CMD=%PS_CMD%Write-Host '4: 終了' -ForegroundColor White; "
set "PS_CMD=%PS_CMD%Write-Host '============================' -ForegroundColor White"

powershell -Command "%PS_CMD%"

choice /c 1234 /n /m "番号を入力してください(1-4):"

if %errorlevel% equ 1 (
    powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    powershell -Command "Write-Host '高パフォーマンスモードに変更しました' -ForegroundColor Blue"
    timeout /t 2 >nul
    goto MENU
) else if %errorlevel% equ 2 (
    powercfg -setactive a1841308-3541-4fab-bc81-f71556f20b4a
    powershell -Command "Write-Host '省電力モードに変更しました' -ForegroundColor White"
    timeout /t 2 >nul
    goto MENU
) else if %errorlevel% equ 3 (
    powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e
    powershell -Command "Write-Host 'バランスモードに変更しました' -ForegroundColor White"
    timeout /t 2 >nul
    goto MENU
) else if %errorlevel% equ 4 (
    exit /b
) else (
    powershell -Command "Write-Host '無効な入力です' -ForegroundColor White"
    timeout /t 2 >nul
    goto MENU
) 