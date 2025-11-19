                            * = $7000
7000   02                   JAM
7001   85 06                STA $06
7003   98                   TYA
7004   7D 8C 02             ADC $028C,X
7007   C9 18                CMP #$18
7009   90 08                BCC L7013
700B   F0 04                BEQ L7011
700D   A9 17                LDA #$17
700F   D0 02                BNE L7013
7011   A9 00      L7011     LDA #$00
7013   9D 8C 02   L7013     STA $028C,X
7016   85 07                STA $07
7018   BD 00 02             LDA $0200,X
701B   A0 E0                LDY #$E0
701D   4A                   LSR A
701E   B0 07                BCS L7027
7020   A0 F0                LDY #$F0
7022   4A                   LSR A
7023   B0 02                BCS L7027
7025   A0 00                LDY #$00
7027   20 FE 72   L7027     JSR L72FE
702A   4C 5E 6F             JMP $6F5E
702D   AD F8 02             LDA $02F8
7030   8D F7 02             STA $02F7
7033   A9 00                LDA #$00
7035   8D 1C 02             STA $021C
7038   8D 3F 02             STA $023F
703B   8D 62 02             STA $0262
703E   60                   RTS
703F   A5 1C                LDA $1C
7041   F0 42                BEQ L7085
7043   AD 1B 02             LDA $021B
7046   30 3D                BMI L7085
7048   AD FA 02             LDA $02FA
704B   F0 39                BEQ L7086
704D   CE FA 02             DEC $02FA
7050   D0 33                BNE L7085
7052   A4 59                LDY $59
7054   30 19                BMI L706F
7056   D0 10                BNE L7068
7058   20 39 71             JSR L7139
705B   D0 24                BNE L7081
705D   AC 1C 02             LDY $021C
7060   F0 06                BEQ L7068
7062   A0 02                LDY #$02
7064   8C FA 02             STY $02FA
7067   60                   RTS
7068   A9 01      L7068     LDA #$01
706A   8D 1B 02             STA $021B
706D   D0 12                BNE L7081
706F   A9 A0      L706F     LDA #$A0
7071   8D 1B 02             STA $021B
7074   A2 3E                LDX #$3E
7076   86 69                STX $69
7078   A6 18                LDX $18
707A   D6 57                DEC $57,X
707C   A9 81                LDA #$81
707E   8D FA 02             STA $02FA
7081   A9 00      L7081     LDA #$00
7083   85 59                STA $59
7085   60         L7085     RTS
7086   AD 07 24   L7086     LDA $2407
7089   10 04                BPL L708F
708B   A9 03                LDA #$03
708D   D0 07                BNE L7096
708F   AD 06 24   L708F     LDA $2406
7092   10 07                BPL L709B
7094   A9 FD                LDA #$FD
7096   18         L7096     CLC
7097   65 61                ADC $61
7099   85 61                STA $61
709B   A5 5C      L709B     LDA $5C
709D   4A                   LSR A
709E   B0 E5                BCS L7085
70A0   AD 05 24             LDA $2405
70A3   10 3C                BPL L70E1
70A5   A9 80                LDA #$80
70A7   8D 03 3C             STA $3C03
70AA   A0 00                LDY #$00
70AC   A5 61                LDA $61
70AE   20 D2 77             JSR L77D2
70B1   10 01                BPL L70B4
70B3   88                   DEY
70B4   0A         L70B4     ASL A
70B5   18                   CLC
70B6   65 64                ADC $64
70B8   AA                   TAX
70B9   98                   TYA
70BA   6D 3E 02             ADC $023E
70BD   20 25 71             JSR L7125
70C0   8D 3E 02             STA $023E
70C3   86 64                STX $64
70C5   A0 00                LDY #$00
70C7   A5 61                LDA $61
70C9   20 D5 77             JSR L77D5
70CC   10 01                BPL L70CF
70CE   88                   DEY
70CF   0A         L70CF     ASL A
70D0   18                   CLC
70D1   65 65                ADC $65
70D3   AA                   TAX
70D4   98                   TYA
70D5   6D 61 02             ADC $0261
70D8   20 25 71             JSR L7125
70DB   8D 61 02             STA $0261
70DE   86 65                STX $65
70E0   60                   RTS
70E1   A9 00      L70E1     LDA #$00
70E3   8D 03 3C             STA $3C03
70E6   AD 3E 02             LDA $023E
70E9   05 64                ORA $64
70EB   F0 18                BEQ L7105
70ED   AD 3E 02             LDA $023E
70F0   0A                   ASL A
70F1   A2 FF                LDX #$FF
70F3   18                   CLC
70F4   49 FF                EOR #$FF
70F6   30 02                BMI L70FA
70F8   E8                   INX
70F9   38                   SEC
70FA   65 64      L70FA     ADC $64
70FC   85 64                STA $64
70FE   8A                   TXA
70FF   6D 3E 02             ADC $023E
7102   8D 3E 02             STA $023E
7105   A5 65      L7105     LDA $65
7107   0D 61 02             ORA $0261
710A   F0 18                BEQ L7124
710C   AD 61 02             LDA $0261
710F   0A                   ASL A
7110   A2 FF                LDX #$FF
7112   18                   CLC
7113   49 FF                EOR #$FF
7115   30 02                BMI L7119
7117   38                   SEC
7118   E8                   INX
7119   65 65      L7119     ADC $65
711B   85 65                STA $65
711D   8A                   TXA
711E   6D 61 02             ADC $0261
7121   8D 61 02             STA $0261
7124   60         L7124     RTS
7125   30 09      L7125     BMI L7130
7127   C9 40                CMP #$40
7129   90 0D                BCC L7138
712B   A2 FF                LDX #$FF
712D   A9 3F                LDA #$3F
712F   60                   RTS
7130   C9 C0      L7130     CMP #$C0
7132   B0 04                BCS L7138
7134   A2 01                LDX #$01
7136   A9 C0                LDA #$C0
7138   60         L7138     RTS
7139   A2 1C      L7139     LDX #$1C
713B   BD 00 02   L713B     LDA $0200,X
713E   F0 1E                BEQ L715E
7140   BD 69 02             LDA $0269,X
7143   38                   SEC
7144   ED 84 02             SBC $0284
7147   C9 04                CMP #$04
7149   90 04                BCC L714F
714B   C9 FC                CMP #$FC
714D   90 0F                BCC L715E
714F   BD 8C 02   L714F     LDA $028C,X
7152   38                   SEC
7153   ED A7 02             SBC $02A7
7156   C9 04                CMP #$04
7158   90 09                BCC L7163
715A   C9 FC                CMP #$FC
715C   B0 05                BCS L7163
715E   CA         L715E     DEX
715F   10 DA                BPL L713B
7161   E8                   INX
7162   60                   RTS
7163   EE FA 02   L7163     INC $02FA
7166   60                   RTS
7167   90 A2                BCC L710B
7169   1A                   NOP
716A   AD FB 02             LDA $02FB
716D   D0 70                BNE L71DF
716F   AD 1C 02             LDA $021C
7172   D0 73                BNE L71E7
7174   8D 3F 02             STA $023F
7177   8D 62 02             STA $0262
717A   EE FD 02             INC $02FD
717D   AD FD 02             LDA $02FD
7180   C9 0B                CMP #$0B
7182   90 03                BCC L7187
7184   CE FD 02             DEC $02FD
7187   AD F5 02   L7187     LDA $02F5
718A   18                   CLC
718B   69 02                ADC #$02
718D   C9 0B                CMP #$0B
718F   90 02                BCC L7193
7191   A9 0B                LDA #$0B
7193   8D F6 02   L7193     STA $02F6
7196   8D F5 02             STA $02F5
7199   85 08                STA $08
719B   A0 1C                LDY #$1C
719D   20 B5 77   L719D     JSR L77B5
71A0   29 18                AND #$18
71A2   09 04                ORA #$04
71A4   9D 00 02             STA $0200,X
71A7   20 03 72             JSR L7203
71AA   20 B5 77             JSR L77B5
71AD   4A                   LSR A
71AE   29 1F                AND #$1F
71B0   90 13                BCC L71C5
71B2   C9 18                CMP #$18
71B4   90 02                BCC L71B8
71B6   29 17                AND #$17
71B8   9D 8C 02   L71B8     STA $028C,X
71BB   A9 00                LDA #$00
71BD   9D 69 02             STA $0269,X
71C0   9D AF 02             STA $02AF,X
71C3   F0 0B                BEQ L71D0
71C5   9D 69 02   L71C5     STA $0269,X
71C8   A9 00                LDA #$00
71CA   9D 8C 02             STA $028C,X
71CD   9D D2 02             STA $02D2,X
71D0   CA         L71D0     DEX
71D1   C6 08                DEC $08
71D3   D0 C8                BNE L719D
71D5   A9 7F                LDA #$7F
71D7   8D F7 02             STA $02F7
71DA   A9 30                LDA #$30
71DC   8D FC 02             STA $02FC
71DF   A9 00      L71DF     LDA #$00
71E1   9D 00 02   L71E1     STA $0200,X
71E4   CA                   DEX
71E5   10 FA                BPL L71E1
71E7   60         L71E7     RTS
71E8   A9 60                LDA #$60
71EA   8D CA 02             STA $02CA
71ED   8D ED 02             STA $02ED
71F0   A9 00                LDA #$00
71F2   8D 3E 02             STA $023E
71F5   8D 61 02             STA $0261
71F8   A9 10                LDA #$10
71FA   8D 84 02             STA $0284
71FD   A9 0C                LDA #$0C
71FF   8D A7 02             STA $02A7
7202   60                   RTS
7203   20 B5 77   L7203     JSR L77B5
7206   29 8F                AND #$8F
7208   10 02                BPL L720C
720A   09 F0                ORA #$F0
720C   18         L720C     CLC
720D   79 23 02             ADC $0223,Y
7210   20 33 72             JSR L7233
7213   9D 23 02             STA $0223,X
7216   20 B5 77             JSR L77B5
7219   20 B5 77             JSR L77B5
721C   20 B5 77             JSR L77B5
721F   20 B5 77             JSR L77B5
7222   29 8F                AND #$8F
7224   10 02                BPL L7228
7226   09 F0                ORA #$F0
7228   18         L7228     CLC
7229   79 46 02             ADC $0246,Y
722C   20 33 72             JSR L7233
722F   9D 46 02             STA $0246,X
7232   60                   RTS
7233   10 0D      L7233     BPL L7242
7235   C9 E1                CMP #$E1
7237   B0 02                BCS L723B
7239   A9 E1                LDA #$E1
723B   C9 FB      L723B     CMP #$FB
723D   90 0F                BCC L724E
723F   A9 FA                LDA #$FA
7241   60                   RTS
7242   C9 06      L7242     CMP #$06
7244   B0 02                BCS L7248
7246   A9 06                LDA #$06
7248   C9 20      L7248     CMP #$20
724A   90 02                BCC L724E
724C   A9 1F                LDA #$1F
724E   60         L724E     RTS
724F   A9 10                LDA #$10
7251   85 00                STA $00
7253   A9 50                LDA #$50
7255   A2 A4                LDX #$A4
7257   20 FC 7B             JSR $7BFC
725A   A9 19                LDA #$19
725C   A2 DB                LDX #$DB
725E   20 03 7C             JSR $7C03
7261   A9 70                LDA #$70
7263   20 DE 7C             JSR $7CDE
7266   A2 00                LDX #$00
7268   A5 1C                LDA $1C
726A   C9 02                CMP #$02
726C   D0 18                BNE L7286
726E   A5 18                LDA $18
7270   D0 14                BNE L7286
7272   A2 20                LDX #$20
7274   AD 1B 02             LDA $021B
7277   05 59                ORA $59
7279   D0 0B                BNE L7286
727B   AD FA 02             LDA $02FA
727E   30 06                BMI L7286
7280   A5 5C                LDA $5C
7282   29 10                AND #$10
7284   F0 0D                BEQ L7293
7286   A9 52      L7286     LDA #$52
7288   A0 02                LDY #$02
728A   38                   SEC
728B   20 3F 77             JSR L773F
728E   A9 00                LDA #$00
7290   20 8B 77             JSR L778B
7293   A9 28      L7293     LDA #$28
7295   A4 57                LDY $57
7297   20 3E 6F             JSR $6F3E
729A   A9 00                LDA #$00
729C   85 00                STA $00
729E   A9 78                LDA #$78
72A0   A2 DB                LDX #$DB
72A2   20 03 7C             JSR $7C03
72A5   A9 50                LDA #$50
72A7   20 DE 7C             JSR $7CDE
72AA   A9 1D                LDA #$1D
72AC   A0 02                LDY #$02
72AE   38                   SEC
72AF   20 3F 77             JSR L773F
72B2   A9 00                LDA #$00
72B4   20 D1 7B             JSR $7BD1
72B7   A9 10                LDA #$10
72B9   85 00                STA $00
72BB   A9 C0                LDA #$C0
72BD   A2 DB                LDX #$DB
72BF   20 03 7C             JSR $7C03
72C2   A9 50                LDA #$50
72C4   20 DE 7C             JSR $7CDE
72C7   A2 00                LDX #$00
72C9   A5 1C                LDA $1C
72CB   C9 01                CMP #$01
72CD   F0 2E                BEQ L72FD
72CF   90 18                BCC L72E9
72D1   A5 18                LDA $18
72D3   F0 14                BEQ L72E9
72D5   A2 20                LDX #$20
72D7   AD 1B 02             LDA $021B
72DA   05 59                ORA $59
72DC   D0 0B                BNE L72E9
72DE   AD FA 02             LDA $02FA
72E1   30 06                BMI L72E9
72E3   A5 5C                LDA $5C
72E5   29 10                AND #$10
72E7   F0 0D                BEQ L72F6
72E9   A9 54      L72E9     LDA #$54
72EB   A0 02                LDY #$02
72ED   38                   SEC
72EE   20 3F 77             JSR L773F
72F1   A9 00                LDA #$00
72F3   20 8B 77             JSR L778B
72F6   A9 CF      L72F6     LDA #$CF
72F8   A4 58                LDY $58
72FA   4C 3E 6F             JMP $6F3E
72FD   60         L72FD     RTS
72FE   84 00      L72FE     STY $00
7300   86 0D                STX $0D
7302   A5 05                LDA $05
7304   4A                   LSR A
7305   66 04                ROR $04
7307   4A                   LSR A
7308   66 04                ROR $04
730A   4A                   LSR A
730B   66 04                ROR $04
730D   85 05                STA $05
730F   A5 07                LDA $07
7311   18                   CLC
7312   69 04                ADC #$04
7314   4A                   LSR A
7315   66 06                ROR $06
7317   4A                   LSR A
7318   66 06                ROR $06
731A   4A                   LSR A
731B   66 06                ROR $06
731D   85 07                STA $07
731F   A2 04                LDX #$04
7321   20 1C 7C             JSR $7C1C
7324   A9 70                LDA #$70
7326   38                   SEC
7327   E5 00                SBC $00
7329   C9 A0                CMP #$A0
732B   90 0E                BCC L733B
732D   48         L732D     PHA
732E   A9 90                LDA #$90
7330   20 DE 7C             JSR $7CDE
7333   68                   PLA
7334   38                   SEC
7335   E9 10                SBC #$10
7337   C9 A0                CMP #$A0
7339   B0 F2                BCS L732D
733B   20 DE 7C   L733B     JSR $7CDE
733E   A6 0D                LDX $0D
7340   BD 00 02             LDA $0200,X
7343   10 16                BPL L735B
7345   E0 1B                CPX #$1B
7347   F0 0C                BEQ L7355
7349   29 0C                AND #$0C
734B   4A                   LSR A
734C   A8                   TAY
734D   B9 F8 50             LDA $50F8,Y
7350   BE F9 50             LDX $50F9,Y
7353   D0 1B                BNE L7370
7355   20 65 74   L7355     JSR L7465
7358   A6 0D                LDX $0D
735A   60                   RTS
735B   E0 1B      L735B     CPX #$1B
735D   F0 17                BEQ L7376
735F   E0 1C                CPX #$1C
7361   F0 19                BEQ L737C
7363   B0 1F                BCS L7384
7365   29 18                AND #$18
7367   4A                   LSR A
7368   4A                   LSR A
7369   A8                   TAY
736A   B9 DE 51             LDA $51DE,Y
736D   BE DF 51             LDX $51DF,Y
7370   20 45 7D   L7370     JSR $7D45
7373   A6 0D                LDX $0D
7375   60                   RTS
7376   20 0B 75   L7376     JSR L750B
7379   A6 0D                LDX $0D
737B   60                   RTS
737C   AD 50 52   L737C     LDA $5250
737F   AE 51 52             LDX $5251
7382   D0 EC                BNE L7370
7384   A9 70      L7384     LDA #$70
7386   A2 F0                LDX #$F0
7388   20 E0 7C             JSR $7CE0
738B   A6 0D                LDX $0D
738D   A5 5C                LDA $5C
738F   29 03                AND #$03
7391   D0 03                BNE L7396
7393   DE 00 02             DEC $0200,X
7396   60         L7396     RTS
7397   F8         L7397     SED
7398   75 52                ADC $52,X
739A   95 52                STA $52,X
739C   90 12                BCC L73B0
739E   B5 53                LDA $53,X
73A0   69 00                ADC #$00
73A2   95 53                STA $53,X
73A4   29 0F                AND #$0F
73A6   D0 08                BNE L73B0
73A8   A9 B0                LDA #$B0
73AA   85 68                STA $68
73AC   A6 18                LDX $18
73AE   F6 57                INC $57,X
73B0   D8         L73B0     CLD
73B1   60                   RTS
73B2   A5 18                LDA $18
73B4   0A                   ASL A
73B5   0A                   ASL A
73B6   85 08                STA $08
73B8   A5 6F                LDA $6F
73BA   29 FB                AND #$FB
73BC   05 08                ORA $08
73BE   85 6F                STA $6F
73C0   8D 00 32             STA $3200
73C3   60                   RTS
73C4   A5 1C                LDA $1C
73C6   F0 02                BEQ L73CA
73C8   18         L73C8     CLC
73C9   60                   RTS
73CA   A5 5D      L73CA     LDA $5D
73CC   29 04                AND #$04
73CE   D0 F8                BNE L73C8
73D0   A5 1D                LDA $1D
73D2   05 1E                ORA $1E
73D4   F0 F2                BEQ L73C8
73D6   A0 00                LDY #$00
73D8   20 F6 77             JSR L77F6
73DB   A2 00                LDX #$00
73DD   86 10                STX $10
73DF   A9 01                LDA #$01
73E1   85 00                STA $00
73E3   A9 A7                LDA #$A7
73E5   85 0E                STA $0E
73E7   A9 10                LDA #$10
73E9   85 00                STA $00
73EB   B5 1D      L73EB     LDA $1D,X
73ED   15 1E                ORA $1E,X
73EF   F0 67                BEQ L7458
73F1   86 0F                STX $0F
73F3   A9 5F                LDA #$5F
73F5   A6 0E                LDX $0E
73F7   20 03 7C             JSR $7C03
73FA   A9 40                LDA #$40
73FC   20 DE 7C             JSR $7CDE
73FF   A5 0F                LDA $0F
7401   4A                   LSR A
7402   F8                   SED
7403   69 01                ADC #$01
7405   D8                   CLD
7406   85 0D                STA $0D
7408   A9 0D                LDA #$0D
740A   38                   SEC
740B   A0 01                LDY #$01
740D   A2 00                LDX #$00
740F   20 3F 77             JSR L773F
7412   A9 40                LDA #$40
7414   AA                   TAX
7415   20 E0 7C             JSR $7CE0
7418   A0 00                LDY #$00
741A   20 35 6F             JSR $6F35
741D   A5 0F                LDA $0F
741F   18                   CLC
7420   69 1D                ADC #$1D
7422   A0 02                LDY #$02
7424   38                   SEC
7425   A2 00                LDX #$00
7427   20 3F 77             JSR L773F
742A   A9 00                LDA #$00
742C   20 D1 7B             JSR $7BD1
742F   A0 00                LDY #$00
7431   20 35 6F             JSR $6F35
7434   A4 10                LDY $10
7436   20 1A 6F             JSR $6F1A
7439   E6 10                INC $10
743B   A4 10                LDY $10
743D   20 1A 6F             JSR $6F1A
7440   E6 10                INC $10
7442   A4 10                LDY $10
7444   20 1A 6F             JSR $6F1A
7447   E6 10                INC $10
7449   A5 0E                LDA $0E
744B   38                   SEC
744C   E9 08                SBC #$08
744E   85 0E                STA $0E
7450   A6 0F                LDX $0F
7452   E8                   INX
7453   E8                   INX
7454   E0 14                CPX #$14
7456   90 93                BCC L73EB
7458   38         L7458     SEC
7459   60                   RTS
745A   A2 1A      L745A     LDX #$1A
745C   BD 00 02   L745C     LDA $0200,X
745F   F0 03                BEQ L7464
7461   CA                   DEX
7462   10 F8                BPL L745C
7464   60         L7464     RTS
7465   AD 1B 02   L7465     LDA $021B
7468   C9 A2                CMP #$A2
746A   B0 22                BCS L748E
746C   A2 0A                LDX #$0A
746E   BD EC 50   L746E     LDA $50EC,X
7471   4A                   LSR A
7472   4A                   LSR A
7473   4A                   LSR A
7474   4A                   LSR A
7475   18                   CLC
7476   69 F8                ADC #$F8
7478   49 F8                EOR #$F8
747A   95 7E                STA $7E,X
747C   BD ED 50             LDA $50ED,X
747F   4A                   LSR A
7480   4A                   LSR A
7481   4A                   LSR A
7482   4A                   LSR A
7483   18                   CLC
7484   69 F8                ADC #$F8
7486   49 F8                EOR #$F8
7488   95 8A                STA $8A,X
748A   CA                   DEX
748B   CA                   DEX
748C   10 E0                BPL L746E
748E   AD 1B 02   L748E     LDA $021B
7491   49 FF                EOR #$FF
7493   29 70                AND #$70
7495   4A                   LSR A
7496   4A                   LSR A
7497   4A                   LSR A
7498   AA                   TAX
7499   86 09      L7499     STX $09
749B   A0 00                LDY #$00
749D   BD EC 50             LDA $50EC,X
74A0   10 01                BPL L74A3
74A2   88                   DEY
74A3   18         L74A3     CLC
74A4   75 7D                ADC $7D,X
74A6   95 7D                STA $7D,X
74A8   98                   TYA
74A9   75 7E                ADC $7E,X
74AB   95 7E                STA $7E,X
74AD   85 04                STA $04
74AF   84 05                STY $05
74B1   A0 00                LDY #$00
74B3   BD ED 50             LDA $50ED,X
74B6   10 01                BPL L74B9
74B8   88                   DEY
74B9   18         L74B9     CLC
74BA   75 89                ADC $89,X
74BC   95 89                STA $89,X
74BE   98                   TYA
74BF   75 8A                ADC $8A,X
74C1   95 8A                STA $8A,X
74C3   85 06                STA $06
74C5   84 07                STY $07
74C7   A5 02                LDA $02
74C9   85 0B                STA $0B
74CB   A5 03                LDA $03
74CD   85 0C                STA $0C
74CF   20 49 7C             JSR $7C49
74D2   A4 09                LDY $09
74D4   B9 E0 50             LDA $50E0,Y
74D7   BE E1 50             LDX $50E1,Y
74DA   20 45 7D             JSR $7D45
74DD   A4 09                LDY $09
74DF   B9 E1 50             LDA $50E1,Y
74E2   49 04                EOR #$04
74E4   AA                   TAX
74E5   B9 E0 50             LDA $50E0,Y
74E8   29 0F                AND #$0F
74EA   49 04                EOR #$04
74EC   20 45 7D             JSR $7D45
74EF   A0 FF                LDY #$FF
74F1   C8         L74F1     INY
74F2   B1 0B                LDA ($0B),Y
74F4   91 02                STA ($02),Y
74F6   C8                   INY
74F7   B1 0B                LDA ($0B),Y
74F9   49 04                EOR #$04
74FB   91 02                STA ($02),Y
74FD   C0 03                CPY #$03
74FF   90 F0                BCC L74F1
7501   20 39 7C             JSR $7C39
7504   A6 09                LDX $09
7506   CA                   DEX
7507   CA                   DEX
7508   10 8F                BPL L7499
750A   60                   RTS
750B   A2 00      L750B     LDX #$00
750D   86 17                STX $17
750F   A0 00                LDY #$00
7511   A5 61                LDA $61
7513   10 06                BPL L751B
7515   A0 04                LDY #$04
7517   8A                   TXA
7518   38                   SEC
7519   E5 61                SBC $61
751B   85 08      L751B     STA $08
751D   24 08                BIT $08
751F   30 02                BMI L7523
7521   50 07                BVC L752A
7523   A2 04      L7523     LDX #$04
7525   A9 80                LDA #$80
7527   38                   SEC
7528   E5 08                SBC $08
752A   86 08      L752A     STX $08
752C   84 09                STY $09
752E   4A                   LSR A
752F   29 FE                AND #$FE
7531   A8                   TAY
7532   B9 6E 52             LDA $526E,Y
7535   BE 6F 52             LDX $526F,Y
7538   20 D3 6A             JSR $6AD3
753B   AD 05 24             LDA $2405
753E   10 14                BPL L7554
7540   A5 5C                LDA $5C
7542   29 04                AND #$04
7544   F0 0E                BEQ L7554
7546   C8                   INY
7547   C8                   INY
7548   38                   SEC
7549   A6 0C                LDX $0C
754B   98                   TYA
754C   65 0B                ADC $0B
754E   90 01                BCC L7551
7550   E8                   INX
7551   20 D3 6A   L7551     JSR $6AD3
7554   60         L7554     RTS
7555   A5 1C                LDA $1C
7557   D0 01                BNE L755A
7559   60                   RTS
755A   A2 00      L755A     LDX #$00
755C   AD 1C 02             LDA $021C
755F   30 0A                BMI L756B
7561   F0 08                BEQ L756B
7563   6A                   ROR A
7564   6A                   ROR A
7565   6A                   ROR A
7566   8D 02 3C             STA $3C02
7569   A2 80                LDX #$80
756B   8E 00 3C   L756B     STX $3C00
756E   A2 01                LDX #$01
7570   20 CD 75             JSR L75CD
7573   8D 01 3C             STA $3C01
7576   CA                   DEX
7577   20 CD 75             JSR L75CD
757A   8D 04 3C             STA $3C04
757D   AD 1B 02             LDA $021B
7580   C9 01                CMP #$01
7582   F0 04                BEQ L7588
7584   8A                   TXA
7585   8D 03 3C             STA $3C03
7588   AD F6 02   L7588     LDA $02F6
758B   F0 11                BEQ L759E
758D   AD 1B 02             LDA $021B
7590   30 0C                BMI L759E
7592   05 59                ORA $59
7594   F0 08                BEQ L759E
7596   A5 6D                LDA $6D
7598   F0 14                BEQ L75AE
759A   C6 6D                DEC $6D
759C   D0 21                BNE L75BF
759E   A5 6C      L759E     LDA $6C
75A0   29 0F                AND #$0F
75A2   85 6C                STA $6C
75A4   8D 00 3A             STA $3A00
75A7   AD FC 02             LDA $02FC
75AA   85 6E                STA $6E
75AC   10 11                BPL L75BF
75AE   C6 6E      L75AE     DEC $6E
75B0   D0 0D                BNE L75BF
75B2   A9 04                LDA #$04
75B4   85 6D                STA $6D
75B6   A5 6C                LDA $6C
75B8   49 14                EOR #$14
75BA   85 6C                STA $6C
75BC   8D 00 3A             STA $3A00
75BF   A5 69      L75BF     LDA $69
75C1   AA                   TAX
75C2   29 3F                AND #$3F
75C4   F0 01                BEQ L75C7
75C6   CA                   DEX
75C7   86 69      L75C7     STX $69
75C9   8E 00 36             STX $3600
75CC   60                   RTS
75CD   B5 6A      L75CD     LDA $6A,X
75CF   30 0C                BMI L75DD
75D1   B5 66                LDA $66,X
75D3   10 12                BPL L75E7
75D5   A9 10                LDA #$10
75D7   95 66                STA $66,X
75D9   A9 80      L75D9     LDA #$80
75DB   30 0C                BMI L75E9
75DD   B5 66      L75DD     LDA $66,X
75DF   F0 06                BEQ L75E7
75E1   30 04                BMI L75E7
75E3   D6 66                DEC $66,X
75E5   D0 F2                BNE L75D9
75E7   A9 00      L75E7     LDA #$00
75E9   95 6A      L75E9     STA $6A,X
75EB   60                   RTS
75EC   86 0D                STX $0D
75EE   A9 50                LDA #$50
75F0   8D F9 02             STA $02F9
75F3   B9 00 02             LDA $0200,Y
75F6   29 78                AND #$78
75F8   85 0E                STA $0E
75FA   B9 00 02             LDA $0200,Y
75FD   29 07                AND #$07
75FF   4A                   LSR A
7600   AA                   TAX
7601   F0 02                BEQ L7605
7603   05 0E                ORA $0E
7605   99 00 02   L7605     STA $0200,Y
7608   A5 1C                LDA $1C
760A   F0 11                BEQ L761D
760C   A5 0D                LDA $0D
760E   F0 04                BEQ L7614
7610   C9 04                CMP #$04
7612   90 09                BCC L761D
7614   BD 59 76   L7614     LDA $7659,X
7617   A6 19                LDX $19
7619   18                   CLC
761A   20 97 73             JSR L7397
761D   BE 00 02   L761D     LDX $0200,Y
7620   F0 34                BEQ L7656
7622   20 5A 74             JSR L745A
7625   30 2F                BMI L7656
7627   EE F6 02             INC $02F6
762A   20 9D 6A             JSR $6A9D
762D   20 03 72             JSR L7203
7630   BD 23 02             LDA $0223,X
7633   29 1F                AND #$1F
7635   0A                   ASL A
7636   5D AF 02             EOR $02AF,X
7639   9D AF 02             STA $02AF,X
763C   20 5C 74             JSR L745C
763F   30 15                BMI L7656
7641   EE F6 02             INC $02F6
7644   20 9D 6A             JSR $6A9D
7647   20 03 72             JSR L7203
764A   BD 46 02             LDA $0246,X
764D   29 1F                AND #$1F
764F   0A                   ASL A
7650   5D D2 02             EOR $02D2,X
7653   9D D2 02             STA $02D2,X
7656   A6 0D      L7656     LDX $0D
7658   60                   RTS
7659   10 05                BPL L7660
765B   02                   JAM
765C   A5 1C                LDA $1C
765E   10 38                BPL L7698
7660   A2 02      L7660     LDX #$02
7662   85 5D                STA $5D
7664   85 32                STA $32
7666   85 33                STA $33
7668   A0 00      L7668     LDY #$00
766A   B9 1D 00   L766A     LDA $001D,Y
766D   D5 52                CMP $52,X
766F   B9 1E 00             LDA $001E,Y
7672   F5 53                SBC $53,X
7674   90 23                BCC L7699
7676   C8                   INY
7677   C8                   INY
7678   C0 14                CPY #$14
767A   90 EE                BCC L766A
767C   CA         L767C     DEX
767D   CA                   DEX
767E   10 E8                BPL L7668
7680   A5 33                LDA $33
7682   30 0E                BMI L7692
7684   C5 32                CMP $32
7686   90 0A                BCC L7692
7688   69 02                ADC #$02
768A   C9 1E                CMP #$1E
768C   90 02                BCC L7690
768E   A9 FF                LDA #$FF
7690   85 33      L7690     STA $33
7692   A9 00      L7692     LDA #$00
7694   85 1C                STA $1C
7696   85 31                STA $31
7698   60         L7698     RTS
7699   86 0B      L7699     STX $0B
769B   84 0C                STY $0C
769D   8A                   TXA
769E   4A                   LSR A
769F   AA                   TAX
76A0   98                   TYA
76A1   4A                   LSR A
76A2   65 0C                ADC $0C
76A4   85 0D                STA $0D
76A6   95 32                STA $32,X
76A8   A2 1B                LDX #$1B
76AA   A0 12                LDY #$12
76AC   E4 0D      L76AC     CPX $0D
76AE   F0 1F                BEQ L76CF
76B0   B5 31                LDA $31,X
76B2   95 34                STA $34,X
76B4   B5 32                LDA $32,X
76B6   95 35                STA $35,X
76B8   B5 33                LDA $33,X
76BA   95 36                STA $36,X
76BC   B9 1B 00             LDA $001B,Y
76BF   99 1D 00             STA $001D,Y
76C2   B9 1C 00             LDA $001C,Y
76C5   99 1E 00             STA $001E,Y
76C8   88                   DEY
76C9   88                   DEY
76CA   CA                   DEX
76CB   CA                   DEX
76CC   CA                   DEX
76CD   D0 DD                BNE L76AC
76CF   A9 0B      L76CF     LDA #$0B
76D1   95 34                STA $34,X
76D3   A9 00                LDA #$00
76D5   95 35                STA $35,X
76D7   95 36                STA $36,X
76D9   A9 F0                LDA #$F0
76DB   85 5D                STA $5D
76DD   A6 0B                LDX $0B
76DF   A4 0C                LDY $0C
76E1   B5 53                LDA $53,X
76E3   99 1E 00             STA $001E,Y
76E6   B5 52                LDA $52,X
76E8   99 1D 00             STA $001D,Y
76EB   A0 00                LDY #$00
76ED   F0 8D                BEQ L767C
76EF   DF 98 10             DCP $1098,X
76F2   09 20                ORA #$20
76F4   08                   PHP
76F5   77 20                RRA $20,X
76F7   FC 76 4C             NOP $4C76,X
76FA   08                   PHP
76FB   77 A8                RRA $A8,X
76FD   8A                   TXA
76FE   10 0E                BPL L770E
7700   20 08 77             JSR L7708
7703   20 0E 77             JSR L770E
7706   49 80                EOR #$80
7708   49 FF      L7708     EOR #$FF
770A   18                   CLC
770B   69 01                ADC #$01
770D   60                   RTS
770E   85 0C      L770E     STA $0C
7710   98                   TYA
7711   C5 0C                CMP $0C
7713   F0 10                BEQ L7725
7715   90 11                BCC L7728
7717   A4 0C                LDY $0C
7719   85 0C                STA $0C
771B   98                   TYA
771C   20 28 77             JSR L7728
771F   38                   SEC
7720   E9 40                SBC #$40
7722   4C 08 77             JMP L7708
7725   A9 20      L7725     LDA #$20
7727   60                   RTS
7728   20 6C 77   L7728     JSR L776C
772B   BD 2F 77             LDA $772F,X
772E   60                   RTS
772F   00                   BRK
7730   02                   JAM
7731   05 07                ORA $07
7733   0A                   ASL A
7734   0C 0F 11             NOP $110F
7737   13 15                SLO ($15),Y
7739   17 19                SLO $19,X
773B   1A                   NOP
773C   1C 1D 1F             NOP $1F1D,X
773F   08         L773F     PHP
7740   86 17                STX $17
7742   88                   DEY
7743   84 16                STY $16
7745   18                   CLC
7746   65 16                ADC $16
7748   85 15                STA $15
774A   28                   PLP
774B   AA                   TAX
774C   08         L774C     PHP
774D   B5 00                LDA $00,X
774F   4A                   LSR A
7750   4A                   LSR A
7751   4A                   LSR A
7752   4A                   LSR A
7753   28                   PLP
7754   20 85 77             JSR L7785
7757   A5 16                LDA $16
7759   D0 01                BNE L775C
775B   18                   CLC
775C   A6 15      L775C     LDX $15
775E   B5 00                LDA $00,X
7760   20 85 77             JSR L7785
7763   C6 15                DEC $15
7765   A6 15                LDX $15
7767   C6 16                DEC $16
7769   10 E1                BPL L774C
776B   60                   RTS
776C   A0 00      L776C     LDY #$00
776E   84 0B                STY $0B
7770   A0 04                LDY #$04
7772   26 0B      L7772     ROL $0B
7774   2A                   ROL A
7775   C5 0C                CMP $0C
7777   90 02                BCC L777B
7779   E5 0C                SBC $0C
777B   88         L777B     DEY
777C   D0 F4                BNE L7772
777E   A5 0B                LDA $0B
7780   2A                   ROL A
7781   29 0F                AND #$0F
7783   AA                   TAX
7784   60                   RTS
7785   90 04      L7785     BCC L778B
7787   29 0F                AND #$0F
7789   F0 27                BEQ L77B2
778B   A6 17      L778B     LDX $17
778D   F0 23                BEQ L77B2
778F   29 0F                AND #$0F
7791   18                   CLC
7792   69 01                ADC #$01
7794   08                   PHP
7795   0A                   ASL A
7796   A8                   TAY
7797   B9 D4 56             LDA $56D4,Y
779A   0A                   ASL A
779B   85 0B                STA $0B
779D   B9 D5 56             LDA $56D5,Y
77A0   2A                   ROL A
77A1   29 1F                AND #$1F
77A3   09 40                ORA #$40
77A5   85 0C                STA $0C
77A7   A9 00                LDA #$00
77A9   85 08                STA $08
77AB   85 09                STA $09
77AD   20 D7 6A             JSR $6AD7
77B0   28                   PLP
77B1   60                   RTS
77B2   4C CB 7B   L77B2     JMP $7BCB
77B5   06 5F      L77B5     ASL $5F
77B7   26 60                ROL $60
77B9   10 02                BPL L77BD
77BB   E6 5F                INC $5F
77BD   A5 5F      L77BD     LDA $5F
77BF   2C D1 77             BIT $77D1
77C2   F0 04                BEQ L77C8
77C4   49 01                EOR #$01
77C6   85 5F                STA $5F
77C8   05 60      L77C8     ORA $60
77CA   D0 02                BNE L77CE
77CC   E6 5F                INC $5F
77CE   A5 5F      L77CE     LDA $5F
77D0   60                   RTS
77D1   02                   JAM
77D2   18         L77D2     CLC
77D3   69 40                ADC #$40
77D5   10 08      L77D5     BPL L77DF
77D7   29 7F                AND #$7F
77D9   20 DF 77             JSR L77DF
77DC   4C 08 77             JMP L7708
77DF   C9 41      L77DF     CMP #$41
77E1   90 04                BCC L77E7
77E3   49 7F                EOR #$7F
77E5   69 00                ADC #$00
77E7   AA         L77E7     TAX
77E8   BD B9 57             LDA $57B9,X
77EB   60                   RTS
77EC   00                   BRK
77ED   00                   BRK
77EE   00                   BRK
77EF   00                   BRK
77F0   00                   BRK
77F1   00                   BRK
77F2   00                   BRK
77F3   00                   BRK
77F4   00                   BRK
77F5   00                   BRK
77F6   AD 03 28   L77F6     LDA $2803
77F9   29 03                AND #$03
77FB   0A                   ASL A
77FC   AA                   TAX
77FD   A9 10                LDA #$10
77FF   85 00                STA $00
                            .END

;auto-generated symbols and labels
 L7011      $7011
 L7013      $7013
 L7027      $7027
 L7068      $7068
 L7081      $7081
 L7085      $7085
 L7086      $7086
 L7096      $7096
 L7105      $7105
 L7119      $7119
 L7124      $7124
 L7125      $7125
 L7130      $7130
 L7138      $7138
 L7139      $7139
 L7163      $7163
 L7187      $7187
 L7193      $7193
 L7203      $7203
 L7228      $7228
 L7233      $7233
 L7242      $7242
 L7248      $7248
 L7286      $7286
 L7293      $7293
 L7355      $7355
 L7370      $7370
 L7376      $7376
 L7384      $7384
 L7396      $7396
 L7397      $7397
 L7458      $7458
 L7464      $7464
 L7465      $7465
 L7499      $7499
 L7523      $7523
 L7551      $7551
 L7554      $7554
 L7588      $7588
 L7605      $7605
 L7614      $7614
 L7656      $7656
 L7660      $7660
 L7668      $7668
 L7690      $7690
 L7692      $7692
 L7698      $7698
 L7699      $7699
 L7708      $7708
 L7725      $7725
 L7728      $7728
 L7772      $7772
 L7785      $7785
 L72FE      $72FE
 L706F      $706F
 L708F      $708F
 L709B      $709B
 L70E1      $70E1
 L77D2      $77D2
 L70B4      $70B4
 L77D5      $77D5
 L70CF      $70CF
 L70FA      $70FA
 L715E      $715E
 L714F      $714F
 L713B      $713B
 L710B      $710B
 L71DF      $71DF
 L71E7      $71E7
 L77B5      $77B5
 L71C5      $71C5
 L71B8      $71B8
 L71D0      $71D0
 L719D      $719D
 L71E1      $71E1
 L720C      $720C
 L723B      $723B
 L724E      $724E
 L773F      $773F
 L778B      $778B
 L72FD      $72FD
 L72E9      $72E9
 L72F6      $72F6
 L733B      $733B
 L732D      $732D
 L735B      $735B
 L737C      $737C
 L750B      $750B
 L73B0      $73B0
 L73CA      $73CA
 L73C8      $73C8
 L77F6      $77F6
 L73EB      $73EB
 L745C      $745C
 L748E      $748E
 L746E      $746E
 L74A3      $74A3
 L74B9      $74B9
 L74F1      $74F1
 L751B      $751B
 L752A      $752A
 L755A      $755A
 L756B      $756B
 L75CD      $75CD
 L759E      $759E
 L75AE      $75AE
 L75BF      $75BF
 L75C7      $75C7
 L75DD      $75DD
 L75E7      $75E7
 L75E9      $75E9
 L75D9      $75D9
 L761D      $761D
 L745A      $745A
 L766A      $766A
 L76CF      $76CF
 L76AC      $76AC
 L767C      $767C
 L770E      $770E
 L776C      $776C
 L775C      $775C
 L774C      $774C
 L777B      $777B
 L77B2      $77B2
 L77BD      $77BD
 L77C8      $77C8
 L77CE      $77CE
 L77DF      $77DF
 L77E7      $77E7