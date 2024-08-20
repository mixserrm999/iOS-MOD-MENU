#!/bin/bash

# เพิ่ม alias ลงใน .bashrc
echo "alias deletefile='rm /home/sermixsummoner/SERMIX /home/sermixsummoner/theos/vendor/templates/SERMIX.MOD.MENU.v0.1.0.nic.tar'" >> ~/.bashrc
# รีโหลด .bashrc เพื่อให้ alias ใช้งานได้ทันที
source ~/.bashrc

echo "Alias 'deletefile' ได้ถูกเพิ่มและ .bashrc ได้ถูกรีโหลดแล้ว."
