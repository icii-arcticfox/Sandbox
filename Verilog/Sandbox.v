module Sandbox(
    /*[Clock]*/ input clk,
    /*[Reset]*/ input reset
);


//***To demonstrate the use of the Environment automation, we will also use the Assert
//***automation. As many people are aware, System Verilog contains asserts. However, many
//***source files, due to multiple factors, are still Verilog files. This makes it
//***challenging to add checks and tests at the source level. Even worse, if you do add
//***checks within your source code, now you have to remember to comment them out when
//***you go to production.

//***The Environment and Assert automations enable you to change the Environment in one
//***location and remove Asserts / test code from your design files.

//***Below we have a detectedTemperature, a gain, and a bias. In t_his setup, the 
//***detectedTemperature would be the raw value read from a sensor, and the gain an the 
//***bias would be adjustments made to correct the raw value. 

//***In our design, the temperature should not go above 180 degress. Additionally, 
//***the temperature should not go below 20. We added two Assert automations to check 
//***these conditions. After you run Arctic Fox, you'll see that the conditions are 
//***checked on the positive edge of the clock. Additionally, an Assert sends a 
//***message each time an Assert is violated, but will only do so once until the Assert
//***is no longer violated.

//S***What To Do In This Sandbox?
//***- Run Arctic Fox, look at the conditions generated by the Asserts
//***- Try your own Assert. Add variables, come up with a condition to Assert
//***- Change the Environments from Simulation to FPGATesting, run Arctic Fox, and see 
//***  that the Asserts no longer generate Verilog

/*[Environments Simulation]*/

reg [7:0] detectedTemperature;
reg [7:0] gain;
reg [7:0] bias;

/*[Assert detectedTemperature * gain + bias < 180]*/
wire someWire; //TODO: No need to declare this wire...

/*[Assert detectedTemperature * gain + bias > 20]*/
wire someWire2; //TODO: No need to declare this wire...


endmodule