				#include<p18F4550.inc>

LOOP_CNT		SET	0x00
LOOP_CNT1		SET	0x01

				org	0x00
				goto start
				org	0x08
				retfie
				org	0x18
				retfie
			
dup_nop			macro hh
				variable	i
i	=	0
				while	i	<	hh
				nop
i	+=	1
				endw
				endm

;==============================================================
;SUBROUTINE FOR name
;==============================================================
DISPLYHAZIRAH	CALL 	DISPLAY
				MOVLW	D'72'  ;DISPLAY H
				MOVWF	PORTD,A
				CALL	DSPLYDATA
				MOVLW	D'65'  ;DISPLAY A
				MOVWF	PORTD,A
				CALL	DSPLYDATA
				MOVLW	D'90'   ;DISPLAY Z
				MOVWF	PORTD,A
				CALL	DSPLYDATA
				MOVLW	D'73'   ;DISPLAY I
				MOVWF	PORTD,A
				CALL	DSPLYDATA
				MOVLW	D'82'  ;DISPLAY R
				MOVWF	PORTD,A
				CALL	DSPLYDATA
				MOVLW	D'65'  ;DISPLAY A
				MOVWF	PORTD,A
				CALL	DSPLYDATA
				MOVLW	D'72'  ;DISPLAY H
				MOVWF	PORTD,A
				CALL	DSPLYDATA
				RETURN

;==============================================================
;SUBROUTINE FOR DISPLAY ID
;==============================================================	
DISPLYID		CALL	DISPLAY
				MOVLW	D'68'  ;DISPLAY D
				MOVWF	PORTD,A

				CALL	DSPLYDATA
				MOVLW	D'69'  ;DISPLAY E
				MOVWF	PORTD,A

				CALL	DSPLYDATA
				MOVLW	D'57'  ;DISPLAY 9
				MOVWF	PORTD,A

				CALL	DSPLYDATA
				MOVLW	D'54'  ;DISPLAY 6
				MOVWF	PORTD,A

				CALL	DSPLYDATA
				MOVLW	D'53'  ;DISPLAY 5
				MOVWF	PORTD,A

				CALL	DSPLYDATA
				MOVLW	D'54'  ;DISPLAY 6
				MOVWF	PORTD,A

				CALL	DSPLYDATA
				MOVLW	D'48'  ;DISPLAY 0
				MOVWF	PORTD,A
				CALL	DSPLYDATA
				RETURN	
;==============================================================
;SUBROUTINE FOR SET CMMAND
;==============================================================	
WRITECMD		MOVLW	0x38 				 	;CONFIGURE 2 LINES AND 5x7 MATRIX
				MOVWF	PORTD
				CALL	SETCMD
				MOVLW	0x0E					;TURN ON DISPLAY WITH CURSOR
				MOVWF	PORTD
				CALL	SETCMD
DISPLAY			MOVLW	0x01 					 ;CLEAR SCREEN/DISPLAY
				MOVWF	PORTD
				CALL	SETCMD
				RETURN
	
;==============================================================
;SUBROUTINE FOR 1 SEC DELAY
;==============================================================
DELAYSEC		MOVLW	D'250'
				MOVWF	LOOP_CNT1,A
AGAIN			MOVLW	D'200'      ;20MHz
				MOVWF	LOOP_CNT,A
AGAIN1			dup_nop	D'97'
				DECFSZ	LOOP_CNT,F,A
				BRA	AGAIN1
				DECFSZ	LOOP_CNT1,F,A
				BRA AGAIN
				RETURN
;==============================================================
;SUBROUTINE FOR KEYPAD
;==============================================================
DISPKEY			CALL	INPUTKEY
				

ZERO			CALL	CONFD
				BTFSS	PORTB,1,A
				BRA		ONE
				CALL	SHOW0	

ONE				CALL	CONFA
				BTFSS	PORTB,0,A
				BRA		TWO
				CALL	SHOW1

TWO				CALL	CONFA
				BTFSS	PORTB,1,A
				BRA		THREE
				CALL	SHOW2

THREE			CALL	CONFA
				BTFSS	PORTB,2,A
				BRA		FOUR
				CALL	SHOW3
				
FOUR			CALL	CONFB
				BTFSS	PORTB,0,A
				BRA		FIVE
				CALL	SHOW4
	
FIVE			CALL	CONFB
				BTFSS	PORTB,1,A
				BRA		SIX
				CALL	SHOW5
	
SIX				CALL	CONFB
				BTFSS	PORTB,2,A
				BRA		SEVEN
				CALL	SHOW6
	
SEVEN			CALL	CONFC
				BTFSS	PORTB,0,A
				BRA		EIGHT
				CALL	SHOW7
	
EIGHT			CALL	CONFC
				BTFSS	PORTB,1,A
				BRA		NINE
				CALL	SHOW8
	
NINE			CALL	CONFC
				BTFSS	PORTB,2,A
				BRA		STAR
				CALL	SHOW9
	
STAR			CALL	CONFD
				BTFSS	PORTB,0,A
				BRA		TAG
				CALL	SHOWSTAR

TAG				CALL	CONFD
				BTFSS	PORTB,2,A
				BRA		ZERO
				CALL	SHOWTAG
				RETURN
	
;==============================================================
;SUBROUTINE FOR CONFIGURATION KEYPAD
;==============================================================
CONFA			BSF	PORTB,3,A
				BCF	PORTB,4,A
				BCF	PORTB,5,A
				BCF	PORTB,6,A
				RETURN

CONFB			BCF	PORTB,3,A
				BSF	PORTB,4,A
				BCF	PORTB,5,A
				BCF	PORTB,6,A
				RETURN

CONFC			BCF	PORTB,3,A
				BCF	PORTB,4,A
				BSF	PORTB,5,A
				BCF	PORTB,6,A
				RETURN

CONFD			BCF	PORTB,3,A
				BCF	PORTB,4,A
				BCF	PORTB,5,A
				BSF	PORTB,6,A
				RETURN

;==============================================================
;SUBROUTINE FOR LCD CONFIGURATION (SECOND LINE)
;==============================================================
SECONDLINE		MOVLW	0xC0
				MOVWF	PORTD,A
				CALL 	SETCMD
				RETURN
;==============================================================
;SUBROUTINE NUMBER FROM 0-#
;==============================================================
SHOW0			CALL	DISPLAY
				CALL	SECONDLINE
				MOVLW	D'48'
				MOVWF	PORTD,A
				CALL	DSPLYDATA
				RETURN

SHOW1			CALL	DISPLAY
				CALL	SECONDLINE
				MOVLW	D'49'
				MOVWF	PORTD,A
				CALL	DSPLYDATA
				RETURN

SHOW2			CALL	DISPLAY	
				CALL	SECONDLINE	
				MOVLW	D'50'
				MOVWF	PORTD,A
				CALL	DSPLYDATA
				RETURN

SHOW3			CALL	DISPLAY
				CALL	SECONDLINE
				MOVLW	D'51'
				MOVWF	PORTD,A
				CALL	DSPLYDATA
				RETURN

SHOW4			CALL	DISPLAY
				MOVLW	D'52'
				MOVWF	PORTD,A
				CALL	DSPLYDATA
				RETURN

SHOW5			CALL	DISPLAY
				CALL	SECONDLINE
				MOVLW	D'53'
				MOVWF	PORTD,A
				CALL	DSPLYDATA
				RETURN

SHOW6			CALL	DISPLAY
				CALL	SECONDLINE
				MOVLW	D'54'
				MOVWF	PORTD,A
				CALL	DSPLYDATA
				RETURN

SHOW7			CALL	DISPLAY	
				CALL	SECONDLINE	
				MOVLW	D'55'
				MOVWF	PORTD,A
				CALL	DSPLYDATA
				RETURN

SHOW8			CALL	DISPLAY
				CALL	SECONDLINE
				MOVLW	D'56'
				MOVWF	PORTD,A
				CALL	DSPLYDATA
				RETURN

SHOW9			CALL	DISPLAY
				CALL	SECONDLINE
				MOVLW	D'57'
				MOVWF	PORTD,A
				CALL	DSPLYDATA
				RETURN

SHOWSTAR		CALL	DISPLAY
				CALL	SECONDLINE
				MOVLW	D'42'
				MOVWF	PORTD,A
				CALL	DSPLYDATA
				RETURN

SHOWTAG			CALL	DISPLAY	
				CALL	SECONDLINE	
				MOVLW	D'35'
				MOVWF	PORTD,A
				CALL	DSPLYDATA
				RETURN


;==============================================================
;SUBROUTINE FOR KEYPAD INPUT
;==============================================================
INPUTKEY		MOVLW	B'00001110'
				MOVWF	TRISB,A
				RETURN
;==============================================================
;SUBROUTINE FOR LCD DATA (SEND DATA)	
;==============================================================
DSPLYDATA		BSF	PORTC,4,A	;RS=1
				BCF	PORTC,5,A	;RW=0
				BSF	PORTC,6,A	;E=1
				CALL	DELAYSEC
				BCF	PORTC,6,A
				RETURN
				
;==============================================================
;SUBROUTINE FOR LCD COMMAND
;==============================================================
SETCMD			BCF	PORTC,4,A	;RS=0
				BCF	PORTC,5,A	;RW=0
				BSF	PORTC,6,A	;E=1
				CALL	DELAYSEC
				BCF	PORTC,6,A
				RETURN

;==============================================================
;main program
;==============================================================
start			MOVLW	B'00001110'
				MOVWF	TRISC,A
				CLRF	TRISD,A
				CLRF	TRISB,A
				CLRF	TRISB,A
				CALL	WRITECMD
				
			
CHECK			BTFSS	PORTC,1,A  
				BRA		CHECK1			
				CALL	DISPLYHAZIRAH			
CHECK1			BTFSS	PORTC,0,A 
 				BRA		CHECK
				CALL	DISPLYID	
CHECK2			CALL	DISPKEY
				BRA		CHECK

				
				END