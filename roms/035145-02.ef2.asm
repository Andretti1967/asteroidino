                            * = $6800
6800   4C F3 7C             JMP $7CF3
6803   20 FA 6E   L6803     JSR L6EFA
6806   20 D8 6E             JSR L6ED8
6809   20 68 71   L6809     JSR $7168
680C   AD 07 20   L680C     LDA $2007
680F   30 FE      L680F     BMI L680F
6811   46 5B                LSR $5B
6813   90 F7                BCC L680C
6815   AD 02 20   L6815     LDA $2002
6818   30 FB                BMI L6815
681A   AD 01 40             LDA $4001
681D   49 02                EOR #$02
681F   8D 01 40             STA $4001
6822   8D 00 30             STA $3000
6825   8D 00 34             STA $3400
6828   E6 5C                INC $5C
682A   D0 02                BNE L682E
682C   E6 5D                INC $5D
682E   A2 40      L682E     LDX #$40
6830   29 02                AND #$02
6832   D0 02                BNE L6836
6834   A2 44                LDX #$44
6836   A9 02      L6836     LDA #$02
6838   85 02                STA $02
683A   86 03                STX $03
683C   20 85 68             JSR L6885
683F   B0 C2                BCS L6803
6841   20 5C 76             JSR $765C
6844   20 90 6D             JSR L6D90
6847   10 1B                BPL L6864
6849   20 C4 73             JSR $73C4
684C   B0 16                BCS L6864
684E   A5 5A                LDA $5A
6850   D0 0C                BNE L685E
6852   20 D7 6C             JSR L6CD7
6855   20 74 6E             JSR L6E74
6858   20 3F 70             JSR $703F
685B   20 93 6B             JSR L6B93
685E   20 57 6F   L685E     JSR L6F57
6861   20 F0 69             JSR L69F0
6864   20 4F 72   L6864     JSR $724F
6867   20 55 75             JSR $7555
686A   A9 7F                LDA #$7F
686C   AA                   TAX
686D   20 03 7C             JSR $7C03
6870   20 B5 77             JSR $77B5
6873   20 C0 7B             JSR $7BC0
6876   AD FB 02             LDA $02FB
6879   F0 03                BEQ L687E
687B   CE FB 02             DEC $02FB
687E   0D F6 02   L687E     ORA $02F6
6881   D0 89                BNE L680C
6883   F0 84                BEQ L6809
6885   A5 1C      L6885     LDA $1C
6887   F0 14                BEQ L689D
6889   A5 5A                LDA $5A
688B   D0 03                BNE L6890
688D   4C 60 69             JMP L6960
6890   C6 5A      L6890     DEC $5A
6892   20 E2 69             JSR L69E2
6895   18         L6895     CLC
6896   60                   RTS
6897   A9 02      L6897     LDA #$02
6899   85 70                STA $70
689B   D0 13                BNE L68B0
689D   A5 71      L689D     LDA $71
689F   29 03                AND #$03
68A1   F0 F4                BEQ L6897
68A3   18                   CLC
68A4   69 07                ADC #$07
68A6   A8                   TAY
68A7   A5 32                LDA $32
68A9   25 33                AND $33
68AB   10 03                BPL L68B0
68AD   20 F6 77             JSR $77F6
68B0   A4 70      L68B0     LDY $70
68B2   F0 E1                BEQ L6895
68B4   A2 01                LDX #$01
68B6   AD 03 24             LDA $2403
68B9   30 23                BMI L68DE
68BB   C0 02                CPY #$02
68BD   90 7C                BCC L693B
68BF   AD 04 24             LDA $2404
68C2   10 77                BPL L693B
68C4   A5 6F                LDA $6F
68C6   09 04                ORA #$04
68C8   85 6F                STA $6F
68CA   8D 00 32             STA $3200
68CD   20 D8 6E             JSR L6ED8
68D0   20 68 71             JSR $7168
68D3   20 E8 71             JSR $71E8
68D6   A5 56                LDA $56
68D8   85 58                STA $58
68DA   A2 02                LDX #$02
68DC   C6 70                DEC $70
68DE   86 1C      L68DE     STX $1C
68E0   C6 70                DEC $70
68E2   A5 6F                LDA $6F
68E4   29 F8                AND #$F8
68E6   45 1C                EOR $1C
68E8   85 6F                STA $6F
68EA   8D 00 32             STA $3200
68ED   20 E8 71             JSR $71E8
68F0   A9 01                LDA #$01
68F2   8D FA 02             STA $02FA
68F5   8D FA 03             STA $03FA
68F8   A9 92                LDA #$92
68FA   8D F8 02             STA $02F8
68FD   8D F8 03             STA $03F8
6900   8D F7 03             STA $03F7
6903   8D F7 02             STA $02F7
6906   A9 7F                LDA #$7F
6908   8D FB 02             STA $02FB
690B   8D FB 03             STA $03FB
690E   A9 05                LDA #$05
6910   8D FD 02             STA $02FD
6913   8D FD 03             STA $03FD
6916   A9 FF                LDA #$FF
6918   85 32                STA $32
691A   85 33                STA $33
691C   A9 80                LDA #$80
691E   85 5A                STA $5A
6920   0A                   ASL A
6921   85 18                STA $18
6923   85 19                STA $19
6925   A5 56                LDA $56
6927   85 57                STA $57
6929   A9 04                LDA #$04
692B   85 6C                STA $6C
692D   85 6E                STA $6E
692F   A9 30                LDA #$30
6931   8D FC 02             STA $02FC
6934   8D FC 03             STA $03FC
6937   8D 00 3E             STA $3E00
693A   60                   RTS
693B   A5 32      L693B     LDA $32
693D   25 32                AND $32
693F   10 0B                BPL L694C
6941   A5 5C                LDA $5C
6943   29 20                AND #$20
6945   D0 05                BNE L694C
6947   A0 06                LDY #$06
6949   20 F6 77             JSR $77F6
694C   A5 5C      L694C     LDA $5C
694E   29 0F                AND #$0F
6950   D0 0C                BNE L695E
6952   A9 01                LDA #$01
6954   C5 70                CMP $70
6956   69 01                ADC #$01
6958   49 01                EOR #$01
695A   45 6F                EOR $6F
695C   85 6F                STA $6F
695E   18         L695E     CLC
695F   60                   RTS
6960   A5 5C      L6960     LDA $5C
6962   29 3F                AND #$3F
6964   D0 0A                BNE L6970
6966   AD FC 02             LDA $02FC
6969   C9 08                CMP #$08
696B   F0 03                BEQ L6970
696D   CE FC 02             DEC $02FC
6970   A6 18      L6970     LDX $18
6972   B5 57                LDA $57,X
6974   D0 1C                BNE L6992
6976   AD 1F 02             LDA $021F
6979   0D 20 02             ORA $0220
697C   0D 21 02             ORA $0221
697F   0D 22 02             ORA $0222
6982   D0 0E                BNE L6992
6984   A0 07                LDY #$07
6986   20 F6 77             JSR $77F6
6989   A5 1C                LDA $1C
698B   C9 02                CMP #$02
698D   90 03                BCC L6992
698F   20 E2 69             JSR L69E2
6992   AD 1B 02   L6992     LDA $021B
6995   D0 36                BNE L69CD
6997   AD FA 02             LDA $02FA
699A   C9 80                CMP #$80
699C   D0 2F                BNE L69CD
699E   A9 10                LDA #$10
69A0   8D FA 02             STA $02FA
69A3   A6 1C                LDX $1C
69A5   A5 57                LDA $57
69A7   05 58                ORA $58
69A9   F0 24                BEQ L69CF
69AB   20 2D 70             JSR $702D
69AE   CA                   DEX
69AF   F0 1C                BEQ L69CD
69B1   A9 80                LDA #$80
69B3   85 5A                STA $5A
69B5   A5 18                LDA $18
69B7   49 01                EOR #$01
69B9   AA                   TAX
69BA   B5 57                LDA $57,X
69BC   F0 0F                BEQ L69CD
69BE   86 18                STX $18
69C0   A9 04                LDA #$04
69C2   45 6F                EOR $6F
69C4   85 6F                STA $6F
69C6   8D 00 32             STA $3200
69C9   8A                   TXA
69CA   0A                   ASL A
69CB   85 19                STA $19
69CD   18         L69CD     CLC
69CE   60                   RTS
69CF   86 1A      L69CF     STX $1A
69D1   A9 FF                LDA #$FF
69D3   85 1C                STA $1C
69D5   20 FA 6E             JSR L6EFA
69D8   A5 6F                LDA $6F
69DA   29 F8                AND #$F8
69DC   09 03                ORA #$03
69DE   85 6F                STA $6F
69E0   18                   CLC
69E1   60                   RTS
69E2   A0 01      L69E2     LDY #$01
69E4   20 F6 77             JSR $77F6
69E7   A4 18                LDY $18
69E9   C8                   INY
69EA   98                   TYA
69EB   20 D1 7B             JSR $7BD1
69EE   60                   RTS
69EF   71 A2                ADC ($A2),Y
69F1   07 BD                SLO $BD
69F3   1B 02 F0             SLO $F002,Y
69F6   02                   JAM
69F7   10 04                BPL L69FD
69F9   CA         L69F9     DEX
69FA   10 F6                BPL L69F2
69FC   60                   RTS
69FD   A0 1C      L69FD     LDY #$1C
69FF   E0 04                CPX #$04
6A01   B0 07                BCS L6A0A
6A03   88                   DEY
6A04   8A                   TXA
6A05   D0 03                BNE L6A0A
6A07   88         L6A07     DEY
6A08   30 EF                BMI L69F9
6A0A   B9 00 02   L6A0A     LDA $0200,Y
6A0D   F0 F8                BEQ L6A07
6A0F   30 F6                BMI L6A07
6A11   85 0B                STA $0B
6A13   B9 AF 02             LDA $02AF,Y
6A16   38                   SEC
6A17   FD CA 02             SBC $02CA,X
6A1A   85 08                STA $08
6A1C   B9 69 02             LDA $0269,Y
6A1F   FD 84 02             SBC $0284,X
6A22   4A                   LSR A
6A23   66 08                ROR $08
6A25   0A                   ASL A
6A26   F0 0C                BEQ L6A34
6A28   10 6D                BPL L6A97
6A2A   49 FE                EOR #$FE
6A2C   D0 69                BNE L6A97
6A2E   A5 08                LDA $08
6A30   49 FF                EOR #$FF
6A32   85 08                STA $08
6A34   B9 D2 02   L6A34     LDA $02D2,Y
6A37   38                   SEC
6A38   FD ED 02             SBC $02ED,X
6A3B   85 09                STA $09
6A3D   B9 8C 02             LDA $028C,Y
6A40   FD A7 02             SBC $02A7,X
6A43   4A                   LSR A
6A44   66 09                ROR $09
6A46   0A                   ASL A
6A47   F0 0C                BEQ L6A55
6A49   10 4C                BPL L6A97
6A4B   49 FE                EOR #$FE
6A4D   D0 48                BNE L6A97
6A4F   A5 09                LDA $09
6A51   49 FF                EOR #$FF
6A53   85 09                STA $09
6A55   A9 2A      L6A55     LDA #$2A
6A57   46 0B                LSR $0B
6A59   B0 08                BCS L6A63
6A5B   A9 48                LDA #$48
6A5D   46 0B                LSR $0B
6A5F   B0 02                BCS L6A63
6A61   A9 84                LDA #$84
6A63   E0 01      L6A63     CPX #$01
6A65   B0 02                BCS L6A69
6A67   69 1C                ADC #$1C
6A69   D0 0C      L6A69     BNE L6A77
6A6B   69 12                ADC #$12
6A6D   AE 1C 02             LDX $021C
6A70   CA                   DEX
6A71   F0 02                BEQ L6A75
6A73   69 12                ADC #$12
6A75   A2 01      L6A75     LDX #$01
6A77   C5 08      L6A77     CMP $08
6A79   90 1C                BCC L6A97
6A7B   C5 09                CMP $09
6A7D   90 18                BCC L6A97
6A7F   85 0B                STA $0B
6A81   4A                   LSR A
6A82   18                   CLC
6A83   65 0B                ADC $0B
6A85   85 0B                STA $0B
6A87   A5 09                LDA $09
6A89   65 08                ADC $08
6A8B   B0 0A                BCS L6A97
6A8D   C5 0B                CMP $0B
6A8F   B0 06                BCS L6A97
6A91   20 0F 6B             JSR L6B0F
6A94   4C F9 69   L6A94     JMP L69F9
6A97   88         L6A97     DEY
6A98   30 FA                BMI L6A94
6A9A   4C 0A 6A             JMP L6A0A
6A9D   B9 00 02             LDA $0200,Y
6AA0   29 07                AND #$07
6AA2   85 08                STA $08
6AA4   20 B5 77             JSR $77B5
6AA7   29 18                AND #$18
6AA9   05 08                ORA $08
6AAB   9D 00 02             STA $0200,X
6AAE   B9 AF 02             LDA $02AF,Y
6AB1   9D AF 02             STA $02AF,X
6AB4   B9 69 02             LDA $0269,Y
6AB7   9D 69 02             STA $0269,X
6ABA   B9 D2 02             LDA $02D2,Y
6ABD   9D D2 02             STA $02D2,X
6AC0   B9 8C 02             LDA $028C,Y
6AC3   9D 8C 02             STA $028C,X
6AC6   B9 23 02             LDA $0223,Y
6AC9   9D 23 02             STA $0223,X
6ACC   B9 46 02             LDA $0246,Y
6ACF   9D 46 02             STA $0246,X
6AD2   60                   RTS
6AD3   85 0B                STA $0B
6AD5   86 0C                STX $0C
6AD7   A0 00                LDY #$00
6AD9   C8         L6AD9     INY
6ADA   B1 0B                LDA ($0B),Y
6ADC   45 09                EOR $09
6ADE   91 02                STA ($02),Y
6AE0   88                   DEY
6AE1   C9 F0                CMP #$F0
6AE3   B0 1E                BCS L6B03
6AE5   C9 A0                CMP #$A0
6AE7   B0 16                BCS L6AFF
6AE9   B1 0B                LDA ($0B),Y
6AEB   91 02                STA ($02),Y
6AED   C8                   INY
6AEE   C8                   INY
6AEF   B1 0B                LDA ($0B),Y
6AF1   91 02                STA ($02),Y
6AF3   C8                   INY
6AF4   B1 0B                LDA ($0B),Y
6AF6   45 08                EOR $08
6AF8   65 17                ADC $17
6AFA   91 02                STA ($02),Y
6AFC   C8         L6AFC     INY
6AFD   D0 DA                BNE L6AD9
6AFF   88         L6AFF     DEY
6B00   4C 39 7C             JMP $7C39
6B03   B1 0B      L6B03     LDA ($0B),Y
6B05   45 08                EOR $08
6B07   18                   CLC
6B08   65 17                ADC $17
6B0A   91 02                STA ($02),Y
6B0C   C8                   INY
6B0D   D0 ED                BNE L6AFC
6B0F   E0 01      L6B0F     CPX #$01
6B11   D0 08                BNE L6B1B
6B13   C0 1B                CPY #$1B
6B15   D0 12                BNE L6B29
6B17   A2 00                LDX #$00
6B19   A0 1C                LDY #$1C
6B1B   8A         L6B1B     TXA
6B1C   D0 1E                BNE L6B3C
6B1E   A9 81                LDA #$81
6B20   8D FA 02             STA $02FA
6B23   A6 18                LDX $18
6B25   D6 57                DEC $57,X
6B27   A2 00                LDX #$00
6B29   A9 A0      L6B29     LDA #$A0
6B2B   9D 1B 02             STA $021B,X
6B2E   A9 00                LDA #$00
6B30   9D 3E 02             STA $023E,X
6B33   9D 61 02             STA $0261,X
6B36   C0 1B                CPY #$1B
6B38   90 0D                BCC L6B47
6B3A   B0 37                BCS L6B73
6B3C   A9 00      L6B3C     LDA #$00
6B3E   9D 1B 02             STA $021B,X
6B41   C0 1B                CPY #$1B
6B43   F0 21                BEQ L6B66
6B45   B0 2C                BCS L6B73
6B47   20 EC 75   L6B47     JSR $75EC
6B4A   B9 00 02   L6B4A     LDA $0200,Y
6B4D   29 03                AND #$03
6B4F   49 02                EOR #$02
6B51   4A                   LSR A
6B52   6A                   ROR A
6B53   6A                   ROR A
6B54   09 3F                ORA #$3F
6B56   85 69                STA $69
6B58   A9 A0                LDA #$A0
6B5A   99 00 02             STA $0200,Y
6B5D   A9 00                LDA #$00
6B5F   99 23 02             STA $0223,Y
6B62   99 46 02             STA $0246,Y
6B65   60                   RTS
6B66   8A         L6B66     TXA
6B67   A6 18                LDX $18
6B69   D6 57                DEC $57,X
6B6B   AA                   TAX
6B6C   A9 81                LDA #$81
6B6E   8D FA 02             STA $02FA
6B71   D0 D7                BNE L6B4A
6B73   AD F8 02   L6B73     LDA $02F8
6B76   8D F7 02             STA $02F7
6B79   A5 1C                LDA $1C
6B7B   F0 CD                BEQ L6B4A
6B7D   86 0D                STX $0D
6B7F   A6 19                LDX $19
6B81   AD 1C 02             LDA $021C
6B84   4A                   LSR A
6B85   A9 99                LDA #$99
6B87   B0 02                BCS L6B8B
6B89   A9 20                LDA #$20
6B8B   20 97 73   L6B8B     JSR $7397
6B8E   A6 0D                LDX $0D
6B90   4C 4A 6B             JMP L6B4A
6B93   A5 5C      L6B93     LDA $5C
6B95   29 03                AND #$03
6B97   F0 01                BEQ L6B9A
6B99   60         L6B99     RTS
6B9A   AD 1C 02   L6B9A     LDA $021C
6B9D   30 FA                BMI L6B99
6B9F   F0 03                BEQ L6BA4
6BA1   4C 34 6C             JMP L6C34
6BA4   A5 1C      L6BA4     LDA $1C
6BA6   F0 07                BEQ L6BAF
6BA8   AD 1B 02             LDA $021B
6BAB   F0 EC                BEQ L6B99
6BAD   30 EA                BMI L6B99
6BAF   AD F9 02   L6BAF     LDA $02F9
6BB2   F0 03                BEQ L6BB7
6BB4   CE F9 02             DEC $02F9
6BB7   CE F7 02   L6BB7     DEC $02F7
6BBA   D0 DD                BNE L6B99
6BBC   A9 12                LDA #$12
6BBE   8D F7 02             STA $02F7
6BC1   AD F9 02             LDA $02F9
6BC4   F0 0A                BEQ L6BD0
6BC6   AD F6 02             LDA $02F6
6BC9   F0 CE                BEQ L6B99
6BCB   CD FD 02             CMP $02FD
6BCE   B0 C9                BCS L6B99
6BD0   AD F8 02   L6BD0     LDA $02F8
6BD3   38                   SEC
6BD4   E9 06                SBC #$06
6BD6   C9 20                CMP #$20
6BD8   90 03                BCC L6BDD
6BDA   8D F8 02             STA $02F8
6BDD   A9 00      L6BDD     LDA #$00
6BDF   8D CB 02             STA $02CB
6BE2   8D 85 02             STA $0285
6BE5   20 B5 77             JSR $77B5
6BE8   4A                   LSR A
6BE9   6E EE 02             ROR $02EE
6BEC   4A                   LSR A
6BED   6E EE 02             ROR $02EE
6BF0   4A                   LSR A
6BF1   6E EE 02             ROR $02EE
6BF4   C9 18                CMP #$18
6BF6   90 02                BCC L6BFA
6BF8   29 17                AND #$17
6BFA   8D A8 02   L6BFA     STA $02A8
6BFD   A2 10                LDX #$10
6BFF   24 60                BIT $60
6C01   70 0C                BVS L6C0F
6C03   A9 1F                LDA #$1F
6C05   8D 85 02             STA $0285
6C08   A9 FF                LDA #$FF
6C0A   8D CB 02             STA $02CB
6C0D   A2 F0                LDX #$F0
6C0F   8E 3F 02   L6C0F     STX $023F
6C12   A2 02                LDX #$02
6C14   AD F8 02             LDA $02F8
6C17   30 17                BMI L6C30
6C19   A4 19                LDY $19
6C1B   B9 53 00             LDA $0053,Y
6C1E   C9 30                CMP #$30
6C20   B0 0D                BCS L6C2F
6C22   20 B5 77             JSR $77B5
6C25   85 08                STA $08
6C27   AD F8 02             LDA $02F8
6C2A   4A                   LSR A
6C2B   C5 08                CMP $08
6C2D   B0 01                BCS L6C30
6C2F   CA         L6C2F     DEX
6C30   8E 1C 02   L6C30     STX $021C
6C33   60                   RTS
6C34   A5 5C      L6C34     LDA $5C
6C36   0A                   ASL A
6C37   D0 0C                BNE L6C45
6C39   20 B5 77             JSR $77B5
6C3C   29 03                AND #$03
6C3E   AA                   TAX
6C3F   BD D3 6C             LDA $6CD3,X
6C42   8D 62 02             STA $0262
6C45   A5 1C      L6C45     LDA $1C
6C47   F0 05                BEQ L6C4E
6C49   AD FA 02             LDA $02FA
6C4C   D0 05                BNE L6C53
6C4E   CE F7 02   L6C4E     DEC $02F7
6C51   F0 01                BEQ L6C54
6C53   60         L6C53     RTS
6C54   A9 0A      L6C54     LDA #$0A
6C56   8D F7 02             STA $02F7
6C59   AD 1C 02             LDA $021C
6C5C   4A                   LSR A
6C5D   F0 06                BEQ L6C65
6C5F   20 B5 77             JSR $77B5
6C62   4C C4 6C             JMP L6CC4
6C65   AD 3F 02   L6C65     LDA $023F
6C68   C9 80                CMP #$80
6C6A   6A                   ROR A
6C6B   85 0C                STA $0C
6C6D   AD CA 02             LDA $02CA
6C70   38                   SEC
6C71   ED CB 02             SBC $02CB
6C74   85 0B                STA $0B
6C76   AD 84 02             LDA $0284
6C79   ED 85 02             SBC $0285
6C7C   06 0B                ASL $0B
6C7E   2A                   ROL A
6C7F   06 0B                ASL $0B
6C81   2A                   ROL A
6C82   38                   SEC
6C83   E5 0C                SBC $0C
6C85   AA                   TAX
6C86   AD 62 02             LDA $0262
6C89   C9 80                CMP #$80
6C8B   6A                   ROR A
6C8C   85 0C                STA $0C
6C8E   AD ED 02             LDA $02ED
6C91   38                   SEC
6C92   ED EE 02             SBC $02EE
6C95   85 0B                STA $0B
6C97   AD A7 02             LDA $02A7
6C9A   ED A8 02             SBC $02A8
6C9D   06 0B                ASL $0B
6C9F   2A                   ROL A
6CA0   06 0B                ASL $0B
6CA2   2A                   ROL A
6CA3   38                   SEC
6CA4   E5 0C                SBC $0C
6CA6   A8                   TAY
6CA7   20 F0 76             JSR $76F0
6CAA   85 62                STA $62
6CAC   20 B5 77             JSR $77B5
6CAF   A6 19                LDX $19
6CB1   B4 53                LDY $53,X
6CB3   C0 35                CPY #$35
6CB5   A2 00                LDX #$00
6CB7   90 01                BCC L6CBA
6CB9   E8                   INX
6CBA   3D CF 6C   L6CBA     AND $6CCF,X
6CBD   10 03                BPL L6CC2
6CBF   1D D1 6C             ORA $6CD1,X
6CC2   65 62      L6CC2     ADC $62
6CC4   85 62      L6CC4     STA $62
6CC6   A0 03                LDY #$03
6CC8   A2 01                LDX #$01
6CCA   86 0E                STX $0E
6CCC   4C F2 6C             JMP L6CF2
6CCF   8F 87 70             SAX $7087
6CD2   78                   SEI
6CD3   F0 00                BEQ L6CD5
6CD5   00         L6CD5     BRK
6CD6   10 A5                BPL L6C7D
6CD8   1C F0 21             NOP $21F0,X
6CDB   0E 04 20             ASL $2004
6CDE   66 63                ROR $63
6CE0   24 63                BIT $63
6CE2   10 18                BPL L6CFC
6CE4   70 16                BVS L6CFC
6CE6   AD FA 02             LDA $02FA
6CE9   D0 11                BNE L6CFC
6CEB   AA                   TAX
6CEC   A9 03                LDA #$03
6CEE   85 0E                STA $0E
6CF0   A0 07                LDY #$07
6CF2   B9 1B 02   L6CF2     LDA $021B,Y
6CF5   F0 06                BEQ L6CFD
6CF7   88                   DEY
6CF8   C4 0E                CPY $0E
6CFA   D0 F6                BNE L6CF2
6CFC   60         L6CFC     RTS
6CFD   86 0D      L6CFD     STX $0D
6CFF   A9 12                LDA #$12
6D01   99 1B 02             STA $021B,Y
6D04   B5 61                LDA $61,X
6D06   20 D2 77             JSR $77D2
6D09   A6 0D                LDX $0D
6D0B   C9 80                CMP #$80
6D0D   6A                   ROR A
6D0E   85 09                STA $09
6D10   18                   CLC
6D11   7D 3E 02             ADC $023E,X
6D14   30 08                BMI L6D1E
6D16   C9 70                CMP #$70
6D18   90 0A                BCC L6D24
6D1A   A9 6F                LDA #$6F
6D1C   D0 06                BNE L6D24
6D1E   C9 91      L6D1E     CMP #$91
6D20   B0 02                BCS L6D24
6D22   A9 91                LDA #$91
6D24   99 3E 02   L6D24     STA $023E,Y
6D27   B5 61                LDA $61,X
6D29   20 D5 77             JSR $77D5
6D2C   A6 0D                LDX $0D
6D2E   C9 80                CMP #$80
6D30   6A                   ROR A
6D31   85 0C                STA $0C
6D33   18                   CLC
6D34   7D 61 02             ADC $0261,X
6D37   30 08                BMI L6D41
6D39   C9 70                CMP #$70
6D3B   90 0A                BCC L6D47
6D3D   A9 6F                LDA #$6F
6D3F   D0 06                BNE L6D47
6D41   C9 91      L6D41     CMP #$91
6D43   B0 02                BCS L6D47
6D45   A9 91                LDA #$91
6D47   99 61 02   L6D47     STA $0261,Y
6D4A   A2 00                LDX #$00
6D4C   A5 09                LDA $09
6D4E   10 01                BPL L6D51
6D50   CA                   DEX
6D51   86 08      L6D51     STX $08
6D53   A6 0D                LDX $0D
6D55   C9 80                CMP #$80
6D57   6A                   ROR A
6D58   18                   CLC
6D59   65 09                ADC $09
6D5B   18                   CLC
6D5C   7D CA 02             ADC $02CA,X
6D5F   99 CA 02             STA $02CA,Y
6D62   A5 08                LDA $08
6D64   7D 84 02             ADC $0284,X
6D67   99 84 02             STA $0284,Y
6D6A   A2 00                LDX #$00
6D6C   A5 0C                LDA $0C
6D6E   10 01                BPL L6D71
6D70   CA                   DEX
6D71   86 0B      L6D71     STX $0B
6D73   A6 0D                LDX $0D
6D75   C9 80                CMP #$80
6D77   6A                   ROR A
6D78   18                   CLC
6D79   65 0C                ADC $0C
6D7B   18                   CLC
6D7C   7D ED 02             ADC $02ED,X
6D7F   99 ED 02             STA $02ED,Y
6D82   A5 0B                LDA $0B
6D84   7D A7 02             ADC $02A7,X
6D87   99 A7 02             STA $02A7,Y
6D8A   A9 80                LDA #$80
6D8C   95 66                STA $66,X
6D8E   60                   RTS
6D8F   D8                   CLD
6D90   A5 32      L6D90     LDA $32
6D92   25 33                AND $33
6D94   10 01                BPL L6D97
6D96   60                   RTS
6D97   A5 1A      L6D97     LDA $1A
6D99   4A                   LSR A
6D9A   F0 18                BEQ L6DB4
6D9C   A0 01                LDY #$01
6D9E   20 F6 77             JSR $77F6
6DA1   A0 02                LDY #$02
6DA3   A6 33                LDX $33
6DA5   10 01                BPL L6DA8
6DA7   88                   DEY
6DA8   84 18      L6DA8     STY $18
6DAA   A5 5C                LDA $5C
6DAC   29 10                AND #$10
6DAE   D0 04                BNE L6DB4
6DB0   98                   TYA
6DB1   20 D1 7B             JSR $7BD1
6DB4   46 18      L6DB4     LSR $18
6DB6   20 B2 73             JSR $73B2
6DB9   A0 02                LDY #$02
6DBB   20 F6 77             JSR $77F6
6DBE   A0 03                LDY #$03
6DC0   20 F6 77             JSR $77F6
6DC3   A0 04                LDY #$04
6DC5   20 F6 77             JSR $77F6
6DC8   A0 05                LDY #$05
6DCA   20 F6 77             JSR $77F6
6DCD   A9 20                LDA #$20
6DCF   85 00                STA $00
6DD1   A9 64                LDA #$64
6DD3   A2 39                LDX #$39
6DD5   20 03 7C             JSR $7C03
6DD8   A9 70                LDA #$70
6DDA   20 DE 7C             JSR $7CDE
6DDD   A6 18                LDX $18
6DDF   B4 32                LDY $32,X
6DE1   84 0B                STY $0B
6DE3   98                   TYA
6DE4   18                   CLC
6DE5   65 31                ADC $31
6DE7   85 0C                STA $0C
6DE9   20 1A 6F             JSR L6F1A
6DEC   A4 0B                LDY $0B
6DEE   C8                   INY
6DEF   20 1A 6F             JSR L6F1A
6DF2   A4 0B                LDY $0B
6DF4   C8                   INY
6DF5   C8                   INY
6DF6   20 1A 6F             JSR L6F1A
6DF9   AD 03 20             LDA $2003
6DFC   2A                   ROL A
6DFD   26 63                ROL $63
6DFF   A5 63                LDA $63
6E01   29 1F                AND #$1F
6E03   C9 07                CMP #$07
6E05   D0 27                BNE L6E2E
6E07   E6 31                INC $31
6E09   A5 31                LDA $31
6E0B   C9 03                CMP #$03
6E0D   90 13                BCC L6E22
6E0F   A6 18                LDX $18
6E11   A9 FF                LDA #$FF
6E13   95 32                STA $32,X
6E15   A2 00      L6E15     LDX #$00
6E17   86 18                STX $18
6E19   86 31                STX $31
6E1B   A2 F0                LDX #$F0
6E1D   86 5D                STX $5D
6E1F   4C B2 73             JMP $73B2
6E22   E6 0C      L6E22     INC $0C
6E24   A6 0C                LDX $0C
6E26   A9 F4                LDA #$F4
6E28   85 5D                STA $5D
6E2A   A9 0B                LDA #$0B
6E2C   95 34                STA $34,X
6E2E   A5 5D      L6E2E     LDA $5D
6E30   D0 08                BNE L6E3A
6E32   A9 FF                LDA #$FF
6E34   85 32                STA $32
6E36   85 33                STA $33
6E38   30 DB                BMI L6E15
6E3A   A5 5C      L6E3A     LDA $5C
6E3C   29 07                AND #$07
6E3E   D0 31                BNE L6E71
6E40   AD 07 24             LDA $2407
6E43   10 04                BPL L6E49
6E45   A9 01                LDA #$01
6E47   D0 07                BNE L6E50
6E49   AD 06 24   L6E49     LDA $2406
6E4C   10 23                BPL L6E71
6E4E   A9 FF                LDA #$FF
6E50   A6 0C      L6E50     LDX $0C
6E52   18                   CLC
6E53   75 34                ADC $34,X
6E55   30 10                BMI L6E67
6E57   C9 0B                CMP #$0B
6E59   B0 0E                BCS L6E69
6E5B   C9 01                CMP #$01
6E5D   F0 04                BEQ L6E63
6E5F   A9 00                LDA #$00
6E61   F0 0C                BEQ L6E6F
6E63   A9 0B      L6E63     LDA #$0B
6E65   D0 08                BNE L6E6F
6E67   A9 24      L6E67     LDA #$24
6E69   C9 25      L6E69     CMP #$25
6E6B   90 02                BCC L6E6F
6E6D   A9 00                LDA #$00
6E6F   95 34      L6E6F     STA $34,X
6E71   A9 00      L6E71     LDA #$00
6E73   60                   RTS
6E74   A5 1C      L6E74     LDA $1C
6E76   F0 5F                BEQ L6ED7
6E78   AD 1B 02             LDA $021B
6E7B   30 5A                BMI L6ED7
6E7D   AD FA 02             LDA $02FA
6E80   D0 55                BNE L6ED7
6E82   AD 03 20             LDA $2003
6E85   10 50                BPL L6ED7
6E87   A9 00                LDA #$00
6E89   8D 1B 02             STA $021B
6E8C   8D 3E 02             STA $023E
6E8F   8D 61 02             STA $0261
6E92   A9 30                LDA #$30
6E94   8D FA 02             STA $02FA
6E97   20 B5 77             JSR $77B5
6E9A   29 1F                AND #$1F
6E9C   C9 1D                CMP #$1D
6E9E   90 02                BCC L6EA2
6EA0   A9 1C                LDA #$1C
6EA2   C9 03      L6EA2     CMP #$03
6EA4   B0 02                BCS L6EA8
6EA6   A9 03                LDA #$03
6EA8   8D 84 02   L6EA8     STA $0284
6EAB   A2 05                LDX #$05
6EAD   20 B5 77   L6EAD     JSR $77B5
6EB0   CA                   DEX
6EB1   D0 FA                BNE L6EAD
6EB3   29 1F                AND #$1F
6EB5   E8                   INX
6EB6   C9 18                CMP #$18
6EB8   90 0C                BCC L6EC6
6EBA   29 07                AND #$07
6EBC   0A                   ASL A
6EBD   69 04                ADC #$04
6EBF   CD F6 02             CMP $02F6
6EC2   90 02                BCC L6EC6
6EC4   A2 80                LDX #$80
6EC6   C9 15      L6EC6     CMP #$15
6EC8   90 02                BCC L6ECC
6ECA   A9 14                LDA #$14
6ECC   C9 03      L6ECC     CMP #$03
6ECE   B0 02                BCS L6ED2
6ED0   A9 03                LDA #$03
6ED2   8D A7 02   L6ED2     STA $02A7
6ED5   86 59                STX $59
6ED7   60         L6ED7     RTS
6ED8   A9 02      L6ED8     LDA #$02
6EDA   8D F5 02             STA $02F5
6EDD   A2 03                LDX #$03
6EDF   4E 02 28             LSR $2802
6EE2   B0 01                BCS L6EE5
6EE4   E8                   INX
6EE5   86 56      L6EE5     STX $56
6EE7   A9 00                LDA #$00
6EE9   A2 04                LDX #$04
6EEB   9D 1B 02   L6EEB     STA $021B,X
6EEE   9D 1F 02             STA $021F,X
6EF1   95 51                STA $51,X
6EF3   CA                   DEX
6EF4   10 F5                BPL L6EEB
6EF6   8D F6 02             STA $02F6
6EF9   60                   RTS
6EFA   A9 00      L6EFA     LDA #$00
6EFC   8D 00 36             STA $3600
6EFF   8D 00 3A             STA $3A00
6F02   8D 00 3C             STA $3C00
6F05   8D 01 3C             STA $3C01
6F08   8D 03 3C             STA $3C03
6F0B   8D 04 3C             STA $3C04
6F0E   8D 05 3C             STA $3C05
6F11   85 69                STA $69
6F13   85 66                STA $66
6F15   85 67                STA $67
6F17   85 68                STA $68
6F19   60                   RTS
6F1A   B9 34 00   L6F1A     LDA $0034,Y
6F1D   0A                   ASL A
6F1E   A8                   TAY
6F1F   D0 14                BNE L6F35
6F21   A5 32                LDA $32
6F23   25 33                AND $33
6F25   30 0E                BMI L6F35
6F27   A9 72                LDA #$72
6F29   A2 F8                LDX #$F8
6F2B   20 45 7D             JSR $7D45
6F2E   A9 01                LDA #$01
6F30   A2 F8                LDX #$F8
6F32   4C 45 7D             JMP $7D45
6F35   BE D5 56   L6F35     LDX $56D5,Y
6F38   B9 D4 56             LDA $56D4,Y
6F3B   4C 45 7D             JMP $7D45
6F3E   F0 16                BEQ L6F56
6F40   84 08                STY $08
6F42   A2 D5                LDX #$D5
6F44   A0 E0                LDY #$E0
6F46   84 00                STY $00
6F48   20 03 7C             JSR $7C03
6F4B   A2 DA      L6F4B     LDX #$DA
6F4D   A9 54                LDA #$54
6F4F   20 FC 7B             JSR $7BFC
6F52   C6 08                DEC $08
6F54   D0 F5                BNE L6F4B
6F56   60         L6F56     RTS
6F57   A2 22      L6F57     LDX #$22
6F59   BD 00 02   L6F59     LDA $0200,X
6F5C   D0 04                BNE L6F62
6F5E   CA         L6F5E     DEX
6F5F   10 F8                BPL L6F59
6F61   60                   RTS
6F62   10 63      L6F62     BPL L6FC7
6F64   20 08 77             JSR $7708
6F67   4A                   LSR A
6F68   4A                   LSR A
6F69   4A                   LSR A
6F6A   4A                   LSR A
6F6B   E0 1B                CPX #$1B
6F6D   D0 07                BNE L6F76
6F6F   A5 5C                LDA $5C
6F71   29 01                AND #$01
6F73   4A                   LSR A
6F74   F0 01                BEQ L6F77
6F76   38         L6F76     SEC
6F77   7D 00 02   L6F77     ADC $0200,X
6F7A   30 25                BMI L6FA1
6F7C   E0 1B                CPX #$1B
6F7E   F0 13                BEQ L6F93
6F80   B0 17                BCS L6F99
6F82   CE F6 02             DEC $02F6
6F85   D0 05                BNE L6F8C
6F87   A0 7F                LDY #$7F
6F89   8C FB 02             STY $02FB
6F8C   A9 00      L6F8C     LDA #$00
6F8E   9D 00 02             STA $0200,X
6F91   F0 CB                BEQ L6F5E
6F93   20 E8 71   L6F93     JSR $71E8
6F96   4C 8C 6F             JMP L6F8C
6F99   AD F8 02   L6F99     LDA $02F8
6F9C   8D F7 02             STA $02F7
6F9F   D0 EB                BNE L6F8C
6FA1   9D 00 02   L6FA1     STA $0200,X
6FA4   29 F0                AND #$F0
6FA6   18                   CLC
6FA7   69 10                ADC #$10
6FA9   E0 1B                CPX #$1B
6FAB   D0 02                BNE L6FAF
6FAD   A9 00                LDA #$00
6FAF   A8         L6FAF     TAY
6FB0   BD AF 02             LDA $02AF,X
6FB3   85 04                STA $04
6FB5   BD 69 02             LDA $0269,X
6FB8   85 05                STA $05
6FBA   BD D2 02             LDA $02D2,X
6FBD   85 06                STA $06
6FBF   BD 8C 02             LDA $028C,X
6FC2   85 07                STA $07
6FC4   4C 27 70             JMP $7027
6FC7   18         L6FC7     CLC
6FC8   A0 00                LDY #$00
6FCA   BD 23 02             LDA $0223,X
6FCD   10 01                BPL L6FD0
6FCF   88                   DEY
6FD0   7D AF 02   L6FD0     ADC $02AF,X
6FD3   9D AF 02             STA $02AF,X
6FD6   85 04                STA $04
6FD8   98                   TYA
6FD9   7D 69 02             ADC $0269,X
6FDC   C9 20                CMP #$20
6FDE   90 0C                BCC L6FEC
6FE0   29 1F                AND #$1F
6FE2   E0 1C                CPX #$1C
6FE4   D0 06                BNE L6FEC
6FE6   20 2D 70             JSR $702D
6FE9   4C 5E 6F             JMP L6F5E
6FEC   9D 69 02   L6FEC     STA $0269,X
6FEF   85 05                STA $05
6FF1   18                   CLC
6FF2   A0 00                LDY #$00
6FF4   BD 46 02             LDA $0246,X
6FF7   10 02                BPL L6FFB
6FF9   A0 FF                LDY #$FF
6FFB   7D D2 02   L6FFB     ADC $02D2,X
6FFE   9D D2 00             STA $00D2,X
                            .END

;auto-generated symbols and labels
 L6803      $6803
 L6809      $6809
 L6815      $6815
 L6836      $6836
 L6864      $6864
 L6885      $6885
 L6890      $6890
 L6895      $6895
 L6897      $6897
 L6960      $6960
 L6970      $6970
 L6992      $6992
 L6EFA      $6EFA
 L6ED8      $6ED8
 L680F      $680F
 L680C      $680C
 L682E      $682E
 L6D90      $6D90
 L685E      $685E
 L6CD7      $6CD7
 L6E74      $6E74
 L6B93      $6B93
 L6F57      $6F57
 L69F0      $69F0
 L687E      $687E
 L689D      $689D
 L69E2      $69E2
 L68B0      $68B0
 L68DE      $68DE
 L693B      $693B
 L694C      $694C
 L695E      $695E
 L69CD      $69CD
 L69CF      $69CF
 L69FD      $69FD
 L69F2      $69F2
 L6A0A      $6A0A
 L69F9      $69F9
 L6A07      $6A07
 L6A34      $6A34
 L6A97      $6A97
 L6A55      $6A55
 L6A63      $6A63
 L6A69      $6A69
 L6A77      $6A77
 L6A75      $6A75
 L6B0F      $6B0F
 L6A94      $6A94
 L6B03      $6B03
 L6AFF      $6AFF
 L6AD9      $6AD9
 L6AFC      $6AFC
 L6B1B      $6B1B
 L6B29      $6B29
 L6B3C      $6B3C
 L6B47      $6B47
 L6B73      $6B73
 L6B66      $6B66
 L6B4A      $6B4A
 L6B8B      $6B8B
 L6B9A      $6B9A
 L6B99      $6B99
 L6BA4      $6BA4
 L6C34      $6C34
 L6BAF      $6BAF
 L6BB7      $6BB7
 L6BD0      $6BD0
 L6BDD      $6BDD
 L6BFA      $6BFA
 L6C0F      $6C0F
 L6C30      $6C30
 L6C2F      $6C2F
 L6C45      $6C45
 L6C4E      $6C4E
 L6C53      $6C53
 L6C54      $6C54
 L6C65      $6C65
 L6CC4      $6CC4
 L6CBA      $6CBA
 L6CC2      $6CC2
 L6CF2      $6CF2
 L6CD5      $6CD5
 L6C7D      $6C7D
 L6CFC      $6CFC
 L6CFD      $6CFD
 L6D1E      $6D1E
 L6D24      $6D24
 L6D41      $6D41
 L6D47      $6D47
 L6D51      $6D51
 L6D71      $6D71
 L6D97      $6D97
 L6DB4      $6DB4
 L6DA8      $6DA8
 L6F1A      $6F1A
 L6E2E      $6E2E
 L6E22      $6E22
 L6E3A      $6E3A
 L6E15      $6E15
 L6E71      $6E71
 L6E49      $6E49
 L6E50      $6E50
 L6E67      $6E67
 L6E69      $6E69
 L6E63      $6E63
 L6E6F      $6E6F
 L6ED7      $6ED7
 L6EA2      $6EA2
 L6EA8      $6EA8
 L6EAD      $6EAD
 L6EC6      $6EC6
 L6ECC      $6ECC
 L6ED2      $6ED2
 L6EE5      $6EE5
 L6EEB      $6EEB
 L6F35      $6F35
 L6F56      $6F56
 L6F4B      $6F4B
 L6F62      $6F62
 L6F59      $6F59
 L6FC7      $6FC7
 L6F76      $6F76
 L6F77      $6F77
 L6FA1      $6FA1
 L6F93      $6F93
 L6F99      $6F99
 L6F8C      $6F8C
 L6F5E      $6F5E
 L6FAF      $6FAF
 L6FD0      $6FD0
 L6FEC      $6FEC
 L6FFB      $6FFB