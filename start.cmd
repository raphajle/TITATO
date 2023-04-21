@echo off
color 0b
set ow=0
set xw=0
set dr=0
set val=0
set c=0
set i=0
set p=X
set msg=Mode de jeu

if not exist start.cmd exit

set sgc=0
for /D %%f in ("SG\*") do set /A sgc+=1
if %sgc% EQU 0 goto setup
if exist "SG" goto load



:reset
set ow=0
set xw=0
set dr=0
set val=0
set c=0
set i=0
set p=X
set msg=Mode de jeu





:setup
cls
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo  "| TI TA TO |" - ( %msg% )
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo  1._ Solo : Pc[Niv. 1] -VS- Joueur
echo  2._ Solo : Pc[Niv. 2] -VS- Joueur
echo  3._ Solo : Pc[Niv. 3] -VS- Joueur
echo  4._ Solo : Pc[Niv. 4] -VS- Joueur
echo  5._ Duel : Joueur -VS- Joueur
echo  6._ Fermer le jeu
echo.

set /a mod=0
set /p mod= choisir le mode [1 a 5] : 
set /a mod=%mod%

set ref=setup
IF %mod% LEQ 0 goto setup
IF %mod% EQU 6 goto confirm
IF %mod% GEQ 7 goto setup






:restart
set tc=0
set c1=_
set c2=_
set c3=_
set c4=_
set c5=_
set c6=_
set c7=_
set c8=_
set c9=_





:start
cls
IF %mod% LEQ 4 set msg= mode Solo[Niv.:%mod%]
IF %mod% EQU 5 set msg= mode Duel
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo  "| TI TA TO |" %msg%
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo      " --- --- --- "
echo      "| %c1% | %c2% | %c3% |"     " 1 | 2 | 3 "     Victoire(s) Joueur O : %ow%
echo      " --- --- --- "     "--- --- ---"
echo      "| %c4% | %c5% | %c6% |"     " 4 | 5 | 6 "     Victoire(s) Joueur X : %xw%
echo      " --- --- --- "     "--- --- ---"
echo      "| %c7% | %c8% | %c9% |"     " 7 | 8 | 9 "     Match nul : %dr%
echo      " --- --- --- "
echo.

IF %mod%%p% EQU 1O goto rand
IF %mod%%p% EQU 2O goto rand
IF %mod%%p% EQU 3O goto rand
IF %mod%%p% EQU 4O goto rand
set err= Emplacement [%np%] invalide !
set np=0
IF %val% EQU X echo %err%
IF %val% EQU O echo %err%
echo  Menu du joueur [%p%] :
echo   [1 a 9] : choisir un emplacement
echo   [E / e] : abandonner la partie
echo.
set /p np=Votre choix : 
set msg=Voulez vous abandonner la partie ?
goto chk





:rand
set /a np=(%RANDOM%*9/32768)+1

set level=lv1
IF %mod% EQU 1 goto chk





set rnp=%np%
set level=lv2
set U=X
goto smart
:lv2
IF %mod% EQU 2 goto chk
IF %rnp% NEQ %np% goto chk





set level=lv3
set U=O
goto smart
:lv3
IF %mod% EQU 3 goto chk


:lv4
IF %tc%%c1% EQU 1X set np=5
IF %tc%%c3% EQU 1X set np=5
IF %tc%%c7% EQU 1X set np=5
IF %tc%%c9% EQU 1X set np=5

IF %tc%%c5%%np% EQU 1X2 set np=1
IF %tc%%c5%%np% EQU 1X4 set np=3
IF %tc%%c5%%np% EQU 1X6 set np=7
IF %tc%%c5%%np% EQU 1X8 set np=9


goto chk





:smart
IF %c1%%c2%%c3% EQU %U%%U%_ set np=3
IF %c4%%c5%%c6% EQU %U%%U%_ set np=6
IF %c7%%c8%%c9% EQU %U%%U%_ set np=9
IF %c1%%c5%%c9% EQU %U%%U%_ set np=9
IF %c2%%c5%%c8% EQU %U%%U%_ set np=8
IF %c3%%c5%%c7% EQU %U%%U%_ set np=7
IF %c1%%c4%%c7% EQU %U%%U%_ set np=7
IF %c3%%c6%%c9% EQU %U%%U%_ set np=9
IF %c1%%c2%%c3% EQU _%U%%U% set np=1
IF %c4%%c5%%c6% EQU _%U%%U% set np=4
IF %c7%%c8%%c9% EQU _%U%%U% set np=7
IF %c1%%c5%%c9% EQU _%U%%U% set np=1
IF %c2%%c5%%c8% EQU _%U%%U% set np=2
IF %c3%%c5%%c7% EQU _%U%%U% set np=3
IF %c1%%c4%%c7% EQU _%U%%U% set np=1
IF %c3%%c6%%c9% EQU _%U%%U% set np=3
IF %c1%%c2%%c3% EQU %U%_%U% set np=2
IF %c4%%c5%%c6% EQU %U%_%U% set np=5
IF %c7%%c8%%c9% EQU %U%_%U% set np=8
IF %c1%%c5%%c9% EQU %U%_%U% set np=5
IF %c2%%c5%%c8% EQU %U%_%U% set np=5
IF %c3%%c5%%c7% EQU %U%_%U% set np=5
IF %c1%%c4%%c7% EQU %U%_%U% set np=4
IF %c3%%c6%%c9% EQU %U%_%U% set np=6
goto %level%





:chk
IF %np% EQU E goto end
IF %np% EQU e goto end
set /a np=%np%
IF %np% GTR 9 goto start
IF %np% LEQ 0 goto start

call set val=%%c%np%%%
IF %val% EQU X goto start
IF %val% EQU O goto start
set c%np%=%p%
set /a tc=%tc%+1
set /a c=0

IF %c1%%c2%%c3% EQU %p%%p%%p% goto win
IF %c4%%c5%%c6% EQU %p%%p%%p% goto win
IF %c7%%c8%%c9% EQU %p%%p%%p% goto win
IF %c1%%c5%%c9% EQU %p%%p%%p% goto win
IF %c2%%c5%%c8% EQU %p%%p%%p% goto win
IF %c3%%c5%%c7% EQU %p%%p%%p% goto win
IF %c1%%c4%%c7% EQU %p%%p%%p% goto win
IF %c3%%c6%%c9% EQU %p%%p%%p% goto win
IF %tc% EQU 9 goto draw
IF %tc% LSS 4 goto step

IF %p% EQU X (set x=O) else (set x=X)
IF %c1%%c2%%c3% EQU %x%%x%_ set /a c=3
IF %c4%%c5%%c6% EQU %x%%x%_ set /a c=6
IF %c7%%c8%%c9% EQU %x%%x%_ set /a c=9
IF %c1%%c5%%c9% EQU %x%%x%_ set /a c=9
IF %c2%%c5%%c8% EQU %x%%x%_ set /a c=8
IF %c3%%c5%%c7% EQU %x%%x%_ set /a c=7
IF %c1%%c4%%c7% EQU %x%%x%_ set /a c=7
IF %c3%%c6%%c9% EQU %x%%x%_ set /a c=9
IF %c1%%c2%%c3% EQU %x%_%x% set /a c=2
IF %c4%%c5%%c6% EQU %x%_%x% set /a c=5
IF %c7%%c8%%c9% EQU %x%_%x% set /a c=8
IF %c1%%c5%%c9% EQU %x%_%x% set /a c=5
IF %c2%%c5%%c8% EQU %x%_%x% set /a c=5
IF %c3%%c5%%c7% EQU %x%_%x% set /a c=5
IF %c1%%c4%%c7% EQU %x%_%x% set /a c=4
IF %c3%%c6%%c9% EQU %x%_%x% set /a c=6
IF %c1%%c2%%c3% EQU _%x%%x% set /a c=1
IF %c4%%c5%%c6% EQU _%x%%x% set /a c=4
IF %c7%%c8%%c9% EQU _%x%%x% set /a c=7
IF %c1%%c5%%c9% EQU _%x%%x% set /a c=1
IF %c2%%c5%%c8% EQU _%x%%x% set /a c=2
IF %c3%%c5%%c7% EQU _%x%%x% set /a c=3
IF %c1%%c4%%c7% EQU _%x%%x% set /a c=1
IF %c3%%c6%%c9% EQU _%x%%x% set /a c=3
IF %c% GTR 0 goto lose
IF %tc% EQU 8 goto draw

:step
IF %p% EQU X (set p=O) else (set p=X)
goto start

:lose
IF %p% EQU X (set p=O) else (set p=X)

:win
IF %p% EQU O set /a ow=%ow%+1
IF %p% EQU X set /a xw=%xw%+1
set msg=partie terminer, le joueur [%p%] a gagner !
goto end

:draw
set /a dr=%dr%+1
set msg=partie terminer, match nul !

:end
IF %c% GTR 0 set c%c%=%p%
cls
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo  "| TI TA TO |" PARTIE TERMINER !
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo      " --- --- --- "
echo      "| %c1% | %c2% | %c3% |"     Victoire(s) Joueur O : %ow%
echo      " --- --- --- "
echo      "| %c4% | %c5% | %c6% |"     Victoire(s) Joueur X : %xw%
echo      " --- --- --- "
echo      "| %c7% | %c8% | %c9% |"     Match nul : %dr%
echo      " --- --- --- "
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo   %msg%
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo Voulez vous continuer a jouer :
echo   1.- Oui
echo   2.- Non
echo   3.- Changer de mode de jeu
echo   4.- Reinitialiser les compteurs
echo.

set rep=0
set ref=end
set /p rep=reponse [1 a 4]: 
IF %rep% EQU 1 goto restart
IF %rep% EQU 2 goto confirm
IF %rep% EQU 3 goto setup
IF %rep% EQU 4 goto reset
IF %rep% GTR 4 goto err
goto end

:err
echo Desole, reponse invalide.
pause
goto end

set ref=end
:confirm
set rep=0
set /p rep=Etes vous sur de vouloir Fermer le jeu ? [ Y / N ] : 
IF %rep% EQU N goto %ref%
IF %rep% EQU n goto %ref%
IF %ow%%xw%%dr% EQU 000 exit

set /p rep=voulez vous sauvegarder les scores ? [ Y / N ] : 
IF %rep% EQU N exit
IF %rep% EQU n exit


set /p rep=veuillez saisir votre nom : 

if not exist SG mkdir SG
if not exist "SG\%rep%" mkdir "SG\%rep%"
echo %ow% > "SG\%rep%\ow.sg"
echo %xw% > "SG\%rep%\xw.sg"
echo %dr% > "SG\%rep%\dr.sg"
exit

set rep=
:load
cls
set rep=Y
set /p rep=voulez vous charger les scores ? [ Y / N ] : 
IF %rep% EQU N goto setup
IF %rep% EQU n goto setup

set rep=_
:load1
cls
echo.
echo   Liste des sauvegardes : 
echo   ~~~~~~~~~~~~~~~~~~~~~~~ 
if "%rep%" NEQ "_" echo  La sauvegarde ( %rep% ) est invalide.
echo.
for /D %%f in (SG\*) do echo    %%f
echo.
echo   ~~~~~~~~~~~~~~~~~~~~~~~ 
echo   0. Pour annuler
echo.
set /p rep= Veuillez saisir votre nom : 
IF %rep% EQU 0 goto load
if not exist "SG\%rep%\xw.sg" goto load1

set /p ow=<"SG\%rep%\ow.sg"
set /p xw=<"SG\%rep%\xw.sg"
set /p dr=<"SG\%rep%\dr.sg"
goto setup