#!/bin/bash

# เพิ่ม alias ลงใน .bashrc
echo "alias d='rm /home/sermixsummoner/theos/vendor/templates/SERMIX.MOD.MENU.v0.1.0.nic.tar'" >> ~/.bashrc
echo "alias dd='rm -r /home/sermixsummoner/SERMIX'" >> ~/.bashrc
echo "alias t='$THEOS/bin/nic.pl'" >> ~/.bashrc

# แจ้งเตือนให้รัน source ~/.bashrc
echo "Alias 'd' และ 'dd' ได้ถูกเพิ่มลงใน .bashrc แล้ว."
echo "กรุณารัน 'source ~/.bashrc' หรือเปิด shell ใหม่เพื่อให้ alias มีผล."
