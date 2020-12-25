.late_rodata
glabel D_80B0F240
    .float 0.01

glabel D_80B0F244
    .float 0.01

.text
glabel func_80B0E430
/* 02680 80B0E430 27BDFFD0 */  addiu   $sp, $sp, 0xFFD0           ## $sp = FFFFFFD0
/* 02684 80B0E434 AFB00020 */  sw      $s0, 0x0020($sp)           
/* 02688 80B0E438 00808025 */  or      $s0, $a0, $zero            ## $s0 = 00000000
/* 0268C 80B0E43C AFBF0024 */  sw      $ra, 0x0024($sp)           
/* 02690 80B0E440 3C040600 */  lui     $a0, %hi(D_06000304)                ## $a0 = 06000000
/* 02694 80B0E444 AFA50034 */  sw      $a1, 0x0034($sp)           
/* 02698 80B0E448 AFA60038 */  sw      $a2, 0x0038($sp)           
/* 0269C 80B0E44C AFA7003C */  sw      $a3, 0x003C($sp)           
/* 026A0 80B0E450 0C028800 */  jal     SkelAnime_GetFrameCount
              
/* 026A4 80B0E454 24840304 */  addiu   $a0, $a0, %lo(D_06000304)           ## $a0 = 06000304
/* 026A8 80B0E458 86030388 */  lh      $v1, 0x0388($s0)           ## 00000388
/* 026AC 80B0E45C 44822000 */  mtc1    $v0, $f4                   ## $f4 = 0.00
/* 026B0 80B0E460 26040168 */  addiu   $a0, $s0, 0x0168           ## $a0 = 00000168
/* 026B4 80B0E464 14600003 */  bne     $v1, $zero, .L80B0E474     
/* 026B8 80B0E468 468020A0 */  cvt.s.w $f2, $f4                   
/* 026BC 80B0E46C 10000004 */  beq     $zero, $zero, .L80B0E480   
/* 026C0 80B0E470 00001025 */  or      $v0, $zero, $zero          ## $v0 = 00000000
.L80B0E474:
/* 026C4 80B0E474 246EFFFF */  addiu   $t6, $v1, 0xFFFF           ## $t6 = FFFFFFFF
/* 026C8 80B0E478 A60E0388 */  sh      $t6, 0x0388($s0)           ## 00000388
/* 026CC 80B0E47C 86020388 */  lh      $v0, 0x0388($s0)           ## 00000388
.L80B0E480:
/* 026D0 80B0E480 1040000C */  beq     $v0, $zero, .L80B0E4B4     
/* 026D4 80B0E484 8FA50034 */  lw      $a1, 0x0034($sp)           
/* 026D8 80B0E488 3C0180B1 */  lui     $at, %hi(D_80B0F240)       ## $at = 80B10000
/* 026DC 80B0E48C C426F240 */  lwc1    $f6, %lo(D_80B0F240)($at)  
/* 026E0 80B0E490 3C063F19 */  lui     $a2, 0x3F19                ## $a2 = 3F190000
/* 026E4 80B0E494 34C6999A */  ori     $a2, $a2, 0x999A           ## $a2 = 3F19999A
/* 026E8 80B0E498 26040168 */  addiu   $a0, $s0, 0x0168           ## $a0 = 00000168
/* 026EC 80B0E49C 24050000 */  addiu   $a1, $zero, 0x0000         ## $a1 = 00000000
/* 026F0 80B0E4A0 3C07447A */  lui     $a3, 0x447A                ## $a3 = 447A0000
/* 026F4 80B0E4A4 0C01E0C4 */  jal     Math_SmoothScaleMaxMinF
              
/* 026F8 80B0E4A8 E7A60010 */  swc1    $f6, 0x0010($sp)           
/* 026FC 80B0E4AC 10000047 */  beq     $zero, $zero, .L80B0E5CC   
/* 02700 80B0E4B0 00001025 */  or      $v0, $zero, $zero          ## $v0 = 00000000
.L80B0E4B4:
/* 02704 80B0E4B4 3C0180B1 */  lui     $at, %hi(D_80B0F244)       ## $at = 80B10000
/* 02708 80B0E4B8 C428F244 */  lwc1    $f8, %lo(D_80B0F244)($at)  
/* 0270C 80B0E4BC 3C063F19 */  lui     $a2, 0x3F19                ## $a2 = 3F190000
/* 02710 80B0E4C0 34C6999A */  ori     $a2, $a2, 0x999A           ## $a2 = 3F19999A
/* 02714 80B0E4C4 3C07447A */  lui     $a3, 0x447A                ## $a3 = 447A0000
/* 02718 80B0E4C8 E7A20028 */  swc1    $f2, 0x0028($sp)           
/* 0271C 80B0E4CC 0C01E0C4 */  jal     Math_SmoothScaleMaxMinF
              
/* 02720 80B0E4D0 E7A80010 */  swc1    $f8, 0x0010($sp)           
/* 02724 80B0E4D4 8FAF003C */  lw      $t7, 0x003C($sp)           
/* 02728 80B0E4D8 24010001 */  addiu   $at, $zero, 0x0001         ## $at = 00000001
/* 0272C 80B0E4DC C7A20028 */  lwc1    $f2, 0x0028($sp)           
/* 02730 80B0E4E0 15E1000A */  bne     $t7, $at, .L80B0E50C       
/* 02734 80B0E4E4 8FA30040 */  lw      $v1, 0x0040($sp)           
/* 02738 80B0E4E8 C60A0164 */  lwc1    $f10, 0x0164($s0)          ## 00000164
/* 0273C 80B0E4EC C6100168 */  lwc1    $f16, 0x0168($s0)          ## 00000168
/* 02740 80B0E4F0 46105480 */  add.s   $f18, $f10, $f16           
/* 02744 80B0E4F4 4612103C */  c.lt.s  $f2, $f18                  
/* 02748 80B0E4F8 00000000 */  nop
/* 0274C 80B0E4FC 45020004 */  bc1fl   .L80B0E510                 
/* 02750 80B0E500 847807A0 */  lh      $t8, 0x07A0($v1)           ## 000007A0
/* 02754 80B0E504 10000031 */  beq     $zero, $zero, .L80B0E5CC   
/* 02758 80B0E508 00001025 */  or      $v0, $zero, $zero          ## $v0 = 00000000
.L80B0E50C:
/* 0275C 80B0E50C 847807A0 */  lh      $t8, 0x07A0($v1)           ## 000007A0
.L80B0E510:
/* 02760 80B0E510 26040024 */  addiu   $a0, $s0, 0x0024           ## $a0 = 00000024
/* 02764 80B0E514 0018C880 */  sll     $t9, $t8,  2               
/* 02768 80B0E518 00794021 */  addu    $t0, $v1, $t9              
/* 0276C 80B0E51C 8D020790 */  lw      $v0, 0x0790($t0)           ## 00000790
/* 02770 80B0E520 0C01DFE4 */  jal     Math_Vec3f_DistXYZ
              
/* 02774 80B0E524 2445005C */  addiu   $a1, $v0, 0x005C           ## $a1 = 0000005C
/* 02778 80B0E528 3C0143BE */  lui     $at, 0x43BE                ## $at = 43BE0000
/* 0277C 80B0E52C 44812000 */  mtc1    $at, $f4                   ## $f4 = 380.00
/* 02780 80B0E530 00000000 */  nop
/* 02784 80B0E534 4604003C */  c.lt.s  $f0, $f4                   
/* 02788 80B0E538 00000000 */  nop
/* 0278C 80B0E53C 45020011 */  bc1fl   .L80B0E584                 
/* 02790 80B0E540 A6000440 */  sh      $zero, 0x0440($s0)         ## 00000440
/* 02794 80B0E544 86030440 */  lh      $v1, 0x0440($s0)           ## 00000440
/* 02798 80B0E548 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 0279C 80B0E54C 14600003 */  bne     $v1, $zero, .L80B0E55C     
/* 027A0 80B0E550 2469FFFF */  addiu   $t1, $v1, 0xFFFF           ## $t1 = FFFFFFFF
/* 027A4 80B0E554 10000003 */  beq     $zero, $zero, .L80B0E564   
/* 027A8 80B0E558 00001025 */  or      $v0, $zero, $zero          ## $v0 = 00000000
.L80B0E55C:
/* 027AC 80B0E55C A6090440 */  sh      $t1, 0x0440($s0)           ## 00000440
/* 027B0 80B0E560 86020440 */  lh      $v0, 0x0440($s0)           ## 00000440
.L80B0E564:
/* 027B4 80B0E564 54400008 */  bnel    $v0, $zero, .L80B0E588     
/* 027B8 80B0E568 87A7003A */  lh      $a3, 0x003A($sp)           
/* 027BC 80B0E56C 0C00BE0A */  jal     Audio_PlayActorSound2
              
/* 027C0 80B0E570 2405388C */  addiu   $a1, $zero, 0x388C         ## $a1 = 0000388C
/* 027C4 80B0E574 240A0004 */  addiu   $t2, $zero, 0x0004         ## $t2 = 00000004
/* 027C8 80B0E578 10000002 */  beq     $zero, $zero, .L80B0E584   
/* 027CC 80B0E57C A60A0440 */  sh      $t2, 0x0440($s0)           ## 00000440
/* 027D0 80B0E580 A6000440 */  sh      $zero, 0x0440($s0)         ## 00000440
.L80B0E584:
/* 027D4 80B0E584 87A7003A */  lh      $a3, 0x003A($sp)           
.L80B0E588:
/* 027D8 80B0E588 86050444 */  lh      $a1, 0x0444($s0)           ## 00000444
/* 027DC 80B0E58C 260400B8 */  addiu   $a0, $s0, 0x00B8           ## $a0 = 000000B8
/* 027E0 80B0E590 24060004 */  addiu   $a2, $zero, 0x0004         ## $a2 = 00000004
/* 027E4 80B0E594 0C01E1A7 */  jal     Math_SmoothScaleMaxMinS
              
/* 027E8 80B0E598 AFA70010 */  sw      $a3, 0x0010($sp)           
/* 027EC 80B0E59C 8A0C00B4 */  lwl     $t4, 0x00B4($s0)           ## 000000B4
/* 027F0 80B0E5A0 9A0C00B7 */  lwr     $t4, 0x00B7($s0)           ## 000000B7
/* 027F4 80B0E5A4 860D0444 */  lh      $t5, 0x0444($s0)           ## 00000444
/* 027F8 80B0E5A8 860E00B8 */  lh      $t6, 0x00B8($s0)           ## 000000B8
/* 027FC 80B0E5AC AA0C0030 */  swl     $t4, 0x0030($s0)           ## 00000030
/* 02800 80B0E5B0 BA0C0033 */  swr     $t4, 0x0033($s0)           ## 00000033
/* 02804 80B0E5B4 960C00B8 */  lhu     $t4, 0x00B8($s0)           ## 000000B8
/* 02808 80B0E5B8 00001025 */  or      $v0, $zero, $zero          ## $v0 = 00000000
/* 0280C 80B0E5BC 15AE0003 */  bne     $t5, $t6, .L80B0E5CC       
/* 02810 80B0E5C0 A60C0034 */  sh      $t4, 0x0034($s0)           ## 00000034
/* 02814 80B0E5C4 10000001 */  beq     $zero, $zero, .L80B0E5CC   
/* 02818 80B0E5C8 24020001 */  addiu   $v0, $zero, 0x0001         ## $v0 = 00000001
.L80B0E5CC:
/* 0281C 80B0E5CC 8FBF0024 */  lw      $ra, 0x0024($sp)           
/* 02820 80B0E5D0 8FB00020 */  lw      $s0, 0x0020($sp)           
/* 02824 80B0E5D4 27BD0030 */  addiu   $sp, $sp, 0x0030           ## $sp = 00000000
/* 02828 80B0E5D8 03E00008 */  jr      $ra                        
/* 0282C 80B0E5DC 00000000 */  nop
