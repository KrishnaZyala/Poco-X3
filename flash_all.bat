fastboot %* getvar product 2>&1 | findstr /r /c:"^product: *karna" || fastboot %* getvar product 2>&1 | findstr /r /c:"^product: *surya" || echo Missmatching image and device
fastboot %* getvar product 2>&1 | findstr /r /c:"^product: *karna" || fastboot %* getvar product 2>&1 | findstr /r /c:"^product: *surya" || exit /B 1
set CURRENT_ANTI_VER=2
for /f "tokens=2 delims=: " %%i in ('fastboot %* getvar anti 2^>^&1 ^| findstr /r /c:"anti:"')  do (set version=%%i)
if [%version%] EQU [] set version=0
if %version% GTR %CURRENT_ANTI_VER% (
        echo current device antirollback version is greater than this package
        exit /B 1
)

fastboot %* erase boot || @echo "Erase boot error" && exit /B 1
fastboot %* flash crclist %~dp0images\crclist.txt || @echo "Flash crclist error" && exit /B 1
fastboot %* flash sparsecrclist %~dp0images\sparsecrclist.txt || @echo "Flash sparsecrclist error" && exit /B 1
fastboot %* flash xbl %~dp0images\xbl.elf || @echo "Flash xbl error" && exit /B 1
fastboot %* flash xblbak %~dp0images\xbl.elf || @echo "Flash xblbak error" && exit /B 1
fastboot %* flash xbl_config %~dp0images\xbl_config.elf || @echo "Flash xbl_config error" && exit /B 1
fastboot %* flash xbl_configbak %~dp0images\xbl_config.elf || @echo "Flash xbl_config error" && exit /B 1
fastboot %* flash imagefv %~dp0images\imagefv.elf || @echo "Flash imagefv error" && exit /B 1
fastboot %* flash imagefvbak %~dp0images\imagefv.elf || @echo "Flash imagefvbak error" && exit /B 1
fastboot %* flash aop %~dp0images\aop.mbn || @echo "Flash aop error" && exit /B 1
fastboot %* flash aopbak %~dp0images\aop.mbn || @echo "Flash aopbak error" && exit /B 1

fastboot %* flash uefisecapp %~dp0images\uefi_sec.mbn || @echo "Flash uefisecapp error" && exit /B 1
fastboot %* flash uefisecappbak %~dp0images\uefi_sec.mbn || @echo "Flash uefisecappbak error" && exit /B 1
fastboot %* flash qupfw %~dp0images\qupv3fw.elf || @echo "Flash qupfw error" && exit /B 1

fastboot %* flash metadata %~dp0images\metadata.img || @echo "Flash xbl error" && exit /B 1
fastboot %* flash tz %~dp0images\tz.mbn || @echo "Flash tz error" && exit /B 1
fastboot %* flash tzbak %~dp0images\tz.mbn || @echo "Flash tzbak error" && exit /B 1


fastboot %* flash hyp %~dp0images\hyp.mbn || @echo "Flash hyp error" && exit /B 1
fastboot %* flash hypbak %~dp0images\hyp.mbn || @echo "Flash hypbak error" && exit /B 1


fastboot %* flash keymaster %~dp0images\km4.mbn || @echo "Flash keymaster error" && exit /B 1
fastboot %* flash keymasterbak %~dp0images\km4.mbn || @echo "Flash keymasterbak error" && exit /B 1
fastboot %* flash cmnlib %~dp0images\cmnlib.mbn || @echo "Flash cmnlib error" && exit /B 1
fastboot %* flash cmnlibbak %~dp0images\cmnlib.mbn || @echo "Flash cmnlib error" && exit /B 1
fastboot %* flash cmnlib64 %~dp0images\cmnlib64.mbn || @echo "Flash cmnlib64 error" && exit /B 1
fastboot %* flash cmnlib64bak %~dp0images\cmnlib64.mbn || @echo "Flash cmnlib64 error" && exit /B 1


fastboot %* flash modem %~dp0images\NON-HLOS.bin || @echo "Flash modem error" && exit /B 1
fastboot %* flash dsp %~dp0images\dspso.bin || @echo "Flash dsp error" && exit /B 1

fastboot %* flash bluetooth %~dp0images\BTFM.bin || @echo "Flash bluetooth error" && exit /B 1

fastboot %* flash storsec %~dp0images\storsec.mbn || @echo "Flash storsec error" && exit /B 1

fastboot %* flash devcfg %~dp0images\devcfg.mbn || @echo "Flash devcfg error" && exit /B 1

fastboot %* flash abl %~dp0images\abl.elf || @echo "Flash abl error" && exit /B 1
fastboot %* flash ablbak %~dp0images\abl.elf || @echo "Flash ablbak error" && exit /B 1

fastboot %* flash dtbo %~dp0images\dtbo.img || @echo "Flash dtbo error" && exit /B 1

fastboot %* flash vbmeta %~dp0images\vbmeta.img || @echo "Flash vbmeta error" && exit /B 1

fastboot %* flash boot %~dp0images\boot.img || @echo "Flash boot error" && exit /B 1
fastboot %* flash recovery %~dp0images\recovery.img || @echo "Flash recovery error" && exit /B 1

fastboot %* flash super %~dp0images\super.img || @echo "Flash super error" && exit /B 1
fastboot %* flash userdata %~dp0images\userdata.img || @echo "Flash userdata error" && exit /B 1
fastboot %* flash vbmeta_system %~dp0images\vbmeta_system.img || @echo "Flash vbmeta_system error" && exit /B 1

fastboot %* flash ffu %~dp0images\ffu.img || @echo "Flash ffu error" && exit /B 1

fastboot %* flash cache %~dp0images\cache.img || @echo "Flash cache error" && exit /B 1

fastboot %* erase misc
fastboot %* erase apdp
fastboot %* erase multiimgoem

fastboot reboot bootloader
fastboot flash recovery .\twrp.img
fastboot reboot recovery