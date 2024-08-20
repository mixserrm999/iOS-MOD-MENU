#!/bin/bash

# กำหนดพาธที่เก็บไฟล์และ URL ของไฟล์ที่ต้องการดาวน์โหลด
DOWNLOAD_URL="https://github.com/xybp888/iOS-SDKs/releases/download/iOS-SDKs/iPhoneOS13.6.sdk.zip"
DEST_DIR="/home/sermixsummoner/theos/sdks"
ZIP_FILE="${DEST_DIR}/iPhoneOS13.6.sdk.zip"
EXTRACTED_DIR="${DEST_DIR}/iPhoneOS13.6.sdk"

# สร้างไดเรกทอรีปลายทางถ้ายังไม่มี
mkdir -p "$DEST_DIR"

# ดาวน์โหลดไฟล์
wget -O "$ZIP_FILE" "$DOWNLOAD_URL"

# ตรวจสอบการดาวน์โหลด
if [ $? -ne 0 ]; then
    echo "Error downloading the file."
    exit 1
fi

# แตกไฟล์ zip
unzip -o "$ZIP_FILE" -d "$DEST_DIR"

# ตรวจสอบการแตกไฟล์
if [ $? -ne 0 ]; then
    echo "Error extracting the file."
    exit 1
fi

# เปลี่ยนชื่อไดเรกทอรีที่แตกไฟล์
mv "${DEST_DIR}/iPhoneOS13.6.sdk" "$EXTRACTED_DIR"

# ตรวจสอบการเปลี่ยนชื่อ
if [ $? -eq 0 ]; then
    echo "File downloaded and extracted successfully."
else
    echo "Error renaming the directory."
    exit 1
fi

# ลบไฟล์ zip ถ้าต้องการ
rm "$ZIP_FILE"

