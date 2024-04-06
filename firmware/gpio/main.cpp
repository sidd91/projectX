#include "gpio.h"

int main(void) {
    Gpio switchGpio(0, 9); // Switch
    Gpio ledGpio(2, 0);    // LED

    switchGpio.SetInput();
    ledGpio.SetOutput();

    // Enable GPIO Interrupt for the switch
    LPC_GPIOINT->IO0IntEnF |= 1 << 9; // Falling edge (assuming active-low switch)

    // Set priority and enable interrupt in NVIC
    NVIC_SetPriority(EINT3_IRQn, 1);
    NVIC_EnableIRQ(EINT3_IRQn);

    while (true) {
        if (!ledOn) {
            // Toggle the LED
            Gpio::State currentLedState = ledGpio.Read();
            ledGpio.Set(currentLedState == Gpio::State::lo ? Gpio::State::hi : Gpio::State::lo);

            // Short delay to slow down toggling speed
            for (volatile int i = 0; i < 100000; ++i);
        } else if (oneMinutePassed) {
            // Keep the LED on
            ledGpio.SetHigh();
            // Optionally, reset the condition to start toggling again
        }
    }

    return 0;
}