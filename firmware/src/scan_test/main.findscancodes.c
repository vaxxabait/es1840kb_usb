//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//
// (C) COPYRIGHT 2013 Michael Tulupov (vaxxabait@gmail.com)

// File:            main.c
// Author:          Michael Tulupov

// Description:     Trivial implementation of keyboard scanning procedure
// Language:        C

// Repository:      https://github.com/vaxxabait/.../

// Dependencies:

// Parameters:

// Constraints:

// Keywords:

// Notes:

/*
	Functional pins of DIL-40 package:

		Column choice (one of 16 columns):
			Pin 12,13,14,15 - column code (output)
			Pin 21 - enable column code above (output)

		Row choice (one of 6 rows):
			Pin 16,17,18 - row code (output)

		Key is pressed:
			Pin 39 - selected key is pressed (input)

		LEDs:
			Pin 5 - enable LEDs (output)
			Pin 32 - "Russian" (output)
			Pin 33 - "Latin" (output)
			Pin 34 - "Numbers" (output)

		Power:
			Pin 20 - GND
			Pin 40 - VCC

	Launchpad pins:
		Column choice (one of 16 columns):
			P2.[0..3] - column code (output)
			P2.4 - enable column code above (output)

		Row choice (one of 6 rows):
			P1.[4..6] - row code (output) - only 0..5 is used

		Key is pressed:
			P1.3 - selected key is pressed (input)

		LEDs:
			P2.5 - enable LEDs (output)
			P1.0 - turn on all 3 LEDs

TODO add MOSFET to control keyboard VCC (disconnect keyboard ICs and LEDs from power supply

*/

// TODO:

//--------------------------------------------------------------------------------------------//



////////////////////////////////////////////////////////////////////////////
// References

// Select specific MCU
#ifndef __MSP430G2553__
#define __MSP430G2553__
#endif

// MCU family library
#include <msp430.h>

// Printf
#include <stdio.h>



////////////////////////////////////////////////////////////////////////////
// Putchar - for printf

int putchar(int c){
	while ((UCA0STAT & UCBUSY)); // Wait if line TX/RX module is busy with data
	//while (!(UC0IFG & UCA0TXIFG));
	UCA0TXBUF = c;
	return c;
}


////////////////////////////////////////////////////////////////////////////
// Main

int main(void){

	////////////////////////////////////////////////////////////////////////////
	// Configure MCU

	// Halt watchdog
	WDTCTL = WDTPW + WDTHOLD;

	BCSCTL1 = CALBC1_1MHZ;            // Set DCO to 1 MHz
	DCOCTL = CALDCO_1MHZ;

	//Set ACLK to use internal VLO (12 kHz clock)
        BCSCTL3 |= LFXT1S_2;

	P1SEL = BIT1 + BIT2;                // Select TX and RX functionality for P1.1 & P1.2
	P1SEL2 = BIT1 + BIT2;

	// Configure UART
	UCA0CTL1 |= UCSSEL_2;             // Have USCI use System Master Clock: AKA core clk 1MHz
	UCA0BR0 = 104;                    // 1MHz 9600, see user manual
	UCA0BR1 = 0;                      //
	UCA0MCTL = UCBRS0;                // Modulation UCBRSx = 1
	UCA0CTL1 &= ~UCSWRST;             // Start USCI state machine

	// Row scan pins (P1.[4..6]) - setup as output
	P1DIR |= BIT4|BIT5|BIT6;

	// Column scan pins - setup as output
	P2DIR |= BIT0|BIT1|BIT2|BIT3; //P2.[0..3] - column code (output)
	P2DIR |= BIT4; //P2.4 - enable column code above (output)

	// Button status pin (P1.3) - setup as input
	P1DIR &= ~BIT3;

	// LED control pins - setup as output
// TODO not needed
// P2DIR |= BIT5; //P2.5 - enable LEDs (output)
	P1DIR |= BIT0; //P1.0 - turn on all 3 LEDs



	////////////////////////////////////////////////////////////////////////////
	// Main loop

	int col;	// Current column
	int row;	// Current row	
	
	char is_pressed = 0; // Shows if the key pressed

// TODO not needed
	//P2OUT |= BIT5; // Enable all LEDS - active high
	//P2OUT &= ~BIT5; // Disable all LEDS
	
	P1OUT &= ~BIT0; // Turn off LEDs

// TODO determine active level (high or low)
	//P2OUT |= BIT4; // Enable column code
	P2OUT &= ~BIT4; // Disable column code

	// Infinite loop
	for(;;){
		for (col=0; col<16; col++) {
			for (row=0; row<8; row++) {

				// Set row
				P1OUT = (P1OUT & (~(BIT4|BIT5|BIT6))) | ((row << 4) & (BIT4|BIT5|BIT6));

				// Set column
				P2OUT = (P2OUT & (~(BIT0|BIT1|BIT2|BIT3))) | (col & (BIT0|BIT1|BIT2|BIT3));

				// wait for debounce & signal propagation
				__delay_cycles(1000);

				// Check if the button is pressed
				if (!(P1IN & BIT3)) {

					//is_pressed = ~is_pressed;
					if (col > 8) is_pressed = 0;
					else is_pressed = 1;
					
					printf("%d:%d\r\n",col,row);
				}

				// Show result as LED value
				P1OUT = (P1OUT & (~BIT0)) | ((is_pressed)?BIT0:0x00);
			}
		}
	}
}
