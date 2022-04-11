;Omer Kenan Ucmaklioglu
;Resistor Calculator

.MODEL SMALL
.STACK 64
;----------------------------------------
.DATA

INFO1 DB "TYPE 1 TO CALCULATE 4 BAND RESISTOR VALUE","$"
INFO2 DB "TYPE 2 TO CALCULATE 5 BAND RESISTOR VALUE","$"
INFO3 DB "TYPE 3 TO CALCULATE SMD RESISTOR VALUE","$"
SMD DB "TYPE 3 DIGIT SMD VALUE:","$"

SMDR DB "RESISTOR VALUE:","$"
SMDR0 DB " OHM","$"
SMDRK DB "K OHM","$"
SMDRM DB "M OHM","$"
SMDRG DB "G OHM","$"
SMDRD DB "deci OHM","$"
SMDRC DB "centi OHM","$"

NEWLINE DB 0AH,0DH,"$"
NVALID DB "THIS SELECTION IS NOT VALID!PRESS ANY KEY TO TRY AGAIN...","$"
COLORS4 DB "TYPE COLORS WITH 1 LETTER IN ORDER.SAMPLE: KRMV","$"
COLORS5 DB "TYPE COLORS WITH 1 LETTER IN ORDER.SAMPLE: KRMVS","$"
CINFO DB "BLACK=B  | BROWN=K | RED=R  | ORANGE=O",0AH,0DH,"YELLOW=Y | GREEN=G | BLUE=M | VIOLET=V",0AH,0DH,"GREY=T   | WHITE=W | GOLD=A | SILVER=S",0AH,0DH,"PINK=P","$"

DATA4 DB ""
;----------------------------------------
.CODE

PROC MAIN
        MOV AX,@DATA
        MOV DS,AX
        
START:  MOV AH,09H
        MOV DX,OFFSET INFO1
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET NEWLINE
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET INFO2
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET NEWLINE
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET INFO3
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET NEWLINE
        INT 21H
        
        MOV AH,01H            
        INT 21H
        
        CMP AL,31H
        JZ BNDCLC4
        
        CMP AL,32H
        JZ BNDCLC5
        
        CMP AL,33H
        JZ SMDCLC 
        
        CMP AL,1BH
        JZ SHUTDOWN
        
        MOV AH,09H
        MOV DX,OFFSET NEWLINE
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET NVALID
        INT 21H
        
        MOV AH,01H             
        INT 21H
        
        CMP AL,1BH
        JZ SHUTDOWN
        
        MOV AH,0
        MOV AL,03H
        INT 10H
        
        JMP START
        
BNDCLC4:CALL BAND4
BNDCLC5:CALL BAND5
SMDCLC: CALL SMDPART
SHUTDOWN:INT 20H     

ENDP MAIN

SMDPART PROC
    
P1:     MOV AH,0
        MOV AL,03H
        INT 10H
                
        MOV AH,09H
        MOV DX,OFFSET SMD
        INT 21H
        
        MOV CX,3H
        
TAKE:   MOV AH,01H             
        INT 21H
        
        CMP AL,1BH
        JZ EXIT
        
        MOV AH,00H
        SUB AL,30H
        PUSH AX
        
        LOOP TAKE
        
        POP AX
        
        CMP AL,0
        JZ CALC0:
        CMP AL,1
        JZ CALC1:
        CMP AL,2
        JZ CALC2:
        CMP AL,3
        JZ CALC3:
        CMP AL,4
        JZ CALC4:
        CMP AL,5
        JZ CALC5:
        CMP AL,6
        JZ CALC6:
        CMP AL,7
        JZ CALC7:
        CMP AL,8
        JZ CALC8:
        CMP AL,9
        JZ CALC9:
        
        MOV AH,09H
        MOV DX,OFFSET NEWLINE
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET NVALID
        INT 21H
        
        MOV AH,01H              
        INT 21H
        
        CMP AL,1BH
        JZ EXIT
        
        JMP P1
        
CALC0:  MOV AH,00              
        MOV AL,12H             
        INT 10H
        INT 10H

        MOV AH,09H
        MOV DX,OFFSET SMDR
        INT 21H
        
        MOV AH,0000H
        
        MOV CL,00H
        POP CX
        ADD CL,30H
        
        MOV DL,00H
        POP DX
        ADD DX,30H
                
        MOV AH,02H
        INT 21H
        
        MOV DL,CL
        
        MOV AH,02H
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET SMDR0
        INT 21H
        
        JMP EXIT
 
CALC1:  MOV AH,00              
        MOV AL,12H             
        INT 10H
        INT 10H

        MOV AH,09H
        MOV DX,OFFSET SMDR
        INT 21H
        
        MOV AH,0000H
        
        MOV CL,00H
        POP CX
        ADD CL,30H
        
        MOV DL,00H
        POP DX
        ADD DX,30H
                
        MOV AH,02H
        INT 21H
        
        MOV DL,CL
        
        MOV AH,02H
        INT 21H
        
        MOV DL,30H
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET SMDR0
        INT 21H        
        
        JMP EXIT
        
CALC2:  MOV AH,00               
        MOV AL,12H             
        INT 10H
        INT 10H

        MOV AH,09H
        MOV DX,OFFSET SMDR
        INT 21H
        
        MOV AH,0000H
        
        MOV CL,00H
        POP CX
        ADD CL,30H
        
        MOV DL,00H
        POP DX
        ADD DX,30H
                
        MOV AH,02H
        INT 21H
        
        MOV DL,2EH
        INT 21H
        
        MOV DL,CL
        
        MOV AH,02H
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET SMDRK
        INT 21H
        
        JMP EXIT        
                                      
CALC3:  MOV AH,00               
        MOV AL,12H              
        INT 10H
        INT 10H

        MOV AH,09H
        MOV DX,OFFSET SMDR
        INT 21H
        
        MOV AH,0000H
        
        MOV CL,00H
        POP CX
        ADD CL,30H
        
        MOV DL,00H
        POP DX
        ADD DX,30H
                
        MOV AH,02H
        INT 21H
               
        MOV DL,CL
        
        MOV AH,02H
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET SMDRK
        INT 21H
        
        JMP EXIT

CALC4:  MOV AH,00               
        MOV AL,12H              
        INT 10H
        INT 10H

        MOV AH,09H
        MOV DX,OFFSET SMDR
        INT 21H
        
        MOV AH,0000H
        
        MOV CL,00H
        POP CX
        ADD CL,30H
        
        MOV DL,00H
        POP DX
        ADD DX,30H
                
        MOV AH,02H
        INT 21H
        
        MOV DL,CL
        
        MOV AH,02H
        INT 21H
        
        MOV DL,30H
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET SMDRK
        INT 21H
        
        JMP EXIT
        
CALC5:  MOV AH,00               
        MOV AL,12H             
        INT 10H
        INT 10H

        MOV AH,09H
        MOV DX,OFFSET SMDR
        INT 21H
        
        MOV AH,0000H
        
        MOV CL,00H
        POP CX
        ADD CL,30H
        
        MOV DL,00H
        POP DX
        ADD DX,30H
                
        MOV AH,02H
        INT 21H
        
        MOV DL,2EH
        INT 21H
        
        MOV DL,CL
        
        MOV AH,02H
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET SMDRM
        INT 21H
        
        JMP EXIT
        
CALC6:  MOV AH,00               
        MOV AL,12H             
        INT 10H
        INT 10H

        MOV AH,09H
        MOV DX,OFFSET SMDR
        INT 21H
        
        MOV AH,0000H
        
        MOV CL,00H
        POP CX
        ADD CL,30H
        
        MOV DL,00H
        POP DX
        ADD DX,30H
                
        MOV AH,02H
        INT 21H
        
        MOV DL,CL
        
        MOV AH,02H
        INT 21H        
        
        MOV AH,09H
        MOV DX,OFFSET SMDRM
        INT 21H
        
        JMP EXIT
        
CALC7:  MOV AH,00               
        MOV AL,12H              
        INT 10H
        INT 10H

        MOV AH,09H
        MOV DX,OFFSET SMDR
        INT 21H
        
        MOV AH,0000H
        
        MOV CL,00H
        POP CX
        ADD CL,30H
        
        MOV DL,00H
        POP DX
        ADD DX,30H
                
        MOV AH,02H
        INT 21H
        
        MOV DL,CL
        
        MOV AH,02H
        INT 21H
        
        MOV DL,30H
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET SMDRM
        INT 21H
        
        JMP EXIT                
                
CALC8:  MOV AH,00               
        MOV AL,12H              
        INT 10H
        INT 10H

        MOV AH,09H
        MOV DX,OFFSET SMDR
        INT 21H
        
        MOV AH,0000H
        
        MOV CL,00H
        POP CX
        ADD CL,30H
        
        MOV DL,00H
        POP DX
        ADD DX,30H
                
        MOV AH,02H
        INT 21H
        
        MOV DL,2EH
        INT 21H
        
        MOV DL,CL
        
        MOV AH,02H
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET SMDRG
        INT 21H
        
        JMP EXIT                

CALC9:  MOV AH,00               
        MOV AL,12H              
        INT 10H
        INT 10H

        MOV AH,09H
        MOV DX,OFFSET SMDR
        INT 21H
        
        MOV AH,0000H
        
        MOV CL,00H
        POP CX
        ADD CL,30H
        
        MOV DL,00H
        POP DX
        ADD DX,30H
                
        MOV AH,02H
        INT 21H
        
        MOV DL,CL
        
        MOV AH,02H
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET SMDRG
        INT 21H
        
                        
EXIT:   INT 20H                 
ENDP SMDPART

BAND4 PROC
S4:     MOV AH,0
        MOV AL,03H
        INT 10H
        
        MOV AH,09H
        MOV DX,OFFSET COLORS4
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET NEWLINE
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET CINFO
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET NEWLINE
        INT 21H
        
        MOV AH,02H
        MOV DL,3AH
        INT 21H
        
        MOV CX,4H
        MOV DI,0000H
        
TAKEN:  MOV AH,01H               
        INT 21H
        
        CMP AL,1BH
        JZ SHTDOWN
                
        MOV AH,00H
        MOV [DI],AX
        INC DI
        
        LOOP TAKEN
        
        MOV AH,0
        MOV AL,03H
        INT 10H
        
        SUB DI,4H
        
        MOV AH,00               
        MOV AL,12H              
        INT 10H
        INT 10H
                       
        MOV BX,0000H
        MOV BX,[DI]
        
        CMP BL,4BH
        JZ PRINT1
        CMP BL,52H
        JZ PRINT2
        CMP BL,4FH
        JZ PRINT3
        CMP BL,59H
        JZ PRINT4
        CMP BL,47H
        JZ PRINT5
        CMP BL,4DH
        JZ PRINT6
        CMP BL,56H
        JZ PRINT7
        CMP BL,54H
        JZ PRINT8
        CMP BL,57H
        JZ PRINT9
        
        MOV AH,09H
        MOV DX,OFFSET NEWLINE
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET NVALID
        INT 21H
        
        MOV AH,01H              
        INT 21H
        
        JMP S4

PRINT1: MOV AH,02H
        MOV DX,31H
        INT 21H
        JMP NEXT

PRINT2: MOV AH,02H
        MOV DX,32H
        INT 21H
        JMP NEXT
        
PRINT3: MOV AH,02H
        MOV DX,33H
        INT 21H
        JMP NEXT

PRINT4: MOV AH,02H
        MOV DX,34H
        INT 21H 
        JMP NEXT

PRINT5: MOV AH,02H
        MOV DX,35H
        INT 21H 
        JMP NEXT
        
PRINT6: MOV AH,02H
        MOV DX,36H
        INT 21H 
        JMP NEXT       
               
PRINT7: MOV AH,02H
        MOV DX,37H
        INT 21H 
        JMP NEXT

PRINT8: MOV AH,02H
        MOV DX,38H
        INT 21H 
        JMP NEXT
        
PRINT9: MOV AH,02H
        MOV DX,39H
        INT 21H
        
NEXT:                               
        INC DI
        
        MOV BX,0000H
        MOV BX,[DI]
        
        CMP BL,42H
        JZ PRNT0
        CMP BL,4BH
        JZ PRNT1
        CMP BL,52H
        JZ PRNT2
        CMP BL,4FH
        JZ PRNT3
        CMP BL,59H
        JZ PRNT4
        CMP BL,47H
        JZ PRNT5
        CMP BL,4DH
        JZ PRNT6
        CMP BL,56H
        JZ PRNT7
        CMP BL,54H
        JZ PRNT8
        CMP BL,57H
        JZ PRNT9
        
        MOV AH,09H
        MOV DX,OFFSET NEWLINE
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET NVALID
        INT 21H
        
        MOV AH,01H              
        INT 21H
        
        JMP S4

PRNT0:  CALL DOTCHCK
        MOV AH,02H
        MOV DX,30H
        INT 21H
        JMP NEXT2
        
PRNT1:  CALL DOTCHCK
        MOV AH,02H
        MOV DX,31H
        INT 21H
        JMP NEXT2

PRNT2:  CALL DOTCHCK
        MOV AH,02H
        MOV DX,32H
        INT 21H
        JMP NEXT2
        
PRNT3:  CALL DOTCHCK
        MOV AH,02H
        MOV DX,33H
        INT 21H
        JMP NEXT2

PRNT4:  CALL DOTCHCK
        MOV AH,02H
        MOV DX,34H
        INT 21H 
        JMP NEXT2

PRNT5:  CALL DOTCHCK
        MOV AH,02H
        MOV DX,35H
        INT 21H 
        JMP NEXT2
        
PRNT6:  CALL DOTCHCK
        MOV AH,02H
        MOV DX,36H
        INT 21H 
        JMP NEXT2       
               
PRNT7:  CALL DOTCHCK
        MOV AH,02H
        MOV DX,37H
        INT 21H 
        JMP NEXT2

PRNT8:  CALL DOTCHCK
        MOV AH,02H
        MOV DX,38H
        INT 21H 
        JMP NEXT2
        
PRNT9:  CALL DOTCHCK
        MOV AH,02H
        MOV DX,39H
        INT 21H

NEXT2:  
        INC DI
        
        MOV BX,0000H
        MOV BX,[DI]
        
        CMP BL,42H
        JZ PRNTO0
        CMP BL,4BH
        JZ PRNTO1
        CMP BL,52H
        JZ PRNTO2
        CMP BL,4FH
        JZ PRNTO3
        CMP BL,59H
        JZ PRNTO4
        CMP BL,47H
        JZ PRNTO5
        CMP BL,4DH
        JZ PRNTO6
        CMP BL,56H
        JZ PRNTO7
        CMP BL,54H
        JZ PRNTO8
        CMP BL,57H
        JZ PRNTO9
        CMP BL,41H
        JZ PRNT10
        CMP BL,53H
        JZ PRNT11
        CMP BL,50H
        JZ PRNT12
        
        MOV AH,09H
        MOV DX,OFFSET NEWLINE
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET NVALID
        INT 21H
        
        MOV AH,01H              
        INT 21H
        
        JMP S4

PRNTO0: MOV AH,09H
        MOV DX,OFFSET SMDR0
        INT 21H               
        JMP NEXT3
        
PRNTO1: MOV AH,02H
        MOV DX,30H
        INT 21H
        MOV AH,09H
        MOV DX,OFFSET SMDR0
        INT 21H
        JMP NEXT3

PRNTO2: MOV AH,09H
        MOV DX,OFFSET SMDRK
        INT 21H
        JMP NEXT3
        
PRNTO3: MOV AH,09H
        MOV DX,OFFSET SMDRK
        INT 21H
        JMP NEXT3

PRNTO4: MOV AH,02H
        MOV DX,30H
        INT 21H

        MOV AH,09H
        MOV DX,OFFSET SMDRK
        INT 21H 
        JMP NEXT3

PRNTO5: MOV AH,09H
        MOV DX,OFFSET SMDRM
        INT 21H 
        JMP NEXT3
        
PRNTO6: MOV AH,09H
        MOV DX,OFFSET SMDRM
        INT 21H 
        JMP NEXT3       
               
PRNTO7: MOV AH,02H
        MOV DX,30H
        INT 21H
        MOV AH,09H
        MOV DX,OFFSET SMDRM
        INT 21H 
        JMP NEXT3

PRNTO8: MOV AH,09H
        MOV DX,OFFSET SMDRG
        INT 21H 
        JMP NEXT3
        
PRNTO9: MOV AH,09H
        MOV DX,OFFSET SMDRG
        INT 21H
        JMP NEXT3

PRNT10: MOV AH,09H
        MOV DX,OFFSET SMDR0
        INT 21H
        JMP NEXT3

PRNT11: MOV AH,09H
        MOV DX,OFFSET SMDRD
        INT 21H 
        JMP NEXT3
        
PRNT12: MOV AH,09H
        MOV DX,OFFSET SMDRD
        INT 21H  
NEXT3:  
        INC DI
                
        MOV BX,0000H
        MOV BX,[DI]
        
        CMP BL,4BH
        JZ PNT1
        CMP BL,52H
        JZ PNT2
        CMP BL,4FH
        JZ PNT3
        CMP BL,59H
        JZ PNT4
        CMP BL,47H
        JZ PNT5
        CMP BL,4DH
        JZ PNT6
        CMP BL,56H
        JZ PNT7
        CMP BL,54H
        JZ PNT8
        CMP BL,41H
        JZ PNT9
        CMP BL,53H
        JZ PNT10
        
        MOV AH,09H
        MOV DX,OFFSET NEWLINE
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET NVALID
        INT 21H
        
        MOV AH,01H              
        INT 21H
        
        JMP S4
        
PNT1:   MOV AH,02H
        MOV DL,20H
        INT 21H
        
        MOV AH,02H
        MOV DL,0F1H
        INT 21H
        
        MOV AH,02H
        MOV DL,31H
        INT 21H
        
        MOV AH,02H
        MOV DL,25H
        INT 21H
        
        JMP NEXT4

PNT2:   MOV AH,02H
        MOV DL,20H
        INT 21H
        
        MOV AH,02H
        MOV DL,0F1H
        INT 21H
        
        MOV AH,02H
        MOV DL,32H
        INT 21H
        
        MOV AH,02H
        MOV DL,25H
        INT 21H
        JMP NEXT4
        
PNT3:   MOV AH,02H
        MOV DL,20H
        INT 21H
        
        MOV AH,02H
        MOV DL,0F1H
        INT 21H
        
        MOV AH,02H
        MOV DL,30H
        INT 21H
        
        MOV AH,02H
        MOV DL,2EH
        INT 21H
        
        MOV AH,02H
        MOV DL,30H
        INT 21H
        
        MOV AH,02H
        MOV DL,35H
        INT 21H
        
        MOV AH,02H
        MOV DL,25H
        INT 21H
        
        JMP NEXT4

PNT4:   MOV AH,02H
        MOV DL,20H
        INT 21H
        
        MOV AH,02H
        MOV DL,0F1H
        INT 21H
        
        MOV AH,02H
        MOV DL,30H
        INT 21H
        
        MOV AH,02H
        MOV DL,2EH
        INT 21H
        
        MOV AH,02H
        MOV DL,30H
        INT 21H
        
        MOV AH,02H
        MOV DL,32H
        INT 21H
        
        MOV AH,02H
        MOV DL,25H
        INT 21H
         
        JMP NEXT4

PNT5:   MOV AH,02H
        MOV DL,20H
        INT 21H
        
        MOV AH,02H
        MOV DL,0F1H
        INT 21H
        
        MOV AH,02H
        MOV DL,30H
        INT 21H
        
        MOV AH,02H
        MOV DL,2EH
        INT 21H
        
        MOV AH,02H
        MOV DL,35H
        INT 21H
        
        MOV AH,02H
        MOV DL,25H
        INT 21H
          
        JMP NEXT4
        
PNT6:   MOV AH,02H
        MOV DL,20H
        INT 21H
        
        MOV AH,02H
        MOV DL,0F1H
        INT 21H
        
        MOV AH,02H
        MOV DL,30H
        INT 21H
        
        MOV AH,02H
        MOV DL,2EH
        INT 21H
        
        MOV AH,02H
        MOV DL,32H
        INT 21H
        
        MOV AH,02H
        MOV DL,35H
        INT 21H
        
        MOV AH,02H
        MOV DL,25H
        INT 21H 
        JMP NEXT4       
               
PNT7:   MOV AH,02H
        MOV DL,20H
        INT 21H
        
        MOV AH,02H
        MOV DL,0F1H
        INT 21H
        
        MOV AH,02H
        MOV DL,30H
        INT 21H
        
        MOV AH,02H
        MOV DL,2EH
        INT 21H
        
        MOV AH,02H
        MOV DL,31H
        INT 21H
        
        MOV AH,02H
        MOV DL,25H
        INT 21H 
        JMP NEXT4

PNT8:   MOV AH,02H
        MOV DL,20H
        INT 21H
        
        MOV AH,02H
        MOV DL,0F1H
        INT 21H
        
        MOV AH,02H
        MOV DL,30H
        INT 21H
        
        MOV AH,02H
        MOV DL,2EH
        INT 21H
        
        MOV AH,02H
        MOV DL,30H
        INT 21H
        
        MOV AH,02H
        MOV DL,31H
        INT 21H
        
        MOV AH,02H
        MOV DL,25H
        INT 21H 
        JMP NEXT4
        
PNT9:   MOV AH,02H
        MOV DL,20H
        INT 21H
        
        MOV AH,02H
        MOV DL,0F1H
        INT 21H
                
        MOV AH,02H
        MOV DL,35H
        INT 21H

        MOV AH,02H
        MOV DL,25H
        INT 21H
        JMP NEXT4
        
PNT10:  MOV AH,02H
        MOV DL,20H
        INT 21H
        
        MOV AH,02H
        MOV DL,0F1H
        INT 21H
        
        MOV AH,02H
        MOV DL,31H
        INT 21H
        
        MOV AH,02H
        MOV DL,30H
        INT 21H
        
        MOV AH,02H
        MOV DL,25H
        INT 21H

NEXT4:
                       
SHTDOWN:INT 20H

ENDP BAND4

DOTCHCK PROC
        INC DI
        
        MOV BX,0000H
        MOV BX,[DI]
        
        CMP BL,52H
        JZ DOT
        CMP BL,47H
        JZ DOT
        CMP BL,54H
        JZ DOT
        CMP BL,41H
        JZ DOT
        CMP BL,50H
        JZ DOT
        JMP CLS
        
DOT:    MOV AH,02H
        MOV DL,2EH
        INT 21H
CLS:    DEC DI
        RET        
    
ENDP DOTCHCK

BAND5 PROC
S5:     MOV AH,0
        MOV AL,03H
        INT 10H
        
        MOV AH,09H
        MOV DX,OFFSET COLORS5
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET NEWLINE
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET CINFO
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET NEWLINE
        INT 21H
        
        MOV AH,02H
        MOV DL,3AH
        INT 21H
        
        MOV CX,5H
        MOV DI,0000H
        
TAKERN: MOV AH,01H             
        INT 21H
        
        CMP AL,1BH
        JZ SHTDWN
                
        MOV AH,00H
        MOV [DI],AX
        INC DI
        
        LOOP TAKERN
        
        MOV AH,0
        MOV AL,03H
        INT 10H
        
        SUB DI,5H
        
        MOV AH,00               
        MOV AL,12H              
        INT 10H
        INT 10H
                       
        MOV BX,0000H
        MOV BX,[DI]
        
        CMP BL,4BH
        JZ RINT1
        CMP BL,52H
        JZ RINT2
        CMP BL,4FH
        JZ RINT3
        CMP BL,59H
        JZ RINT4
        CMP BL,47H
        JZ RINT5
        CMP BL,4DH
        JZ RINT6
        CMP BL,56H
        JZ RINT7
        CMP BL,54H
        JZ RINT8
        CMP BL,57H
        JZ RINT9
        
        MOV AH,09H
        MOV DX,OFFSET NEWLINE
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET NVALID
        INT 21H
        
        MOV AH,01H              
        INT 21H
        
        JMP S5

RINT1: MOV AH,02H
        MOV DX,31H
        INT 21H
        JMP EXT

RINT2: MOV AH,02H
        MOV DX,32H
        INT 21H
        JMP EXT
        
RINT3: MOV AH,02H
        MOV DX,33H
        INT 21H
        JMP EXT

RINT4: MOV AH,02H
        MOV DX,34H
        INT 21H 
        JMP EXT

RINT5: MOV AH,02H
        MOV DX,35H
        INT 21H 
        JMP EXT
        
RINT6: MOV AH,02H
        MOV DX,36H
        INT 21H 
        JMP EXT       
               
RINT7: MOV AH,02H
        MOV DX,37H
        INT 21H 
        JMP EXT

RINT8: MOV AH,02H
        MOV DX,38H
        INT 21H 
        JMP EXT
        
RINT9: MOV AH,02H
        MOV DX,39H
        INT 21H
        
EXT:                               
        INC DI
        
        MOV BX,0000H
        MOV BX,[DI]
        
        CMP BL,42H
        JZ RNT0
        CMP BL,4BH
        JZ RNT1
        CMP BL,52H
        JZ RNT2
        CMP BL,4FH
        JZ RNT3
        CMP BL,59H
        JZ RNT4
        CMP BL,47H
        JZ RNT5
        CMP BL,4DH
        JZ RNT6
        CMP BL,56H
        JZ RNT7
        CMP BL,54H
        JZ RNT8
        CMP BL,57H
        JZ RNT9
        
        MOV AH,09H
        MOV DX,OFFSET NEWLINE
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET NVALID
        INT 21H
        
        MOV AH,01H              
        INT 21H
        
        JMP S5

RNT0:   CALL DOTCHCK51
        MOV AH,02H
        MOV DX,30H
        INT 21H
        JMP EXT2
        
RNT1:   CALL DOTCHCK51
        MOV AH,02H
        MOV DX,31H
        INT 21H
        JMP EXT2

RNT2:   CALL DOTCHCK51
        MOV AH,02H
        MOV DX,32H
        INT 21H
        JMP EXT2
        
RNT3:   CALL DOTCHCK51
        MOV AH,02H
        MOV DX,33H
        INT 21H
        JMP EXT2

RNT4:   CALL DOTCHCK51
        MOV AH,02H
        MOV DX,34H
        INT 21H 
        JMP EXT2

RNT5:   CALL DOTCHCK51
        MOV AH,02H
        MOV DX,35H
        INT 21H 
        JMP EXT2
        
RNT6:   CALL DOTCHCK51
        MOV AH,02H
        MOV DX,36H
        INT 21H 
        JMP EXT2       
               
RNT7:   CALL DOTCHCK51
        MOV AH,02H
        MOV DX,37H
        INT 21H 
        JMP EXT2

RNT8:   CALL DOTCHCK51
        MOV AH,02H
        MOV DX,38H
        INT 21H 
        JMP EXT2
        
RNT9:   CALL DOTCHCK51
        MOV AH,02H
        MOV DX,39H
        INT 21H

EXT2:  

        INC DI
        
        MOV BX,0000H
        MOV BX,[DI]
        
        CMP BL,42H
        JZ PRINTQ1
        CMP BL,4BH
        JZ PRINTQ1
        CMP BL,52H
        JZ PRINTQ2
        CMP BL,4FH
        JZ PRINTQ3
        CMP BL,59H
        JZ PRINTQ4
        CMP BL,47H
        JZ PRINTQ5
        CMP BL,4DH
        JZ PRINTQ6
        CMP BL,56H
        JZ PRINTQ7
        CMP BL,54H
        JZ PRINTQ8
        CMP BL,57H
        JZ PRINTQ9
        
        MOV AH,09H
        MOV DX,OFFSET NEWLINE
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET NVALID
        INT 21H
        
        MOV AH,01H             
        INT 21H
        
        JMP S5
PRINTQ0:CALL DOTCHCK52
        MOV AH,02H
        MOV DX,30H
        INT 21H
        JMP NEXTQ
        
PRINTQ1:CALL DOTCHCK52
        MOV AH,02H
        MOV DX,31H
        INT 21H
        JMP NEXTQ

PRINTQ2:CALL DOTCHCK52
        MOV AH,02H
        MOV DX,32H
        INT 21H
        JMP NEXTQ
        
PRINTQ3:CALL DOTCHCK52
        MOV AH,02H
        MOV DX,33H
        INT 21H
        JMP NEXTQ

PRINTQ4:CALL DOTCHCK52
        MOV AH,02H
        MOV DX,34H
        INT 21H 
        JMP NEXTQ

PRINTQ5:CALL DOTCHCK52
        MOV AH,02H
        MOV DX,35H
        INT 21H 
        JMP NEXTQ
        
PRINTQ6:CALL DOTCHCK52
        MOV AH,02H
        MOV DX,36H
        INT 21H 
        JMP NEXTQ       
               
PRINTQ7:CALL DOTCHCK52
        MOV AH,02H
        MOV DX,37H
        INT 21H 
        JMP NEXTQ

PRINTQ8:CALL DOTCHCK52
        MOV AH,02H
        MOV DX,38H
        INT 21H 
        JMP NEXTQ
        
PRINTQ9:CALL DOTCHCK52
        MOV AH,02H
        MOV DX,39H
        INT 21H
NEXTQ:
        INC DI
        
        MOV BX,0000H
        MOV BX,[DI]
        
        CMP BL,42H
        JZ RNTO0
        CMP BL,4BH
        JZ RNTO1
        CMP BL,52H
        JZ RNTO2
        CMP BL,4FH
        JZ RNTO3
        CMP BL,59H
        JZ RNTO4
        CMP BL,47H
        JZ RNTO5
        CMP BL,4DH
        JZ RNTO6
        CMP BL,56H
        JZ RNTO7
        CMP BL,54H
        JZ RNTO8
        CMP BL,57H
        JZ RNTO9
        CMP BL,41H
        JZ RNT10
        CMP BL,53H
        JZ RNT11
        CMP BL,50H
        JZ RNT12
        
        MOV AH,09H
        MOV DX,OFFSET NEWLINE
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET NVALID
        INT 21H
        
        MOV AH,01H              
        INT 21H
        
        JMP S5

RNTO0: MOV AH,09H
        MOV DX,OFFSET SMDR0
        INT 21H               
        JMP EXT3
        
RNTO1: MOV AH,09H
        MOV DX,OFFSET SMDRK
        INT 21H
        JMP EXT3

RNTO2: MOV AH,09H
        MOV DX,OFFSET SMDRK
        INT 21H
        JMP EXT3
        
RNTO3: MOV AH,09H
        MOV DX,OFFSET SMDRK
        INT 21H
        JMP EXT3

RNTO4: MOV AH,09H
        MOV DX,OFFSET SMDRM
        INT 21H 
        JMP EXT3

RNTO5: MOV AH,09H
        MOV DX,OFFSET SMDRM
        INT 21H 
        JMP EXT3
        
RNTO6: MOV AH,09H
        MOV DX,OFFSET SMDRM
        INT 21H 
        JMP EXT3       
               
RNTO7: MOV AH,09H
        MOV DX,OFFSET SMDRG
        INT 21H 
        JMP EXT3

RNTO8: MOV AH,09H
        MOV DX,OFFSET SMDRG
        INT 21H 
        JMP EXT3
        
RNTO9: MOV AH,09H
        MOV DX,OFFSET SMDRG
        INT 21H
        JMP EXT3

RNT10: MOV AH,09H
        MOV DX,OFFSET SMDR0
        INT 21H
        JMP EXT3

RNT11: MOV AH,09H
        MOV DX,OFFSET SMDRD
        INT 21H 
        JMP EXT3
        
RNT12: MOV AH,09H
        MOV DX,OFFSET SMDRD
        INT 21H  
EXT3:  
        INC DI
                
        MOV BX,0000H
        MOV BX,[DI]
        
        CMP BL,4BH
        JZ NT1
        CMP BL,52H
        JZ NT2
        CMP BL,4FH
        JZ NT3
        CMP BL,59H
        JZ NT4
        CMP BL,47H
        JZ NT5
        CMP BL,4DH
        JZ NT6
        CMP BL,56H
        JZ NT7
        CMP BL,54H
        JZ NT8
        CMP BL,41H
        JZ NT9
        CMP BL,53H
        JZ NT10
        
        MOV AH,09H
        MOV DX,OFFSET NEWLINE
        INT 21H
        
        MOV AH,09H
        MOV DX,OFFSET NVALID
        INT 21H
        
        MOV AH,01H              
        INT 21H
        
        JMP S5
        
NT1:   MOV AH,02H
        MOV DL,20H
        INT 21H
        
        MOV AH,02H
        MOV DL,0F1H
        INT 21H
        
        MOV AH,02H
        MOV DL,31H
        INT 21H
        
        MOV AH,02H
        MOV DL,25H
        INT 21H
        
        JMP EXT4

NT2:   MOV AH,02H
        MOV DL,20H
        INT 21H
        
        MOV AH,02H
        MOV DL,0F1H
        INT 21H
        
        MOV AH,02H
        MOV DL,32H
        INT 21H
        
        MOV AH,02H
        MOV DL,25H
        INT 21H
        JMP EXT4
        
NT3:   MOV AH,02H
        MOV DL,20H
        INT 21H
        
        MOV AH,02H
        MOV DL,0F1H
        INT 21H
        
        MOV AH,02H
        MOV DL,30H
        INT 21H
        
        MOV AH,02H
        MOV DL,2EH
        INT 21H
        
        MOV AH,02H
        MOV DL,30H
        INT 21H
        
        MOV AH,02H
        MOV DL,35H
        INT 21H
        
        MOV AH,02H
        MOV DL,25H
        INT 21H
        
        JMP EXT4

NT4:   MOV AH,02H
        MOV DL,20H
        INT 21H
        
        MOV AH,02H
        MOV DL,0F1H
        INT 21H
        
        MOV AH,02H
        MOV DL,30H
        INT 21H
        
        MOV AH,02H
        MOV DL,2EH
        INT 21H
        
        MOV AH,02H
        MOV DL,30H
        INT 21H
        
        MOV AH,02H
        MOV DL,32H
        INT 21H
        
        MOV AH,02H
        MOV DL,25H
        INT 21H
         
        JMP EXT4

NT5:   MOV AH,02H
        MOV DL,20H
        INT 21H
        
        MOV AH,02H
        MOV DL,0F1H
        INT 21H
        
        MOV AH,02H
        MOV DL,30H
        INT 21H
        
        MOV AH,02H
        MOV DL,2EH
        INT 21H
        
        MOV AH,02H
        MOV DL,35H
        INT 21H
        
        MOV AH,02H
        MOV DL,25H
        INT 21H
          
        JMP EXT4
        
NT6:   MOV AH,02H
        MOV DL,20H
        INT 21H
        
        MOV AH,02H
        MOV DL,0F1H
        INT 21H
        
        MOV AH,02H
        MOV DL,30H
        INT 21H
        
        MOV AH,02H
        MOV DL,2EH
        INT 21H
        
        MOV AH,02H
        MOV DL,32H
        INT 21H
        
        MOV AH,02H
        MOV DL,35H
        INT 21H
        
        MOV AH,02H
        MOV DL,25H
        INT 21H 
        JMP EXT4       
               
NT7:   MOV AH,02H
        MOV DL,20H
        INT 21H
        
        MOV AH,02H
        MOV DL,0F1H
        INT 21H
        
        MOV AH,02H
        MOV DL,30H
        INT 21H
        
        MOV AH,02H
        MOV DL,2EH
        INT 21H
        
        MOV AH,02H
        MOV DL,31H
        INT 21H
        
        MOV AH,02H
        MOV DL,25H
        INT 21H 
        JMP EXT4

NT8:   MOV AH,02H
        MOV DL,20H
        INT 21H
        
        MOV AH,02H
        MOV DL,0F1H
        INT 21H
        
        MOV AH,02H
        MOV DL,30H
        INT 21H
        
        MOV AH,02H
        MOV DL,2EH
        INT 21H
        
        MOV AH,02H
        MOV DL,30H
        INT 21H
        
        MOV AH,02H
        MOV DL,31H
        INT 21H
        
        MOV AH,02H
        MOV DL,25H
        INT 21H 
        JMP EXT4
        
NT9:   MOV AH,02H
        MOV DL,20H
        INT 21H
        
        MOV AH,02H
        MOV DL,0F1H
        INT 21H
                
        MOV AH,02H
        MOV DL,35H
        INT 21H

        MOV AH,02H
        MOV DL,25H
        INT 21H
        JMP EXT4
        
NT10:  MOV AH,02H
        MOV DL,20H
        INT 21H
        
        MOV AH,02H
        MOV DL,0F1H
        INT 21H
        
        MOV AH,02H
        MOV DL,31H
        INT 21H
        
        MOV AH,02H
        MOV DL,30H
        INT 21H
        
        MOV AH,02H
        MOV DL,25H
        INT 21H

EXT4:
                       
SHTDWN: INT 20H

ENDP BAND5

DOTCHCK51 PROC
        INC DI
        INC DI
        
        MOV BX,0000H
        MOV BX,[DI]
        
        CMP BL,4BH
        JZ DOT51
        CMP BL,59H
        JZ DOT51
        CMP BL,56H
        JZ DOT51
        JMP CLS51
        
DOT51:  MOV AH,02H
        MOV DL,2EH
        INT 21H
CLS51:  DEC DI
        DEC DI
        RET        
    
ENDP DOTCHCK51

DOTCHCK52 PROC
        INC DI
        
        MOV BX,0000H
        MOV BX,[DI]
        
        CMP BL,52H
        JZ DOT52
        CMP BL,47H
        JZ DOT52
        CMP BL,54H
        JZ DOT52
        CMP BL,53H
        JZ DOT52
        CMP BL,41H
        JZ DOT52
        JMP CLS52
        
DOT52:  MOV AH,02H
        MOV DL,2EH
        INT 21H
CLS52:  DEC DI
        RET        
    
ENDP DOTCHCK52