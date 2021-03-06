.late_rodata
glabel D_80969610
    .float 0.2

glabel D_80969614
    .float 0.12

glabel D_80969618
    .float 0.2

glabel D_8096961C
    .float 0.0015

glabel D_80969620
    .float 0.033

glabel D_80969624
    .float 0.03

.text
glabel func_8096784C
/* 00EFC 8096784C 27BDFFD0 */  addiu   $sp, $sp, 0xFFD0           ## $sp = FFFFFFD0
/* 00F00 80967850 AFBF002C */  sw      $ra, 0x002C($sp)           
/* 00F04 80967854 AFB00028 */  sw      $s0, 0x0028($sp)           
/* 00F08 80967858 AFA50034 */  sw      $a1, 0x0034($sp)           
/* 00F0C 8096785C 948F0290 */  lhu     $t7, 0x0290($a0)           ## 00000290
/* 00F10 80967860 8CA3009C */  lw      $v1, 0x009C($a1)           ## 0000009C
/* 00F14 80967864 00808025 */  or      $s0, $a0, $zero            ## $s0 = 00000000
/* 00F18 80967868 25F80001 */  addiu   $t8, $t7, 0x0001           ## $t8 = 00000001
/* 00F1C 8096786C 3302FFFF */  andi    $v0, $t8, 0xFFFF           ## $v0 = 00000001
/* 00F20 80967870 28410019 */  slti    $at, $v0, 0x0019           
/* 00F24 80967874 14200005 */  bne     $at, $zero, .L8096788C     
/* 00F28 80967878 A4980290 */  sh      $t8, 0x0290($a0)           ## 00000290
/* 00F2C 8096787C 0C00B55C */  jal     Actor_Kill
              
/* 00F30 80967880 00000000 */  nop
/* 00F34 80967884 10000034 */  beq     $zero, $zero, .L80967958   
/* 00F38 80967888 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
.L8096788C:
/* 00F3C 8096788C 28410005 */  slti    $at, $v0, 0x0005           
/* 00F40 80967890 14200028 */  bne     $at, $zero, .L80967934     
/* 00F44 80967894 30790001 */  andi    $t9, $v1, 0x0001           ## $t9 = 00000000
/* 00F48 80967898 3C018097 */  lui     $at, %hi(D_80969610)       ## $at = 80970000
/* 00F4C 8096789C 0C00CFC8 */  jal     Math_Rand_CenteredFloat
              
/* 00F50 809678A0 C42C9610 */  lwc1    $f12, %lo(D_80969610)($at) 
/* 00F54 809678A4 C604005C */  lwc1    $f4, 0x005C($s0)           ## 0000005C
/* 00F58 809678A8 3C018097 */  lui     $at, %hi(D_80969614)       ## $at = 80970000
/* 00F5C 809678AC C6080060 */  lwc1    $f8, 0x0060($s0)           ## 00000060
/* 00F60 809678B0 46002180 */  add.s   $f6, $f4, $f0              
/* 00F64 809678B4 E606005C */  swc1    $f6, 0x005C($s0)           ## 0000005C
/* 00F68 809678B8 C42A9614 */  lwc1    $f10, %lo(D_80969614)($at) 
/* 00F6C 809678BC 3C018097 */  lui     $at, %hi(D_80969618)       ## $at = 80970000
/* 00F70 809678C0 460A4400 */  add.s   $f16, $f8, $f10            
/* 00F74 809678C4 E6100060 */  swc1    $f16, 0x0060($s0)          ## 00000060
/* 00F78 809678C8 0C00CFC8 */  jal     Math_Rand_CenteredFloat
              
/* 00F7C 809678CC C42C9618 */  lwc1    $f12, %lo(D_80969618)($at) 
/* 00F80 809678D0 C6120064 */  lwc1    $f18, 0x0064($s0)          ## 00000064
/* 00F84 809678D4 C6060024 */  lwc1    $f6, 0x0024($s0)           ## 00000024
/* 00F88 809678D8 C608005C */  lwc1    $f8, 0x005C($s0)           ## 0000005C
/* 00F8C 809678DC 46009100 */  add.s   $f4, $f18, $f0             
/* 00F90 809678E0 C6120060 */  lwc1    $f18, 0x0060($s0)          ## 00000060
/* 00F94 809678E4 C6100028 */  lwc1    $f16, 0x0028($s0)          ## 00000028
/* 00F98 809678E8 46083280 */  add.s   $f10, $f6, $f8             
/* 00F9C 809678EC E6040064 */  swc1    $f4, 0x0064($s0)           ## 00000064
/* 00FA0 809678F0 C6080064 */  lwc1    $f8, 0x0064($s0)           ## 00000064
/* 00FA4 809678F4 C606002C */  lwc1    $f6, 0x002C($s0)           ## 0000002C
/* 00FA8 809678F8 E60A0024 */  swc1    $f10, 0x0024($s0)          ## 00000024
/* 00FAC 809678FC 46128100 */  add.s   $f4, $f16, $f18            
/* 00FB0 80967900 3C018097 */  lui     $at, %hi(D_8096961C)       ## $at = 80970000
/* 00FB4 80967904 C6100050 */  lwc1    $f16, 0x0050($s0)          ## 00000050
/* 00FB8 80967908 46083280 */  add.s   $f10, $f6, $f8             
/* 00FBC 8096790C E6040028 */  swc1    $f4, 0x0028($s0)           ## 00000028
/* 00FC0 80967910 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 00FC4 80967914 E60A002C */  swc1    $f10, 0x002C($s0)          ## 0000002C
/* 00FC8 80967918 C432961C */  lwc1    $f18, %lo(D_8096961C)($at) 
/* 00FCC 8096791C 46128101 */  sub.s   $f4, $f16, $f18            
/* 00FD0 80967920 E6040050 */  swc1    $f4, 0x0050($s0)           ## 00000050
/* 00FD4 80967924 0C259DA9 */  jal     func_809676A4              
/* 00FD8 80967928 8FA50034 */  lw      $a1, 0x0034($sp)           
/* 00FDC 8096792C 1000000A */  beq     $zero, $zero, .L80967958   
/* 00FE0 80967930 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
.L80967934:
/* 00FE4 80967934 13200005 */  beq     $t9, $zero, .L8096794C     
/* 00FE8 80967938 3C018097 */  lui     $at, %hi(D_80969624)       ## $at = 80970000
/* 00FEC 8096793C 3C018097 */  lui     $at, %hi(D_80969620)       ## $at = 80970000
/* 00FF0 80967940 C4269620 */  lwc1    $f6, %lo(D_80969620)($at)  
/* 00FF4 80967944 10000003 */  beq     $zero, $zero, .L80967954   
/* 00FF8 80967948 E6060050 */  swc1    $f6, 0x0050($s0)           ## 00000050
.L8096794C:
/* 00FFC 8096794C C4289624 */  lwc1    $f8, %lo(D_80969624)($at)  
/* 01000 80967950 E6080050 */  swc1    $f8, 0x0050($s0)           ## 00000050
.L80967954:
/* 01004 80967954 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
.L80967958:
/* 01008 80967958 0C00B58B */  jal     Actor_SetScale
              
/* 0100C 8096795C 8E050050 */  lw      $a1, 0x0050($s0)           ## 00000050
/* 01010 80967960 920B0293 */  lbu     $t3, 0x0293($s0)           ## 00000293
/* 01014 80967964 3C0D8097 */  lui     $t5, %hi(D_809692F8)       ## $t5 = 80970000
/* 01018 80967968 C60A0024 */  lwc1    $f10, 0x0024($s0)          ## 00000024
/* 0101C 8096796C 000B6080 */  sll     $t4, $t3,  2               
/* 01020 80967970 25AD92F8 */  addiu   $t5, $t5, %lo(D_809692F8)  ## $t5 = 809692F8
/* 01024 80967974 018B6023 */  subu    $t4, $t4, $t3              
/* 01028 80967978 018D1021 */  addu    $v0, $t4, $t5              
/* 0102C 8096797C 4600540D */  trunc.w.s $f16, $f10                 
/* 01030 80967980 904E0000 */  lbu     $t6, 0x0000($v0)           ## 00000000
/* 01034 80967984 904F0001 */  lbu     $t7, 0x0001($v0)           ## 00000001
/* 01038 80967988 90580002 */  lbu     $t8, 0x0002($v0)           ## 00000002
/* 0103C 8096798C C6120028 */  lwc1    $f18, 0x0028($s0)          ## 00000028
/* 01040 80967990 C606002C */  lwc1    $f6, 0x002C($s0)           ## 0000002C
/* 01044 80967994 44058000 */  mfc1    $a1, $f16                  
/* 01048 80967998 3C01457A */  lui     $at, 0x457A                ## $at = 457A0000
/* 0104C 8096799C AFAE0010 */  sw      $t6, 0x0010($sp)           
/* 01050 809679A0 AFAF0014 */  sw      $t7, 0x0014($sp)           
/* 01054 809679A4 AFB80018 */  sw      $t8, 0x0018($sp)           
/* 01058 809679A8 C60A0050 */  lwc1    $f10, 0x0050($s0)          ## 00000050
/* 0105C 809679AC 44818000 */  mtc1    $at, $f16                  ## $f16 = 4000.00
/* 01060 809679B0 4600910D */  trunc.w.s $f4, $f18                  
/* 01064 809679B4 00052C00 */  sll     $a1, $a1, 16               
/* 01068 809679B8 46105482 */  mul.s   $f18, $f10, $f16           
/* 0106C 809679BC 4600320D */  trunc.w.s $f8, $f6                   
/* 01070 809679C0 44062000 */  mfc1    $a2, $f4                   
/* 01074 809679C4 00052C03 */  sra     $a1, $a1, 16               
/* 01078 809679C8 26040150 */  addiu   $a0, $s0, 0x0150           ## $a0 = 00000150
/* 0107C 809679CC 44074000 */  mfc1    $a3, $f8                   
/* 01080 809679D0 00063400 */  sll     $a2, $a2, 16               
/* 01084 809679D4 4600910D */  trunc.w.s $f4, $f18                  
/* 01088 809679D8 00073C00 */  sll     $a3, $a3, 16               
/* 0108C 809679DC 00073C03 */  sra     $a3, $a3, 16               
/* 01090 809679E0 00063403 */  sra     $a2, $a2, 16               
/* 01094 809679E4 44082000 */  mfc1    $t0, $f4                   
/* 01098 809679E8 0C01E763 */  jal     Lights_PointNoGlowSetInfo
              
/* 0109C 809679EC AFA8001C */  sw      $t0, 0x001C($sp)           
/* 010A0 809679F0 8FBF002C */  lw      $ra, 0x002C($sp)           
/* 010A4 809679F4 8FB00028 */  lw      $s0, 0x0028($sp)           
/* 010A8 809679F8 27BD0030 */  addiu   $sp, $sp, 0x0030           ## $sp = 00000000
/* 010AC 809679FC 03E00008 */  jr      $ra                        
/* 010B0 80967A00 00000000 */  nop
