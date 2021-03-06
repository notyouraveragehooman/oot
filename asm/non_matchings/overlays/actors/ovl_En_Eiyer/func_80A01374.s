glabel func_80A01374
/* 013D4 80A01374 27BDFFD8 */  addiu   $sp, $sp, 0xFFD8           ## $sp = FFFFFFD8
/* 013D8 80A01378 AFBF001C */  sw      $ra, 0x001C($sp)           
/* 013DC 80A0137C AFB00018 */  sw      $s0, 0x0018($sp)           
/* 013E0 80A01380 AFA5002C */  sw      $a1, 0x002C($sp)           
/* 013E4 80A01384 84820194 */  lh      $v0, 0x0194($a0)           ## 00000194
/* 013E8 80A01388 00808025 */  or      $s0, $a0, $zero            ## $s0 = 00000000
/* 013EC 80A0138C 00002825 */  or      $a1, $zero, $zero          ## $a1 = 00000000
/* 013F0 80A01390 10400003 */  beq     $v0, $zero, .L80A013A0     
/* 013F4 80A01394 24060200 */  addiu   $a2, $zero, 0x0200         ## $a2 = 00000200
/* 013F8 80A01398 244EFFFF */  addiu   $t6, $v0, 0xFFFF           ## $t6 = FFFFFFFF
/* 013FC 80A0139C A48E0194 */  sh      $t6, 0x0194($a0)           ## 00000194
.L80A013A0:
/* 01400 80A013A0 0C01DE2B */  jal     Math_ApproxUpdateScaledS
              
/* 01404 80A013A4 260400B4 */  addiu   $a0, $s0, 0x00B4           ## $a0 = 000000B4
/* 01408 80A013A8 2604014C */  addiu   $a0, $s0, 0x014C           ## $a0 = 0000014C
/* 0140C 80A013AC 0C02927F */  jal     SkelAnime_FrameUpdateMatrix
              
/* 01410 80A013B0 AFA40024 */  sw      $a0, 0x0024($sp)           
/* 01414 80A013B4 8FA40024 */  lw      $a0, 0x0024($sp)           
/* 01418 80A013B8 0C0295B2 */  jal     func_800A56C8              
/* 0141C 80A013BC 24050000 */  addiu   $a1, $zero, 0x0000         ## $a1 = 00000000
/* 01420 80A013C0 10400003 */  beq     $v0, $zero, .L80A013D0     
/* 01424 80A013C4 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 01428 80A013C8 0C00BE0A */  jal     Audio_PlayActorSound2
              
/* 0142C 80A013CC 2405394E */  addiu   $a1, $zero, 0x394E         ## $a1 = 0000394E
.L80A013D0:
/* 01430 80A013D0 960F0088 */  lhu     $t7, 0x0088($s0)           ## 00000088
/* 01434 80A013D4 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 01438 80A013D8 31F80002 */  andi    $t8, $t7, 0x0002           ## $t8 = 00000000
/* 0143C 80A013DC 53000004 */  beql    $t8, $zero, .L80A013F0     
/* 01440 80A013E0 86190194 */  lh      $t9, 0x0194($s0)           ## 00000194
/* 01444 80A013E4 0C00BE0A */  jal     Audio_PlayActorSound2
              
/* 01448 80A013E8 2405387B */  addiu   $a1, $zero, 0x387B         ## $a1 = 0000387B
/* 0144C 80A013EC 86190194 */  lh      $t9, 0x0194($s0)           ## 00000194
.L80A013F0:
/* 01450 80A013F0 5720000A */  bnel    $t9, $zero, .L80A0141C     
/* 01454 80A013F4 8FBF001C */  lw      $ra, 0x001C($sp)           
/* 01458 80A013F8 44800000 */  mtc1    $zero, $f0                 ## $f0 = 0.00
/* 0145C 80A013FC 3C0880A0 */  lui     $t0, %hi(D_80A01970+0x22)       ## $t0 = 80A00000
/* 01460 80A01400 02002025 */  or      $a0, $s0, $zero            ## $a0 = 00000000
/* 01464 80A01404 E600006C */  swc1    $f0, 0x006C($s0)           ## 0000006C
/* 01468 80A01408 E6000060 */  swc1    $f0, 0x0060($s0)           ## 00000060
/* 0146C 80A0140C 85081992 */  lh      $t0, %lo(D_80A01970+0x22)($t0)  
/* 01470 80A01410 0C28012F */  jal     func_80A004BC              
/* 01474 80A01414 A60802CA */  sh      $t0, 0x02CA($s0)           ## 000002CA
/* 01478 80A01418 8FBF001C */  lw      $ra, 0x001C($sp)           
.L80A0141C:
/* 0147C 80A0141C 8FB00018 */  lw      $s0, 0x0018($sp)           
/* 01480 80A01420 27BD0028 */  addiu   $sp, $sp, 0x0028           ## $sp = 00000000
/* 01484 80A01424 03E00008 */  jr      $ra                        
/* 01488 80A01428 00000000 */  nop
