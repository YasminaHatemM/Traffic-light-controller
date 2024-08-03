
_CountDown:

;Traffic_Light_Controller.c,15 :: 		void CountDown(char num){
;Traffic_Light_Controller.c,16 :: 		for (i = num; i > 3 ; i--){
	MOVF       FARG_CountDown_num+0, 0
	MOVWF      _i+0
L_CountDown0:
	MOVF       _i+0, 0
	SUBLW      3
	BTFSC      STATUS+0, 0
	GOTO       L_CountDown1
;Traffic_Light_Controller.c,18 :: 		PORTC = i / 10 ;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _i+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;Traffic_Light_Controller.c,20 :: 		PORTC |= ((i % 10)<<4) ;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _i+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	MOVF       R1+0, 0
	IORWF      PORTC+0, 1
;Traffic_Light_Controller.c,21 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_CountDown3:
	DECFSZ     R13+0, 1
	GOTO       L_CountDown3
	DECFSZ     R12+0, 1
	GOTO       L_CountDown3
	DECFSZ     R11+0, 1
	GOTO       L_CountDown3
	NOP
	NOP
;Traffic_Light_Controller.c,16 :: 		for (i = num; i > 3 ; i--){
	DECF       _i+0, 1
;Traffic_Light_Controller.c,22 :: 		}
	GOTO       L_CountDown0
L_CountDown1:
;Traffic_Light_Controller.c,23 :: 		if (num==3){
	MOVF       FARG_CountDown_num+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_CountDown4
;Traffic_Light_Controller.c,24 :: 		for (i = num; i > 0 ; i--){
	MOVF       FARG_CountDown_num+0, 0
	MOVWF      _i+0
L_CountDown5:
	MOVF       _i+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_CountDown6
;Traffic_Light_Controller.c,25 :: 		PORTC = 0 | ((i % 10)<<4) ;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _i+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	MOVF       R1+0, 0
	MOVWF      PORTC+0
;Traffic_Light_Controller.c,26 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_CountDown8:
	DECFSZ     R13+0, 1
	GOTO       L_CountDown8
	DECFSZ     R12+0, 1
	GOTO       L_CountDown8
	DECFSZ     R11+0, 1
	GOTO       L_CountDown8
	NOP
	NOP
;Traffic_Light_Controller.c,24 :: 		for (i = num; i > 0 ; i--){
	DECF       _i+0, 1
;Traffic_Light_Controller.c,27 :: 		}
	GOTO       L_CountDown5
L_CountDown6:
;Traffic_Light_Controller.c,28 :: 		PORTC = 0X00 ;
	CLRF       PORTC+0
;Traffic_Light_Controller.c,29 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_CountDown9:
	DECFSZ     R13+0, 1
	GOTO       L_CountDown9
	DECFSZ     R12+0, 1
	GOTO       L_CountDown9
	DECFSZ     R11+0, 1
	GOTO       L_CountDown9
	NOP
	NOP
;Traffic_Light_Controller.c,30 :: 		}
L_CountDown4:
;Traffic_Light_Controller.c,31 :: 		}
L_end_CountDown:
	RETURN
; end of _CountDown

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Traffic_Light_Controller.c,32 :: 		void interrupt(){
;Traffic_Light_Controller.c,33 :: 		if(INTF_bit){
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt10
;Traffic_Light_Controller.c,34 :: 		PORTC = 0X00;
	CLRF       PORTC+0
;Traffic_Light_Controller.c,35 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_interrupt11:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt11
	DECFSZ     R12+0, 1
	GOTO       L_interrupt11
	DECFSZ     R11+0, 1
	GOTO       L_interrupt11
	NOP
;Traffic_Light_Controller.c,36 :: 		if (!switching_button){
	BTFSC      PORTB+0, 1
	GOTO       L_interrupt12
;Traffic_Light_Controller.c,37 :: 		if(RED_W) {
	BTFSS      PORTD+0, 0
	GOTO       L_interrupt13
;Traffic_Light_Controller.c,38 :: 		GREEN_W=1; YELLOW_S=1 ; RED_S=0;
	BSF        PORTD+0, 2
	BSF        PORTD+0, 4
	BCF        PORTD+0, 3
;Traffic_Light_Controller.c,39 :: 		GREEN_S=0; RED_W=0; YELLOW_W=0;
	BCF        PORTD+0, 5
	BCF        PORTD+0, 0
	BCF        PORTD+0, 1
;Traffic_Light_Controller.c,40 :: 		for (count = 3; count > 0 ; count--){
	MOVLW      3
	MOVWF      _count+0
L_interrupt14:
	MOVF       _count+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt15
;Traffic_Light_Controller.c,41 :: 		PORTC = 0 | ((count % 10)<<4) ;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _count+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	MOVF       R1+0, 0
	MOVWF      PORTC+0
;Traffic_Light_Controller.c,42 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_interrupt17:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt17
	DECFSZ     R12+0, 1
	GOTO       L_interrupt17
	DECFSZ     R11+0, 1
	GOTO       L_interrupt17
	NOP
	NOP
;Traffic_Light_Controller.c,40 :: 		for (count = 3; count > 0 ; count--){
	DECF       _count+0, 1
;Traffic_Light_Controller.c,43 :: 		}
	GOTO       L_interrupt14
L_interrupt15:
;Traffic_Light_Controller.c,44 :: 		RED_S=1;
	BSF        PORTD+0, 3
;Traffic_Light_Controller.c,45 :: 		YELLOW_S=0;
	BCF        PORTD+0, 4
;Traffic_Light_Controller.c,46 :: 		}
	GOTO       L_interrupt18
L_interrupt13:
;Traffic_Light_Controller.c,47 :: 		else if(RED_S){
	BTFSS      PORTD+0, 3
	GOTO       L_interrupt19
;Traffic_Light_Controller.c,48 :: 		GREEN_S=1; YELLOW_W=1;RED_W = 0;
	BSF        PORTD+0, 5
	BSF        PORTD+0, 1
	BCF        PORTD+0, 0
;Traffic_Light_Controller.c,49 :: 		RED_S=0; YELLOW_S=0; GREEN_W=0;
	BCF        PORTD+0, 3
	BCF        PORTD+0, 4
	BCF        PORTD+0, 2
;Traffic_Light_Controller.c,50 :: 		for (count = 3; count > 0 ; count--){
	MOVLW      3
	MOVWF      _count+0
L_interrupt20:
	MOVF       _count+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt21
;Traffic_Light_Controller.c,51 :: 		PORTC = 0 | ((count % 10)<<4) ;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _count+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	MOVF       R1+0, 0
	MOVWF      PORTC+0
;Traffic_Light_Controller.c,52 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_interrupt23:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt23
	DECFSZ     R12+0, 1
	GOTO       L_interrupt23
	DECFSZ     R11+0, 1
	GOTO       L_interrupt23
	NOP
	NOP
;Traffic_Light_Controller.c,50 :: 		for (count = 3; count > 0 ; count--){
	DECF       _count+0, 1
;Traffic_Light_Controller.c,53 :: 		}
	GOTO       L_interrupt20
L_interrupt21:
;Traffic_Light_Controller.c,54 :: 		RED_W=1;
	BSF        PORTD+0, 0
;Traffic_Light_Controller.c,55 :: 		YELLOW_W=0;
	BCF        PORTD+0, 1
;Traffic_Light_Controller.c,56 :: 		}
L_interrupt19:
L_interrupt18:
;Traffic_Light_Controller.c,57 :: 		PORTC = 0X00 ;
	CLRF       PORTC+0
;Traffic_Light_Controller.c,58 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_interrupt24:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt24
	DECFSZ     R12+0, 1
	GOTO       L_interrupt24
	DECFSZ     R11+0, 1
	GOTO       L_interrupt24
	NOP
;Traffic_Light_Controller.c,59 :: 		while(!switching_button);
L_interrupt25:
	BTFSC      PORTB+0, 1
	GOTO       L_interrupt26
	GOTO       L_interrupt25
L_interrupt26:
;Traffic_Light_Controller.c,60 :: 		}
L_interrupt12:
;Traffic_Light_Controller.c,61 :: 		if(manual_button)INTF_bit = 0;
	BTFSS      PORTB+0, 0
	GOTO       L_interrupt27
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
L_interrupt27:
;Traffic_Light_Controller.c,62 :: 		}
L_interrupt10:
;Traffic_Light_Controller.c,63 :: 		}
L_end_interrupt:
L__interrupt33:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Traffic_Light_Controller.c,65 :: 		void main() {
;Traffic_Light_Controller.c,67 :: 		TRISB.B1 = 1 ;
	BSF        TRISB+0, 1
;Traffic_Light_Controller.c,68 :: 		TRISB.B0= 1 ;
	BSF        TRISB+0, 0
;Traffic_Light_Controller.c,69 :: 		INTE_bit =1;
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
;Traffic_Light_Controller.c,70 :: 		GIE_bit =1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;Traffic_Light_Controller.c,71 :: 		INTEDG_bit = 0;
	BCF        INTEDG_bit+0, BitPos(INTEDG_bit+0)
;Traffic_Light_Controller.c,72 :: 		NOT_RBPU_bit =0;
	BCF        NOT_RBPU_bit+0, BitPos(NOT_RBPU_bit+0)
;Traffic_Light_Controller.c,75 :: 		TRISB.B4 = 0;
	BCF        TRISB+0, 4
;Traffic_Light_Controller.c,76 :: 		TRISB.B5 = 0;
	BCF        TRISB+0, 5
;Traffic_Light_Controller.c,77 :: 		TRISB.B6 = 0;
	BCF        TRISB+0, 6
;Traffic_Light_Controller.c,78 :: 		TRISB.B7 = 0;
	BCF        TRISB+0, 7
;Traffic_Light_Controller.c,79 :: 		SW1 = 1;
	BSF        PORTB+0, 4
;Traffic_Light_Controller.c,80 :: 		SW2 = 1;
	BSF        PORTB+0, 5
;Traffic_Light_Controller.c,81 :: 		SW3 = 1;
	BSF        PORTB+0, 6
;Traffic_Light_Controller.c,82 :: 		SW4 = 1;
	BSF        PORTB+0, 7
;Traffic_Light_Controller.c,85 :: 		TRISC = 0x00;
	CLRF       TRISC+0
;Traffic_Light_Controller.c,86 :: 		PORTC = 0X00;
	CLRF       PORTC+0
;Traffic_Light_Controller.c,89 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;Traffic_Light_Controller.c,90 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;Traffic_Light_Controller.c,92 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main28:
	DECFSZ     R13+0, 1
	GOTO       L_main28
	DECFSZ     R12+0, 1
	GOTO       L_main28
	DECFSZ     R11+0, 1
	GOTO       L_main28
	NOP
	NOP
;Traffic_Light_Controller.c,94 :: 		while(1){
L_main29:
;Traffic_Light_Controller.c,95 :: 		GREEN_S = 1; RED_W = 1;
	BSF        PORTD+0, 5
	BSF        PORTD+0, 0
;Traffic_Light_Controller.c,96 :: 		YELLOW_S = 0; RED_S = 0; GREEN_W = 0; YELLOW_W = 0;
	BCF        PORTD+0, 4
	BCF        PORTD+0, 3
	BCF        PORTD+0, 2
	BCF        PORTD+0, 1
;Traffic_Light_Controller.c,97 :: 		CountDown(15);
	MOVLW      15
	MOVWF      FARG_CountDown_num+0
	CALL       _CountDown+0
;Traffic_Light_Controller.c,98 :: 		YELLOW_S = 1;RED_W = 1;YELLOW_W = 0;
	BSF        PORTD+0, 4
	BSF        PORTD+0, 0
	BCF        PORTD+0, 1
;Traffic_Light_Controller.c,99 :: 		GREEN_S=0; RED_S =0; GREEN_W = 0;
	BCF        PORTD+0, 5
	BCF        PORTD+0, 3
	BCF        PORTD+0, 2
;Traffic_Light_Controller.c,100 :: 		CountDown(3);
	MOVLW      3
	MOVWF      FARG_CountDown_num+0
	CALL       _CountDown+0
;Traffic_Light_Controller.c,101 :: 		RED_S = 1; GREEN_W = 1; YELLOW_W =0 ;
	BSF        PORTD+0, 3
	BSF        PORTD+0, 2
	BCF        PORTD+0, 1
;Traffic_Light_Controller.c,102 :: 		RED_W = 0; YELLOW_S = 0;GREEN_S=0;
	BCF        PORTD+0, 0
	BCF        PORTD+0, 4
	BCF        PORTD+0, 5
;Traffic_Light_Controller.c,103 :: 		CountDown(23);
	MOVLW      23
	MOVWF      FARG_CountDown_num+0
	CALL       _CountDown+0
;Traffic_Light_Controller.c,104 :: 		YELLOW_W = 1; YELLOW_S = 0;GREEN_S=0;
	BSF        PORTD+0, 1
	BCF        PORTD+0, 4
	BCF        PORTD+0, 5
;Traffic_Light_Controller.c,105 :: 		GREEN_W = 0;RED_W = 0; RED_S =1;
	BCF        PORTD+0, 2
	BCF        PORTD+0, 0
	BSF        PORTD+0, 3
;Traffic_Light_Controller.c,106 :: 		CountDown(3);
	MOVLW      3
	MOVWF      FARG_CountDown_num+0
	CALL       _CountDown+0
;Traffic_Light_Controller.c,107 :: 		}
	GOTO       L_main29
;Traffic_Light_Controller.c,108 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
