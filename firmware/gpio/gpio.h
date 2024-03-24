/**************************

                              gpio driver

***************************/
#pragma once

#include "LPC17xx.h"
#include <cstdint>
#include <iostream>
#include <string>
using namespace std;

class Gpio{
    public:
    int port_,pin_;
     enum class Direction{
        ip=0,op=1
};
     enum class State{
         lo=0,hi=1
     };
    Gpio(int port, int pin) : port_(port), pin_(pin) {
        Pinsel();
    }
    void Pinsel()
    {
               // uint8_t pinReg = pin_ / 16;
                uint8_t pinShift = (pin_ % 16) * 2;
                *PINSELRegister() &= ~(3 << pinShift);

     }

     void SetInput(){
         *FIODIRR() &= ~(1 << pin_);
     }
     void SetOutput(){
         *FIODIRR() |= (1 << pin_);
     }

     void SetLow(){
         *FIOPINN() &= ~(1<<pin_);
     }
     void SetHigh(){
         *FIOPINN() |= (1<<pin_);
     }
     State Read(){
    	 return static_cast<State>((*FIOPINN() >> pin_) & 1);;
     }
     bool ReadBool()
     {
         return static_cast<bool>(Read());
     }
     void Set(State state)
    {
        if (state == State::hi)
        {
            SetHigh();
        }
        else
        {
            SetLow();
        }
    }
     volatile uint32_t* FIODIRR(){
        switch(port_){
            case 0:
                return &LPC_GPIO0->FIODIR;
            case 1:
                return &LPC_GPIO1->FIODIR;
            case 2:
                return &LPC_GPIO2->FIODIR;
            case 3:
                return &LPC_GPIO3->FIODIR;
            case 4:
                return &LPC_GPIO4->FIODIR;

            default:
                return nullptr;
        }
    }
    volatile uint32_t* FIOPINN(){
        switch(port_){
            case 0:
                return &LPC_GPIO0->FIOPIN;
            case 1:
                return &LPC_GPIO1->FIOPIN;
            case 2:
                return &LPC_GPIO2->FIOPIN;
            case 3:
                return &LPC_GPIO3->FIOPIN;
            case 4:
                return &LPC_GPIO4->FIOPIN;
            default:
                return nullptr; // Invalid port
        }
    }
    volatile uint32_t* PINSELRegister(){

    if(port_==0 && pin_<=15)
    {
        return &LPC_PINCON->PINSEL0;
    }
    else if(port_==0 && pin_ > 15){

        return &LPC_PINCON->PINSEL1;
    }
    else if(port_==1 && pin_ <=31 && pin_ >=18){

        return &LPC_PINCON->PINSEL3;
    }
    else if(port_ == 2 && pin_ <14){

        return &LPC_PINCON->PINSEL4;
    }
    else if(port_== 4 && pin_ == 29){
        return &LPC_PINCON->PINSEL9;
    }

    else {
        return nullptr;
    }

}

};

int main(void)
{
    // Define the LabGPIO objects for the switch and LED
    Gpio switchGpio(0, 9); // Assuming switch is connected to P0.9
    Gpio ledGpio(2, 0);    // Assuming LED is connected to P2.0

    // Initialize switch as input and LED as output
    switchGpio.SetInput();
    ledGpio.SetOutput();

    while (true)
    {
        // Read the state of the switch
        Gpio::State switchstate = switchGpio.Read();

        // Check if the switch is pressed (assuming switch is active low)
        if (switchstate == Gpio::State::hi)
        {
            // Toggle the state of the LED
            Gpio::State currentLedState = ledGpio.Read();
            ledGpio.Set(currentLedState == Gpio::State::lo ? Gpio::State::hi : Gpio::State::lo);

            // Add a delay to debounce the switch
            for (volatile int i = 0; i < 100000; ++i)
                ;
        }
    }

    return 0;
}
