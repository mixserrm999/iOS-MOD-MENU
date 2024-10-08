#import "Macros.h"
#include "Vector3.h"
#import "include.h"
%hook FP_CameraLook

- (void)SetRecoil:(Vector3)KPGOEACPIFF {
    // ปรับ recoil ตามที่ต้องการ
    KPGOEACPIFF.X *= 2;
    KPGOEACPIFF.Y *= 2;
    KPGOEACPIFF.Z *= 2;

    // แสดงข้อมูล recoil บนหน้าจอด้วย ImGui
    ImGui::Begin("Recoil Info");
    ImGui::Text("SetRecoil Hooked:");
    ImGui::Text("X: %f", KPGOEACPIFF.X);
    ImGui::Text("Y: %f", KPGOEACPIFF.Y);
    ImGui::Text("Z: %f", KPGOEACPIFF.Z);
    ImGui::End();

    %orig(KPGOEACPIFF);
}

%end

/***********************************************************
  INSIDE THE FUNCTION BELOW YOU'LL HAVE TO ADD YOUR SWITCHES!
***********************************************************/
void setup() {
  /*
  //patching offsets directly, without switch
  patchOffset(ENCRYPTOFFSET("0x1002DB3C8"), ENCRYPTHEX("0xC0035FD6"));
  patchOffset(ENCRYPTOFFSET("0x10020D2D4"), ENCRYPTHEX("0x00008052C0035FD6"));

  // You can write as many bytes as you want to an offset
  patchOffset(ENCRYPTOFFSET("0x10020D3A8"), ENCRYPTHEX("0x00F0271E0008201EC0035FD6"));
  // or  
  patchOffset(ENCRYPTOFFSET("0x10020D3A8"), ENCRYPTHEX("00F0271E0008201EC0035FD6"));
  // spaces are fine too
  patchOffset(ENCRYPTOFFSET("0x10020D3A8"), ENCRYPTHEX("00 F0 27 1E 00 08 20 1E C0 03 5F D6"));
  */

  // Empty switch - usefull with hooking
  /*
  [switches addSwitch:NSSENCRYPT("TEST")
    description:NSSENCRYPT("TWST")
  ];

  [switches addSwitch:NSSENCRYPT("TEST2")
    description:NSSENCRYPT("TEST2")
  ];
  */
  

  // Offset Switch with one patch
  [switches addOffsetSwitch:NSSENCRYPT("CalcRecoilPattern") // 
    description:NSSENCRYPT("mov_w0_#0")
    offsets: {
      ENCRYPTOFFSET("0x1DFE60C")
    }
    bytes: {
      ENCRYPTHEX("00 00 A0 E3 1E FF 2F E1") // mov w0 #0
    }
  ];

  [switches addOffsetSwitch:NSSENCRYPT("CalcRecoilPattern")
    description:NSSENCRYPT("ret")
    offsets: {
      ENCRYPTOFFSET("0x1DFE60C")
    }
    bytes: {
      ENCRYPTHEX("C0 03 5F D6") // ret
    }
  ];

  [switches addOffsetSwitch:NSSENCRYPT("CalcRecoilPattern")
    description:NSSENCRYPT("NOP")
    offsets: {
      ENCRYPTOFFSET("0x1DFE60C")
    }
    bytes: {
      ENCRYPTHEX("1F 20 03 D5") // NOP
    }
  ];

  [switches addOffsetSwitch:NSSENCRYPT("CalcSpreadPattern")
    description:NSSENCRYPT("mov_w0_#0")
    offsets: {
      ENCRYPTOFFSET("0x1DFE828")
    }
    bytes: {
      ENCRYPTHEX("00 00 A0 E3 1E FF 2F E1") // mov s0 #0
    }
  ];

  [switches addOffsetSwitch:NSSENCRYPT("CalcSpreadPattern")
    description:NSSENCRYPT("ret")
    offsets: {
      ENCRYPTOFFSET("0x1DFE828")
    }
    bytes: {
      ENCRYPTHEX("C0 03 5F D6") // ret
    }
  ];

  [switches addOffsetSwitch:NSSENCRYPT("CalcSpreadPattern")
    description:NSSENCRYPT("NOP")
    offsets: {
      ENCRYPTOFFSET("0x1DFE828")
    }
    bytes: {
      ENCRYPTHEX("1F 20 03 D5") // NOP
    }
  ];

  [switches addOffsetSwitch:NSSENCRYPT("CalcRecoilPattern_shooter")
    description:NSSENCRYPT("mov_w0_#0")
    offsets: {
      ENCRYPTOFFSET("0x1DE09E4")
    }
    bytes: {
      ENCRYPTHEX("00 00 A0 E3 1E FF 2F E1") // mov s0 #0
    }
  ];

  [switches addOffsetSwitch:NSSENCRYPT("CalcRecoilPattern_shooter")
    description:NSSENCRYPT("ret")
    offsets: {
      ENCRYPTOFFSET("0x1DE09E4")
    }
    bytes: {
      ENCRYPTHEX("C0 03 5F D6") // ret
    }
  ];

  [switches addOffsetSwitch:NSSENCRYPT("CalcRecoilPattern_shooter")
    description:NSSENCRYPT("NOP")
    offsets: {
      ENCRYPTOFFSET("0x1DE09E4")
    }
    bytes: {
      ENCRYPTHEX("1F 20 03 D5") // NOP
    }
  ];

  [switches addOffsetSwitch:NSSENCRYPT("CalcSpreadPattern_shooter")
    description:NSSENCRYPT("mov_w0_#0")
    offsets: {
      ENCRYPTOFFSET("0x1DE0A28")
    }
    bytes: {
      ENCRYPTHEX("00 00 A0 E3 1E FF 2F E1") // mov s0 #0
    }
  ];

  [switches addOffsetSwitch:NSSENCRYPT("CalcSpreadPattern_shooter")
    description:NSSENCRYPT("ret")
    offsets: {
      ENCRYPTOFFSET("0x1DE0A28")
    }
    bytes: {
      ENCRYPTHEX("C0 03 5F D6") // ret
    }
  ];

  [switches addOffsetSwitch:NSSENCRYPT("CalcSpreadPattern_shooter")
    description:NSSENCRYPT("NOP")
    offsets: {
      ENCRYPTOFFSET("0x1DE0A28")
    }
    bytes: {
      ENCRYPTHEX("1F 20 03 D5") // NOP
    }
  ];

  [switches addOffsetSwitch:NSSENCRYPT("show")
    description:NSSENCRYPT("0000000000000000")
    offsets: {
      ENCRYPTOFFSET("0x1DF5090")
    }
    bytes: {
      ENCRYPTHEX("20 00 80 52 C0 03 5F D6") // mov w0 #1
    }
  ];
  /*
  [switches addOffsetSwitch:NSSENCRYPT(" percent attack")
    description:NSSENCRYPT("0000000000000000")
    offsets: {
      ENCRYPTOFFSET("0x1710530")
    }
    bytes: {
      ENCRYPTHEX("00 90 26 1E 01 90 22 1E 02 08 21 1E C0 03 5F D6") // float 100
    }
  ];
  [switches addOffsetSwitch:NSSENCRYPT("add percent atk")
    description:NSSENCRYPT("0000000000000000")
    offsets: {
      ENCRYPTOFFSET("0x1744544")
    }
    bytes: {
      ENCRYPTHEX("00 90 66 1E 01 90 66 1E 02 90 66 1E 03 08 61 1E 44 08 63 1E C0 03 5F D6") // double 8000
    }
  ];
  [switches addOffsetSwitch:NSSENCRYPT("health recovery")
    description:NSSENCRYPT("0000000000000000")
    offsets: {
      ENCRYPTOFFSET("0x1740F60")
    }
    bytes: {
      ENCRYPTHEX("00 90 66 1E 01 90 66 1E 02 90 66 1E 03 08 61 1E 44 08 63 1E C0 03 5F D6") // double 8000
    }
  ];
  [switches addOffsetSwitch:NSSENCRYPT("move_speed_non_buff")
    description:NSSENCRYPT("0000000000000000")
    offsets: {
      ENCRYPTOFFSET("0x16FC3E4")
    }
    bytes: {
      ENCRYPTHEX("00 90 22 1E C0 03 5F D6")
    }
  ];
  */

  // show and copy //
  /*

  [switches addOffsetSwitch:NSSENCRYPT("00000000000000")
    description:NSSENCRYPT("0000000000000000")
    offsets: {
      ENCRYPTOFFSET("00000000000000000")
    }
    bytes: {
      ENCRYPTHEX("0000000000000000000000")
    }
  ];

  */

  // Offset switch with multiple patches
  /*

  [switches addOffsetSwitch:NSSENCRYPT("No Recoil")
    description:NSSENCRYPT("Remove Animation fireRate / camera")
    offsets: {
      ENCRYPTOFFSET("0x211CF38"),
      ENCRYPTOFFSET("0x2106854"),
      ENCRYPTOFFSET("0x210243C")
    }
    bytes: {
      ENCRYPTHEX("00008052C0035FD6"),
      ENCRYPTHEX("E003271EC0035FD6"),
      ENCRYPTHEX("E003271EC0035FD6")
    }
  ];

  */

  /*

  // Textfield Switch - used in hooking
  [switches addTextfieldSwitch:NSSENCRYPT("Custom Gold")
    description:NSSENCRYPT("Here you can enter your own gold amount")
    inputBorderColor:UIColorFromHex(0xBD0000)
  ];

  // Slider Switch - used in hooking
  [switches addSliderSwitch:NSSENCRYPT("Custom Move Speed")
    description:NSSENCRYPT("Set your custom move speed")
    minimumValue:0
    maximumValue:10
    sliderColor:UIColorFromHex(0xBD0000)
  ];

  */
}


/**********************************************************************************************************
     You can customize the menu here
     For colors, you can use hex color codes or UIColor itself
      - For the hex color #BD0000 you'd use: UIColorFromHex(0xBD0000)
      - For UIColor you can visit this site: https://www.uicolor.xyz/#/rgb-to-ui
        NOTE: remove the ";" when you copy your UIColor from there!
     
     Site to find your perfect font for the menu: http://iosfonts.com/  --> view on mac or ios device
     See comment next to maxVisibleSwitches!!!!!

     menuIcon & menuButton is base64 data, upload a image to: https://www.browserling.com/tools/image-to-base64 \
     then replace that string with mine.
************************************************************************************************************/
void setupMenu() {

  // If a game uses a framework as base executable, you can enter the name here.
  // For example: UnityFramework, in that case you have to replace NULL with "UnityFramework" (note the quotes)
  [menu setFrameworkName:"UnityFramework"];

  menu = [[Menu alloc]  
            initWithTitle:NSSENCRYPT("@@APPNAME@@ - Mod Menu")
            titleColor:[UIColor whiteColor]
            titleFont:NSSENCRYPT("Copperplate-Bold")
            credits:NSSENCRYPT("This Mod Menu has been made by @@USER@@, do not share this without proper credits and my permission. \n\nEnjoy!")
            headerColor:UIColorFromHex(0x000000)
            switchOffColor:[UIColor darkGrayColor]
            switchOnColor:UIColorFromHex(0x00F500)
            switchTitleFont:NSSENCRYPT("Copperplate-Bold")
            switchTitleColor:[UIColor whiteColor]
            infoButtonColor:UIColorFromHex(0xBD0000)
            maxVisibleSwitches:4 // Less than max -> blank space, more than max -> you can scroll!
            menuWidth:400
            menuIcon:@"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"
            menuButton:@"iVBORw0KGgoAAAANSUhEUgAAAIAAAACACAYAAADDPmHLAAAACXBIWXMAAAs/AAALPwFJxTL7AAAAGXRFWHRTb2Z0d2FyZQB3d3cuaW5rc2NhcGUub3Jnm+48GgAAIABJREFUeJztXXl4VNXZ/73nziQhCwQCuFQFW9RCMsMS6i4mmQEEZRG9E9BabWux2trWVm3rUqPWtna3tv3q+rlUJZkiklAsmIQouJYEyAK41a22KrJmT+ae9/tj5i4zc2cyk8wE8OP3PPM899x7lnfmvvOec97tAEdwBEfw/xd0sAn4LKNoztLjhca3MfG7LbVVdwHgg01TJMTBJuCzDJLydmZ+jBkTXLPVWQebHjsc1gyQu21NUe62NUUHm45YIOB9AF8G4GZN/Ptg02OHw3YKyHv16QLpVG4Ck2Ti33XNWPSfg02THVwe9YwAa//ZUf/0ewebls8cchurfblNq5cebDoOCTATuCJpiX7YSoAjMDGurSq3qzfzdkD0Oinwy33TL9yXaFuH3U23Z+k5zPJOJvw3c1/+Vxob7+9PHblHkGp09WR9A0THAsz9EFcD+HmibW1FBkN+P+AMLBPAJ31j9p6ZMkoPA6iqqrhL1YXuOeWH7OIyEp0H8u4Fyw8A/m9nrvO3ybSNwQC8xtHveIrBM9HtbE4NmYcHduwVtzNRCQf4jy6v6jrY9CQIBzmUx0jQw9ivKUk1tLvZWud/6JSzFla5j83s8vuf1FJD42EC5tFM/AJABUQYc7DJSQilpT0dQOtgmh5ZBEZg+jx1XKCPbmOi11trK+892PQcwREcwREcwRGkCUmtGFOBqd6l08eeWHj8rnfa/jvcYx9BNIZ1EVjk8T1KwMUAiJifbZ5VqKKiQqZ6nOnz1HH9/UohQTuWpBjP4EwAAHE/CB2k4SMGPmTh+Hdr3VMfp3r8wwnDxgBF3vLJxLyFtMAkZHAfa843mcW81voVLw2178lzlxzj1JyzmXkOgFkAjk+ieQ+A94i5TQqxQzBaIeWW5g3+14dK1+EAWz1AOqAwNAkIzaEIBQEAALMcNAMWlpZPFYIvAngRAuRi8GD7ygJwChOdQsxBjw1BKPL4PgXwMhG/xFJ5obV+xcs4BB06horhngIeoKB9PABCfUtt1WIk8aMWetQpgsVlIFYBfCFOVQ3A6yC8C8YugHoBzgEhAwAgMR5ExwN8HBC6NwAI9B4zniIHnmheXzkopcuhiGFXBLm8qkuyyGqrq9yMBF7+tJLF+dLhXCaZriDg1BjVJICtBKyTJNZnjuh8rbGmpisBcmjy3CVHO/odJzEwhQQVgmURQDMB5MZp908w3dZSX/lsAmMc0jhkNYFTSy8qlEK5FkGJkWNTpZ+BesH0Nzj6qpvXr/okVWOXlJQ49jqOdkmWZzJwNgEXwIYhGNhEjJtb6qteSNXYYCYQDdtUc8gxQFFZ+RyCvBFEZYimjwFsBNMj6FOeadn05N7hoKl4wYLs/q7shRJ8CQHnAXBGVHlU0fq+t7XhmYTt8JHIaap5SIO4Q2GtorN44VeHRnHiOFQYgFwe3yIANwH4ks3zD4nwIEN7rKV25b+GmbYwuOeoJ7JGtyEomSx6FPoXSC5uqfW3JNtndtPqmSBMJ6armOgvLLm1u3jhK6mjOjYOOgO4ysrngfjnAKZGP+WNYHFvxv5RzxxqTinuUvUUFvR7BCWCjnaCOL+5bsXGZPrK3lwzA0JOIxLLGfIh1ri5e+biV1NLsT0OGgMUesq/pIDvZqA04pEE8DQx/by5vrLpYNCWBMjtVa9nprtgTgsdAM9pqfO/nExHuVuq79OI7hAa//QzPQUUeZYdRdDuBvCViPEDIDxOGt99uClhXB71DIBqABSEbn1EWuBLzQ1PH5Ku4FYMGwOUlJQ4PlXGX0PA7QDyLY8YhL+Rxrcebi/eiqnepdMly3qEvhsxXmyeNWVWOlTdqcSwMEDQtYr+F4ziiEcvsBA/aH1uxebhoCPdKPKq5xNTNQxXO/5BS50/KR+94UZaGaCkpMSx2zH+R2DcinCN2wcMvqG1zl+ZzvEHi8IS9WhF4Osk8Py2Wv+mZNq6Pb57GPhOqNgRcARO3rHu6UPW8pm20LBCVc3YrYx/AYw7Yb78AAh3k5I5OZmXX+T1fc1d5tvk9pQPSxCIUOgxJvqpZKov9JTbbUtjwkn8EwAfhYq5zoDzztRTmDqkTQK4Pep5DLKoSnkLsbgy2ZW921t+OjNvQnDP3UNK/wQ7rZ+7VF3Igu4DsD0ju3tBgqpgWxR5fP8gYC4AgPBWX3fPjNdfrG5Pov2XCXg8VOxnRXyhdf2KDwZLTzqRNgnAIGs8waoCbdepyb78QlXNYJYPwlS4ZLHm+KbteALXATgaQFlfV/bvBkW03hf4+wC6QoVJGVlZSTmHttZVPQHgn6GiU2jyu0OhZyhwedSfFHl81VNLLyq0e56+6GBmgwEIWN3Q0BBItgtlt7gGoAjC6ZuFqmpnweu2DL68yOvzJTuejrY6/3Zm/MBy63KXV70kiS6YCb82CsDyaSWL8+M1SAfcpUtPY9DxDP6RFIrtVBSXAXKb1o5DVZWS27R2XDIDq6qqgMi03ElOWq15ylkL8xh8k82jY8RucWnkTQbtt5aJ8Wf3nAvHJzuujtb6qr8AeMYcgP48rWTpxETbjw188jSAd0PFvICS8fXB0jJYEGn/JmCqYLqNTYkUhtgMsGFDFnPgr7mTshYzB6J+8HjYvg8uAHmh4p7mDf43kmkPAM6srOUgBBmPsYuAP+jPiHDbpHnzMq31BSHSEFPAgYwhTQX96L8SwIeh4ihN0Z4oKSlJyImmoaEhQEz3GDSDh027p2Nbvf9D6eDzmJS7WuuqbOMFYzJATn7HtSB8wMDtTJSb17jmnEQHVqQw53/CK0jWk6aiQhBwtUkl/7YP/XcAaAcABk/I7h15tbUJS4q2xBFfMtXrm5vU2BbsrFu1WwKXIaieBkBn7laOujXR9ppTPgagN9S20FWqRupB0o62df49rXVPxQzvi8kAGgJ+AG8S8DKYnkWgb3uigzLzNLOApMW/64Udc2F6/Ozp6+790866VbuZyJACkvjmL3ouLDBbsa0pVjL+FCktkkFbXdUGAu62jHNzolvDtnX+PQys0csk6CuDpSNdiMkAPfvyPyLGSJL0GwHtjPbTluxOuFeCGVlLlHRwKZG8xigwHtW3YD1Oxy8B/Dc4BMY6kfFrSyMrA7wM45+HL4zoy/1WsjRY4dyXfxvMOVQRkA8WFy+P9AmwhZD8mH7NjGWqqg67K348xF4DlJb2dBQvvLl95oKdHcWL/phEnwSYDCADsi0Zggq96gkMmqeXWdAD+vVbzz5xAKAbzNp8ucvr84YGNReBhL0A7jHLdEvhXHXQgZ6Njff3C6l9FUBfqEN33+h9P0ykrfPA6GcB7AnRNW77p3T6YOlIB1K+DZxWsnQCzAVgV1tJYVIOHIoUS2Ds+/ml1trKHdbnLXWVTwLcECoSGPcHt1jSlADM+RnEPws6hAJgjBYaJTx322HbhpVtRJbEC4xbirzlkwdq19h4fz8I6/QyKSZzHwpIOQMEFLYkVuDtyVrDmOQi/ZpY+O2qQJFXA+gMlU/UlIyHQcIyBVB+Y61/Pwm+zdLqGnfJkuOSoSUS2mj+GdgIw84Ukh9AxcB5eQj0D/1aMJ8/FBpSjZQzgCBp/CsYlPDCEQCCizo6W28uHbTSrl7L+pU7CbDO6xcy8xWWcj4AjAnsegCALkEyWHFelww9kWjz+/uIxZUIup2DCWe5Xmi7ZoBmkCzWIbQTYmBqkWfZUUOhI5VIOQMw0wSzgCjxX6iqGS6Pb43L43uvyKuG/RsyKON86MEqhKZ4+vPmuqpHATxqubXccp0PBPfiAN1loe4bQ1kLAEDzhhWvgmCqhol+VuhVT4jXJhh+xlv1FoK1WO7tw46UMwCBJ1iuo3Lj0V5aDOB8ACcQU1XR7KUz9WeS2WNUlPTcgGMpmd8CWF9kWg1b2bq6+Itj5AoQ3grdzxMBGtKOAABIZN4C4B29T4XFLwdsQ2T4+HHs+IZhR+olAEwJIImiGYBRZilmk5Srp5apnwMAMsU/SKHagcZqXv94p6IpFwCIShKZ0YFRAOD3+zUA5gtiXHvGGeqIxL5N7HEJbIh+Bs8faFvIgGEIY7L1fD4oSIcxyGAAQVoUAzCoLOLWsVLQ6sISdRLAnw/d07R+LSGv2K0NK94lheYaK359nIA0jC8ZI7qfgGUr1jmCFif2VWKj+ZzC9TC3nnl9+XtnxqtPkhqN66Dr+0H3yAZSzADFXnUUgJGhIsvR4flxi0uWjSXwSaGiBl3FyigWilXkc1tbg78j0XGb11e2wqHNAqCvGbr6+4XhhdNYU9NFhIf1siRcnvCXioXg7uY1k2SKmwxaK5CtMJVTYybPXXL0kGlIAVLKAH2QFtUs2tv8/j7r814lMN1SfJuIf2QpTzSumJL2iW9Zv3InQ/kSMV0HybMiGYih/Q9CK3ECvPq0MzSQ6fotovwdwxD8LVhfi8AZyJg09PGHjpQyAJPTusLeE/mcmGYYdYHXm2v9vwLokah6oNci7yWC1rqnPm6ur/x9ywZ/Y+SzYEQR6/59igR9eTBjWEGQJgMwDWjoYZCxK5IkT4pXd7iQ2jWA1EZbSlEMAIFTjEvC6wAgx8irGAhzvJRJ6g8SBTM9aRQIQzbM9CFgsbHzxIEWgkR427iW9BlkACCuBACbMf2SeScQFI3ODF4Cc1u1JzOnc2tU2xQgQP1+AHqI2ZREVLnxsLNu1W6ETNQARH/B3riaRqsEAPFnbwogCm69guBOmyon6hdKSAIAwJZn/bscGXwaA9cLqc0aikNnPOysW7WbLNKGWKZCL28sdJkRVyEENpgcxDgmBWMPGalNEcNkikCiPpsahgpUkBKmJdzyrH8XgN8kMkz25pXHEJSxpCgFgBwHxlgJjCUWBYAcC6ICAGMRDNXa4XCIL+93X7AXABj4B4x4RJoHYGiBG8QfgGly8FJMiFeVgY/1vZ8kGrS7WiqRUgYgJifruQ0khUXznnLWwjxYgkM0cob58CWCMa+sHdmb0f88QNMAgJmhb6cpSABsttcn9ge0C4HgNpCh/CMUmwgAZxYXL3cOKfKYydzqShk3OZXk/k8E6ZpuPiTsASmdAiTYZChCmAQQmQ7r+kA2r388aTHfl9VfrL/8ZMDSUBejte6pFgB6XEF2T/7+pPsL6xtkOsoQ2WUyMZCd029VVo2cWHJF1lDGTgVSuwYQFgYAh5mBM8hpdcvqgI2fYO7W6sLspuo/5DRVb87eUnNl5POOrt5XYC4W9XE2gvkJAH9g4DYifIuBF42noJciYu0ZBCMWkcBnJPj1bEEMI5u6BMWVqKG1jaGfyMtonziUsVOB1K4BJLFFAof54QUgHcJ8aCppNmzIyhl54GIWdBVLnK3XIOY/gPmhsHw5Z/q6ZVPNpQL8gk47E5q7Ziz6tl5l9OaqUb0iy/DhEyyj1xWMRgDzQ6UhnQnAZOa6I+ZEfs8D0PMNSeUqAEMyUQ8VqVUECTLEOgfz75kDUVha2o6RW2pOymmq/kXOqPb3QfQ4Mc5GOLrtkiV1z1jwMjMq9DIxXZOzZfVsvdyjZBRS6Adm0Nsdb/eujiKUTL28YAxpK0gMq6RLgAGox7hkXOk6+5LRcSqnHSllACHN6ByKZAAoxo/Td2wBNObXAfwQQKygk3di3EfXjKafA2gwhmI8nL9lVT4AdO8b9RpAK8B4nYCr4PNFHXjBgBGnwIQvDvzNEoSgBAw83GMp5FJG/4AOJelEilXBYQyQbX0WsIpHlg6EL9c/BujnCHO/pti+hFQhpeK4DEBoAUbHBaQIqnZLSwOdMxYs6yxe+MXOGQvq7Jr3d3dbjVQFQzEPs/VUEWnvmh4BKwOAia49mIvBFGsCTeUPB/fhBhTLFEBS6teNAF3emdlzQueMBTeB2UIPx3Um7Z46/98M/hqAAIBeDZRwkomQm/kBo69MJeaWrHC2Os3t8V3unnOZ7QqfyJRgRPzpwKOHSQAAOCrP0XnQ4gVSuw2UYTb5MNFOIN0UCse+TiGEckrnjIUzmbE3pzdrdU5TzXMgYRhomGNPATq6ZiyqlorjRAZ/Pum0akyGE4kk2DLA1DL1c0LSyww8wlrvX2z7kRhvXlICsRN0YtQtph8k4lyaDqRYE8gfWyR7AYIFBgCJ/v26tzf1BvLap53/BgAQ8R8BnBC5KyQRXwLo6J46f3CJmIiNXYoW/a8M3hfiNGLWxfN8WL6P2Y/JAALxJcBUT/nJEqyrgLtDfWUDOLlo047FrcDTyX6NoSKlXBfo77Xm3ndOn6ca00A/S6vmbyR0TmGyS6z4UWavM9158gzfBXJStOEKAEGebCmOKfKWhy0YQ4GiuhcTWJHvxhtQEp9r9o1XQGQ4qRDzDfat0ouUMkBobjXWAbLXNP4cre21MoCYNO/SPADoHKlcROBzATk7+CGv6A8U7Tl9/gGkCSGzrR68gszMzhiim04OL4crjT51HHUSTH1Hb0Hf7rcQD4xzzUtuICF/C0DPm3C6q8w37EfMp/68AMY7emygRjgRIbephoaGgMvj60Qo8XOWpo0CcAAnze/tAFKXbDkB9Oa3jyFzruqOaX1kdoVtViTNBEzXMpIosjx+I4EkGAYDQOD55vX+d4o8vr8RsBQAiPgGDPNvkfqFB+FN45IQueAxpIAIcFJJJ1IJRsDqumYr/oNu5RSmJRTEEToDdutXNIATS1FZ+RcA6P4CPe39Oa8CgGD6lUkXnR8rlUu6kA63cEMMEsSUiKfGIkkKedDs4QoUa1i5rfinfYobEepshunRFKzEhvZSMsffhgpz/gfQk6XszwGAUN4k3QWepHBcPxD9qUTqQ8PMtChgNv8hQZAR6SOkSJ4B3lybmdu0+urcpuq/5DbVfGfsptV5AzeKBlucVynG1k1I7Syb28eEzNoIKm/MSF8laJ+IN6iVAfKdcBo2CrZIAYAvSY3DamJIOQOEmYSByVY/OSLDbRssOCm36Pwtq/Jz2wMNDPozA1cx+J7ubGrJbVqd9MLJqr1jQ5sYDgny2Nwm54gRxwFAnrPzNJjq7vbRclfcDGgCdG7Era+4y9QyAGitr1xPgO4Gl6GRGLasYqkPDSO2qoAzesbsNec0yeaenZF4pO7m+5wBVtYyEBlbP4FB9TmNq29MhkYBtkwB0VvAkpISByHsH2vsbEgG1y4kyZp65sV4C8DJZUsmsCVkTu+KiX6vJ4xgYkMKEPiqUIxF2pH6RaAMd4oQkkxRKoQZ7EkcrRGLgRxx7LUMWLdgT7JpUlZAdHduU/XtifbHIMsUEL0G2KWMPwdmgMv7YIv/gAhqOBlYYnbIf483nlM4Lds/ehNGogm4du6lrwFAQWBXFczpc2Qf01WJfp+hIA27AMoOL8NgACZpCRWjzyMRcIUA2Jqz7+7OGQsvdTBPhyUyh4GfZDdVJ5SKjdlUAkmbKUAwLjTJpOpQxpHQOFwQWqnrC0IWwKr441kWgIQqBv2P+RAVE0uuyGpoaAgwYM1q9t2h5DZKFOmeAgDGOQhtph1Q3rTcn5BIvpzsppnTARwbKu7r7Om5HQAOFC96q1NSKWAGkRLoN9lNq4+168cKwWysAYijpgACmQzALKsBS/4hiQwpHNYklK9uq/d/iPgwGYDl8wH03WlhqmNzHd3fAAChZD4EkyGPzerPSyo932CQhvwAiLS/HzfVu3QaAGx5bsV/YfrRO9/cpQx4wqdAmP/8yzjTZ2YEnbmgq1NiEUMP/+ZRILpiQBqtUwDLMAngmq3Ogrlf389j8DyDzfmdkAGYySiIKW7Sa/cc9USYGc/6hZL1UtA9nY10M8T8w0nz5mU2r3+8E8Cfzfu4HmkOIk2DBLCmbA1Ck3Jh6JJBpjNGwKENqPRgi18B28UazFzQRSAjDSoxnxdVJxoGA2gR20CWwTkZAIious3v76Ow34nmAYb/f69Tir/GpV+j+ZbixtBLBkTWn2EqoT6X1ZvrAwBHBt8LM+3tZHepuiCB7zNopEMCRDEAERt5fyDJCAghSUWRdaMhjShfAk20qyGkJRMJ08AuVmQygHBqBgMUe9VRocOtQ13Jh0INrL+TuT1krG5seCq+DwAZvodgYK1+3bz+8U6w+W8H0beBYHwEsxkvKQWl1UiUclsAMe3hKFc+mlboVU9oq/W/D5KvG1LNmk8wBpjQTEGzKQGYltu0dlzHjPlhuQAkmS+NBL8Z2YcNzDUApLEG6AN9DabEeaPlOX9QucOcbRHE1qszXF5fmAaQGZ8qJH68rXbFljPOUEd0sHkolpC8xlqXHP33sua8EUAGAae6POozDOoWoQiH0GBnuzzqGckeQpUoUm8MIuOwhLC7QmIhgD8CYYkjp8LOxm5B14xF/8lpqv4ngmlVHMxaZW5TzTOS8BYxFzDjdBAbaWMl6NFYfQFAYYmaC1PFy2P69u4Bgnv/PUzfZZOUhwy6iMfHmIqPB4efVE4AJMsAgAs6sqgUgO5u9nbkmUjN61d94vKozwIUkpC0KPhjRP2BbgQsO5MUIvVTgDBFdth9onIAUDRhDfx0uTzqa67ZaqSWLLwtmxY4EJcy+B4K7r0fI8I1MN/Oc11v9qyx60OHFJrVELRfV+DsUY662KKs6SGl/xFLvaQMVwy8BwAkLJ7ORLbnDDNZIpZjY6G7VD1l4GrJI/UMoAlbDx0CznbPKS/a2rDiPeu+GqCZkNTg8vpWu+ZcZOuh2zWj6QEE/5HxRt6Y2ee42M4L2AonnFFaQFVVFQZbE0k+FH4qCYXbLRitIMw2PhyeCVwh8WCwGsy0MRrbMkAmeB1g2TkRbgXRHxmwri2EFHRPOtzGUt7h5AL5LsI9Xw3HDqnx1QAYzNuiGjIWQlNaijy+P0Xl+acK2Tlj4ZVSytMJdCcIaxBUAtUR8wNE7OucvqUkEScSGeasGtQC7tiNSwDolss+SWwklZo+Tx2H8LB3EHBTS21Vrf4hQRPNh/zqttoVW4LVjKwhvRm53Q129DTW+vcTYHpFEW9sqa28ViiZE9m6JQTmul/Y8R27PoaCtOwxXR7fVphHwdYC8IauD/T19ByXMSLrDjC+F7rXjmAgh5WWAwTcndPFv3v5ZX/UrmIwmFqmfk4KuhaMq2CeW/iP7oz2xSP6Rm5HKEEVgR5qrqs0wtJcZb5ZIDxv9sQbW+r8hgGqpKTEsVsZ/w503QHzV1vq/Y8UetUTBBtZ0ra31FXF3PIWeXxP6U4hAH2zpa7yPmN8b/m9YNYjn3ZnZHefkMrw+fR4ohIM5wgibIV+/g4w0pmZdSlJU4VLwNtEdCaxGc8HYCQDd3Vk0xtuj+/yoYi+Is8yt8vje0QS/QuMHyL80MrdI/pzr4OZnaxbI3lH+FcJcwvrJ0WEBXLsdhx1PvSXT9ib241KACCpWIxd0fkSw8YgMsV9hCa1r7v7Jphp8Aq6Op0pdaRJCwOwNHPiQfLnGTAWOkS4joVmTZro6u3ubmuurzqbwKolqSMAHMfAI66NbZvds5famWdjosijznZ51XUEbSuAyxF+bmGQFuYRYLrZJBy/aav1v2+tI2FqCpnol83rK1utz5n5MvOaHtMlliBtpFmL4qeWZ/OlkwzfQ7/+YnW7lPCBeD2AH+6ofzouMyWL1G8DATDR8xTaykiiWQw+l0BfRdAv/GRIx7kg/hDA5wAomdnZpwKoa67z/61QVauV3eIaJr4VxtxL01nKWpfXt1Zo2o3bNqy0TUFfXLzc2Ttq71Ii+gGAqdGbS24DoQNMp4XoXATzRLL/SMl3R7Zorfevcnt9F7OkkZPHyMesb39ayeJ8LZj1FAAgGObZAALdlqjBgVTeRoi6DP8DAADaNlS9CP0YuxQjLRJgnPbxFoR0/gSMBUQOCFVGBeKfAKYLFUtpHDHT5vf3NddX/h69jkkUzBhiBJSAMV8KZZurzHf/5LlLjJV5sVcd5faqN/Tl7/sXET0G26Po0dLX03sGQVjPLzKMUUx0bazchM21VStb6iv/N5R11EBAcV4E0ylkh/VYvIx+RxuMo2ZwSpFHnQ0buL3lpwPQ0+dpQukbVIa0wSItDBDcWxsp2aCwnMNBfb3+g0wEyBqVaz1jEADQsunJvc11VdeDtClgVMFUFikgfMMRcLzh9voqXJ7y3/Qxvc9MvwRiOpl8omhi4esvVrezxRKog0CVrbWVSQdlCJBprSOE7edDKmJj60dMT7jKysNyErnKfLOYeRX0BTDhabtDMdOJtIUjEYShkGGBBaGDHx63VLEurs6KdRpXS+3Kf7XUV5UT0ZkAv2R5lMuM2xA85NEy30bZInqlxJKtDSveDZULIp7/26mJb0fcw/TZS491e9TzYtHlLllyHJtmXga0KIWOBN8IfQFMGAfitW5P+bsur7rO5VFbQ7sL3TWuS2hawk4tqULaGEBCrISu4GA6zTXnoi86hLgJ1uQQJvL2OI6Km2u3ubbylZY6f3ChCDPfngXvEvh7IMtZfwCIaHloDg2SYjEFAwgQxCWRBh3X2ZeM7pdyG4Oe3a2Mvw92cCjLYJ4S/nIwEWU42ur82yGhwuJSxuAJYJqD8AMxu5nYF2ttk06kjQGCOfKxwbgRcFy+5bkV/yHmX9jVl8yldvcjwM11/r/JMTyFmK4D8DYDmxi8tED75CTJ2APGMrM2/aK5tvIxawcEtiwN6dvNdSs2Ro2SqfnIUBhFxgKE7jIMpxCCeCIWwS0bqtYK0AwGVsLMUahDEngNFG1Ga60/rltZupCWXYAOYqpkYm+ocJmqqrdsB34l9vCyiH8ACCgDLGfyxEEoB/HvQx8AwNTSiwqJLK5W4NUts6bcjPoImiCuBLQbmbGupb7K/t8NNo6JZVCUbaHQq55gSQ0rQ9IuJrbVVb4B4OLCEjVXCJoB0FEAOphEU0vwj3LQkFZvE/ecy3JY630P+rxLfGlLrf/JqWXqqZLoJSAsbUxPRnZ3wWC0XKFxXoOpzv0AvY6pLZue3BuvnR2K5iw9njT5LoLSkUHapEjx7vao32VQiPnCNYNh3b5qAAAKiklEQVSHG9Iakx48WAH3GzeYbkFFhdhW73+NGZGHGWf1dmclMg1EgbXeP8F8+ZogvmQwLz/YWl4I83d5xW5uZ8A8b4AorkPooFFVpeQ01nw1u6l6ZW5j9aqcpppfj2xcnfL0smlPSiCh3APTODS5aNP2iwGgddaUOxHM2mkgwtc+IbhKffMBa/5/umtbrX9TzAYDgADDBSs0b4ehuGTZWFhPNhH8TGSdoWL05qpROZMy/w7ihwlYwoTFAP9AI2rNbVy9ZOAeEkfaGSC0GDR+SGLcVly83ImKCunI4K/AkmsXhPJJ8y4dadONLYq96igIWOfxVwq0j22PSU+4P8AQ5wqoJrJOr0NbCHPt1NS83j9gJpNk0U+ZvwJs/wyZTGJFbtMzU2yeDQppZwBXWbkKq8gEpvTm77seCOUHlrwYpqfw+BH9fXHz7VrRy/RrmMqfAyDt0gRCtGOin8U86DYDpp2hxVsYBLMlZiB+PMBgkNX09wlMZIlvoIdBdKnF89nJEL8ZsbkmfmLqBJFWBnB5fDeCuBKhnAA6CLg1eEYQ0LLB3ygl5oG5DoyfttT67TKGRKHIo84mwPihiOhau/k6GTCb4h/E1ZHPJ5ZckRV+5hFH5yDUUVWljGxcPSm36ZkpaKuKMkTFgiA5Hfp7YbR2zljw9c7pC54UjJst1c4TgneOaKwZsptY2raBbq+vIqipM/AfBFXBxwEYIRS6D0E/AQ4parw23dhi0rx5mdQn/gJwMEc0eE1zbdVjA7WLh5KSEsduwfN0hbMgjhL/uaJ7Fkyn0X/bMevYTavzukfQT0C4UgPyAUJOT1Y7N1Y/7sjKuPVA4Xm2+Qh0kJS5ICMBtmEYkty/keBsBxmZTUYI4idGbV7l2j/zQjvFWEJIiwRwe8qvCX/59C+p8bnEfDlMe0CZ2+P78WD6H9Gb9z2LDb8LCobsKbNHjJsFhu5Svnt0YFdU1jGCJeaAEeXilbvt6fHd2fQKCNfD6ndAyCPCNYHevlezN6+MHxYvzHzDksyAlK6ZF/1XarKQgSsBI8h2RIDEkGIIU84ALm/5Igbfa7n1T0eGPL2twf9Wc72/nkFmXDxwZ5Gn/IJk+nfPuXA8CBbG4VtTsRCTJPTgFTDwd9u1BMFgABb0j8jHrDkehbkdBYJ2ACOsjIBJJDLiSiq2JJwmiDAauk9d/EHXjIUPgSwHYRMicjAkh5QywOSyJRPA/LCl33cyNGV+6DCIYJ0x8scwt3+CwE8mkxaFNecdQOhkEqadGftG3xu/xcBwlarFBDZVuxyt/ZtWsnQiYOQVDmRChmUhHdFYfTpgMggIN3TuzxvV+VbPWGKyGJvYm920OrbdQ7KpHGNp7+DKZnpbIgzJPSx1a4CKCuHYuH0FTAfKfVC0+Y11VWGGFr/fr7nOvuQSZPY3AOQGkCcV5Rl3yZLS5oan4+b8c88pL2KNjYUfC3n9UA57cM+5LIcDvXeC8B2YWsm+7kzHusi6ASHPM9SmjBcb6/xhB14o4PPYsOpSdcf0Bb/Wn3UAf8ppqr4AIQYhiOrspuq/dPX0/Cos1hGAADmMuADCl3K3VIepq5kxCTCDTSSip6JkkDIJEPJY1RM4MIGXtaxfudOubsumJ/dKDXMN9y/GJFacz4f+ZTHBku+CybTPDcWA4i5Ty6D1tYFwHayOIcBrbz37RJR3sQCbDh2Co8Q/zAhmMHGUgYnDTNl8DAG352RlNeRtrglLqcsizGX+ZGYst34QtJnovPhCl/bRIwN81bhICQMUlywby8SGLZuBh5rr/HY/koG2Bv9HLEQZQfec5c9rinxh2uyLbI9TK/SoU8Aw1gsSdLNdvQFpLV7udHt9FUz0nE3WDpDVgmm5Lck8GZQ0JaoOk8iwVI7yZGYhHgZ4IxB2lM6prMj7rfWyM7qrAdj+cazdAbRC9AeWYOZVgz/uBiligF5F3gLdKYOxix38w0Tata5f8QErgfNgagOP16Ty/FTv0umRdQXRLSa9vLqtrvKfkXUGwlRP+cl9+XtfDe1Q9O8e5p9AzA2R7dxzygtN8zDax/BHUQdThjKgAwCkNZw8hO5pCz7snLFoVuf+3JFM5p6emS60avZ2Ffo6sjN7vkTgZcy4KvID4iuIRWHnjAXL2k9bkkBu4vgY8hpg+jx1XKCPl5t3+Ma2df64e10rWtav3FnoVc8SUqxDMA/fMZLliy5P+Tda6iqfAIDCEnUSTPs7Sylui92jPYq86vmS+a8AWd3C/8lEvyBmXVXd58zpidr+sRaW4s0+HxAJBaYSIXZ0UmlpTxfws5zGGi8o5APBSilgutLvKvR1AFiR6HcbCoYsAQJ9uBqhAEgCvVcgd8WNl7dDW63/fUemnGVxFB0B8F/dnvIHQzb0G2HO02vbNlRGRxbFQkWFcHl8dxBTDcy9uQTTLzL25Z9FzNZ9+Su25miyZPggfj7qOQCGtGzfoiVAVH0hjRcuSUb5KQ4XhsoARBBGQgUJvnewuvgtz/p3kZJVQsyGcyaDvy4U2grLMa8kxO/se4jGpHnzMos2bn8CwK0wF04fE/j8lvrKHzc23t8PNo0/RPbzvzXHH0E02I0l2HJglByAATbf5yQmYyVPbB9PORwYEgMUlvrOtCyk2jOJHxxKf83rH+9srvdfDMaPYGoMvwAznLul+bkV9fatw+E6+5LRI/ry1pshV8EVvtR4WtgClcwIXmnzckMZwvVYxQ7n3lHR8z8AFpbplGJMAVwh8jbXfDFXOboSpsKoFxlyrW39YQAVect/SszfA+P+lvqq77tLlhzHimOdhcBuZvyktb7q10WeZW6CtgYDBzocwcHBByA+v6XW3+L2qjcw0+0w8xNsF8xzttX7PyzylP+ewFcC+K0g5u8CyAHhWlVVFakocxGuzhxBhG8CAEj6cOTlH8o4HpJ8AMDBPIPWs5CmaILmqqqqEPjbCFpovyfAeABAgAgP+v1+TWOt1tybAwACIDwCAELi6Yi49SM4hMDAp0IIfQ31KMyzCADgXQbXBqOb6CEAAQLuDy6MKioEKirCTvrUz7Nrd2R0v9vwSI/dsyOIRvcxBY5+9/jcyPtKh6blvPhGu12bVCHSD3JiyRVZeYG+EXbP7N75ERzBEfx/Q1rjAgaDvM01YyWhCsQxTvXmXYKVK9uLL9iYs7VmDiT/ERFnFA4jPgXxtzqnL3our3HNOZK0BwGyT+DAtFUwfO0zFxxSa6i0RgYNBpqQCwkUJz6ARmukfQfARki+DoCt8WiYMBrBELXnNNK+Q1GHTFlAXKoRL4TlzKFDAQflsMJ4UBS8CIsXjQ2YWKwFAApm3oyZY3AYwMQcpCVIUzxa9oW+2yGFQ24KAABsrsnOYrI9UcRJfMAqRnOb1o4LaDLho2OIAuOEELanjEopT2d27LJ7ZgeHItqtWUvzNteM7WeyjWvoIf4IMxekLLlTqnBoMsBQwUy5W9ecC8io+VgC+cR0v20z4uUilvQRyo6OqRe02j47jPGZZICcxtU3gigq388QISXJc7qnL35p4KqHDw65NUAqQJTgaSTJQQgoE9PQ70HFIbcLSAW0gLxLOER2VIrXoYB5a2eeEjcPwBEcwREcweGF/wPu1jmgcxqD7wAAAABJRU5ErkJggg=="];    

    /********************************************************************
        Once menu has been initialized, it will run the setup functions. 
        All of your switches should be entered in the setup() function!
    *********************************************************************/
    setup();
}

// If the menu button doesn't show up; Change the timer to a bigger amount.
static void didFinishLaunching(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef info) {
  timer(5) {
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];

    // Website link, remove it if you don't need it.
    [alert addButton: NSSENCRYPT("Visit Me!") actionBlock: ^(void) {
      [[UIApplication sharedApplication] openURL: [NSURL URLWithString: NSSENCRYPT("@@SITE@@")]];
      timer(2) {
        setupMenu();
      });        
    }];

    [alert addButton: NSSENCRYPT("Thankyou, understood.") actionBlock: ^(void) {
      timer(2) {
        setupMenu();
      });
    }];    

    alert.shouldDismissOnTapOutside = NO;
    alert.customViewColor = [UIColor purpleColor];  
    alert.showAnimationType = SCLAlertViewShowAnimationSlideInFromCenter;   
    
    [alert showSuccess: nil
            subTitle:NSSENCRYPT("@@APPNAME@@ - Mod Menu \n\nThis Mod Menu has been made by @@USER@@, do not share this without proper credits and my permission. \n\nEnjoy!") 
              closeButtonTitle:nil
                duration:99999999.0f];
  });
}


%ctor {
  CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(), NULL, &didFinishLaunching, (CFStringRef)UIApplicationDidFinishLaunchingNotification, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}