:: Initialize new Ninja patch
@ECHO OFF
SET PAGE=0
SET PAGES_MAX=5

CALL :SHOWHEADER

IF NOT EXIST %~dp0code_1C47577B.patch (
    ECHO ERROR: Patch file missing: %~dp0code_1C47577B.patch
    PAUSE > NUL
    CLS
    EXIT /B 1
)
IF NOT EXIST %~dp0code_CB86CAC3.patch (
    ECHO ERROR: Patch file missing: %~dp0code_CB86CAC3.patch
    PAUSE > NUL
    CLS
    EXIT /B 1
)
IF NOT EXIST %~dp0code_EFD8A07B.patch (
    ECHO ERROR: Patch file missing: %~dp0code_EFD8A07B.patch
    PAUSE > NUL
    CLS
    EXIT /B 1
)

ECHO Before we start...
ECHO/
ECHO Disclaimer
ECHO ==========
ECHO/
ECHO Please be aware that creating a Ninja patch is not a one time
ECHO effort. You sign up for continuous development on your part!
ECHO Every time a new version of LeGo or similar is released each
ECHO patch needs to be updated to stay compatible with mods as well
ECHO as with other patches. If you release a patch upon the world
ECHO you need to be ready to create new versions of it every once in
ECHO a while.
ECHO/
ECHO The easiest way to do so is to star/watch the patch template on
ECHO GitHub ^<https://github.com/szapp/NinjaPatchTemplate^>, as it
ECHO will always be kept up to date. The best way is to fork the re-
ECHO pository and simply merge any changes once they arise.
ECHO/
ECHO I agree and I understand the implications (press any key) . . .
PAUSE > NUL

::=============================================== PAGE BREAK =========================================================::

CALL :SHOWHEADER
ECHO Patch Properties
ECHO ================
ECHO/

ECHO Name
ECHO ----
ECHO First, the most imporant thing is the name of the patch. The
ECHO patch will be identified by this name and it determines the
ECHO name of the VDF. Allowed are alpha numercial characters only.
ECHO/

:PROMPT_NAME
SET NAME=
SET /P NAME="Patch name: "
IF "%NAME%" == "" (
    ECHO Input must not be empty!
    ECHO/
    GOTO PROMPT_NAME
)
ECHO %NAME%| findstr /XR "^[0-9a-z][0-9a-z]*$" > NUL || (
    ECHO Input must be alpha numeric [0-9a-zA-Z]
    ECHO/
    GOTO PROMPT_NAME
)
:: Check if directory already exists
IF EXIST "%~dp0Ninja\%NAME%" (
    ECHO Directory \Ninja\%NAME% already exists. Please choose
    ECHO another patch name or rename/remove the directory.
    ECHO/
    GOTO PROMPT_NAME
)

:: Get length of name
SET NAME_LEN=0
SET NAME_UNDERLINE=
SET NAME_TMP=%NAME%
:GETLEN
IF NOT DEFINED NAME_TMP GOTO RESULT
:: Remove first letter until empty
SET NAME_TMP=%NAME_TMP:~1%
SET /A NAME_LEN+=1
SET NAME_UNDERLINE=%NAME_UNDERLINE%^=
GOTO GETLEN
:RESULT
IF %NAME_LEN% GEQ 60 (
    ECHO Input too long!
    ECHO/
    GOTO PROMPT_NAME
)

ECHO/
ECHO/
ECHO Description
ECHO -----------
ECHO Please supply a brief sentence describing the patch. It serves
ECHO as basic information for players in the ingame console and in-
ECHO side the VDF. Maximum length is 250 characters. Illegal char-
ECHO acters: ^>^<^|^&
ECHO You may use %%%%N for line breaks. No more than three lines are
ECHO supported.
ECHO/

:PROMPT_SHORT_DESCR
SET SHORT_DESCR=
SET /P SHORT_DESCR="Short description: "
IF "%SHORT_DESCR%" == "" (
    ECHO Input must not be empty!
    ECHO/
    GOTO PROMPT_SHORT_DESCR
)
ECHO "%SHORT_DESCR%"| findstr /R "[><|&]" > NUL && (
    ECHO Input contains illegal characters: ^>^<^|^&
    ECHO/
    GOTO PROMPT_SHORT_DESCR
)
SET SHORT_DESCR=%SHORT_DESCR:(=^^^(%
SET SHORT_DESCR=%SHORT_DESCR:)=^^^)%
:: Get length of description
SET DESC_LEN=0
SET NAME_TMP=%SHORT_DESCR%
:GETLEN_D
IF NOT DEFINED NAME_TMP GOTO RESULT_D
:: Remove first letter until empty
SET NAME_TMP=%NAME_TMP:~1%
SET /A DESC_LEN+=1
GOTO GETLEN_D
:RESULT_D
IF %DESC_LEN% GEQ 250 (
    ECHO Input too long!
    ECHO/
    GOTO PROMPT_SHORT_DESCR
)

::=============================================== PAGE BREAK =========================================================::

CALL :SHOWHEADER
ECHO Assign Ninjas (SRC Files)
ECHO =========================
ECHO/
ECHO A patch deploys different ninjas that infiltrate the game to
ECHO inject changes. There is one ninja for each type of parser.
ECHO Each of them follows an SRC file (exceptions: ani and OU).
ECHO/
ECHO Because, by default, Ninja patches are compatible with both
ECHO Gothic 1 and Gothic 2, you can have (for each ninja) a single
ECHO SRC file used for both games or separate SRC files for each
ECHO game.
ECHO/
ECHO Below, choose the ninjas you need (i.e. SRC files).
ECHO/
ECHO/

::--------------------------------------------------------------------------------------------------------------------::

ECHO Content Ninja
ECHO -------------
ECHO This ninja enables changes in the content scripts.
ECHO/
ECHO 0) Not needed
ECHO 1) Gothic 1
ECHO 2) Gothic 2
ECHO 3) Both
ECHO/

:PROMPT_CONTENT
SET CONTENT=
SET /P CONTENT="Please choose (0/1/2/3): "
IF "%CONTENT%" == ""  SET CONTENT=0 && GOTO INIT_MENU_CONT
IF "%CONTENT%" == "0" GOTO INIT_MENU_CONT
IF "%CONTENT%" == "1" GOTO CONTENT_CONT
IF "%CONTENT%" == "2" GOTO CONTENT_CONT
IF "%CONTENT%" == "3" GOTO CONTENT_CONT
ECHO Invalid input!
ECHO/
GOTO PROMPT_CONTENT
:CONTENT_CONT

ECHO/
:PROMPT_IKARUS
SET IKARUS=
SET /P IKARUS="Patch needs Ikarus (Y/N/?): "
IF "%IKARUS%" == "Y" SET IKARUS=y && GOTO IKARUS_CONT
IF "%IKARUS%" == "y" GOTO IKARUS_CONT
IF "%IKARUS%" == "N" GOTO LEGO_CONT
IF "%IKARUS%" == "n" GOTO LEGO_CONT
IF "%IKARUS%" == "?" (
    ECHO/
    ECHO If you do not know what Ikarus is you should not be tackling
    ECHO a Ninja patch, but instead start with basic modding. Bye.
    ECHO/
    GOTO QUIT
) ELSE (
    ECHO Please supply a valid answer.
    ECHO/
    GOTO PROMPT_IKARUS
)
:IKARUS_CONT

:PROMPT_LeGo
SET LEGO=
SET /P LEGO="Patch needs LeGo (Y/N/?):   "
IF "%LEGO%" == "Y" SET LEGO=y && GOTO LEGO_CONT
IF "%LEGO%" == "y" GOTO LEGO_CONT
IF "%LEGO%" == "N" GOTO LEGO_CONT
IF "%LEGO%" == "n" GOTO LEGO_CONT
IF "%LEGO%" == "?" (
    ECHO/
    ECHO If you do not know what LeGo is you should not be tackling
    ECHO a Ninja patch, but instead start with basic modding. Bye.
    ECHO/
    GOTO QUIT
) ELSE (
    ECHO Please supply a valid answer.
    ECHO/
    GOTO PROMPT_LEGO
)
:LEGO_CONT

ECHO/
ECHO Ninja offers to call a patch-specific initialzation function
ECHO after 'Init_Global' (G2) / 'Init_^<Levelname^>' (G1) was called.
IF "%IKARUS%" == "y" (
    ECHO This is useful to add your own initializations especially since
    IF "%LEGO%" == "y" (
        ECHO you use Ikarus and LeGo.
    ) ELSE (
        ECHO you use Ikarus.
    )
) ELSE (
ECHO This is useful to add your own initializations.
)
:PROMPT_INIT_CONTENT
SET INIT_CONTENT=
SET /P INIT_CONTENT="Patch needs content initialization function (Y/N): "
IF "%INIT_CONTENT%" == "Y" SET INIT_CONTENT=y && GOTO INIT_CONTENT_CONT
IF "%INIT_CONTENT%" == "y" GOTO INIT_CONTENT_CONT
IF "%INIT_CONTENT%" == "N" GOTO INIT_CONTENT_CONT
IF "%INIT_CONTENT%" == "n" GOTO INIT_CONTENT_CONT
ECHO Please supply a valid answer.
ECHO/
GOTO PROMPT_INIT_CONTENT
:INIT_CONTENT_CONT

ECHO/
ECHO Ninja also offers a patch-specific initialization function for
ECHO menus. It is called whenever a menu is opened, including the
ECHO main menu, before the game even started.
:PROMPT_INIT_MENU
SET INIT_MENU=
SET /P INIT_MENU="Patch needs menu initialization function (Y/N): "
IF "%INIT_MENU%" == "Y" SET INIT_MENU=y && GOTO INIT_MENU_CONT
IF "%INIT_MENU%" == "y" GOTO INIT_MENU_CONT
IF "%INIT_MENU%" == "N" GOTO INIT_MENU_CONT
IF "%INIT_MENU%" == "n" GOTO INIT_MENU_CONT
ECHO Please supply a valid answer.
ECHO/
GOTO PROMPT_INIT_MENU
:INIT_MENU_CONT

::--------------------------------------------------------------------------------------------------------------------::

ECHO/
ECHO/
ECHO Menu Ninja
ECHO ----------
ECHO This ninja enables changes in the menu scripts.
ECHO/
ECHO 0) Not needed
ECHO 1) Gothic 1
ECHO 2) Gothic 2
ECHO 3) Both
ECHO/

:PROMPT_MENU
SET MENU=
SET /P MENU="Please choose (0/1/2/3): "
IF "%MENU%" == ""  SET MENU=0 && GOTO MENU_CONT
IF "%MENU%" == "0" GOTO MENU_CONT
IF "%MENU%" == "1" GOTO MENU_CONT
IF "%MENU%" == "2" GOTO MENU_CONT
IF "%MENU%" == "3" GOTO MENU_CONT
ECHO Invalid input!
ECHO/
GOTO PROMPT_MENU
:MENU_CONT

::--------------------------------------------------------------------------------------------------------------------::

ECHO/
ECHO/
ECHO PFX Ninja
ECHO ---------
ECHO This ninja enables changes in the particle FX scripts.
ECHO/
ECHO 0) Not needed
ECHO 1) Gothic 1
ECHO 2) Gothic 2
ECHO 3) Both
ECHO/

:PROMPT_PFX
SET PFX=
SET /P PFX="Please choose (0/1/2/3): "
IF "%PFX%" == ""  SET PFX=0 && GOTO PFX_CONT
IF "%PFX%" == "0" GOTO PFX_CONT
IF "%PFX%" == "1" GOTO PFX_CONT
IF "%PFX%" == "2" GOTO PFX_CONT
IF "%PFX%" == "3" GOTO PFX_CONT
ECHO Invalid input!
ECHO/
GOTO PROMPT_PFX
:PFX_CONT

::--------------------------------------------------------------------------------------------------------------------::

ECHO/
ECHO/
ECHO VFX Ninja
ECHO ---------
ECHO This ninja enables changes in the visual FX scripts.
ECHO/
ECHO 0) Not needed
ECHO 1) Gothic 1
ECHO 2) Gothic 2
ECHO 3) Both
ECHO/

:PROMPT_VFX
SET VFX=
SET /P VFX="Please choose (0/1/2/3): "
IF "%VFX%" == ""  SET vFX=0 && GOTO VFX_CONT
IF "%VFX%" == "0" GOTO VFX_CONT
IF "%VFX%" == "1" GOTO VFX_CONT
IF "%VFX%" == "2" GOTO VFX_CONT
IF "%VFX%" == "3" GOTO VFX_CONT
ECHO Invalid input!
ECHO/
GOTO PROMPT_VFX
:VFX_CONT

::--------------------------------------------------------------------------------------------------------------------::

ECHO/
ECHO/
ECHO SFX Ninja
ECHO ---------
ECHO This ninja enables changes in the sound FX scripts.
ECHO/
ECHO 0) Not needed
ECHO 1) Gothic 1
ECHO 2) Gothic 2
ECHO 3) Both
ECHO/

:PROMPT_SFX
SET SFX=
SET /P SFX="Please choose (0/1/2/3): "
IF "%SFX%" == ""  SET SFX=0 &&  GOTO SFX_CONT
IF "%SFX%" == "0" GOTO SFX_CONT
IF "%SFX%" == "1" GOTO SFX_CONT
IF "%SFX%" == "2" GOTO SFX_CONT
IF "%SFX%" == "3" GOTO SFX_CONT
ECHO Invalid input!
ECHO/
GOTO PROMPT_SFX
:SFX_CONT

::--------------------------------------------------------------------------------------------------------------------::

ECHO/
ECHO/
ECHO Music Ninja
ECHO -----------
ECHO This ninja enables changes in the music scripts.
ECHO/
ECHO 0) Not needed
ECHO 1) Gothic 1
ECHO 2) Gothic 2
ECHO 3) Both
ECHO/

:PROMPT_MUSIC
SET MUSIC=
SET /P MUSIC="Please choose (0/1/2/3): "
IF "%MUSIC%" == ""  SET MUSIC=0 &&  GOTO MUSIC_CONT
IF "%MUSIC%" == "0" GOTO MUSIC_CONT
IF "%MUSIC%" == "1" GOTO MUSIC_CONT
IF "%MUSIC%" == "2" GOTO MUSIC_CONT
IF "%MUSIC%" == "3" GOTO MUSIC_CONT
ECHO Invalid input!
ECHO/
GOTO PROMPT_MUSIC
:MUSIC_CONT

::--------------------------------------------------------------------------------------------------------------------::

ECHO/
ECHO/
ECHO Camera Ninja
ECHO ------------
ECHO This ninja enables changes in the camera scripts.
ECHO/
ECHO 0) Not needed
ECHO 1) Gothic 1
ECHO 2) Gothic 2
ECHO 3) Both
ECHO/

:PROMPT_CAMERA
SET CAMERA=
SET /P CAMERA="Please choose (0/1/2/3): "
IF "%CAMERA%" == ""  SET CAMERA=0 && GOTO CAMERA_CONT
IF "%CAMERA%" == "1" GOTO CAMERA_CONT
IF "%CAMERA%" == "2" GOTO CAMERA_CONT
IF "%CAMERA%" == "3" GOTO CAMERA_CONT
ECHO Invalid input!
ECHO/
GOTO PROMPT_CAMERA
:CAMERA_CONT

::--------------------------------------------------------------------------------------------------------------------::

ECHO/
ECHO/
ECHO Fight AI Ninja
ECHO --------------
ECHO This ninja enables changes in the fight AI scripts.
ECHO/
ECHO 0) Not needed
ECHO 1) Gothic 1
ECHO 2) Gothic 2
ECHO 3) Both
ECHO/

:PROMPT_FIGHT
SET FIGHT=
SET /P FIGHT="Please choose (0/1/2/3): "
IF "%FIGHT%" == ""  SET FIGHT=0 &&  GOTO FIGHT_CONT
IF "%FIGHT%" == "0" GOTO FIGHT_CONT
IF "%FIGHT%" == "1" GOTO FIGHT_CONT
IF "%FIGHT%" == "2" GOTO FIGHT_CONT
IF "%FIGHT%" == "3" GOTO FIGHT_CONT
ECHO Invalid input!
ECHO/
GOTO PROMPT_FIGHT
:FIGHT_CONT

::--------------------------------------------------------------------------------------------------------------------::

ECHO/
ECHO/
ECHO Output Unit Ninja
ECHO -----------------
ECHO This ninja enables changes in the output units (dialogs).
ECHO/
ECHO 0) Not needed
ECHO 1) Gothic 1
ECHO 2) Gothic 2
ECHO 3) Both
ECHO/

:PROMPT_OU
SET OU=
SET /P OU="Please choose (0/1/2/3): "
IF "%OU%" == ""  SET OU=0 && GOTO OU_CONT
IF "%OU%" == "0" GOTO OU_CONT
IF "%OU%" == "1" GOTO OU_CONT
IF "%OU%" == "2" GOTO OU_CONT
IF "%OU%" == "3" GOTO OU_CONT
ECHO Invalid input!
ECHO/
GOTO PROMPT_OU
:OU_CONT

::--------------------------------------------------------------------------------------------------------------------::

ECHO/
ECHO/
ECHO Animation Ninja
ECHO ---------------
ECHO This ninja enables changes in the animations.
ECHO/
ECHO 0) Not needed
ECHO 1) Gothic 1
ECHO 2) Gothic 2
ECHO 3) Both
ECHO/

:PROMPT_ANIMATION
SET ANIMATION=
SET /P ANIMATION="Please choose (0/1/2/3): "
IF "%ANIMATION%" == ""  SET ANIMATION=0 && GOTO ANIMATION_CONT
IF "%ANIMATION%" == "0" GOTO ANIMATION_CONT
IF "%ANIMATION%" == "1" GOTO ANIMATION_CONT
IF "%ANIMATION%" == "2" GOTO ANIMATION_CONT
IF "%ANIMATION%" == "3" GOTO ANIMATION_CONT
ECHO Invalid input!
ECHO/
GOTO PROMPT_ANIMATION
:ANIMATION_CONT

::=============================================== PAGE BREAK =========================================================::

CALL :SHOWHEADER

ECHO Survey Complete
ECHO ===============
ECHO/
ECHO All necessary information has been gathered. No actions have
ECHO been performed yet. You may press CTRL+C to abort the process.
ECHO Press any key to create all files to initialize your new Ninja
ECHO patch '%NAME%' . . .
PAUSE > NUL
ECHO/

:START

:: Directory structure
ECHO Create patch directory
MKDIR "%~dp0Ninja\%NAME%" || GOTO ERR

ECHO Create subdirectories in '_work'
IF NOT EXIST "%~dp0_work\Data\Anims\_compiled"    MKDIR "%~dp0_work\Data\Anims\_compiled"    || GOTO ERR
IF NOT EXIST "%~dp0_work\Data\Meshes\_compiled"   MKDIR "%~dp0_work\Data\Meshes\_compiled"   || GOTO ERR
IF NOT EXIST "%~dp0_work\Data\Textures\_compiled" MKDIR "%~dp0_work\Data\Textures\_compiled" || GOTO ERR

SET CONTENT_ONCE=
IF "%CONTENT%" == "1" CALL :MAKE_CONTENT 1
IF "%CONTENT%" == "2" CALL :MAKE_CONTENT 2
IF "%CONTENT%" == "3" CALL :MAKE_CONTENT 1 && CALL :MAKE_CONTENT 2

CALL :MAKE_SRC Menu %MENU% 1
CALL :MAKE_SRC PFX %PFX% 1
CALL :MAKE_SRC VFX %VFX% 1
CALL :MAKE_SRC SFX %SFX% 1
CALL :MAKE_SRC Music %MUSIC%
CALL :MAKE_SRC Fight %FIGHT%
CALL :MAKE_SRC Camera %CAMERA%

IF "%OU%" GTR "0" (
    IF "%OU%" == "3" (
        ECHO Create empty output unit files
        COPY /Y NUL "%~dp0Ninja\%NAME%\OU.csl" > NUL || GOTO ERR
        COPY /Y NUL "%~dp0Ninja\%NAME%\OU.bin" > NUL || GOTO ERR
    ) ELSE (
        ECHO Create empty output unit files ^(G%OU%^)
        COPY /Y NUL "%~dp0Ninja\%NAME%\OU_G%OU%.csl" > NUL || GOTO ERR
        COPY /Y NUL "%~dp0Ninja\%NAME%\OU_G%OU%.bin" > NUL || GOTO ERR
    )
)

IF "%ANIMATION%" GTR "0" (
    IF "%ANIMATION%" == "3" (
        SET ANIMF="%~dp0Ninja\%NAME%\Anims_Humans.mds"
        ECHO Write animation file
    ) ELSE (
        SET ANIMF="%~dp0Ninja\%NAME%\Anims_Humans_G%ANIMATION%.mds"
        ECHO Write animation file ^(G%ANIMATION%^)
    )
)
:: Separate IF because of delayed extension
IF "%ANIMATION%" GTR "0" (
    (ECHO Model ^("HuS"^))>                                                   "%ANIMF%" || GOTO ERR
    (ECHO {)>>                                                                "%ANIMF%" || GOTO ERR
    (ECHO/)>>                                                                 "%ANIMF%" || GOTO ERR
    (ECHO     ^/^/ REGISTER NEW ARMOR HERE)>>                                 "%ANIMF%" || GOTO ERR
    (ECHO/)>>                                                                 "%ANIMF%" || GOTO ERR
    (ECHO     aniEnum)>>                                                      "%ANIMF%" || GOTO ERR
    (ECHO     {)>>                                                            "%ANIMF%" || GOTO ERR
    (ECHO/)>>                                                                 "%ANIMF%" || GOTO ERR
    (ECHO         ^/^/ ADD NEW ANIMATIONS HERE)>>                             "%ANIMF%" || GOTO ERR
    (ECHO/)>>                                                                 "%ANIMF%" || GOTO ERR
    (ECHO     })>>                                                            "%ANIMF%" || GOTO ERR
    (ECHO })>>                                                                "%ANIMF%" || GOTO ERR
)

ECHO Write VDFS VM script
(ECHO [BEGINVDF])>                                                            "%~dp0Ninja_%NAME%.vm" || GOTO ERR
(ECHO Comment=%SHORT_DESCR%%%%%NNinja ^<http://tiny.cc/GothicNinja^>)>>       "%~dp0Ninja_%NAME%.vm" || GOTO ERR
(ECHO VDFName=.\Ninja_%NAME%.vdf)>>                                           "%~dp0Ninja_%NAME%.vm" || GOTO ERR
(ECHO/)>>                                                                     "%~dp0Ninja_%NAME%.vm" || GOTO ERR
(ECHO [FILES])>>                                                              "%~dp0Ninja_%NAME%.vm" || GOTO ERR
(ECHO README_%NAME%.md)>>                                                     "%~dp0Ninja_%NAME%.vm" || GOTO ERR
(ECHO/)>>                                                                     "%~dp0Ninja_%NAME%.vm" || GOTO ERR
(ECHO ; Resources ^(list the specific files from _work here^))>>              "%~dp0Ninja_%NAME%.vm" || GOTO ERR
(ECHO ; _work\* -r)>>                                                         "%~dp0Ninja_%NAME%.vm" || GOTO ERR
(ECHO/)>>                                                                     "%~dp0Ninja_%NAME%.vm" || GOTO ERR
(ECHO ; Script files)>>                                                       "%~dp0Ninja_%NAME%.vm" || GOTO ERR
IF "%IKARUS%" == "y" (
    (ECHO Ninja\Ikarus\* -r)>>                                                "%~dp0Ninja_%NAME%.vm" || GOTO ERR
    IF "%LEGO%" == "y" (
        (ECHO Ninja\LeGo\* -r)>>                                              "%~dp0Ninja_%NAME%.vm" || GOTO ERR
    )
)
(ECHO Ninja\%NAME%\* -r)>>                                                    "%~dp0Ninja_%NAME%.vm" || GOTO ERR
(ECHO/)>>                                                                     "%~dp0Ninja_%NAME%.vm" || GOTO ERR
(ECHO ; Ninja files)>>                                                        "%~dp0Ninja_%NAME%.vm" || GOTO ERR
(ECHO *.patch)>>                                                              "%~dp0Ninja_%NAME%.vm" || GOTO ERR
(ECHO/)>>                                                                     "%~dp0Ninja_%NAME%.vm" || GOTO ERR
(ECHO [EXCLUDE])>>                                                            "%~dp0Ninja_%NAME%.vm" || GOTO ERR
(ECHO _work\Data\Scripts\* -r)>>                                              "%~dp0Ninja_%NAME%.vm" || GOTO ERR
(ECHO *.vm)>>                                                                 "%~dp0Ninja_%NAME%.vm" || GOTO ERR
(ECHO *.vdf)>>                                                                "%~dp0Ninja_%NAME%.vm" || GOTO ERR
(ECHO *.bat)>>                                                                "%~dp0Ninja_%NAME%.vm" || GOTO ERR
(ECHO/)>>                                                                     "%~dp0Ninja_%NAME%.vm" || GOTO ERR
(ECHO [INCLUDE])>>                                                            "%~dp0Ninja_%NAME%.vm" || GOTO ERR
(ECHO/)>>                                                                     "%~dp0Ninja_%NAME%.vm" || GOTO ERR
(ECHO [ENDVDF])>>                                                             "%~dp0Ninja_%NAME%.vm" || GOTO ERR

ECHO Write Readme
(ECHO %NAME%)>                                                                "%~dp0README_%NAME%.md" || GOTO ERR
(ECHO %NAME_UNDERLINE%)>>                                                     "%~dp0README_%NAME%.md" || GOTO ERR
(ECHO/)>>                                                                     "%~dp0README_%NAME%.md" || GOTO ERR
(ECHO Forked from https://github.com/szapp/NinjaPatchTemplate)>>              "%~dp0README_%NAME%.md" || GOTO ERR
(ECHO/)>>                                                                     "%~dp0README_%NAME%.md" || GOTO ERR
(ECHO/)>>                                                                     "%~dp0README_%NAME%.md" || GOTO ERR
(ECHO ^[ PROVIDE MORE INFORMATION HERE ^])>>                                  "%~dp0README_%NAME%.md" || GOTO ERR
(ECHO/)>>                                                                     "%~dp0README_%NAME%.md" || GOTO ERR
(ECHO/)>>                                                                     "%~dp0README_%NAME%.md" || GOTO ERR
IF "%IKARUS%" == "y" (
    IF "%LEGO%" == "y" (
        (ECHO Patch includes Ikarus and LeGo.)>>                              "%~dp0README_%NAME%.md" || GOTO ERR
    ) ELSE (
        (ECHO Patch includes Ikarus.)>>                                       "%~dp0README_%NAME%.md" || GOTO ERR
    )
    (ECHO/)>>                                                                 "%~dp0README_%NAME%.md" || GOTO ERR
    (ECHO/)>>                                                                 "%~dp0README_%NAME%.md" || GOTO ERR
)
(ECHO Ninja ^<http://tiny.cc/GothicNinja^>)>>                                 "%~dp0README_%NAME%.md" || GOTO ERR

ECHO/
ECHO Initialization successful
ECHO/
ECHO Press any key to continue . . .
PAUSE > NUL

::=============================================== PAGE BREAK =========================================================::

:DONE
CALL :SHOWHEADER

ECHO A VM script was created with which you can create the VDF using
ECHO GothicVDFS, see ^<http://www.bendlins.de/nico/gothic2/^>.
ECHO/
ECHO/
SET ITER=1
ECHO Next Steps
ECHO ==========
ECHO/
ECHO %ITER%. Adjust Readme
SET /A ITER+=1
ECHO    If your patch requires a lot of explanations you may want to
ECHO    adjust the readme file which has been written provisionally.
ECHO/
ECHO %ITER%. Add Scripts
SET /A ITER+=1
ECHO    Add any necessary scripts in the subdirectories 'Content'
ECHO    and 'System' and register them in the respective SRC files.
ECHO/
IF "%OU%" GTR "0" (
    ECHO %ITER%. Add Output Units
    SET /A ITER+=1
    ECHO    The OU files are empty place holders. Replace them with your
    ECHO    compiled versions ^(e.g. using Redefix^). Either the CSL or
    ECHO    the BIN file will suffice. Not both of them are required.
    ECHO/
)
IF "%ANIMATION%" GTR "0" (
    ECHO %ITER%. Add Animations
    SET /A ITER+=1
    ECHO    The MDS file is an empty place holder. Copy/rename it to the
    ECHO    desired model name and fill in your new armor/animations.
    ECHO/
)
ECHO %ITER%. Add Resources
SET /A ITER+=1
ECHO    If you have further resources like textures, meshes or ani-
ECHO    mations, add them in the respective directory ^('_compiled'^)
ECHO    in the directory '_work' and add their paths to the VM
ECHO    script. See the comments inside the VM script.
ECHO/
ECHO %ITER%. Build the Patch
SET /A ITER+=1
ECHO    In GothicVDFS click '^(Builder^)' and then 'Open Script'.
ECHO    Navigate to and open
ECHO    %~dp0Ninja_%NAME%.vm
ECHO    Adjust 'Root Path' to the same directory.
ECHO    Confirm the contents of the fields and click 'Build volume'.
ECHO/
ECHO %ITER%. Test the Patch
SET /A ITER+=1
ECHO    Throughly test your patch in Gothic with different mods.
IF "%IKARUS%" == "y" (
    IF "%LEGO%" == "y" (
        ECHO    It is important to try various mods that ^[don't^] use LeGo!
    ) ELSE (
        ECHO    It is important to try various mods that ^[don't^] use Ikarus!
    )
)
ECHO/
ECHO %ITER%. Keep the Patch up to Date
SET /A ITER+=1
ECHO    Watch closely for new versions of Ninja and update your
ECHO    patch accordingly!
ECHO/

:QUIT
ECHO Press any key to quit . . .
PAUSE > NUL
CLS
EXIT /B 0

:ERR
ECHO ERROR: Operation failed
PAUSE > NUL
CLS
EXIT /B 1

:MAKE_CONTENT GOTHIC_BASE_VERSION
IF NOT EXIST "%~dp0Ninja\%NAME%\Content" (
    ECHO Create subdirectory 'Content'
    MKDIR "%~dp0Ninja\%NAME%\Content" || GOTO ERR
)

IF "%IKARUS%" == "y" (
    ECHO Write content SRC ^(G%1^)
    (ECHO ..\Ikarus\Ikarus_G%1.src)>                                          "%~dp0Ninja\%NAME%\Content_G%1.src" || GOTO ERR
    IF "%LEGO%" == "y" (
        (ECHO ..\LeGo\Header_G%1.src)>>                                       "%~dp0Ninja\%NAME%\Content_G%1.src" || GOTO ERR

        IF NOT DEFINED CONTENT_ONCE (
            ECHO Write content init file
            (ECHO /*)>                                                        "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
            IF "%INIT_CONTENT%" == "y" (
                (ECHO  * Call this function ^(from the function "Ninja_%NAME%_Init" ^
below^) to initialize LeGo packages.)>>                                       "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
            ) ELSE (
                (ECHO  * Call this function to initialize LeGo packages.)>>   "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
            )
            (ECHO  *)>>                                                       "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
            (ECHO  * It ensures that all necessary LeGo packages will be ^
loaded without breaking already loaded LeGo packages.)>>                      "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
            (ECHO  *)>>                                                       "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
            (ECHO  * Caution: When re-using this function elsewhere, it is ^
important to rename it to prevent clashes!)>>                                 "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
            (ECHO  * Each Ninja patch that needs it, has to have their own ^
function with a unique name. Otherwise they cannot be stacked.)>>             "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
            (ECHO  *)>>                                                       "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
            (ECHO  * Do not modify this function in any way!)>>               "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
            (ECHO  */)>>                                                      "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
            (ECHO func void Ninja_%NAME%_MergeLeGoFlags^(var int flags^) {)>> "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
            (ECHO     const int legoInit    = -1; // Prior initialization ^
state)>>                                                                      "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
            (ECHO     const int initialized =  0; // Once per session)>>      "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
            (ECHO     var   int loaded;           // Once per game save)>>    "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
            (ECHO     legoInit    = LeGo_MergeFlags^(flags, legoInit, ^
initialized, loaded^);)>>                                                     "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
            (ECHO     initialized = 1;)>>                                     "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
            (ECHO     loaded      = 1;)>>                                     "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
            (ECHO };)>>                                                       "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
            (ECHO/)>>                                                         "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
            (ECHO/)>>                                                         "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
        )
    )
    (ECHO/)>>                                                                 "%~dp0Ninja\%NAME%\Content_G%1.src" || GOTO ERR
    (ECHO // LIST YOUR FILES HERE)>>                                          "%~dp0Ninja\%NAME%\Content_G%1.src" || GOTO ERR
    (ECHO/)>>                                                                 "%~dp0Ninja\%NAME%\Content_G%1.src" || GOTO ERR
) ELSE (
    ECHO Create empty content SRC ^(G%1^)
    COPY /Y NUL "%~dp0Ninja\%NAME%\Content_G%1.src" > NUL || GOTO ERR
)
IF "%INIT_CONTENT%" == "y" GOTO INIT_D
IF "%INIT_MENU%"    == "y" GOTO INIT_D
EXIT /B 0

:INIT_D
IF NOT "%IKARUS%" == "y" (
    (ECHO/)>>                                                                 "%~dp0Ninja\%NAME%\Content_G%1.src" || GOTO ERR
    (ECHO // LIST YOUR FILES HERE)>>                                          "%~dp0Ninja\%NAME%\Content_G%1.src" || GOTO ERR
    (ECHO/)>>                                                                 "%~dp0Ninja\%NAME%\Content_G%1.src" || GOTO ERR
)
(ECHO Content\NinjaInit.d)>>                                                  "%~dp0Ninja\%NAME%\Content_G%1.src" || GOTO ERR
IF NOT EXIST "%~dp0Ninja\%NAME%\Content\NinjaInit.d" (
    ECHO Create empty content init file
    COPY /Y NUL "%~dp0Ninja\%NAME%\Content\NinjaInit.d" > NUL || GOTO ERR
)
IF "%INIT_MENU%" == "y" (
    IF NOT DEFINED CONTENT_ONCE (
        (ECHO /*)>>                                                           "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
        (ECHO  * Menu initialization function called by Ninja every time a ^
menu is opened)>>                                                             "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
        (ECHO  */)>>                                                          "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
        (ECHO func void Ninja_%NAME%_Menu^(var int menuPtr^) {)>>             "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
        IF "%IKARUS%" == "y" (
            (ECHO     MEM_InitAll^(^);)>>                                     "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
            (ECHO/)>>                                                         "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
        )
        (ECHO/)>>                                                             "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
        (ECHO     // WRITE YOUR INITIALIZATIONS HERE)>>                       "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
        (ECHO/)>>                                                             "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
        (ECHO };)>>                                                           "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
        (ECHO/)>>                                                             "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
        (ECHO/)>>                                                             "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
    )
)
IF "%INIT_CONTENT%" == "y" (
    IF NOT DEFINED CONTENT_ONCE (
        (ECHO /*)>>                                                           "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
        (ECHO  * Initialization function called by Ninja after "Init_Global" ^(^
G2^) / "Init_<Levelname>" ^(G1^))>>                                           "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
        (ECHO  */)>>                                                          "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
        (ECHO func void Ninja_%NAME%_Init^(^) {)>>                            "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
        IF "%LEGO%" == "y" (
            (ECHO     // Wrapper for "LeGo_Init" to ensure correct LeGo ^
initialization without breaking the mod)>>                                    "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
            (ECHO     Ninja_%NAME%_MergeLeGoFlags^( /* DESIRED LEGO PACKAGES ^
*/ ^);)>>                                                                     "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
            (ECHO/)>>                                                         "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
        ) ELSE (
            IF "%IKARUS%" == "y" (
                (ECHO     MEM_InitAll^(^);)>>                                 "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
                (ECHO/)>>                                                     "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
            )
        )
        (ECHO/)>>                                                             "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
        (ECHO     // WRITE YOUR INITIALIZATIONS HERE)>>                       "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
        (ECHO/)>>                                                             "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
        (ECHO };)>>                                                           "%~dp0Ninja\%NAME%\Content\NinjaInit.d" || GOTO ERR
    )
)
SET CONTENT_ONCE=1
EXIT /B 0

:MAKE_SRC SRC_NAME GOTHIC_BASE_VERSION
IF "%2" == "0" EXIT /B 0
IF "%3" == "1" (
    IF NOT EXIST "%~dp0Ninja\%NAME%\System" (
        ECHO Create subdirectory 'System'
        MKDIR "%~dp0Ninja\%NAME%\System" || GOTO ERR
    )
)
IF "%2" == "3" (
    ECHO Create empty %1 SRC
    COPY /Y NUL "%~dp0Ninja\%NAME%\%1.src" > NUL || GOTO ERR
) ELSE (
    ECHO Create empty %1 SRC ^(G%2^)
    COPY /Y NUL "%~dp0Ninja\%NAME%\%1_G%2.src" > NUL || GOTO ERR
)
EXIT /B 0


:SHOWHEADER
SET /A PAGE+=1
CLS
ECHO/
ECHO ================================================================
ECHO/
ECHO                         New Ninja Patch
ECHO/
ECHO  This process will take you through the first steps of creating
ECHO  a new patch from the patch template. It is advised to be fami-
ECHO  liar with the Ninja documentation or have it ready alongside
ECHO  this initialization to resolve any questions. You can find it
ECHO  at ^<http://tiny.cc/GothicNinja^>. You may abort this process at
ECHO  any time by pressing CTRL+C or by closing this command window.
ECHO/
ECHO                            PAGE %PAGE%/%PAGES_MAX%
ECHO/
ECHO ================================================================
ECHO/
ECHO/
EXIT /B 0
