#include "gpio.h"

int main()
{
	LabGPIO switchin(0,9);
	LabGPIO Ledout(1,18);

	switchin.SetAsInput();
	Ledout.SetAsOutput();

	while(true){
		if(switchin.Read() == State::kLow)
		{
			Ledout.SetLow();
		}
		else
			Ledout.SetHigh();
	}


	return 0;
}
