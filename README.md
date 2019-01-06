revfat+4rpi.sh formerly known as : raspberrypi-reformat
====================
 Script to take an SD card image created by Livemedia-Creator (such as for a
 Raspberry Pi) with an ext4 boot partition.
 
 This will reconfigure the boot partition as vfat and 
 it will take a new bootlabel input and apply it to the fstab on the images rootfs.
 
 To use this script, provide the image name as
 the first argument and the new bootlabel (UPPERCASE 11 char maximum alpha-numeric only) for second arg.
 
 *BOTH args $1 and $2 are mandatory in this configuration to ensure maximum likelyhood of sucessful booting 
 
 
      Use  Example:
      #chmod +x .revfat+4rpi.sh
      #./revfat+4rpi.sh image-name.img RPIBOOTPART

 Requirements 
 
     The actual rpi install image you created with livemedia-creator already! 
     
     * For input: This Script Currently setup to expect a 2 partition layout as follows:
            1:/boot 2:/rootfs  
               If  dont use 2 parts as stated above, in your lmc project, change as you need.
               eg.  change the NR== line in script for 'rootfs' to match actual rootfs part #, in your layout.
           
     Also needed,
      # basic linux tools 
      # bash,blkid,fdisk,kpartx,sed

Historical Credits:
 
    Original revfat Version 1.1 2014-08-27
    Original revfat Authors:
     Andrew Greene,        Seneca College 2013-04-05
      Christopher Markieta, Seneca College 2014-08-27


Recent Version 1.2 revfat+4rpi.sh 2018-01-03 KFlynn

Example Input:
Needs updating, shows older 3 part method, but still valid for example, minus the swap part.

     -bash-4.2# kpartx -avs ./diskSnm4zt.img 
     add map loop0p1 (254:0): 0 1048576 linear /dev/loop0 2048
     add map loop0p2 (254:1): 0 1048576 linear /dev/loop0 1050624
     add map loop0p3 (254:2): 0 8189952 linear /dev/loop0 2099200
     
     -bash-4.2# blkid /dev/mapper/loop0p*
     /dev/mapper/loop0p1: LABEL="boot" UUID="e9155a49-0495-4ca5-9dcf-78c2c193d12e" TYPE="ext4" 
     /dev/mapper/loop0p2: LABEL="swap" UUID="c715ec8e-adb7-4a50-b4ca-b80c37d86fab" TYPE="swap" 
     /dev/mapper/loop0p3: LABEL="rootfs" UUID="8c355f33-3368-43fe-8fd5-eb79ea99f049" TYPE="ext4" 
     
         
     *Note the boot part is a ext4 part, which we will be converting to vfat







Example Output:  

Needs updating, shows older 3 part method, but still valid for example.

     #chmod  +x revfat+4rpi.sh
     
     # ./revfat+4rpi.sh diskSnm4zt.img RPIBOOTPART
     ++ dirname ./revfat+4rpi.sh
     + MY_DIR=.
     ++ id -u
     + '[' 0 -ne 0 ']'
     + '[' -z diskSnm4zt.img ']'
     + '[' -z RPIBOOTPART ']'
     ++ kpartx -avs diskSnm4zt.img
     ++ awk 'NR==1 {print $3}'
     + bootloopdev=loop0p1
     + echo loop0p1
     loop0p1
     + mkdir -v ./temp/
     mkdir: created directory ‘./temp/’
     + mkdir -pv ./tmp/boot/
     mkdir: created directory ‘./tmp’
     mkdir: created directory ‘./tmp/boot/’
     + mount -o rw /dev/mapper/loop0p1 ./temp/
     + cp -rv ./temp/bcm2708-rpi-0-w.dtb ./temp/bcm2708-rpi-b.dtb ./temp/bcm2708-rpi-b-plus.dtb ./temp/bcm2708-rpi-cm.dtb ./temp/bcm2709-rpi-2-b.dtb ./temp/bcm2710-rpi-3-b.dtb ./temp/bcm2710-rpi-3-b-plus.dtb ./temp/bcm2710-rpi-cm3.dtb ./temp/bcm2835-rpi-a.dtb ./temp/bcm2835-rpi-a-plus.dtb ./temp/bcm2835-rpi-b.dtb ./temp/bcm2835-rpi-b-plus.dtb ./temp/bcm2835-rpi-b-rev2.dtb ./temp/bcm2835-rpi-zero.dtb ./temp/bcm2835-rpi-zero-w.dtb ./temp/bcm2836-rpi-2-b.dtb ./temp/bcm2837-rpi-3-b.dtb ./temp/bootcode.bin ./temp/cmdline.txt ./temp/COPYING.linux ./temp/extlinux ./temp/fixup_cd.dat ./temp/fixup.dat ./temp/fixup_db.dat ./temp/fixup_x.dat ./temp/grub ./temp/initramfs-4.14.82-v7.9999.amdev.el7.armv7hl.img ./temp/kernel-4.14.82-v7.9999.amdev.el7.img ./temp/kernel7.img ./temp/LICENCE.broadcom ./temp/lost+found ./temp/overlays ./temp/start_cd.elf ./temp/start_db.elf ./temp/start.elf ./temp/start_x.elf ./tmp/boot/
     ‘./temp/bcm2708-rpi-0-w.dtb’ -> ‘./tmp/boot/bcm2708-rpi-0-w.dtb’
     ‘./temp/bcm2708-rpi-b.dtb’ -> ‘./tmp/boot/bcm2708-rpi-b.dtb’
     ‘./temp/bcm2708-rpi-b-plus.dtb’ -> ‘./tmp/boot/bcm2708-rpi-b-plus.dtb’
     ‘./temp/bcm2708-rpi-cm.dtb’ -> ‘./tmp/boot/bcm2708-rpi-cm.dtb’
     ‘./temp/bcm2709-rpi-2-b.dtb’ -> ‘./tmp/boot/bcm2709-rpi-2-b.dtb’
     ‘./temp/bcm2710-rpi-3-b.dtb’ -> ‘./tmp/boot/bcm2710-rpi-3-b.dtb’
     ‘./temp/bcm2710-rpi-3-b-plus.dtb’ -> ‘./tmp/boot/bcm2710-rpi-3-b-plus.dtb’
     ‘./temp/bcm2710-rpi-cm3.dtb’ -> ‘./tmp/boot/bcm2710-rpi-cm3.dtb’
     ‘./temp/bcm2835-rpi-a.dtb’ -> ‘./tmp/boot/bcm2835-rpi-a.dtb’
     ‘./temp/bcm2835-rpi-a-plus.dtb’ -> ‘./tmp/boot/bcm2835-rpi-a-plus.dtb’
     ‘./temp/bcm2835-rpi-b.dtb’ -> ‘./tmp/boot/bcm2835-rpi-b.dtb’
     ‘./temp/bcm2835-rpi-b-plus.dtb’ -> ‘./tmp/boot/bcm2835-rpi-b-plus.dtb’
     ‘./temp/bcm2835-rpi-b-rev2.dtb’ -> ‘./tmp/boot/bcm2835-rpi-b-rev2.dtb’
     ‘./temp/bcm2835-rpi-zero.dtb’ -> ‘./tmp/boot/bcm2835-rpi-zero.dtb’
     ‘./temp/bcm2835-rpi-zero-w.dtb’ -> ‘./tmp/boot/bcm2835-rpi-zero-w.dtb’
     ‘./temp/bcm2836-rpi-2-b.dtb’ -> ‘./tmp/boot/bcm2836-rpi-2-b.dtb’
     ‘./temp/bcm2837-rpi-3-b.dtb’ -> ‘./tmp/boot/bcm2837-rpi-3-b.dtb’
     ‘./temp/bootcode.bin’ -> ‘./tmp/boot/bootcode.bin’
     ‘./temp/cmdline.txt’ -> ‘./tmp/boot/cmdline.txt’
     ‘./temp/COPYING.linux’ -> ‘./tmp/boot/COPYING.linux’
     ‘./temp/extlinux’ -> ‘./tmp/boot/extlinux’
     ‘./temp/fixup_cd.dat’ -> ‘./tmp/boot/fixup_cd.dat’
     ‘./temp/fixup.dat’ -> ‘./tmp/boot/fixup.dat’
     ‘./temp/fixup_db.dat’ -> ‘./tmp/boot/fixup_db.dat’
     ‘./temp/fixup_x.dat’ -> ‘./tmp/boot/fixup_x.dat’
     ‘./temp/grub’ -> ‘./tmp/boot/grub’
     ‘./temp/grub/splash.xpm.gz’ -> ‘./tmp/boot/grub/splash.xpm.gz’
     ‘./temp/initramfs-4.14.82-v7.9999.amdev.el7.armv7hl.img’ -> ‘./tmp/boot/initramfs-4.14.82-v7.9999.amdev.el7.armv7hl.img’
     ‘./temp/kernel-4.14.82-v7.9999.amdev.el7.img’ -> ‘./tmp/boot/kernel-4.14.82-v7.9999.amdev.el7.img’
     ‘./temp/kernel7.img’ -> ‘./tmp/boot/kernel7.img’
     ‘./temp/LICENCE.broadcom’ -> ‘./tmp/boot/LICENCE.broadcom’
     ‘./temp/lost+found’ -> ‘./tmp/boot/lost+found’
     ‘./temp/overlays’ -> ‘./tmp/boot/overlays’
     ‘./temp/overlays/audioinjector-ultra.dtbo’ -> ‘./tmp/boot/overlays/audioinjector-ultra.dtbo’
     ‘./temp/overlays/gpio-fan.dtbo’ -> ‘./tmp/boot/overlays/gpio-fan.dtbo’
     ‘./temp/overlays/w1-gpio.dtbo’ -> ‘./tmp/boot/overlays/w1-gpio.dtbo’
     ‘./temp/overlays/iqaudio-dac.dtbo’ -> ‘./tmp/boot/overlays/iqaudio-dac.dtbo’
     ‘./temp/overlays/mpu6050.dtbo’ -> ‘./tmp/boot/overlays/mpu6050.dtbo’
     ‘./temp/overlays/sdtweak.dtbo’ -> ‘./tmp/boot/overlays/sdtweak.dtbo’
     ‘./temp/overlays/tinylcd35.dtbo’ -> ‘./tmp/boot/overlays/tinylcd35.dtbo’
     ‘./temp/overlays/gpio-no-bank0-irq.dtbo’ -> ‘./tmp/boot/overlays/gpio-no-bank0-irq.dtbo’
     ‘./temp/overlays/vc4-kms-kippah-7inch.dtbo’ -> ‘./tmp/boot/overlays/vc4-kms-kippah-7inch.dtbo’
     ‘./temp/overlays/i2c1-bcm2708.dtbo’ -> ‘./tmp/boot/overlays/i2c1-bcm2708.dtbo’
     ‘./temp/overlays/qca7000.dtbo’ -> ‘./tmp/boot/overlays/qca7000.dtbo’
     ‘./temp/overlays/hifiberry-digi-pro.dtbo’ -> ‘./tmp/boot/overlays/hifiberry-digi-pro.dtbo’
     ‘./temp/overlays/pitft35-resistive.dtbo’ -> ‘./tmp/boot/overlays/pitft35-resistive.dtbo’
     ‘./temp/overlays/applepi-dac.dtbo’ -> ‘./tmp/boot/overlays/applepi-dac.dtbo’
     ‘./temp/overlays/spi-rtc.dtbo’ -> ‘./tmp/boot/overlays/spi-rtc.dtbo’
     ‘./temp/overlays/hifiberry-amp.dtbo’ -> ‘./tmp/boot/overlays/hifiberry-amp.dtbo’
     ‘./temp/overlays/iqaudio-digi-wm8804-audio.dtbo’ -> ‘./tmp/boot/overlays/iqaudio-digi-wm8804-audio.dtbo’
     ‘./temp/overlays/upstream.dtbo’ -> ‘./tmp/boot/overlays/upstream.dtbo’
     ‘./temp/overlays/pwm-2chan.dtbo’ -> ‘./tmp/boot/overlays/pwm-2chan.dtbo’
     ‘./temp/overlays/dpi24.dtbo’ -> ‘./tmp/boot/overlays/dpi24.dtbo’
     ‘./temp/overlays/iqaudio-dacplus.dtbo’ -> ‘./tmp/boot/overlays/iqaudio-dacplus.dtbo’
     ‘./temp/overlays/jedec-spi-nor.dtbo’ -> ‘./tmp/boot/overlays/jedec-spi-nor.dtbo’
     ‘./temp/overlays/sx150x.dtbo’ -> ‘./tmp/boot/overlays/sx150x.dtbo’
     ‘./temp/overlays/hy28b-2017.dtbo’ -> ‘./tmp/boot/overlays/hy28b-2017.dtbo’
     ‘./temp/overlays/enc28j60-spi2.dtbo’ -> ‘./tmp/boot/overlays/enc28j60-spi2.dtbo’
     ‘./temp/overlays/tc358743-audio.dtbo’ -> ‘./tmp/boot/overlays/tc358743-audio.dtbo’
     ‘./temp/overlays/piscreen2r.dtbo’ -> ‘./tmp/boot/overlays/piscreen2r.dtbo’
     ‘./temp/overlays/googlevoicehat-soundcard.dtbo’ -> ‘./tmp/boot/overlays/googlevoicehat-soundcard.dtbo’
     ‘./temp/overlays/mz61581.dtbo’ -> ‘./tmp/boot/overlays/mz61581.dtbo’
     ‘./temp/overlays/superaudioboard.dtbo’ -> ‘./tmp/boot/overlays/superaudioboard.dtbo’
     ‘./temp/overlays/i2c-rtc-gpio.dtbo’ -> ‘./tmp/boot/overlays/i2c-rtc-gpio.dtbo’
     ‘./temp/overlays/justboom-dac.dtbo’ -> ‘./tmp/boot/overlays/justboom-dac.dtbo’
     ‘./temp/overlays/fe-pi-audio.dtbo’ -> ‘./tmp/boot/overlays/fe-pi-audio.dtbo’
     ‘./temp/overlays/ltc294x.dtbo’ -> ‘./tmp/boot/overlays/ltc294x.dtbo’
     ‘./temp/overlays/hifiberry-dac.dtbo’ -> ‘./tmp/boot/overlays/hifiberry-dac.dtbo’
     ‘./temp/overlays/sc16is750-i2c.dtbo’ -> ‘./tmp/boot/overlays/sc16is750-i2c.dtbo’
     ‘./temp/overlays/gpio-key.dtbo’ -> ‘./tmp/boot/overlays/gpio-key.dtbo’
     ‘./temp/overlays/gpio-ir-tx.dtbo’ -> ‘./tmp/boot/overlays/gpio-ir-tx.dtbo’
     ‘./temp/overlays/audioinjector-addons.dtbo’ -> ‘./tmp/boot/overlays/audioinjector-addons.dtbo’
     ‘./temp/overlays/rpi-ft5406.dtbo’ -> ‘./tmp/boot/overlays/rpi-ft5406.dtbo’
     ‘./temp/overlays/dwc2.dtbo’ -> ‘./tmp/boot/overlays/dwc2.dtbo’
     ‘./temp/overlays/hd44780-lcd.dtbo’ -> ‘./tmp/boot/overlays/hd44780-lcd.dtbo’
     ‘./temp/overlays/pwm-ir-tx.dtbo’ -> ‘./tmp/boot/overlays/pwm-ir-tx.dtbo’
     ‘./temp/overlays/dionaudio-loco.dtbo’ -> ‘./tmp/boot/overlays/dionaudio-loco.dtbo’
     ‘./temp/overlays/goodix.dtbo’ -> ‘./tmp/boot/overlays/goodix.dtbo’
     ‘./temp/overlays/spi1-2cs.dtbo’ -> ‘./tmp/boot/overlays/spi1-2cs.dtbo’
     ‘./temp/overlays/mcp23s17.dtbo’ -> ‘./tmp/boot/overlays/mcp23s17.dtbo’
     ‘./temp/overlays/ads1015.dtbo’ -> ‘./tmp/boot/overlays/ads1015.dtbo’
     ‘./temp/overlays/allo-piano-dac-plus-pcm512x-audio.dtbo’ -> ‘./tmp/boot/overlays/allo-piano-dac-plus-pcm512x-audio.dtbo’
     ‘./temp/overlays/hy28b.dtbo’ -> ‘./tmp/boot/overlays/hy28b.dtbo’
     ‘./temp/overlays/mmc.dtbo’ -> ‘./tmp/boot/overlays/mmc.dtbo’
     ‘./temp/overlays/i2c-pwm-pca9685a.dtbo’ -> ‘./tmp/boot/overlays/i2c-pwm-pca9685a.dtbo’
     ‘./temp/overlays/spi2-3cs.dtbo’ -> ‘./tmp/boot/overlays/spi2-3cs.dtbo’
     ‘./temp/overlays/w1-gpio-pullup.dtbo’ -> ‘./tmp/boot/overlays/w1-gpio-pullup.dtbo’
     ‘./temp/overlays/ads1115.dtbo’ -> ‘./tmp/boot/overlays/ads1115.dtbo’
     ‘./temp/overlays/rpi-poe.dtbo’ -> ‘./tmp/boot/overlays/rpi-poe.dtbo’
     ‘./temp/overlays/pi3-act-led.dtbo’ -> ‘./tmp/boot/overlays/pi3-act-led.dtbo’
     ‘./temp/overlays/rpi-cirrus-wm5102.dtbo’ -> ‘./tmp/boot/overlays/rpi-cirrus-wm5102.dtbo’
     ‘./temp/overlays/spi2-2cs.dtbo’ -> ‘./tmp/boot/overlays/spi2-2cs.dtbo’
     ‘./temp/overlays/smi-dev.dtbo’ -> ‘./tmp/boot/overlays/smi-dev.dtbo’
     ‘./temp/overlays/pitft28-capacitive.dtbo’ -> ‘./tmp/boot/overlays/pitft28-capacitive.dtbo’
     ‘./temp/overlays/hifiberry-digi.dtbo’ -> ‘./tmp/boot/overlays/hifiberry-digi.dtbo’
     ‘./temp/overlays/piscreen.dtbo’ -> ‘./tmp/boot/overlays/piscreen.dtbo’
     ‘./temp/overlays/pi3-miniuart-bt.dtbo’ -> ‘./tmp/boot/overlays/pi3-miniuart-bt.dtbo’
     ‘./temp/overlays/wittypi.dtbo’ -> ‘./tmp/boot/overlays/wittypi.dtbo’
     ‘./temp/overlays/i2c-rtc.dtbo’ -> ‘./tmp/boot/overlays/i2c-rtc.dtbo’
     ‘./temp/overlays/rpi-backlight.dtbo’ -> ‘./tmp/boot/overlays/rpi-backlight.dtbo’
     ‘./temp/overlays/pisound.dtbo’ -> ‘./tmp/boot/overlays/pisound.dtbo’
     ‘./temp/overlays/justboom-digi.dtbo’ -> ‘./tmp/boot/overlays/justboom-digi.dtbo’
     ‘./temp/overlays/rra-digidac1-wm8741-audio.dtbo’ -> ‘./tmp/boot/overlays/rra-digidac1-wm8741-audio.dtbo’
     ‘./temp/overlays/bmp085_i2c-sensor.dtbo’ -> ‘./tmp/boot/overlays/bmp085_i2c-sensor.dtbo’
     ‘./temp/overlays/papirus.dtbo’ -> ‘./tmp/boot/overlays/papirus.dtbo’
     ‘./temp/overlays/i2c-gpio.dtbo’ -> ‘./tmp/boot/overlays/i2c-gpio.dtbo’
     ‘./temp/overlays/allo-katana-dac-audio.dtbo’ -> ‘./tmp/boot/overlays/allo-katana-dac-audio.dtbo’
     ‘./temp/overlays/pi3-disable-wifi.dtbo’ -> ‘./tmp/boot/overlays/pi3-disable-wifi.dtbo’
     ‘./temp/overlays/dpi18.dtbo’ -> ‘./tmp/boot/overlays/dpi18.dtbo’
     ‘./temp/overlays/spi-gpio35-39.dtbo’ -> ‘./tmp/boot/overlays/spi-gpio35-39.dtbo’
     ‘./temp/overlays/gpio-poweroff.dtbo’ -> ‘./tmp/boot/overlays/gpio-poweroff.dtbo’
     ‘./temp/overlays/sdio.dtbo’ -> ‘./tmp/boot/overlays/sdio.dtbo’
     ‘./temp/overlays/gpio-ir.dtbo’ -> ‘./tmp/boot/overlays/gpio-ir.dtbo’
     ‘./temp/overlays/allo-digione.dtbo’ -> ‘./tmp/boot/overlays/allo-digione.dtbo’
     ‘./temp/overlays/gpio-shutdown.dtbo’ -> ‘./tmp/boot/overlays/gpio-shutdown.dtbo’
     ‘./temp/overlays/adau7002-simple.dtbo’ -> ‘./tmp/boot/overlays/adau7002-simple.dtbo’
     ‘./temp/overlays/spi0-hw-cs.dtbo’ -> ‘./tmp/boot/overlays/spi0-hw-cs.dtbo’
     ‘./temp/overlays/pps-gpio.dtbo’ -> ‘./tmp/boot/overlays/pps-gpio.dtbo’
     ‘./temp/overlays/tc358743.dtbo’ -> ‘./tmp/boot/overlays/tc358743.dtbo’
     ‘./temp/overlays/pibell.dtbo’ -> ‘./tmp/boot/overlays/pibell.dtbo’
     ‘./temp/overlays/adv728x-m.dtbo’ -> ‘./tmp/boot/overlays/adv728x-m.dtbo’
     ‘./temp/overlays/mcp23017.dtbo’ -> ‘./tmp/boot/overlays/mcp23017.dtbo’
     ‘./temp/overlays/at86rf233.dtbo’ -> ‘./tmp/boot/overlays/at86rf233.dtbo’
     ‘./temp/overlays/rpi-dac.dtbo’ -> ‘./tmp/boot/overlays/rpi-dac.dtbo’
     ‘./temp/overlays/sdhost.dtbo’ -> ‘./tmp/boot/overlays/sdhost.dtbo’
     ‘./temp/overlays/vc4-kms-v3d.dtbo’ -> ‘./tmp/boot/overlays/vc4-kms-v3d.dtbo’
     ‘./temp/overlays/hy28a.dtbo’ -> ‘./tmp/boot/overlays/hy28a.dtbo’
     ‘./temp/overlays/midi-uart1.dtbo’ -> ‘./tmp/boot/overlays/midi-uart1.dtbo’
     ‘./temp/overlays/pitft28-resistive.dtbo’ -> ‘./tmp/boot/overlays/pitft28-resistive.dtbo’
     ‘./temp/overlays/midi-uart0.dtbo’ -> ‘./tmp/boot/overlays/midi-uart0.dtbo’
     ‘./temp/overlays/i2s-gpio28-31.dtbo’ -> ‘./tmp/boot/overlays/i2s-gpio28-31.dtbo’
     ‘./temp/overlays/audioinjector-wm8731-audio.dtbo’ -> ‘./tmp/boot/overlays/audioinjector-wm8731-audio.dtbo’
     ‘./temp/overlays/sc16is752-spi1.dtbo’ -> ‘./tmp/boot/overlays/sc16is752-spi1.dtbo’
     ‘./temp/overlays/i2c-sensor.dtbo’ -> ‘./tmp/boot/overlays/i2c-sensor.dtbo’
     ‘./temp/overlays/pitft22.dtbo’ -> ‘./tmp/boot/overlays/pitft22.dtbo’
     ‘./temp/overlays/gpio-no-irq.dtbo’ -> ‘./tmp/boot/overlays/gpio-no-irq.dtbo’
     ‘./temp/overlays/audremap.dtbo’ -> ‘./tmp/boot/overlays/audremap.dtbo’
     ‘./temp/overlays/allo-piano-dac-pcm512x-audio.dtbo’ -> ‘./tmp/boot/overlays/allo-piano-dac-pcm512x-audio.dtbo’
     ‘./temp/overlays/dht11.dtbo’ -> ‘./tmp/boot/overlays/dht11.dtbo’
     ‘./temp/overlays/i2c-mux.dtbo’ -> ‘./tmp/boot/overlays/i2c-mux.dtbo’
     ‘./temp/overlays/smi.dtbo’ -> ‘./tmp/boot/overlays/smi.dtbo’
     ‘./temp/overlays/vc4-fkms-v3d.dtbo’ -> ‘./tmp/boot/overlays/vc4-fkms-v3d.dtbo’
     ‘./temp/overlays/balena-fin.dtbo’ -> ‘./tmp/boot/overlays/balena-fin.dtbo’
     ‘./temp/overlays/rotary-encoder.dtbo’ -> ‘./tmp/boot/overlays/rotary-encoder.dtbo’
     ‘./temp/overlays/mcp3202.dtbo’ -> ‘./tmp/boot/overlays/mcp3202.dtbo’
     ‘./temp/overlays/akkordion-iqdacplus.dtbo’ -> ‘./tmp/boot/overlays/akkordion-iqdacplus.dtbo’
     ‘./temp/overlays/uart0.dtbo’ -> ‘./tmp/boot/overlays/uart0.dtbo’
     ‘./temp/overlays/spi0-cs.dtbo’ -> ‘./tmp/boot/overlays/spi0-cs.dtbo’
     ‘./temp/overlays/spi1-1cs.dtbo’ -> ‘./tmp/boot/overlays/spi1-1cs.dtbo’
     ‘./temp/overlays/sc16is752-i2c.dtbo’ -> ‘./tmp/boot/overlays/sc16is752-i2c.dtbo’
     ‘./temp/overlays/dwc-otg.dtbo’ -> ‘./tmp/boot/overlays/dwc-otg.dtbo’
     ‘./temp/overlays/hifiberry-dacplus.dtbo’ -> ‘./tmp/boot/overlays/hifiberry-dacplus.dtbo’
     ‘./temp/overlays/i2c0-bcm2708.dtbo’ -> ‘./tmp/boot/overlays/i2c0-bcm2708.dtbo’
     ‘./temp/overlays/sdio-1bit.dtbo’ -> ‘./tmp/boot/overlays/sdio-1bit.dtbo’
     ‘./temp/overlays/exc3000.dtbo’ -> ‘./tmp/boot/overlays/exc3000.dtbo’
     ‘./temp/overlays/mcp2515-can0.dtbo’ -> ‘./tmp/boot/overlays/mcp2515-can0.dtbo’
     ‘./temp/overlays/rpi-proto.dtbo’ -> ‘./tmp/boot/overlays/rpi-proto.dtbo’
     ‘./temp/overlays/ov5647.dtbo’ -> ‘./tmp/boot/overlays/ov5647.dtbo’
     ‘./temp/overlays/upstream-aux-interrupt.dtbo’ -> ‘./tmp/boot/overlays/upstream-aux-interrupt.dtbo’
     ‘./temp/overlays/i2c-bcm2708.dtbo’ -> ‘./tmp/boot/overlays/i2c-bcm2708.dtbo’
     ‘./temp/overlays/rpi-display.dtbo’ -> ‘./tmp/boot/overlays/rpi-display.dtbo’
     ‘./temp/overlays/vga666.dtbo’ -> ‘./tmp/boot/overlays/vga666.dtbo’
     ‘./temp/overlays/rpi-tv.dtbo’ -> ‘./tmp/boot/overlays/rpi-tv.dtbo’
     ‘./temp/overlays/adv7282m.dtbo’ -> ‘./tmp/boot/overlays/adv7282m.dtbo’
     ‘./temp/overlays/media-center.dtbo’ -> ‘./tmp/boot/overlays/media-center.dtbo’
     ‘./temp/overlays/enc28j60.dtbo’ -> ‘./tmp/boot/overlays/enc28j60.dtbo’
     ‘./temp/overlays/mbed-dac.dtbo’ -> ‘./tmp/boot/overlays/mbed-dac.dtbo’
     ‘./temp/overlays/pwm.dtbo’ -> ‘./tmp/boot/overlays/pwm.dtbo’
     ‘./temp/overlays/smi-nand.dtbo’ -> ‘./tmp/boot/overlays/smi-nand.dtbo’
     ‘./temp/overlays/dionaudio-loco-v2.dtbo’ -> ‘./tmp/boot/overlays/dionaudio-loco-v2.dtbo’
     ‘./temp/overlays/ads7846.dtbo’ -> ‘./tmp/boot/overlays/ads7846.dtbo’
     ‘./temp/overlays/allo-boss-dac-pcm512x-audio.dtbo’ -> ‘./tmp/boot/overlays/allo-boss-dac-pcm512x-audio.dtbo’
     ‘./temp/overlays/mcp2515-can1.dtbo’ -> ‘./tmp/boot/overlays/mcp2515-can1.dtbo’
     ‘./temp/overlays/pi3-disable-bt.dtbo’ -> ‘./tmp/boot/overlays/pi3-disable-bt.dtbo’
     ‘./temp/overlays/mcp3008.dtbo’ -> ‘./tmp/boot/overlays/mcp3008.dtbo’
     ‘./temp/overlays/uart1.dtbo’ -> ‘./tmp/boot/overlays/uart1.dtbo’
     ‘./temp/overlays/rpi-sense.dtbo’ -> ‘./tmp/boot/overlays/rpi-sense.dtbo’
     ‘./temp/overlays/adau1977-adc.dtbo’ -> ‘./tmp/boot/overlays/adau1977-adc.dtbo’
     ‘./temp/overlays/lirc-rpi.dtbo’ -> ‘./tmp/boot/overlays/lirc-rpi.dtbo’
     ‘./temp/overlays/spi1-3cs.dtbo’ -> ‘./tmp/boot/overlays/spi1-3cs.dtbo’
     ‘./temp/overlays/spi2-1cs.dtbo’ -> ‘./tmp/boot/overlays/spi2-1cs.dtbo’
     ‘./temp/start_cd.elf’ -> ‘./tmp/boot/start_cd.elf’
     ‘./temp/start_db.elf’ -> ‘./tmp/boot/start_db.elf’
     ‘./temp/start.elf’ -> ‘./tmp/boot/start.elf’
     ‘./temp/start_x.elf’ -> ‘./tmp/boot/start_x.elf’
     + umount -v ./temp/
     umount: /tmp/DEMO/20180105r2/temp (/dev/mapper/loop0p1) unmounted
     + mkfs -V -t vfat -n RPIBOOTPART /dev/mapper/loop0p1
     mkfs from util-linux 2.23.2
     mkfs.vfat -n RPIBOOTPART /dev/mapper/loop0p1 
     mkfs.fat 3.0.20 (12 Jun 2013)
     unable to get drive geometry, using default 255/63
     + echo 't
     1
     c
     w
     '
     + fdisk diskSnm4zt.img
     Welcome to fdisk (util-linux 2.23.2).
     
     Changes will remain in memory only, until you decide to write them.
     Be careful before using the write command.
     
     
     Command (m for help): Partition number (1-3, default 3): Hex code (type L to list all codes): Changed type of partition 'W95 FAT32 (LBA)' to 'W95 FAT32 (LBA)'
     
     Command (m for help): The partition table has been altered!
     
     Syncing disks.
     + mount -o rw /dev/mapper/loop0p1 ./temp/
     + cp -rv ./tmp/boot/bcm2708-rpi-0-w.dtb ./tmp/boot/bcm2708-rpi-b.dtb ./tmp/boot/bcm2708-rpi-b-plus.dtb ./tmp/boot/bcm2708-rpi-cm.dtb ./tmp/boot/bcm2709-rpi-2-b.dtb ./tmp/boot/bcm2710-rpi-3-b.dtb ./tmp/boot/bcm2710-rpi-3-b-plus.dtb ./tmp/boot/bcm2710-rpi-cm3.dtb ./tmp/boot/bcm2835-rpi-a.dtb ./tmp/boot/bcm2835-rpi-a-plus.dtb ./tmp/boot/bcm2835-rpi-b.dtb ./tmp/boot/bcm2835-rpi-b-plus.dtb ./tmp/boot/bcm2835-rpi-b-rev2.dtb ./tmp/boot/bcm2835-rpi-zero.dtb ./tmp/boot/bcm2835-rpi-zero-w.dtb ./tmp/boot/bcm2836-rpi-2-b.dtb ./tmp/boot/bcm2837-rpi-3-b.dtb ./tmp/boot/bootcode.bin ./tmp/boot/cmdline.txt ./tmp/boot/COPYING.linux ./tmp/boot/extlinux ./tmp/boot/fixup_cd.dat ./tmp/boot/fixup.dat ./tmp/boot/fixup_db.dat ./tmp/boot/fixup_x.dat ./tmp/boot/grub ./tmp/boot/initramfs-4.14.82-v7.9999.amdev.el7.armv7hl.img ./tmp/boot/kernel-4.14.82-v7.9999.amdev.el7.img ./tmp/boot/kernel7.img ./tmp/boot/LICENCE.broadcom ./tmp/boot/lost+found ./tmp/boot/overlays ./tmp/boot/start_cd.elf ./tmp/boot/start_db.elf ./tmp/boot/start.elf ./tmp/boot/start_x.elf ./temp/
     ‘./tmp/boot/bcm2708-rpi-0-w.dtb’ -> ‘./temp/bcm2708-rpi-0-w.dtb’
     ‘./tmp/boot/bcm2708-rpi-b.dtb’ -> ‘./temp/bcm2708-rpi-b.dtb’
     ‘./tmp/boot/bcm2708-rpi-b-plus.dtb’ -> ‘./temp/bcm2708-rpi-b-plus.dtb’
     ‘./tmp/boot/bcm2708-rpi-cm.dtb’ -> ‘./temp/bcm2708-rpi-cm.dtb’
     ‘./tmp/boot/bcm2709-rpi-2-b.dtb’ -> ‘./temp/bcm2709-rpi-2-b.dtb’
     ‘./tmp/boot/bcm2710-rpi-3-b.dtb’ -> ‘./temp/bcm2710-rpi-3-b.dtb’
     ‘./tmp/boot/bcm2710-rpi-3-b-plus.dtb’ -> ‘./temp/bcm2710-rpi-3-b-plus.dtb’
     ‘./tmp/boot/bcm2710-rpi-cm3.dtb’ -> ‘./temp/bcm2710-rpi-cm3.dtb’
     ‘./tmp/boot/bcm2835-rpi-a.dtb’ -> ‘./temp/bcm2835-rpi-a.dtb’
     ‘./tmp/boot/bcm2835-rpi-a-plus.dtb’ -> ‘./temp/bcm2835-rpi-a-plus.dtb’
     ‘./tmp/boot/bcm2835-rpi-b.dtb’ -> ‘./temp/bcm2835-rpi-b.dtb’
     ‘./tmp/boot/bcm2835-rpi-b-plus.dtb’ -> ‘./temp/bcm2835-rpi-b-plus.dtb’
     ‘./tmp/boot/bcm2835-rpi-b-rev2.dtb’ -> ‘./temp/bcm2835-rpi-b-rev2.dtb’
     ‘./tmp/boot/bcm2835-rpi-zero.dtb’ -> ‘./temp/bcm2835-rpi-zero.dtb’
     ‘./tmp/boot/bcm2835-rpi-zero-w.dtb’ -> ‘./temp/bcm2835-rpi-zero-w.dtb’
     ‘./tmp/boot/bcm2836-rpi-2-b.dtb’ -> ‘./temp/bcm2836-rpi-2-b.dtb’
     ‘./tmp/boot/bcm2837-rpi-3-b.dtb’ -> ‘./temp/bcm2837-rpi-3-b.dtb’
     ‘./tmp/boot/bootcode.bin’ -> ‘./temp/bootcode.bin’
     ‘./tmp/boot/cmdline.txt’ -> ‘./temp/cmdline.txt’
     ‘./tmp/boot/COPYING.linux’ -> ‘./temp/COPYING.linux’
     ‘./tmp/boot/extlinux’ -> ‘./temp/extlinux’
     ‘./tmp/boot/fixup_cd.dat’ -> ‘./temp/fixup_cd.dat’
     ‘./tmp/boot/fixup.dat’ -> ‘./temp/fixup.dat’
     ‘./tmp/boot/fixup_db.dat’ -> ‘./temp/fixup_db.dat’
     ‘./tmp/boot/fixup_x.dat’ -> ‘./temp/fixup_x.dat’
     ‘./tmp/boot/grub’ -> ‘./temp/grub’
     ‘./tmp/boot/grub/splash.xpm.gz’ -> ‘./temp/grub/splash.xpm.gz’
     ‘./tmp/boot/initramfs-4.14.82-v7.9999.amdev.el7.armv7hl.img’ -> ‘./temp/initramfs-4.14.82-v7.9999.amdev.el7.armv7hl.img’
     ‘./tmp/boot/kernel-4.14.82-v7.9999.amdev.el7.img’ -> ‘./temp/kernel-4.14.82-v7.9999.amdev.el7.img’
     ‘./tmp/boot/kernel7.img’ -> ‘./temp/kernel7.img’
     ‘./tmp/boot/LICENCE.broadcom’ -> ‘./temp/LICENCE.broadcom’
     ‘./tmp/boot/lost+found’ -> ‘./temp/lost+found’
     ‘./tmp/boot/overlays’ -> ‘./temp/overlays’
     ‘./tmp/boot/overlays/spi2-1cs.dtbo’ -> ‘./temp/overlays/spi2-1cs.dtbo’
     ‘./tmp/boot/overlays/spi1-3cs.dtbo’ -> ‘./temp/overlays/spi1-3cs.dtbo’
     ‘./tmp/boot/overlays/lirc-rpi.dtbo’ -> ‘./temp/overlays/lirc-rpi.dtbo’
     ‘./tmp/boot/overlays/adau1977-adc.dtbo’ -> ‘./temp/overlays/adau1977-adc.dtbo’
     ‘./tmp/boot/overlays/rpi-sense.dtbo’ -> ‘./temp/overlays/rpi-sense.dtbo’
     ‘./tmp/boot/overlays/uart1.dtbo’ -> ‘./temp/overlays/uart1.dtbo’
     ‘./tmp/boot/overlays/mcp3008.dtbo’ -> ‘./temp/overlays/mcp3008.dtbo’
     ‘./tmp/boot/overlays/pi3-disable-bt.dtbo’ -> ‘./temp/overlays/pi3-disable-bt.dtbo’
     ‘./tmp/boot/overlays/mcp2515-can1.dtbo’ -> ‘./temp/overlays/mcp2515-can1.dtbo’
     ‘./tmp/boot/overlays/allo-boss-dac-pcm512x-audio.dtbo’ -> ‘./temp/overlays/allo-boss-dac-pcm512x-audio.dtbo’
     ‘./tmp/boot/overlays/ads7846.dtbo’ -> ‘./temp/overlays/ads7846.dtbo’
     ‘./tmp/boot/overlays/dionaudio-loco-v2.dtbo’ -> ‘./temp/overlays/dionaudio-loco-v2.dtbo’
     ‘./tmp/boot/overlays/smi-nand.dtbo’ -> ‘./temp/overlays/smi-nand.dtbo’
     ‘./tmp/boot/overlays/pwm.dtbo’ -> ‘./temp/overlays/pwm.dtbo’
     ‘./tmp/boot/overlays/mbed-dac.dtbo’ -> ‘./temp/overlays/mbed-dac.dtbo’
     ‘./tmp/boot/overlays/enc28j60.dtbo’ -> ‘./temp/overlays/enc28j60.dtbo’
     ‘./tmp/boot/overlays/media-center.dtbo’ -> ‘./temp/overlays/media-center.dtbo’
     ‘./tmp/boot/overlays/adv7282m.dtbo’ -> ‘./temp/overlays/adv7282m.dtbo’
     ‘./tmp/boot/overlays/rpi-tv.dtbo’ -> ‘./temp/overlays/rpi-tv.dtbo’
     ‘./tmp/boot/overlays/vga666.dtbo’ -> ‘./temp/overlays/vga666.dtbo’
     ‘./tmp/boot/overlays/rpi-display.dtbo’ -> ‘./temp/overlays/rpi-display.dtbo’
     ‘./tmp/boot/overlays/i2c-bcm2708.dtbo’ -> ‘./temp/overlays/i2c-bcm2708.dtbo’
     ‘./tmp/boot/overlays/upstream-aux-interrupt.dtbo’ -> ‘./temp/overlays/upstream-aux-interrupt.dtbo’
     ‘./tmp/boot/overlays/ov5647.dtbo’ -> ‘./temp/overlays/ov5647.dtbo’
     ‘./tmp/boot/overlays/rpi-proto.dtbo’ -> ‘./temp/overlays/rpi-proto.dtbo’
     ‘./tmp/boot/overlays/mcp2515-can0.dtbo’ -> ‘./temp/overlays/mcp2515-can0.dtbo’
     ‘./tmp/boot/overlays/exc3000.dtbo’ -> ‘./temp/overlays/exc3000.dtbo’
     ‘./tmp/boot/overlays/sdio-1bit.dtbo’ -> ‘./temp/overlays/sdio-1bit.dtbo’
     ‘./tmp/boot/overlays/i2c0-bcm2708.dtbo’ -> ‘./temp/overlays/i2c0-bcm2708.dtbo’
     ‘./tmp/boot/overlays/hifiberry-dacplus.dtbo’ -> ‘./temp/overlays/hifiberry-dacplus.dtbo’
     ‘./tmp/boot/overlays/dwc-otg.dtbo’ -> ‘./temp/overlays/dwc-otg.dtbo’
     ‘./tmp/boot/overlays/sc16is752-i2c.dtbo’ -> ‘./temp/overlays/sc16is752-i2c.dtbo’
     ‘./tmp/boot/overlays/spi1-1cs.dtbo’ -> ‘./temp/overlays/spi1-1cs.dtbo’
     ‘./tmp/boot/overlays/spi0-cs.dtbo’ -> ‘./temp/overlays/spi0-cs.dtbo’
     ‘./tmp/boot/overlays/uart0.dtbo’ -> ‘./temp/overlays/uart0.dtbo’
     ‘./tmp/boot/overlays/akkordion-iqdacplus.dtbo’ -> ‘./temp/overlays/akkordion-iqdacplus.dtbo’
     ‘./tmp/boot/overlays/mcp3202.dtbo’ -> ‘./temp/overlays/mcp3202.dtbo’
     ‘./tmp/boot/overlays/rotary-encoder.dtbo’ -> ‘./temp/overlays/rotary-encoder.dtbo’
     ‘./tmp/boot/overlays/balena-fin.dtbo’ -> ‘./temp/overlays/balena-fin.dtbo’
     ‘./tmp/boot/overlays/vc4-fkms-v3d.dtbo’ -> ‘./temp/overlays/vc4-fkms-v3d.dtbo’
     ‘./tmp/boot/overlays/smi.dtbo’ -> ‘./temp/overlays/smi.dtbo’
     ‘./tmp/boot/overlays/i2c-mux.dtbo’ -> ‘./temp/overlays/i2c-mux.dtbo’
     ‘./tmp/boot/overlays/dht11.dtbo’ -> ‘./temp/overlays/dht11.dtbo’
     ‘./tmp/boot/overlays/allo-piano-dac-pcm512x-audio.dtbo’ -> ‘./temp/overlays/allo-piano-dac-pcm512x-audio.dtbo’
     ‘./tmp/boot/overlays/audremap.dtbo’ -> ‘./temp/overlays/audremap.dtbo’
     ‘./tmp/boot/overlays/gpio-no-irq.dtbo’ -> ‘./temp/overlays/gpio-no-irq.dtbo’
     ‘./tmp/boot/overlays/pitft22.dtbo’ -> ‘./temp/overlays/pitft22.dtbo’
     ‘./tmp/boot/overlays/i2c-sensor.dtbo’ -> ‘./temp/overlays/i2c-sensor.dtbo’
     ‘./tmp/boot/overlays/sc16is752-spi1.dtbo’ -> ‘./temp/overlays/sc16is752-spi1.dtbo’
     ‘./tmp/boot/overlays/audioinjector-wm8731-audio.dtbo’ -> ‘./temp/overlays/audioinjector-wm8731-audio.dtbo’
     ‘./tmp/boot/overlays/i2s-gpio28-31.dtbo’ -> ‘./temp/overlays/i2s-gpio28-31.dtbo’
     ‘./tmp/boot/overlays/midi-uart0.dtbo’ -> ‘./temp/overlays/midi-uart0.dtbo’
     ‘./tmp/boot/overlays/pitft28-resistive.dtbo’ -> ‘./temp/overlays/pitft28-resistive.dtbo’
     ‘./tmp/boot/overlays/midi-uart1.dtbo’ -> ‘./temp/overlays/midi-uart1.dtbo’
     ‘./tmp/boot/overlays/hy28a.dtbo’ -> ‘./temp/overlays/hy28a.dtbo’
     ‘./tmp/boot/overlays/vc4-kms-v3d.dtbo’ -> ‘./temp/overlays/vc4-kms-v3d.dtbo’
     ‘./tmp/boot/overlays/sdhost.dtbo’ -> ‘./temp/overlays/sdhost.dtbo’
     ‘./tmp/boot/overlays/rpi-dac.dtbo’ -> ‘./temp/overlays/rpi-dac.dtbo’
     ‘./tmp/boot/overlays/at86rf233.dtbo’ -> ‘./temp/overlays/at86rf233.dtbo’
     ‘./tmp/boot/overlays/mcp23017.dtbo’ -> ‘./temp/overlays/mcp23017.dtbo’
     ‘./tmp/boot/overlays/adv728x-m.dtbo’ -> ‘./temp/overlays/adv728x-m.dtbo’
     ‘./tmp/boot/overlays/pibell.dtbo’ -> ‘./temp/overlays/pibell.dtbo’
     ‘./tmp/boot/overlays/tc358743.dtbo’ -> ‘./temp/overlays/tc358743.dtbo’
     ‘./tmp/boot/overlays/pps-gpio.dtbo’ -> ‘./temp/overlays/pps-gpio.dtbo’
     ‘./tmp/boot/overlays/spi0-hw-cs.dtbo’ -> ‘./temp/overlays/spi0-hw-cs.dtbo’
     ‘./tmp/boot/overlays/adau7002-simple.dtbo’ -> ‘./temp/overlays/adau7002-simple.dtbo’
     ‘./tmp/boot/overlays/gpio-shutdown.dtbo’ -> ‘./temp/overlays/gpio-shutdown.dtbo’
     ‘./tmp/boot/overlays/allo-digione.dtbo’ -> ‘./temp/overlays/allo-digione.dtbo’
     ‘./tmp/boot/overlays/gpio-ir.dtbo’ -> ‘./temp/overlays/gpio-ir.dtbo’
     ‘./tmp/boot/overlays/sdio.dtbo’ -> ‘./temp/overlays/sdio.dtbo’
     ‘./tmp/boot/overlays/gpio-poweroff.dtbo’ -> ‘./temp/overlays/gpio-poweroff.dtbo’
     ‘./tmp/boot/overlays/spi-gpio35-39.dtbo’ -> ‘./temp/overlays/spi-gpio35-39.dtbo’
     ‘./tmp/boot/overlays/dpi18.dtbo’ -> ‘./temp/overlays/dpi18.dtbo’
     ‘./tmp/boot/overlays/pi3-disable-wifi.dtbo’ -> ‘./temp/overlays/pi3-disable-wifi.dtbo’
     ‘./tmp/boot/overlays/allo-katana-dac-audio.dtbo’ -> ‘./temp/overlays/allo-katana-dac-audio.dtbo’
     ‘./tmp/boot/overlays/i2c-gpio.dtbo’ -> ‘./temp/overlays/i2c-gpio.dtbo’
     ‘./tmp/boot/overlays/papirus.dtbo’ -> ‘./temp/overlays/papirus.dtbo’
     ‘./tmp/boot/overlays/bmp085_i2c-sensor.dtbo’ -> ‘./temp/overlays/bmp085_i2c-sensor.dtbo’
     ‘./tmp/boot/overlays/rra-digidac1-wm8741-audio.dtbo’ -> ‘./temp/overlays/rra-digidac1-wm8741-audio.dtbo’
     ‘./tmp/boot/overlays/justboom-digi.dtbo’ -> ‘./temp/overlays/justboom-digi.dtbo’
     ‘./tmp/boot/overlays/pisound.dtbo’ -> ‘./temp/overlays/pisound.dtbo’
     ‘./tmp/boot/overlays/rpi-backlight.dtbo’ -> ‘./temp/overlays/rpi-backlight.dtbo’
     ‘./tmp/boot/overlays/i2c-rtc.dtbo’ -> ‘./temp/overlays/i2c-rtc.dtbo’
     ‘./tmp/boot/overlays/wittypi.dtbo’ -> ‘./temp/overlays/wittypi.dtbo’
     ‘./tmp/boot/overlays/pi3-miniuart-bt.dtbo’ -> ‘./temp/overlays/pi3-miniuart-bt.dtbo’
     ‘./tmp/boot/overlays/piscreen.dtbo’ -> ‘./temp/overlays/piscreen.dtbo’
     ‘./tmp/boot/overlays/hifiberry-digi.dtbo’ -> ‘./temp/overlays/hifiberry-digi.dtbo’
     ‘./tmp/boot/overlays/pitft28-capacitive.dtbo’ -> ‘./temp/overlays/pitft28-capacitive.dtbo’
     ‘./tmp/boot/overlays/smi-dev.dtbo’ -> ‘./temp/overlays/smi-dev.dtbo’
     ‘./tmp/boot/overlays/spi2-2cs.dtbo’ -> ‘./temp/overlays/spi2-2cs.dtbo’
     ‘./tmp/boot/overlays/rpi-cirrus-wm5102.dtbo’ -> ‘./temp/overlays/rpi-cirrus-wm5102.dtbo’
     ‘./tmp/boot/overlays/pi3-act-led.dtbo’ -> ‘./temp/overlays/pi3-act-led.dtbo’
     ‘./tmp/boot/overlays/rpi-poe.dtbo’ -> ‘./temp/overlays/rpi-poe.dtbo’
     ‘./tmp/boot/overlays/ads1115.dtbo’ -> ‘./temp/overlays/ads1115.dtbo’
     ‘./tmp/boot/overlays/w1-gpio-pullup.dtbo’ -> ‘./temp/overlays/w1-gpio-pullup.dtbo’
     ‘./tmp/boot/overlays/spi2-3cs.dtbo’ -> ‘./temp/overlays/spi2-3cs.dtbo’
     ‘./tmp/boot/overlays/i2c-pwm-pca9685a.dtbo’ -> ‘./temp/overlays/i2c-pwm-pca9685a.dtbo’
     ‘./tmp/boot/overlays/mmc.dtbo’ -> ‘./temp/overlays/mmc.dtbo’
     ‘./tmp/boot/overlays/hy28b.dtbo’ -> ‘./temp/overlays/hy28b.dtbo’
     ‘./tmp/boot/overlays/allo-piano-dac-plus-pcm512x-audio.dtbo’ -> ‘./temp/overlays/allo-piano-dac-plus-pcm512x-audio.dtbo’
     ‘./tmp/boot/overlays/ads1015.dtbo’ -> ‘./temp/overlays/ads1015.dtbo’
     ‘./tmp/boot/overlays/mcp23s17.dtbo’ -> ‘./temp/overlays/mcp23s17.dtbo’
     ‘./tmp/boot/overlays/spi1-2cs.dtbo’ -> ‘./temp/overlays/spi1-2cs.dtbo’
     ‘./tmp/boot/overlays/goodix.dtbo’ -> ‘./temp/overlays/goodix.dtbo’
     ‘./tmp/boot/overlays/dionaudio-loco.dtbo’ -> ‘./temp/overlays/dionaudio-loco.dtbo’
     ‘./tmp/boot/overlays/pwm-ir-tx.dtbo’ -> ‘./temp/overlays/pwm-ir-tx.dtbo’
     ‘./tmp/boot/overlays/hd44780-lcd.dtbo’ -> ‘./temp/overlays/hd44780-lcd.dtbo’
     ‘./tmp/boot/overlays/dwc2.dtbo’ -> ‘./temp/overlays/dwc2.dtbo’
     ‘./tmp/boot/overlays/rpi-ft5406.dtbo’ -> ‘./temp/overlays/rpi-ft5406.dtbo’
     ‘./tmp/boot/overlays/audioinjector-addons.dtbo’ -> ‘./temp/overlays/audioinjector-addons.dtbo’
     ‘./tmp/boot/overlays/gpio-ir-tx.dtbo’ -> ‘./temp/overlays/gpio-ir-tx.dtbo’
     ‘./tmp/boot/overlays/gpio-key.dtbo’ -> ‘./temp/overlays/gpio-key.dtbo’
     ‘./tmp/boot/overlays/sc16is750-i2c.dtbo’ -> ‘./temp/overlays/sc16is750-i2c.dtbo’
     ‘./tmp/boot/overlays/hifiberry-dac.dtbo’ -> ‘./temp/overlays/hifiberry-dac.dtbo’
     ‘./tmp/boot/overlays/ltc294x.dtbo’ -> ‘./temp/overlays/ltc294x.dtbo’
     ‘./tmp/boot/overlays/fe-pi-audio.dtbo’ -> ‘./temp/overlays/fe-pi-audio.dtbo’
     ‘./tmp/boot/overlays/justboom-dac.dtbo’ -> ‘./temp/overlays/justboom-dac.dtbo’
     ‘./tmp/boot/overlays/i2c-rtc-gpio.dtbo’ -> ‘./temp/overlays/i2c-rtc-gpio.dtbo’
     ‘./tmp/boot/overlays/superaudioboard.dtbo’ -> ‘./temp/overlays/superaudioboard.dtbo’
     ‘./tmp/boot/overlays/mz61581.dtbo’ -> ‘./temp/overlays/mz61581.dtbo’
     ‘./tmp/boot/overlays/googlevoicehat-soundcard.dtbo’ -> ‘./temp/overlays/googlevoicehat-soundcard.dtbo’
     ‘./tmp/boot/overlays/piscreen2r.dtbo’ -> ‘./temp/overlays/piscreen2r.dtbo’
     ‘./tmp/boot/overlays/tc358743-audio.dtbo’ -> ‘./temp/overlays/tc358743-audio.dtbo’
     ‘./tmp/boot/overlays/enc28j60-spi2.dtbo’ -> ‘./temp/overlays/enc28j60-spi2.dtbo’
     ‘./tmp/boot/overlays/hy28b-2017.dtbo’ -> ‘./temp/overlays/hy28b-2017.dtbo’
     ‘./tmp/boot/overlays/sx150x.dtbo’ -> ‘./temp/overlays/sx150x.dtbo’
     ‘./tmp/boot/overlays/jedec-spi-nor.dtbo’ -> ‘./temp/overlays/jedec-spi-nor.dtbo’
     ‘./tmp/boot/overlays/iqaudio-dacplus.dtbo’ -> ‘./temp/overlays/iqaudio-dacplus.dtbo’
     ‘./tmp/boot/overlays/dpi24.dtbo’ -> ‘./temp/overlays/dpi24.dtbo’
     ‘./tmp/boot/overlays/pwm-2chan.dtbo’ -> ‘./temp/overlays/pwm-2chan.dtbo’
     ‘./tmp/boot/overlays/upstream.dtbo’ -> ‘./temp/overlays/upstream.dtbo’
     ‘./tmp/boot/overlays/iqaudio-digi-wm8804-audio.dtbo’ -> ‘./temp/overlays/iqaudio-digi-wm8804-audio.dtbo’
     ‘./tmp/boot/overlays/hifiberry-amp.dtbo’ -> ‘./temp/overlays/hifiberry-amp.dtbo’
     ‘./tmp/boot/overlays/spi-rtc.dtbo’ -> ‘./temp/overlays/spi-rtc.dtbo’
     ‘./tmp/boot/overlays/applepi-dac.dtbo’ -> ‘./temp/overlays/applepi-dac.dtbo’
     ‘./tmp/boot/overlays/pitft35-resistive.dtbo’ -> ‘./temp/overlays/pitft35-resistive.dtbo’
     ‘./tmp/boot/overlays/hifiberry-digi-pro.dtbo’ -> ‘./temp/overlays/hifiberry-digi-pro.dtbo’
     ‘./tmp/boot/overlays/qca7000.dtbo’ -> ‘./temp/overlays/qca7000.dtbo’
     ‘./tmp/boot/overlays/i2c1-bcm2708.dtbo’ -> ‘./temp/overlays/i2c1-bcm2708.dtbo’
     ‘./tmp/boot/overlays/vc4-kms-kippah-7inch.dtbo’ -> ‘./temp/overlays/vc4-kms-kippah-7inch.dtbo’
     ‘./tmp/boot/overlays/gpio-no-bank0-irq.dtbo’ -> ‘./temp/overlays/gpio-no-bank0-irq.dtbo’
     ‘./tmp/boot/overlays/tinylcd35.dtbo’ -> ‘./temp/overlays/tinylcd35.dtbo’
     ‘./tmp/boot/overlays/sdtweak.dtbo’ -> ‘./temp/overlays/sdtweak.dtbo’
     ‘./tmp/boot/overlays/mpu6050.dtbo’ -> ‘./temp/overlays/mpu6050.dtbo’
     ‘./tmp/boot/overlays/iqaudio-dac.dtbo’ -> ‘./temp/overlays/iqaudio-dac.dtbo’
     ‘./tmp/boot/overlays/w1-gpio.dtbo’ -> ‘./temp/overlays/w1-gpio.dtbo’
     ‘./tmp/boot/overlays/gpio-fan.dtbo’ -> ‘./temp/overlays/gpio-fan.dtbo’
     ‘./tmp/boot/overlays/audioinjector-ultra.dtbo’ -> ‘./temp/overlays/audioinjector-ultra.dtbo’
     ‘./tmp/boot/start_cd.elf’ -> ‘./temp/start_cd.elf’
     ‘./tmp/boot/start_db.elf’ -> ‘./temp/start_db.elf’
     ‘./tmp/boot/start.elf’ -> ‘./temp/start.elf’
     ‘./tmp/boot/start_x.elf’ -> ‘./temp/start_x.elf’
     + umount ./temp/
     + kpartx -dv diskSnm4zt.img
     del devmap : loop0p3
     del devmap : loop0p2
     del devmap : loop0p1
     loop deleted : /dev/loop0
     + rmdir -v ./temp/
     rmdir: removing directory, ‘./temp/’
     + rm -rfv ./tmp/
     removed ‘./tmp/boot/start_x.elf’
     removed ‘./tmp/boot/start.elf’
     removed ‘./tmp/boot/start_db.elf’
     removed ‘./tmp/boot/start_cd.elf’
     removed ‘./tmp/boot/overlays/spi2-1cs.dtbo’
     removed ‘./tmp/boot/overlays/spi1-3cs.dtbo’
     removed ‘./tmp/boot/overlays/lirc-rpi.dtbo’
     removed ‘./tmp/boot/overlays/adau1977-adc.dtbo’
     removed ‘./tmp/boot/overlays/rpi-sense.dtbo’
     removed ‘./tmp/boot/overlays/uart1.dtbo’
     removed ‘./tmp/boot/overlays/mcp3008.dtbo’
     removed ‘./tmp/boot/overlays/pi3-disable-bt.dtbo’
     removed ‘./tmp/boot/overlays/mcp2515-can1.dtbo’
     removed ‘./tmp/boot/overlays/allo-boss-dac-pcm512x-audio.dtbo’
     removed ‘./tmp/boot/overlays/ads7846.dtbo’
     removed ‘./tmp/boot/overlays/dionaudio-loco-v2.dtbo’
     removed ‘./tmp/boot/overlays/smi-nand.dtbo’
     removed ‘./tmp/boot/overlays/pwm.dtbo’
     removed ‘./tmp/boot/overlays/mbed-dac.dtbo’
     removed ‘./tmp/boot/overlays/enc28j60.dtbo’
     removed ‘./tmp/boot/overlays/media-center.dtbo’
     removed ‘./tmp/boot/overlays/adv7282m.dtbo’
     removed ‘./tmp/boot/overlays/rpi-tv.dtbo’
     removed ‘./tmp/boot/overlays/vga666.dtbo’
     removed ‘./tmp/boot/overlays/rpi-display.dtbo’
     removed ‘./tmp/boot/overlays/i2c-bcm2708.dtbo’
     removed ‘./tmp/boot/overlays/upstream-aux-interrupt.dtbo’
     removed ‘./tmp/boot/overlays/ov5647.dtbo’
     removed ‘./tmp/boot/overlays/rpi-proto.dtbo’
     removed ‘./tmp/boot/overlays/mcp2515-can0.dtbo’
     removed ‘./tmp/boot/overlays/exc3000.dtbo’
     removed ‘./tmp/boot/overlays/sdio-1bit.dtbo’
     removed ‘./tmp/boot/overlays/i2c0-bcm2708.dtbo’
     removed ‘./tmp/boot/overlays/hifiberry-dacplus.dtbo’
     removed ‘./tmp/boot/overlays/dwc-otg.dtbo’
     removed ‘./tmp/boot/overlays/sc16is752-i2c.dtbo’
     removed ‘./tmp/boot/overlays/spi1-1cs.dtbo’
     removed ‘./tmp/boot/overlays/spi0-cs.dtbo’
     removed ‘./tmp/boot/overlays/uart0.dtbo’
     removed ‘./tmp/boot/overlays/akkordion-iqdacplus.dtbo’
     removed ‘./tmp/boot/overlays/mcp3202.dtbo’
     removed ‘./tmp/boot/overlays/rotary-encoder.dtbo’
     removed ‘./tmp/boot/overlays/balena-fin.dtbo’
     removed ‘./tmp/boot/overlays/vc4-fkms-v3d.dtbo’
     removed ‘./tmp/boot/overlays/smi.dtbo’
     removed ‘./tmp/boot/overlays/i2c-mux.dtbo’
     removed ‘./tmp/boot/overlays/dht11.dtbo’
     removed ‘./tmp/boot/overlays/allo-piano-dac-pcm512x-audio.dtbo’
     removed ‘./tmp/boot/overlays/audremap.dtbo’
     removed ‘./tmp/boot/overlays/gpio-no-irq.dtbo’
     removed ‘./tmp/boot/overlays/pitft22.dtbo’
     removed ‘./tmp/boot/overlays/i2c-sensor.dtbo’
     removed ‘./tmp/boot/overlays/sc16is752-spi1.dtbo’
     removed ‘./tmp/boot/overlays/audioinjector-wm8731-audio.dtbo’
     removed ‘./tmp/boot/overlays/i2s-gpio28-31.dtbo’
     removed ‘./tmp/boot/overlays/midi-uart0.dtbo’
     removed ‘./tmp/boot/overlays/pitft28-resistive.dtbo’
     removed ‘./tmp/boot/overlays/midi-uart1.dtbo’
     removed ‘./tmp/boot/overlays/hy28a.dtbo’
     removed ‘./tmp/boot/overlays/vc4-kms-v3d.dtbo’
     removed ‘./tmp/boot/overlays/sdhost.dtbo’
     removed ‘./tmp/boot/overlays/rpi-dac.dtbo’
     removed ‘./tmp/boot/overlays/at86rf233.dtbo’
     removed ‘./tmp/boot/overlays/mcp23017.dtbo’
     removed ‘./tmp/boot/overlays/adv728x-m.dtbo’
     removed ‘./tmp/boot/overlays/pibell.dtbo’
     removed ‘./tmp/boot/overlays/tc358743.dtbo’
     removed ‘./tmp/boot/overlays/pps-gpio.dtbo’
     removed ‘./tmp/boot/overlays/spi0-hw-cs.dtbo’
     removed ‘./tmp/boot/overlays/adau7002-simple.dtbo’
     removed ‘./tmp/boot/overlays/gpio-shutdown.dtbo’
     removed ‘./tmp/boot/overlays/allo-digione.dtbo’
     removed ‘./tmp/boot/overlays/gpio-ir.dtbo’
     removed ‘./tmp/boot/overlays/sdio.dtbo’
     removed ‘./tmp/boot/overlays/gpio-poweroff.dtbo’
     removed ‘./tmp/boot/overlays/spi-gpio35-39.dtbo’
     removed ‘./tmp/boot/overlays/dpi18.dtbo’
     removed ‘./tmp/boot/overlays/pi3-disable-wifi.dtbo’
     removed ‘./tmp/boot/overlays/allo-katana-dac-audio.dtbo’
     removed ‘./tmp/boot/overlays/i2c-gpio.dtbo’
     removed ‘./tmp/boot/overlays/papirus.dtbo’
     removed ‘./tmp/boot/overlays/bmp085_i2c-sensor.dtbo’
     removed ‘./tmp/boot/overlays/rra-digidac1-wm8741-audio.dtbo’
     removed ‘./tmp/boot/overlays/justboom-digi.dtbo’
     removed ‘./tmp/boot/overlays/pisound.dtbo’
     removed ‘./tmp/boot/overlays/rpi-backlight.dtbo’
     removed ‘./tmp/boot/overlays/i2c-rtc.dtbo’
     removed ‘./tmp/boot/overlays/wittypi.dtbo’
     removed ‘./tmp/boot/overlays/pi3-miniuart-bt.dtbo’
     removed ‘./tmp/boot/overlays/piscreen.dtbo’
     removed ‘./tmp/boot/overlays/hifiberry-digi.dtbo’
     removed ‘./tmp/boot/overlays/pitft28-capacitive.dtbo’
     removed ‘./tmp/boot/overlays/smi-dev.dtbo’
     removed ‘./tmp/boot/overlays/spi2-2cs.dtbo’
     removed ‘./tmp/boot/overlays/rpi-cirrus-wm5102.dtbo’
     removed ‘./tmp/boot/overlays/pi3-act-led.dtbo’
     removed ‘./tmp/boot/overlays/rpi-poe.dtbo’
     removed ‘./tmp/boot/overlays/ads1115.dtbo’
     removed ‘./tmp/boot/overlays/w1-gpio-pullup.dtbo’
     removed ‘./tmp/boot/overlays/spi2-3cs.dtbo’
     removed ‘./tmp/boot/overlays/i2c-pwm-pca9685a.dtbo’
     removed ‘./tmp/boot/overlays/mmc.dtbo’
     removed ‘./tmp/boot/overlays/hy28b.dtbo’
     removed ‘./tmp/boot/overlays/allo-piano-dac-plus-pcm512x-audio.dtbo’
     removed ‘./tmp/boot/overlays/ads1015.dtbo’
     removed ‘./tmp/boot/overlays/mcp23s17.dtbo’
     removed ‘./tmp/boot/overlays/spi1-2cs.dtbo’
     removed ‘./tmp/boot/overlays/goodix.dtbo’
     removed ‘./tmp/boot/overlays/dionaudio-loco.dtbo’
     removed ‘./tmp/boot/overlays/pwm-ir-tx.dtbo’
     removed ‘./tmp/boot/overlays/hd44780-lcd.dtbo’
     removed ‘./tmp/boot/overlays/dwc2.dtbo’
     removed ‘./tmp/boot/overlays/rpi-ft5406.dtbo’
     removed ‘./tmp/boot/overlays/audioinjector-addons.dtbo’
     removed ‘./tmp/boot/overlays/gpio-ir-tx.dtbo’
     removed ‘./tmp/boot/overlays/gpio-key.dtbo’
     removed ‘./tmp/boot/overlays/sc16is750-i2c.dtbo’
     removed ‘./tmp/boot/overlays/hifiberry-dac.dtbo’
     removed ‘./tmp/boot/overlays/ltc294x.dtbo’
     removed ‘./tmp/boot/overlays/fe-pi-audio.dtbo’
     removed ‘./tmp/boot/overlays/justboom-dac.dtbo’
     removed ‘./tmp/boot/overlays/i2c-rtc-gpio.dtbo’
     removed ‘./tmp/boot/overlays/superaudioboard.dtbo’
     removed ‘./tmp/boot/overlays/mz61581.dtbo’
     removed ‘./tmp/boot/overlays/googlevoicehat-soundcard.dtbo’
     removed ‘./tmp/boot/overlays/piscreen2r.dtbo’
     removed ‘./tmp/boot/overlays/tc358743-audio.dtbo’
     removed ‘./tmp/boot/overlays/enc28j60-spi2.dtbo’
     removed ‘./tmp/boot/overlays/hy28b-2017.dtbo’
     removed ‘./tmp/boot/overlays/sx150x.dtbo’
     removed ‘./tmp/boot/overlays/jedec-spi-nor.dtbo’
     removed ‘./tmp/boot/overlays/iqaudio-dacplus.dtbo’
     removed ‘./tmp/boot/overlays/dpi24.dtbo’
     removed ‘./tmp/boot/overlays/pwm-2chan.dtbo’
     removed ‘./tmp/boot/overlays/upstream.dtbo’
     removed ‘./tmp/boot/overlays/iqaudio-digi-wm8804-audio.dtbo’
     removed ‘./tmp/boot/overlays/hifiberry-amp.dtbo’
     removed ‘./tmp/boot/overlays/spi-rtc.dtbo’
     removed ‘./tmp/boot/overlays/applepi-dac.dtbo’
     removed ‘./tmp/boot/overlays/pitft35-resistive.dtbo’
     removed ‘./tmp/boot/overlays/hifiberry-digi-pro.dtbo’
     removed ‘./tmp/boot/overlays/qca7000.dtbo’
     removed ‘./tmp/boot/overlays/i2c1-bcm2708.dtbo’
     removed ‘./tmp/boot/overlays/vc4-kms-kippah-7inch.dtbo’
     removed ‘./tmp/boot/overlays/gpio-no-bank0-irq.dtbo’
     removed ‘./tmp/boot/overlays/tinylcd35.dtbo’
     removed ‘./tmp/boot/overlays/sdtweak.dtbo’
     removed ‘./tmp/boot/overlays/mpu6050.dtbo’
     removed ‘./tmp/boot/overlays/iqaudio-dac.dtbo’
     removed ‘./tmp/boot/overlays/w1-gpio.dtbo’
     removed ‘./tmp/boot/overlays/gpio-fan.dtbo’
     removed ‘./tmp/boot/overlays/audioinjector-ultra.dtbo’
     removed directory: ‘./tmp/boot/overlays’
     removed directory: ‘./tmp/boot/lost+found’
     removed ‘./tmp/boot/LICENCE.broadcom’
     removed ‘./tmp/boot/kernel7.img’
     removed ‘./tmp/boot/kernel-4.14.82-v7.9999.amdev.el7.img’
     removed ‘./tmp/boot/initramfs-4.14.82-v7.9999.amdev.el7.armv7hl.img’
     removed ‘./tmp/boot/grub/splash.xpm.gz’
     removed directory: ‘./tmp/boot/grub’
     removed ‘./tmp/boot/fixup_x.dat’
     removed ‘./tmp/boot/fixup_db.dat’
     removed ‘./tmp/boot/fixup.dat’
     removed ‘./tmp/boot/fixup_cd.dat’
     removed directory: ‘./tmp/boot/extlinux’
     removed ‘./tmp/boot/COPYING.linux’
     removed ‘./tmp/boot/cmdline.txt’
     removed ‘./tmp/boot/bootcode.bin’
     removed ‘./tmp/boot/bcm2837-rpi-3-b.dtb’
     removed ‘./tmp/boot/bcm2836-rpi-2-b.dtb’
     removed ‘./tmp/boot/bcm2835-rpi-zero-w.dtb’
     removed ‘./tmp/boot/bcm2835-rpi-zero.dtb’
     removed ‘./tmp/boot/bcm2835-rpi-b-rev2.dtb’
     removed ‘./tmp/boot/bcm2835-rpi-b-plus.dtb’
     removed ‘./tmp/boot/bcm2835-rpi-b.dtb’
     removed ‘./tmp/boot/bcm2835-rpi-a-plus.dtb’
     removed ‘./tmp/boot/bcm2835-rpi-a.dtb’
     removed ‘./tmp/boot/bcm2710-rpi-cm3.dtb’
     removed ‘./tmp/boot/bcm2710-rpi-3-b-plus.dtb’
     removed ‘./tmp/boot/bcm2710-rpi-3-b.dtb’
     removed ‘./tmp/boot/bcm2709-rpi-2-b.dtb’
     removed ‘./tmp/boot/bcm2708-rpi-cm.dtb’
     removed ‘./tmp/boot/bcm2708-rpi-b-plus.dtb’
     removed ‘./tmp/boot/bcm2708-rpi-b.dtb’
     removed ‘./tmp/boot/bcm2708-rpi-0-w.dtb’
     removed directory: ‘./tmp/boot’
     removed directory: ‘./tmp/’
     ++ kpartx -avs diskSnm4zt.img
     ++ awk 'NR==3 {print $3}'
     + rootfsloopdev=loop0p3
     + echo loop0p3
     loop0p3
     + mkdir -pv ./tmp/rootfs/
     mkdir: created directory ‘./tmp’
     mkdir: created directory ‘./tmp/rootfs/’
     + mount -o rw /dev/mapper/loop0p3 ./tmp/rootfs/
     + sed -i '\/boot/d' ./tmp/rootfs/etc/fstab
     + echo 'removing old /boot entries if any from fstab'
     removing old /boot entries if any from fstab
     + echo 'LABEL=RPIBOOTPART          /boot		vfat	defaults,noatime	0 0'
     + echo ...
     ...
     + echo 'Using RPIBOOTPART as bootlabel name for image rootfs /etc/fstab'
     Using RPIBOOTPART as bootlabel name for image rootfs /etc/fstab
     + echo ...
     ...
     + sleep 3
     + echo ...
     ...
     + echo ...
     ...
     + echo ...
     ...
     + echo 'printing final fstab contents before umount of rootfs:'
     printing final fstab contents before umount of rootfs:
     + cat ./tmp/rootfs/etc/fstab
     
     #
     # /etc/fstab
     # Created by anaconda on Sun Jan  6 04:49:56 2019
     #
     # Accessible filesystems, by reference, are maintained under '/dev/disk'
     # See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info
     #
     UUID=8c355f33-3368-43fe-8fd5-eb79ea99f049 /                       ext4    defaults        1 1
     UUID=c715ec8e-adb7-4a50-b4ca-b80c37d86fab swap                    swap    defaults        0 0
     LABEL=RPIBOOTPART          /boot		vfat	defaults,noatime	0 0
     + sleep 3
     + echo ...
     ...
     + echo ...
     ...
     + echo ...
     ...
     + umount -v ./tmp/rootfs
     umount: /tmp/DEMO/20180105r2/tmp/rootfs (/dev/mapper/loop0p3) unmounted
     + sleep 1
     + kpartx -dv diskSnm4zt.img
     del devmap : loop0p3
     del devmap : loop0p2
     del devmap : loop0p1
     loop deleted : /dev/loop0
     + rm -rfv ./tmp
     removed directory: ‘./tmp/rootfs’
     removed directory: ‘./tmp’
     + echo ...
     ...
     + echo 'Showing our resultant device mapper blkid output'
     Showing our resultant device mapper blkid output
     + echo ...
     ...
     + kpartx -avs diskSnm4zt.img
     add map loop0p1 (253:0): 0 1048576 linear /dev/loop0 2048
     add map loop0p2 (253:1): 0 1048576 linear /dev/loop0 1050624
     add map loop0p3 (253:2): 0 8189952 linear /dev/loop0 2099200
     + sleep 1
     + blkid /dev/mapper/loop0p1
     /dev/mapper/loop0p1: SEC_TYPE="msdos" LABEL="RPIBOOTPART" UUID="8115-F922" TYPE="vfat" 
     + blkid /dev/mapper/loop0p2
     /dev/mapper/loop0p2: LABEL="swap" UUID="c715ec8e-adb7-4a50-b4ca-b80c37d86fab" TYPE="swap" 
     + blkid /dev/mapper/loop0p3
     /dev/mapper/loop0p3: LABEL="rootfs" UUID="8c355f33-3368-43fe-8fd5-eb79ea99f049" TYPE="ext4" 
     + echo ...
     ...
     + echo 'All done!'
     All done!
     + echo ...
     ...
     + sleep 1
     + kpartx -dv diskSnm4zt.img
     del devmap : loop0p3
     del devmap : loop0p2
     del devmap : loop0p1
     loop deleted : /dev/loop0
     + exit 0



