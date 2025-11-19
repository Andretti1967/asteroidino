                            * = $7800
7800   00                   BRK
7801   BD 88 78             LDA $7888,X
7804   85 09                STA $09
7806   BD 87 78             LDA $7887,X
7809   85 08                STA $08
780B   71 08                ADC ($08),Y
780D   85 08                STA $08
780F   90 02                BCC L7813
7811   E6 09                INC $09
7813   98         L7813     TYA
7814   0A                   ASL A
7815   A8                   TAY
7816   B9 71 78             LDA $7871,Y
7819   BE 72 78             LDX $7872,Y
781C   20 03 7C             JSR L7C03
781F   A9 70                LDA #$70
7821   20 DE 7C             JSR L7CDE
7824   A0 00                LDY #$00
7826   A2 00                LDX #$00
7828   A1 08      L7828     LDA ($08,X)
782A   85 0B                STA $0B
782C   4A                   LSR A
782D   4A                   LSR A
782E   20 4D 78             JSR L784D
7831   A1 08                LDA ($08,X)
7833   2A                   ROL A
7834   26 0B                ROL $0B
7836   2A                   ROL A
7837   A5 0B                LDA $0B
7839   2A                   ROL A
783A   0A                   ASL A
783B   20 53 78             JSR L7853
783E   A1 08                LDA ($08,X)
7840   85 0B                STA $0B
7842   20 4D 78             JSR L784D
7845   46 0B                LSR $0B
7847   90 DF                BCC L7828
7849   88         L7849     DEY
784A   4C 39 7C             JMP L7C39
784D   E6 08      L784D     INC $08
784F   D0 02                BNE L7853
7851   E6 09                INC $09
7853   29 3E      L7853     AND #$3E
7855   D0 04                BNE L785B
7857   68                   PLA
7858   68                   PLA
7859   D0 EE                BNE L7849
785B   C9 0A      L785B     CMP #$0A
785D   90 02                BCC L7861
785F   69 0D                ADC #$0D
7861   AA         L7861     TAX
7862   BD D2 56             LDA $56D2,X
7865   91 02                STA ($02),Y
7867   C8                   INY
7868   BD D3 56             LDA $56D3,X
786B   91 02                STA ($02),Y
786D   C8                   INY
786E   A2 00                LDX #$00
7870   60                   RTS
7871   64 B6                NOP $B6
7873   64 B6                NOP $B6
7875   0C AA 0C             NOP $0CAA
7878   A2 0C                LDX #$0C
787A   9A                   TXS
787B   0C 92 64             NOP $6492
787E   C6 64                DEC $64
7880   9D 50 39             STA $3950,X
7883   50 39                BVC L78BE
7885   50 39                BVC L78C0
7887   1E 57 8F             ASL $8F57,X
788A   78                   SEI
788B   46 79                LSR $79
788D   F3 79                ISC ($79),Y
788F   0B 15                ANC #$15
7891   1B 35 4D             SLO $4D35,Y
7894   65 7F                ADC $7F
7896   8D 93 9F             STA $9F93
7899   AB 64                LXA #$64
789B   D2                   JAM
789C   3B 2E C2             RLA $C22E,Y
789F   6C 5A 4C             JMP ($4C5A)
78A2   93 6F                SHA ($6F),Y
78A4   BD 1A 4C             LDA $4C1A,X
78A7   12                   JAM
78A8   B0 40                BCS L78EA
78AA   6B 2C                ARR #$2C
78AC   0A                   ASL A
78AD   6C 5A 4C             JMP ($4C5A)
78B0   93 6E                SHA ($6E),Y
78B2   0B 6E                ANC #$6E
78B4   C0 52                CPY #$52
78B6   6C 92 B8             JMP ($B892)
78B9   50 4D                BVC L7908
78BB   82 F2                NOP #$F2
78BD   58                   CLI
78BE   90 4C      L78BE     BCC L790C
78C0   4D F0 4C   L78C0     EOR $4CF0
78C3   80 33                NOP #$33
78C5   70 C2                BVS L7889
78C7   42                   JAM
78C8   5A                   NOP
78C9   4C 4C 82             JMP $824C
78CC   BB 52 0B             LAS $0B52,Y
78CF   58                   CLI
78D0   B2                   JAM
78D1   42                   JAM
78D2   6C 9A C3             JMP ($C39A)
78D5   4A                   LSR A
78D6   82 64                NOP #$64
78D8   0A                   ASL A
78D9   5A                   NOP
78DA   90 00                BCC L78DC
78DC   F6 6C      L78DC     INC $6C,X
78DE   09 B2                ORA #$B2
78E0   3B 2E C1             RLA $C12E,Y
78E3   4C 4C B6             JMP $B64C
78E6   2B 20                ANC #$20
78E8   0D A6 C1             ORA $C1A6
78EB   70 48                BVS L7935
78ED   50 B6                BVC L78A5
78EF   52                   JAM
78F0   3B D2 90             RLA $90D2,Y
78F3   00                   BRK
78F4   DA                   NOP
78F5   64 90                NOP $90
78F7   4C C9 D8             JMP $D8C9
78FA   BE 0A 32             LDX $320A,Y
78FD   42                   JAM
78FE   9B C2 67             TAS $67C2,Y
7901   68                   PLA
7902   4D AE A1             EOR $A1AE
7905   4E 48 50             LSR $5048
7908   B6 52      L7908     LDX $52,Y
790A   3B D2 90             RLA $90D2,Y
790D   00                   BRK
790E   BE 0A B6             LDX $B60A,Y
7911   1E 94 D2             ASL $D294,X
7914   A2 92      L7914     LDX #$92
7916   0A                   ASL A
7917   2C CA 4E             BIT $4ECA
791A   7A                   NOP
791B   65 BD                ADC $BD
791D   1A                   NOP
791E   4C 12 92             JMP $9212
7921   13 18                SLO ($18),Y
7923   62                   JAM
7924   CA                   DEX
7925   64 F2                NOP $F2
7927   42                   JAM
7928   20 6E A3             JSR $A36E
792B   52                   JAM
792C   82 40                NOP #$40
792E   18                   CLC
792F   62                   JAM
7930   CA                   DEX
7931   64 F2                NOP $F2
7933   42                   JAM
7934   18                   CLC
7935   6E A3 52   L7935     ROR $52A3
7938   80 00                NOP #$00
793A   20 62 CA             JSR $CA62
793D   64 F2                NOP $F2
793F   64 08                NOP $08
7941   C2 BD                NOP #$BD
7943   1A                   NOP
7944   4C 00 0B             JMP $0B00
7947   15 19                ORA $19,X
7949   31 41                AND ($41),Y
794B   57 73                SRE $73,X
794D   7F 89 95             RRA $9589,X
7950   A1 8A                LDA ($8A,X)
7952   5A                   NOP
7953   84 12                STY $12
7955   CD 82 B9             CMP $B982
7958   E6 B2                INC $B2
795A   40                   RTI
795B   74 F2                NOP $F2,X
795D   4D 83 D4             EOR $D483
7960   F0 B2                BEQ L7914
7962   42                   JAM
7963   B9 E6 B2             LDA $B2E6,Y
7966   42                   JAM
7967   4D F0 0E             EOR $0EF0
796A   64 0A                NOP $0A
796C   12                   JAM
796D   B8                   CLV
796E   46 10                LSR $10
7970   62                   JAM
7971   4B 60                ALR #$60
7973   82 72                NOP #$72
7975   B5 C0                LDA $C0,X
7977   BE A8 0A             LDX $0AA8,Y
797A   64 C5                NOP $C5
797C   92                   JAM
797D   F0 74                BEQ L79F3
797F   9D C2 6C             STA $6CC2,X
7982   9A                   TXS
7983   C3 4A                DCP ($4A,X)
7985   82 6F                NOP #$6F
7987   A4 F2                LDY $F2
7989   BD D2 F0             LDA $F0D2,X
798C   6C 9E 0A             JMP ($0A9E)
798F   C2 42                NOP #$42
7991   A4 F2                LDY $F2
7993   B0 74                BCS L7A09
7995   9D C2 6C             STA $6CC2,X
7998   9A                   TXS
7999   C3 4A                DCP ($4A,X)
799B   82 6F                NOP #$6F
799D   A4 F2                LDY $F2
799F   BD D2 F0             LDA $F0D2,X
79A2   58                   CLI
79A3   ED 12 B5             SBC $B512
79A6   E8                   INX
79A7   29 D2                AND #$D2
79A9   0D 72 2C             ORA $2C72
79AC   90 0C                BCC L79BA
79AE   12                   JAM
79AF   C6 2C                DEC $2C
79B1   48                   PHA
79B2   4E 9D AC             LSR $AC9D
79B5   49 F0                EOR #$F0
79B7   48                   PHA
79B8   00                   BRK
79B9   2D 28 CF             AND $CF28
79BC   52                   JAM
79BD   B0 6E                BCS L7A2D
79BF   CD 82 BE             CMP $BE82
79C2   0A                   ASL A
79C3   B6 00                LDX $00,Y
79C5   53 64                SRE ($64),Y
79C7   0A                   ASL A
79C8   12                   JAM
79C9   0D 0A B6             ORA $B60A
79CC   1A                   NOP
79CD   48                   PHA
79CE   00                   BRK
79CF   18                   CLC
79D0   68                   PLA
79D1   6A                   ROR A
79D2   4E 48 48             LSR $4848
79D5   0B A6                ANC #$A6
79D7   CA                   DEX
79D8   72                   JAM
79D9   B5 C0                LDA $C0,X
79DB   18                   CLC
79DC   68                   PLA
79DD   6A                   ROR A
79DE   4E 48 46             LSR $4648
79E1   0B A6                ANC #$A6
79E3   CA                   DEX
79E4   72                   JAM
79E5   B0 00                BCS L79E7
79E7   20 68 6A   L79E7     JSR $6A68
79EA   4E 4D C2             LSR $C24D
79ED   18                   CLC
79EE   5C 9E 52             NOP $529E,X
79F1   CD 80 0B             CMP $0B80
79F4   11 17                ORA ($17),Y
79F6   31 45                AND ($45),Y
79F8   5F 6B 73             SRE $736B,X
79FB   7D 89 93             ADC $9389,X
79FE   B2                   JAM
79FF   4E 9D 90             LSR $909D
7A02   B8                   CLV
7A03   00                   BRK
7A04   76 56                ROR $56,X
7A06   2A                   ROL A
7A07   26 B0                ROL $B0
7A09   40         L7A09     RTI
7A0A   BE 42 A6             LDX $A642,Y
7A0D   64 C1                NOP $C1
7A0F   5C 48 52             NOP $5248,X
7A12   BE 0A 0A             LDX $0A0A,Y
7A15   64 C5                NOP $C5
7A17   92                   JAM
7A18   0C 26 B8             NOP $B826
7A1B   50 6A                BVC L7A87
7A1D   7C 0C 52             NOP $520C,X
7A20   74 EC                NOP $EC,X
7A22   4D C0 A4             EOR $A4C0
7A25   EC 0A 8A             CPX $8A0A
7A28   D4 EC                NOP $EC,X
7A2A   0A                   ASL A
7A2B   64 C5                NOP $C5
7A2D   92         L7A2D     JAM
7A2E   0D F2 B8             ORA $B8F2
7A31   5A                   NOP
7A32   93 4E                SHA ($4E),Y
7A34   69 60                ADC #$60
7A36   4D C0 9D             EOR $9DC0
7A39   2C 6C 4A             BIT $4A6C
7A3C   0D A6 C1             ORA $C1A6
7A3F   70 48                BVS L7A89
7A41   68                   PLA
7A42   2D 8A 0D             AND $0D8A
7A45   D2                   JAM
7A46   82 4E                NOP #$4E
7A48   3B 66 91             RLA $9166,Y
7A4B   6C 0C 0A             JMP ($0A0C)
7A4E   0C 12 C5             NOP $C512
7A51   8B 9D                ANE #$9D
7A53   2C 6C 4A             BIT $4A6C
7A56   0B 3A                ANC #$3A
7A58   A2 6C                LDX #$6C
7A5A   BD 0A 3A             LDA $3A0A,X
7A5D   40                   RTI
7A5E   A6 60                LDX $60
7A60   B9 6C 0D             LDA $0D6C,Y
7A63   F0 2D                BEQ L7A92
7A65   B1 76                LDA ($76),Y
7A67   52                   JAM
7A68   5C C2 C2             NOP $C2C2,X
7A6B   6C 8B 64             JMP ($648B)
7A6E   2A                   ROL A
7A6F   27 18                RLA $18
7A71   54 69                NOP $69,X
7A73   D8                   CLD
7A74   28                   PLP
7A75   48                   PHA
7A76   0B B2                ANC #$B2
7A78   4A                   LSR A
7A79   E6 B8                INC $B8
7A7B   00                   BRK
7A7C   18                   CLC
7A7D   54 69                NOP $69,X
7A7F   D8                   CLD
7A80   28                   PLP
7A81   46 0B                LSR $0B
7A83   B2                   JAM
7A84   4A                   LSR A
7A85   E7 20                ISC $20
7A87   54 69      L7A87     NOP $69,X
7A89   D8         L7A89     CLD
7A8A   2D C2 18             AND $18C2
7A8D   5C CA 56             NOP $56CA,X
7A90   98                   TYA
7A91   00                   BRK
7A92   52         L7A92     JAM
7A93   A2 02      L7A93     LDX #$02
7A95   BD 00 24   L7A95     LDA $2400,X
7A98   0A                   ASL A
7A99   B5 7A                LDA $7A,X
7A9B   29 1F                AND #$1F
7A9D   90 37                BCC L7AD6
7A9F   F0 10                BEQ L7AB1
7AA1   C9 1B                CMP #$1B
7AA3   B0 0A                BCS L7AAF
7AA5   A8                   TAY
7AA6   A5 5E                LDA $5E
7AA8   29 07                AND #$07
7AAA   C9 07                CMP #$07
7AAC   98                   TYA
7AAD   90 02                BCC L7AB1
7AAF   E9 01      L7AAF     SBC #$01
7AB1   95 7A      L7AB1     STA $7A,X
7AB3   AD 06 20             LDA $2006
7AB6   29 80                AND #$80
7AB8   F0 04                BEQ L7ABE
7ABA   A9 F0                LDA #$F0
7ABC   85 72                STA $72
7ABE   A5 72      L7ABE     LDA $72
7AC0   F0 08                BEQ L7ACA
7AC2   C6 72                DEC $72
7AC4   A9 00                LDA #$00
7AC6   95 7A                STA $7A,X
7AC8   95 77                STA $77,X
7ACA   18         L7ACA     CLC
7ACB   B5 77                LDA $77,X
7ACD   F0 23                BEQ L7AF2
7ACF   D6 77                DEC $77,X
7AD1   D0 1F                BNE L7AF2
7AD3   38                   SEC
7AD4   B0 1C                BCS L7AF2
7AD6   C9 1B      L7AD6     CMP #$1B
7AD8   B0 09                BCS L7AE3
7ADA   B5 7A                LDA $7A,X
7ADC   69 20                ADC #$20
7ADE   90 D1                BCC L7AB1
7AE0   F0 01                BEQ L7AE3
7AE2   18                   CLC
7AE3   A9 1F      L7AE3     LDA #$1F
7AE5   B0 CA                BCS L7AB1
7AE7   95 7A                STA $7A,X
7AE9   B5 77                LDA $77,X
7AEB   F0 01                BEQ L7AEE
7AED   38                   SEC
7AEE   A9 78      L7AEE     LDA #$78
7AF0   95 77                STA $77,X
7AF2   90 23      L7AF2     BCC L7B17
7AF4   A9 00                LDA #$00
7AF6   E0 01                CPX #$01
7AF8   90 16                BCC L7B10
7AFA   F0 0C                BEQ L7B08
7AFC   A5 71                LDA $71
7AFE   29 0C                AND #$0C
7B00   4A                   LSR A
7B01   4A                   LSR A
7B02   F0 0C                BEQ L7B10
7B04   69 02                ADC #$02
7B06   D0 08                BNE L7B10
7B08   A5 71      L7B08     LDA $71
7B0A   29 10                AND #$10
7B0C   F0 02                BEQ L7B10
7B0E   A9 01                LDA #$01
7B10   38         L7B10     SEC
7B11   65 73                ADC $73
7B13   85 73                STA $73
7B15   F6 74                INC $74,X
7B17   CA         L7B17     DEX
7B18   30 03                BMI L7B1D
7B1A   4C 95 7A             JMP L7A95
7B1D   A5 71      L7B1D     LDA $71
7B1F   29 03                AND #$03
7B21   A8                   TAY
7B22   F0 12                BEQ L7B36
7B24   4A                   LSR A
7B25   69 00                ADC #$00
7B27   49 FF                EOR #$FF
7B29   38                   SEC
7B2A   65 73                ADC $73
7B2C   90 0A                BCC L7B38
7B2E   C0 02                CPY #$02
7B30   B0 02                BCS L7B34
7B32   E6 70                INC $70
7B34   E6 70      L7B34     INC $70
7B36   85 73      L7B36     STA $73
7B38   A5 5E      L7B38     LDA $5E
7B3A   4A                   LSR A
7B3B   B0 27                BCS L7B64
7B3D   A0 00                LDY #$00
7B3F   A2 02                LDX #$02
7B41   B5 74      L7B41     LDA $74,X
7B43   F0 09                BEQ L7B4E
7B45   C9 10                CMP #$10
7B47   90 05                BCC L7B4E
7B49   69 EF                ADC #$EF
7B4B   C8                   INY
7B4C   95 74                STA $74,X
7B4E   CA         L7B4E     DEX
7B4F   10 F0                BPL L7B41
7B51   98                   TYA
7B52   D0 10                BNE L7B64
7B54   A2 02                LDX #$02
7B56   B5 74      L7B56     LDA $74,X
7B58   F0 07                BEQ L7B61
7B5A   18                   CLC
7B5B   69 EF                ADC #$EF
7B5D   95 74                STA $74,X
7B5F   30 03                BMI L7B64
7B61   CA         L7B61     DEX
7B62   10 F2                BPL L7B56
7B64   60         L7B64     RTS
7B65   48                   PHA
7B66   98                   TYA
7B67   48                   PHA
7B68   8A                   TXA
7B69   48                   PHA
7B6A   D8                   CLD
7B6B   AD FF 01             LDA $01FF
7B6E   0D D0 01             ORA $01D0
7B71   D0 FE      L7B71     BNE L7B71
7B73   E6 5E                INC $5E
7B75   A5 5E                LDA $5E
7B77   29 03                AND #$03
7B79   D0 08                BNE L7B83
7B7B   E6 5B                INC $5B
7B7D   A5 5B                LDA $5B
7B7F   C9 04                CMP #$04
7B81   B0 FE      L7B81     BCS L7B81
7B83   20 93 7A   L7B83     JSR L7A93
7B86   A5 6F                LDA $6F
7B88   29 C7                AND #$C7
7B8A   24 74                BIT $74
7B8C   10 02                BPL L7B90
7B8E   09 08                ORA #$08
7B90   24 75      L7B90     BIT $75
7B92   10 02                BPL L7B96
7B94   09 10                ORA #$10
7B96   24 76      L7B96     BIT $76
7B98   10 02                BPL L7B9C
7B9A   09 20                ORA #$20
7B9C   85 6F      L7B9C     STA $6F
7B9E   8D 00 32             STA $3200
7BA1   A5 72                LDA $72
7BA3   F0 04                BEQ L7BA9
7BA5   A9 80                LDA #$80
7BA7   D0 0E                BNE L7BB7
7BA9   A5 68      L7BA9     LDA $68
7BAB   F0 0A                BEQ L7BB7
7BAD   A5 5C                LDA $5C
7BAF   6A                   ROR A
7BB0   90 02                BCC L7BB4
7BB2   C6 68                DEC $68
7BB4   6A         L7BB4     ROR A
7BB5   6A                   ROR A
7BB6   6A                   ROR A
7BB7   8D 05 3C   L7BB7     STA $3C05
7BBA   68                   PLA
7BBB   AA                   TAX
7BBC   68                   PLA
7BBD   A8                   TAY
7BBE   68                   PLA
7BBF   40                   RTI
7BC0   A9 B0      L7BC0     LDA #$B0
7BC2   A0 00      L7BC2     LDY #$00
7BC4   91 02                STA ($02),Y
7BC6   C8                   INY
7BC7   91 02                STA ($02),Y
7BC9   D0 6E                BNE L7C39
7BCB   90 04                BCC L7BD1
7BCD   29 0F                AND #$0F
7BCF   F0 05                BEQ L7BD6
7BD1   29 0F      L7BD1     AND #$0F
7BD3   18                   CLC
7BD4   69 01                ADC #$01
7BD6   08         L7BD6     PHP
7BD7   0A                   ASL A
7BD8   A0 00                LDY #$00
7BDA   AA                   TAX
7BDB   BD D4 56             LDA $56D4,X
7BDE   91 02                STA ($02),Y
7BE0   BD D5 56             LDA $56D5,X
7BE3   C8                   INY
7BE4   91 02                STA ($02),Y
7BE6   20 39 7C             JSR L7C39
7BE9   28                   PLP
7BEA   60                   RTS
7BEB   4A                   LSR A
7BEC   29 0F                AND #$0F
7BEE   09 E0                ORA #$E0
7BF0   A0 01      L7BF0     LDY #$01
7BF2   91 02                STA ($02),Y
7BF4   88                   DEY
7BF5   8A                   TXA
7BF6   6A                   ROR A
7BF7   91 02                STA ($02),Y
7BF9   C8                   INY
7BFA   D0 3D                BNE L7C39
7BFC   4A         L7BFC     LSR A
7BFD   29 0F                AND #$0F
7BFF   09 C0                ORA #$C0
7C01   D0 ED                BNE L7BF0
7C03   A0 00      L7C03     LDY #$00
7C05   84 05                STY $05
7C07   84 07                STY $07
7C09   0A                   ASL A
7C0A   26 05                ROL $05
7C0C   0A                   ASL A
7C0D   26 05                ROL $05
7C0F   85 04                STA $04
7C11   8A                   TXA
7C12   0A                   ASL A
7C13   26 07                ROL $07
7C15   0A                   ASL A
7C16   26 07                ROL $07
7C18   85 06                STA $06
7C1A   A2 04                LDX #$04
7C1C   B5 02                LDA $02,X
7C1E   A0 00                LDY #$00
7C20   91 02                STA ($02),Y
7C22   B5 03                LDA $03,X
7C24   29 0F                AND #$0F
7C26   09 A0                ORA #$A0
7C28   C8                   INY
7C29   91 02                STA ($02),Y
7C2B   B5 00                LDA $00,X
7C2D   C8                   INY
7C2E   91 02                STA ($02),Y
7C30   B5 01                LDA $01,X
7C32   29 0F                AND #$0F
7C34   05 00                ORA $00
7C36   C8                   INY
7C37   91 02                STA ($02),Y
7C39   98         L7C39     TYA
7C3A   38                   SEC
7C3B   65 02                ADC $02
7C3D   85 02                STA $02
7C3F   90 02                BCC L7C43
7C41   E6 03                INC $03
7C43   60         L7C43     RTS
7C44   A9 D0                LDA #$D0
7C46   4C C2 7B             JMP L7BC2
7C49   A5 05                LDA $05
7C4B   C9 80                CMP #$80
7C4D   90 11                BCC L7C60
7C4F   49 FF                EOR #$FF
7C51   85 05                STA $05
7C53   A5 04                LDA $04
7C55   49 FF                EOR #$FF
7C57   69 00                ADC #$00
7C59   85 04                STA $04
7C5B   90 02                BCC L7C5F
7C5D   E6 05                INC $05
7C5F   38         L7C5F     SEC
7C60   26 08      L7C60     ROL $08
7C62   A5 07                LDA $07
7C64   C9 80                CMP #$80
7C66   90 11                BCC L7C79
7C68   49 FF                EOR #$FF
7C6A   85 07                STA $07
7C6C   A5 06                LDA $06
7C6E   49 FF                EOR #$FF
7C70   69 00                ADC #$00
7C72   85 06                STA $06
7C74   90 02                BCC L7C78
7C76   E6 07                INC $07
7C78   38         L7C78     SEC
7C79   26 08      L7C79     ROL $08
7C7B   A5 05                LDA $05
7C7D   05 07                ORA $07
7C7F   F0 0A                BEQ L7C8B
7C81   A2 00                LDX #$00
7C83   C9 02                CMP #$02
7C85   B0 24                BCS L7CAB
7C87   A0 01                LDY #$01
7C89   D0 10                BNE L7C9B
7C8B   A0 02      L7C8B     LDY #$02
7C8D   A2 09                LDX #$09
7C8F   A5 04                LDA $04
7C91   05 06                ORA $06
7C93   F0 16                BEQ L7CAB
7C95   30 04                BMI L7C9B
7C97   C8         L7C97     INY
7C98   0A                   ASL A
7C99   10 FC                BPL L7C97
7C9B   98         L7C9B     TYA
7C9C   AA                   TAX
7C9D   A5 05                LDA $05
7C9F   06 04      L7C9F     ASL $04
7CA1   2A                   ROL A
7CA2   06 06                ASL $06
7CA4   26 07                ROL $07
7CA6   88                   DEY
7CA7   D0 F6                BNE L7C9F
7CA9   85 05                STA $05
7CAB   8A         L7CAB     TXA
7CAC   38                   SEC
7CAD   E9 0A                SBC #$0A
7CAF   49 FF                EOR #$FF
7CB1   0A                   ASL A
7CB2   66 08                ROR $08
7CB4   2A                   ROL A
7CB5   66 08                ROR $08
7CB7   2A                   ROL A
7CB8   0A                   ASL A
7CB9   85 08                STA $08
7CBB   A0 00                LDY #$00
7CBD   A5 06                LDA $06
7CBF   91 02                STA ($02),Y
7CC1   A5 08                LDA $08
7CC3   29 F4                AND #$F4
7CC5   05 07                ORA $07
7CC7   C8                   INY
7CC8   91 02                STA ($02),Y
7CCA   A5 04                LDA $04
7CCC   C8                   INY
7CCD   91 02                STA ($02),Y
7CCF   A5 08                LDA $08
7CD1   29 02                AND #$02
7CD3   0A                   ASL A
7CD4   05 01                ORA $01
7CD6   05 05                ORA $05
7CD8   C8                   INY
7CD9   91 02                STA ($02),Y
7CDB   4C 39 7C             JMP L7C39
7CDE   A2 00      L7CDE     LDX #$00
7CE0   A0 01                LDY #$01
7CE2   91 02                STA ($02),Y
7CE4   88                   DEY
7CE5   98                   TYA
7CE6   91 02                STA ($02),Y
7CE8   C8                   INY
7CE9   C8                   INY
7CEA   91 02                STA ($02),Y
7CEC   C8                   INY
7CED   8A                   TXA
7CEE   91 02                STA ($02),Y
7CF0   4C 39 7C             JMP L7C39
7CF3   A2 FE                LDX #$FE
7CF5   9A                   TXS
7CF6   D8                   CLD
7CF7   A9 00                LDA #$00
7CF9   AA                   TAX
7CFA   CA         L7CFA     DEX
7CFB   9D 00 03             STA $0300,X
7CFE   9D 00 02             STA $0200,X
7D01   9D 00 01             STA $0100,X
7D04   95 00                STA $00,X
7D06   D0 F2                BNE L7CFA
7D08   AC 07 20             LDY $2007
7D0B   30 43                BMI L7D50
7D0D   E8                   INX
7D0E   8E 00 40             STX $4000
7D11   A9 E2                LDA #$E2
7D13   8D 01 40             STA $4001
7D16   A9 B0                LDA #$B0
7D18   8D 03 40             STA $4003
7D1B   85 32                STA $32
7D1D   85 33                STA $33
7D1F   A9 03                LDA #$03
7D21   85 6F                STA $6F
7D23   8D 00 32             STA $3200
7D26   2D 00 28             AND $2800
7D29   85 71                STA $71
7D2B   AD 01 28             LDA $2801
7D2E   29 03                AND #$03
7D30   0A                   ASL A
7D31   0A                   ASL A
7D32   05 71                ORA $71
7D34   85 71                STA $71
7D36   AD 02 28             LDA $2802
7D39   29 02                AND #$02
7D3B   0A                   ASL A
7D3C   0A                   ASL A
7D3D   0A                   ASL A
7D3E   05 71                ORA $71
7D40   85 71                STA $71
7D42   4C 03 68             JMP $6803
7D45   A0 00      L7D45     LDY #$00
7D47   91 02                STA ($02),Y
7D49   C8                   INY
7D4A   8A                   TXA
7D4B   91 02                STA ($02),Y
7D4D   4C 39 7C             JMP L7C39
7D50   9D 00 40   L7D50     STA $4000,X
7D53   9D 00 41             STA $4100,X
7D56   9D 00 42             STA $4200,X
7D59   9D 00 43             STA $4300,X
7D5C   9D 00 44             STA $4400,X
7D5F   9D 00 45             STA $4500,X
7D62   9D 00 46             STA $4600,X
7D65   9D 00 47             STA $4700,X
7D68   E8                   INX
7D69   D0 E5                BNE L7D50
7D6B   8D 00 34             STA $3400
7D6E   A2 00                LDX #$00
7D70   B5 00      L7D70     LDA $00,X
7D72   D0 47                BNE L7DBB
7D74   A9 11                LDA #$11
7D76   95 00      L7D76     STA $00,X
7D78   A8                   TAY
7D79   55 00                EOR $00,X
7D7B   D0 3E                BNE L7DBB
7D7D   98                   TYA
7D7E   0A                   ASL A
7D7F   90 F5                BCC L7D76
7D81   E8                   INX
7D82   D0 EC                BNE L7D70
7D84   8D 00 34             STA $3400
7D87   8A                   TXA
7D88   85 00                STA $00
7D8A   2A                   ROL A
7D8B   85 01      L7D8B     STA $01
7D8D   A0 00                LDY #$00
7D8F   A2 11      L7D8F     LDX #$11
7D91   B1 00                LDA ($00),Y
7D93   D0 2A                BNE L7DBF
7D95   8A         L7D95     TXA
7D96   91 00                STA ($00),Y
7D98   51 00                EOR ($00),Y
7D9A   D0 23                BNE L7DBF
7D9C   8A                   TXA
7D9D   0A                   ASL A
7D9E   AA                   TAX
7D9F   90 F4                BCC L7D95
7DA1   C8                   INY
7DA2   D0 EB                BNE L7D8F
7DA4   8D 00 34             STA $3400
7DA7   E6 01                INC $01
7DA9   A6 01                LDX $01
7DAB   E0 04                CPX #$04
7DAD   90 E0                BCC L7D8F
7DAF   A9 40                LDA #$40
7DB1   E0 40                CPX #$40
7DB3   90 D6                BCC L7D8B
7DB5   E0 48                CPX #$48
7DB7   90 D6                BCC L7D8F
7DB9   B0 69                BCS L7E24
7DBB   A0 00      L7DBB     LDY #$00
7DBD   F0 0E                BEQ L7DCD
7DBF   A0 00      L7DBF     LDY #$00
7DC1   A6 01                LDX $01
7DC3   E0 04                CPX #$04
7DC5   90 06                BCC L7DCD
7DC7   C8                   INY
7DC8   E0 44                CPX #$44
7DCA   90 01                BCC L7DCD
7DCC   C8                   INY
7DCD   C9 10      L7DCD     CMP #$10
7DCF   2A                   ROL A
7DD0   29 1F                AND #$1F
7DD2   C9 02                CMP #$02
7DD4   2A                   ROL A
7DD5   29 03                AND #$03
7DD7   88         L7DD7     DEY
7DD8   30 04                BMI L7DDE
7DDA   0A                   ASL A
7DDB   0A                   ASL A
7DDC   90 F9                BCC L7DD7
7DDE   4A         L7DDE     LSR A
7DDF   A2 14                LDX #$14
7DE1   90 02                BCC L7DE5
7DE3   A2 1D                LDX #$1D
7DE5   8E 00 3A   L7DE5     STX $3A00
7DE8   A2 00                LDX #$00
7DEA   A0 08                LDY #$08
7DEC   2C 01 20   L7DEC     BIT $2001
7DEF   10 FB                BPL L7DEC
7DF1   2C 01 20   L7DF1     BIT $2001
7DF4   30 FB                BMI L7DF1
7DF6   CA                   DEX
7DF7   8D 00 34             STA $3400
7DFA   D0 F0                BNE L7DEC
7DFC   88                   DEY
7DFD   D0 ED                BNE L7DEC
7DFF   8E 00 3A             STX $3A00
7E02   A0 08                LDY #$08
7E04   2C 01 20   L7E04     BIT $2001
7E07   10 FB                BPL L7E04
7E09   2C 01 20   L7E09     BIT $2001
7E0C   30 FB                BMI L7E09
7E0E   CA                   DEX
7E0F   8D 00 34             STA $3400
7E12   D0 F0                BNE L7E04
7E14   88                   DEY
7E15   D0 ED                BNE L7E04
7E17   AA                   TAX
7E18   D0 C4                BNE L7DDE
7E1A   8D 00 34   L7E1A     STA $3400
7E1D   AD 07 20             LDA $2007
7E20   30 F8                BMI L7E1A
7E22   10 FE      L7E22     BPL L7E22
7E24   A9 00      L7E24     LDA #$00
7E26   A8                   TAY
7E27   AA                   TAX
7E28   85 08                STA $08
7E2A   A9 50                LDA #$50
7E2C   85 09      L7E2C     STA $09
7E2E   A9 04                LDA #$04
7E30   85 0B                STA $0B
7E32   A9 FF                LDA #$FF
7E34   51 08      L7E34     EOR ($08),Y
7E36   C8                   INY
7E37   D0 FB                BNE L7E34
7E39   E6 09                INC $09
7E3B   C6 0B                DEC $0B
7E3D   D0 F5                BNE L7E34
7E3F   95 0D                STA $0D,X
7E41   E8                   INX
7E42   8D 00 34             STA $3400
7E45   A5 09                LDA $09
7E47   C9 58                CMP #$58
7E49   90 E1                BCC L7E2C
7E4B   D0 02                BNE L7E4F
7E4D   A9 68                LDA #$68
7E4F   C9 80      L7E4F     CMP #$80
7E51   90 D9                BCC L7E2C
7E53   8D 00 03             STA $0300
7E56   A2 04                LDX #$04
7E58   8E 00 32             STX $3200
7E5B   86 15                STX $15
7E5D   A2 00                LDX #$00
7E5F   CD 00 02             CMP $0200
7E62   F0 01                BEQ L7E65
7E64   E8                   INX
7E65   AD 00 03   L7E65     LDA $0300
7E68   C9 88                CMP #$88
7E6A   F0 01                BEQ L7E6D
7E6C   E8                   INX
7E6D   86 16      L7E6D     STX $16
7E6F   A9 10                LDA #$10
7E71   85 00                STA $00
7E73   A2 24      L7E73     LDX #$24
7E75   AD 01 20   L7E75     LDA $2001
7E78   10 FB                BPL L7E75
7E7A   AD 01 20   L7E7A     LDA $2001
7E7D   30 FB                BMI L7E7A
7E7F   CA                   DEX
7E80   10 F3                BPL L7E75
7E82   2C 02 20   L7E82     BIT $2002
7E85   30 FB                BMI L7E82
7E87   8D 00 34             STA $3400
7E8A   A9 00                LDA #$00
7E8C   85 02                STA $02
7E8E   A9 40                LDA #$40
7E90   85 03                STA $03
7E92   AD 05 20             LDA $2005
7E95   10 5B                BPL L7EF2
7E97   A6 15      L7E97     LDX $15
7E99   AD 03 20             LDA $2003
7E9C   10 0A      L7E9C     BPL L7EA8
7E9E   4D 09 00             EOR $0009
7EA1   10 05                BPL L7EA8
7EA3   CA                   DEX
7EA4   F0 02                BEQ L7EA8
7EA6   86 15                STX $15
7EA8   BC BB 7E   L7EA8     LDY $7EBB,X
7EAB   A9 B0                LDA #$B0
7EAD   91 02                STA ($02),Y
7EAF   88                   DEY
7EB0   88                   DEY
7EB1   B9 C0 7E   L7EB1     LDA $7EC0,Y
7EB4   91 02                STA ($02),Y
7EB6   88                   DEY
7EB7   10 F8                BPL L7EB1
7EB9   4C 9D 7F             JMP L7F9D
7EBC   33 1D                RLA ($1D),Y
7EBE   17 0D                SLO $0D,X
7EC0   80 A0                NOP #$A0
7EC2   00                   BRK
7EC3   00                   BRK
7EC4   00                   BRK
7EC5   70 00                BVS L7EC7
7EC7   00         L7EC7     BRK
7EC8   FF 92 FF             ISC $FF92,X
7ECB   73 D0                RRA ($D0),Y
7ECD   A1 30                LDA ($30,X)
7ECF   02                   JAM
7ED0   00                   BRK
7ED1   70 00                BVS L7ED3
7ED3   00         L7ED3     BRK
7ED4   7F FB 0D             RRA $0DFB,X
7ED7   E0 00                CPX #$00
7ED9   B0 7E                BCS L7F59
7EDB   FA                   NOP
7EDC   11 C0                ORA ($C0),Y
7EDE   78                   SEI
7EDF   FE 00 B0             INC $B000,X
7EE2   13 C0                SLO ($C0),Y
7EE4   00                   BRK
7EE5   D0 15                BNE L7EFC
7EE7   C0 00                CPY #$00
7EE9   D0 17                BNE L7F02
7EEB   C0 00                CPY #$00
7EED   D0 7A                BNE L7F69
7EEF   F8                   SED
7EF0   00                   BRK
7EF1   D0 A9                BNE L7E9C
7EF3   50 A2                BVC L7E97
7EF5   00                   BRK
7EF6   20 FC 7B             JSR L7BFC
7EF9   A9 69                LDA #$69
7EFB   A2 93                LDX #$93
7EFD   20 03 7C             JSR L7C03
7F00   A9 30                LDA #$30
7F02   20 DE 7C   L7F02     JSR L7CDE
7F05   A2 03                LDX #$03
7F07   BD 00 28   L7F07     LDA $2800,X
7F0A   29 01                AND #$01
7F0C   86 0B                STX $0B
7F0E   20 D1 7B             JSR L7BD1
7F11   A6 0B                LDX $0B
7F13   BD 00 28             LDA $2800,X
7F16   29 02                AND #$02
7F18   4A                   LSR A
7F19   20 D1 7B             JSR L7BD1
7F1C   A6 0B                LDX $0B
7F1E   CA                   DEX
7F1F   10 E6                BPL L7F07
7F21   A9 7A                LDA #$7A
7F23   A2 9D                LDX #$9D
7F25   20 03 7C             JSR L7C03
7F28   A9 10                LDA #$10
7F2A   20 DE 7C             JSR L7CDE
7F2D   AD 02 28             LDA $2802
7F30   29 02                AND #$02
7F32   4A                   LSR A
7F33   69 01                ADC #$01
7F35   20 D1 7B             JSR L7BD1
7F38   AD 01 28             LDA $2801
7F3B   29 03                AND #$03
7F3D   AA                   TAX
7F3E   BD F5 7F             LDA $7FF5,X
7F41   20 D1 7B             JSR L7BD1
7F44   A5 16                LDA $16
7F46   F0 07                BEQ L7F4F
7F48   A2 88                LDX #$88
7F4A   A9 50                LDA #$50
7F4C   20 FC 7B             JSR L7BFC
7F4F   A2 96      L7F4F     LDX #$96
7F51   8E 0C 00             STX $000C
7F54   A2 07                LDX #$07
7F56   B5 0D      L7F56     LDA $0D,X
7F58   F0 37                BEQ L7F91
7F5A   48                   PHA
7F5B   8E 0B 00             STX $000B
7F5E   AE 0C 00             LDX $000C
7F61   8A                   TXA
7F62   38                   SEC
7F63   E9 08                SBC #$08
7F65   8D 0C 00             STA $000C
7F68   A9 20                LDA #$20
7F6A   20 03 7C             JSR L7C03
7F6D   A9 70                LDA #$70
7F6F   20 DE 7C             JSR L7CDE
7F72   AD 0B 00             LDA $000B
7F75   20 D1 7B             JSR L7BD1
7F78   AD D4 56             LDA $56D4
7F7B   AE D5 56             LDX $56D5
7F7E   20 45 7D             JSR L7D45
7F81   68                   PLA
7F82   48                   PHA
7F83   4A                   LSR A
7F84   4A                   LSR A
7F85   4A                   LSR A
7F86   4A                   LSR A
7F87   20 D1 7B             JSR L7BD1
7F8A   68                   PLA
7F8B   20 D1 7B             JSR L7BD1
7F8E   AE 0B 00             LDX $000B
7F91   CA         L7F91     DEX
7F92   10 C2                BPL L7F56
7F94   A9 7F                LDA #$7F
7F96   AA                   TAX
7F97   20 03 7C             JSR L7C03
7F9A   20 C0 7B             JSR L7BC0
7F9D   A9 00      L7F9D     LDA #$00
7F9F   A2 04                LDX #$04
7FA1   3E 03 20   L7FA1     ROL $2003,X
7FA4   6A                   ROR A
7FA5   CA                   DEX
7FA6   10 F9                BPL L7FA1
7FA8   A8                   TAY
7FA9   A2 07                LDX #$07
7FAB   3E 00 24   L7FAB     ROL $2400,X
7FAE   2A                   ROL A
7FAF   CA                   DEX
7FB0   10 F9                BPL L7FAB
7FB2   AA                   TAX
7FB3   45 08                EOR $08
7FB5   86 08                STX $08
7FB7   08                   PHP
7FB8   A9 04                LDA #$04
7FBA   8D 00 32             STA $3200
7FBD   2E 03 20             ROL $2003
7FC0   2A                   ROL A
7FC1   2E 04 20             ROL $2004
7FC4   2A                   ROL A
7FC5   2E 07 24             ROL $2407
7FC8   2A                   ROL A
7FC9   2E 06 24             ROL $2406
7FCC   2A                   ROL A
7FCD   2E 05 24             ROL $2405
7FD0   2A                   ROL A
7FD1   AA                   TAX
7FD2   28                   PLP
7FD3   D0 09                BNE L7FDE
7FD5   45 0A                EOR $0A
7FD7   D0 05                BNE L7FDE
7FD9   98                   TYA
7FDA   45 09                EOR $09
7FDC   F0 02                BEQ L7FE0
7FDE   A9 80      L7FDE     LDA #$80
7FE0   8D 05 3C   L7FE0     STA $3C05
7FE3   8D 00 32             STA $3200
7FE6   8D 00 30             STA $3000
7FE9   86 0A                STX $0A
7FEB   84 09                STY $09
7FED   AD 07 20             LDA $2007
7FF0   10 FE      L7FF0     BPL L7FF0
7FF2   4C 73 7E             JMP L7E73
7FF5   01 04                ORA ($04,X)
7FF7   05 06                ORA $06
7FF9   4E 65 7B             LSR $7B65
7FFC   F3 7C                ISC ($7C),Y
7FFE   F3 7C                ISC ($7C),Y
                            .END

;auto-generated symbols and labels
 L7813      $7813
 L7828      $7828
 L7849      $7849
 L7853      $7853
 L7861      $7861
 L7889      $7889
 L7908      $7908
 L7914      $7914
 L7935      $7935
 L7C03      $7C03
 L7CDE      $7CDE
 L784D      $784D
 L7C39      $7C39
 L785B      $785B
 L78BE      $78BE
 L78C0      $78C0
 L78EA      $78EA
 L790C      $790C
 L78DC      $78DC
 L78A5      $78A5
 L79F3      $79F3
 L7A09      $7A09
 L79BA      $79BA
 L7A2D      $7A2D
 L79E7      $79E7
 L7A87      $7A87
 L7A89      $7A89
 L7A92      $7A92
 L7AD6      $7AD6
 L7AB1      $7AB1
 L7AAF      $7AAF
 L7ABE      $7ABE
 L7ACA      $7ACA
 L7AF2      $7AF2
 L7AE3      $7AE3
 L7AEE      $7AEE
 L7B17      $7B17
 L7B10      $7B10
 L7B08      $7B08
 L7B1D      $7B1D
 L7A95      $7A95
 L7B36      $7B36
 L7B38      $7B38
 L7B34      $7B34
 L7B64      $7B64
 L7B4E      $7B4E
 L7B41      $7B41
 L7B61      $7B61
 L7B56      $7B56
 L7B71      $7B71
 L7B83      $7B83
 L7B81      $7B81
 L7A93      $7A93
 L7B90      $7B90
 L7B96      $7B96
 L7B9C      $7B9C
 L7BA9      $7BA9
 L7BB7      $7BB7
 L7BB4      $7BB4
 L7BD1      $7BD1
 L7BD6      $7BD6
 L7BF0      $7BF0
 L7C43      $7C43
 L7BC2      $7BC2
 L7C60      $7C60
 L7C5F      $7C5F
 L7C79      $7C79
 L7C78      $7C78
 L7C8B      $7C8B
 L7CAB      $7CAB
 L7C9B      $7C9B
 L7C97      $7C97
 L7C9F      $7C9F
 L7CFA      $7CFA
 L7D50      $7D50
 L7DBB      $7DBB
 L7D76      $7D76
 L7D70      $7D70
 L7DBF      $7DBF
 L7D95      $7D95
 L7D8F      $7D8F
 L7D8B      $7D8B
 L7E24      $7E24
 L7DCD      $7DCD
 L7DDE      $7DDE
 L7DD7      $7DD7
 L7DE5      $7DE5
 L7DEC      $7DEC
 L7DF1      $7DF1
 L7E04      $7E04
 L7E09      $7E09
 L7E1A      $7E1A
 L7E22      $7E22
 L7E34      $7E34
 L7E2C      $7E2C
 L7E4F      $7E4F
 L7E65      $7E65
 L7E6D      $7E6D
 L7E75      $7E75
 L7E7A      $7E7A
 L7E82      $7E82
 L7EF2      $7EF2
 L7EA8      $7EA8
 L7EB1      $7EB1
 L7F9D      $7F9D
 L7EC7      $7EC7
 L7ED3      $7ED3
 L7F59      $7F59
 L7EFC      $7EFC