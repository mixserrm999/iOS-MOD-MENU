#!/bin/bash

# ดาวน์โหลดไฟล์ iPhoneOS13.6.sdk.zip
wget https://github.com/xybp888/iOS-SDKs/releases/download/iOS-SDKs/iPhoneOS13.6.sdk.zip -O /tmp/iPhoneOS13.6.sdk.zip

# สร้างโฟลเดอร์ sdks ถ้ายังไม่มี
mkdir -p /home/sermixsummoner/theos/sdks

# แตกไฟล์ zip ไปที่โฟลเดอร์ /home/sermixsummoner/theos/sdks
unzip /tmp/iPhoneOS13.6.sdk.zip -d /home/sermixsummoner/theos/sdks

# ลบไฟล์ zip หลังจากแตกไฟล์เสร็จแล้ว
rm /tmp/iPhoneOS13.6.sdk.zip

echo "Download and extraction complete."
