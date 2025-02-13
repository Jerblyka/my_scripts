@echo off
title Instalador do Windows via DISM
cls
echo ========================================
echo  INSTALLER DO WINDOWS - MODO MBR
echo ========================================
echo.

:: Criando um arquivo temporario para listar os discos
echo list disk > listdisk.txt

:: Executando o diskpart para mostrar os discos
diskpart /s listdisk.txt

:: Excluindo o arquivo temporario
del listdisk.txt

:: Solicitando o numero do disco
set /p disknum="Digite o numero do disco de destino (ex: 0, 1, 2): "

:: Verifica se o numero do disco e valido
set /a check=%disknum%+0 2>nul
if %errorlevel% neq 0 (
    echo ERRO: Numero de disco invalido!
    pause
    exit /b
)

:: Confirmacao antes de apagar o disco
set /p confirm="Tem certeza que deseja formatar o disco %disknum%? (S/N): "
if /I not "%confirm%"=="S" (
    echo Operacao cancelada pelo usuario.
    exit /b
)

:: Criando script para o diskpart
echo select disk %disknum% > diskpart.txt
echo clean >> diskpart.txt
echo create partition primary >> diskpart.txt
echo format fs=ntfs quick >> diskpart.txt
echo active >> diskpart.txt
echo assign letter=C >> diskpart.txt

:: Executando o diskpart
diskpart /s diskpart.txt
del diskpart.txt
cls
echo Disco formatado e preparado com sucesso!
echo.

:: Procurando automaticamente a unidade da ISO do Windows
for %%D in (D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist %%D:\sources\install.wim set winiso=%%D:\sources
    if exist %%D:\sources\install.esd set winiso=%%D:\sources
)

:: Se nao encontrar, exibe erro e sai
if "%winiso%"=="" (
    echo ERRO: Nenhuma imagem install.wim ou install.esd encontrada!
    pause
    exit /b
)

:: Listando os indices disponiveis no WIM
dism /get-wiminfo /wimfile:%winiso%\install.wim
set /p index="Digite o indice da edicao do Windows a instalar (ex: 1, 2, 3): "

:: Verifica se o indice digitado e um numero
set /a check=%index%+0 2>nul
if %errorlevel% neq 0 (
    echo ERRO: O indice deve ser um numero!
    pause
    exit /b
)

:: Aplicando a imagem do Windows na particao C:
echo ========================================
echo  APLICANDO A IMAGEM DO WINDOWS...
echo ========================================
dism /apply-image /imagefile:%winiso%\install.wim /index:%index% /applydir:C:\ /progress

:: Configurando o Bootloader para MBR
echo ========================================
echo  CONFIGURANDO O BOOTLOADER...
echo ========================================
bcdboot C:\Windows /s C: /f BIOS
bootsect /nt60 C: /mbr

:: Concluido
echo.
echo ========================================
echo  INSTALACAO FINALIZADA COM SUCESSO!
echo ========================================
echo O sistema sera reiniciado em 10 segundos...
timeout /t 10 /nobreak
shutdown /r /t 0
