#include "LPC17xx.h"
#include <cstdint>

enum class Direction : uint8_t
{
        kInput = 0,
        kOutput = 1
};
enum class State : uint8_t
{
        kLow = 0,
        kHigh = 1
};

class LabGPIO
{
public:
    // Table of GPIO ports located in LPC memory map ordered in such a way that
    // using the port number in the braces looks up the appropriate gpio register
    LPC_GPIO_TypeDef* gpio[6] = {LPC_GPIO0, LPC_GPIO1, LPC_GPIO2, LPC_GPIO3, LPC_GPIO4, nullptr};

    constexpr LabGPIO(uint8_t port, uint8_t pin);
        void SetAsInput();
        void SetAsOutput();
        void SetHigh();
        void SetLow();
        void Set(State state);
        State Read();
        bool ReadBool();

    private:
        uint8_t port_;
        uint8_t pin_;
        volatile uint32_t* GetPINSELRegister();
        void ConfigurePINSEL();
};

LabGPIO::LabGPIO(uint8_t port, uint8_t pin) : port_(port), pin_(pin)
{
    ConfigurePINSEL();
}

void LabGPIO::ConfigurePINSEL()
{
    // Calculate the PINSEL shift value based on the pin number
    uint8_t pinSelShift = (pin_ % 16) * 2;

    // Set the PINSEL register bits to 01 to enable GPIO for the pin
    *GetPINSELRegister() &= ~(0b11 << pinSelShift);
}

volatile uint32_t* LabGPIO::GetPINSELRegister()
{
    switch (port_)
    {
    case 0:
        return &LPC_PINCON->PINSEL0;
    case 1:
        return &LPC_PINCON->PINSEL2;
    case 2:
        return &LPC_PINCON->PINSEL4;
    case 3:
    	return &LPC_PINCON->PINSEL6;
    case 4:
    	return &LPC_PINCON->PINSEL8;
    default:
        return nullptr; // Invalid port
    }
}
State LabGPIO::Read()
{
    return static_cast<State>((gpio[port_]->FIOPIN >> pin_) & 1); // Read pin state
}

bool LabGPIO::ReadBool()
{
    return static_cast<bool>(Read());
}

void LabGPIO::SetAsInput()
{
    gpio[port_]->FIODIR &= ~(1 << pin_); // Set as input
}

void LabGPIO::SetAsOutput()
{
    gpio[port_]->FIODIR |= (1 << pin_); // Set as output
}

void LabGPIO::SetHigh()
{
    gpio[port_]->FIOSET = (1 << pin_); // Set pin high
}

void LabGPIO::SetLow()
{
    gpio[port_]->FIOCLR = (1 << pin_); // Set pin low
}
