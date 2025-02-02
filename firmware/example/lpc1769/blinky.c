//*****************************************************************************
//   +--+
//   | ++----+
//   +-++    |
//     |     |
//   +-+--+  |
//   | +--+--+
//   +----+    Copyright (c) 2010-11 Code Red Technologies Ltd.
//
// systick_main.c provides an example of how to use the SysTick timer
// built in to the Cortex-M3 core of the LPC1768 MCU on the LPCXpresso1768
// processor board. The example will cause the state of "LED2" (P0_22)
// to toggle every second.
//
//
// Software License Agreement
//
// The software is owned by Code Red Technologies and/or its suppliers, and is
// protected under applicable copyright laws.  All rights are reserved.  Any
// use in violation of the foregoing restrictions may subject the user to criminal
// sanctions under applicable laws, as well as to civil liability for the breach
// of the terms and conditions of this license.
//
// THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
// OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
// MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
// USE OF THIS SOFTWARE FOR COMMERCIAL DEVELOPMENT AND/OR EDUCATION IS SUBJECT
// TO A CURRENT END USER LICENSE AGREEMENT (COMMERCIAL OR EDUCATIONAL) WITH
// CODE RED TECHNOLOGIES LTD.

// CMSIS headers required for setting up SysTick Timer
#include "LPC17xx.h"

// #include <cr_section_macros.h>
// #include <NXP/crp.h>

// Variable to store CRP value in. Will be placed automatically
// by the linker when "Enable Code Read Protect" selected.
// See crp.h header for more information
// __CRP const unsigned int CRP_WORD = CRP_NO_CRP ;

void delay_ms(unsigned int ms)
{
    unsigned int i,j;

    for(i=0;i<ms;i++)
        for(j=0;j<20000;j++);
}

int main(void) {

 	SystemInit();
		// Set P0_22 to 00 - GPIO
	LPC_PINCON->PINSEL1	&= (~(3 << 12));
	// Set GPIO - P0_22 - to be output
	LPC_GPIO0->FIODIR |= (1 << 22);
	// LPC_GPIO3->FIODIR = 0xffffffff;
	// LPC_GPIO3->FIOSET = 0xffffffff;
	//Add code for GPIO toggling here

    // Force the counter to be placed into memory
    volatile static int i = 0 ;
    // Enter an infinite loop, just incrementing a counter
    while(1) {
        i++ ;
        // "Dummy" NOP to allow source level single
        // stepping of tight while() loop
        __asm volatile ("nop");
       LPC_GPIO0->FIOSET = (1 << 22);   // Make all the Port pins as high
                delay_ms(100);

               LPC_GPIO0->FIOCLR = (1 << 22);    // Make all the Port pins as low
                delay_ms(100);

    }
    return 0 ;
}
