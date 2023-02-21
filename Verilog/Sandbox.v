module Sandbox(
    /*[Clock]*/ input clk,
    /*[Reset]*/ input reset,

    input [15:0] input1,

    output [15:0] output1
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

/*[Environments Simulation]*/

reg [7:0] detectedTemperature;
reg [7:0] gain;
reg [7:0] bias;

/*[Assert detectedTemperature * gain + bias < 180]*/
wire someWire; //TODO: No need to declare this wire...

/*[Assert detectedTemperature * gain + bias > 20]*/
wire someWire2; //TODO: No need to declare this wire...


endmodule