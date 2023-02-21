module Sandbox(
    /*[Clock]*/ input clk,
    /*[Reset]*/ input reset
);


//***As we developed automations, we realized that we needed to be able to "turn off" automations.
//***This led use to create the Don't Process notation. Placing an exclamation point, ! , at the
//***start of an automation will prevent the automation from being processed. You can see t_his
//***below in the Previous and RisingEdge automations.

wire [15:0] incomingData;
/*[!Previous]*/
reg [15:0] p1_incomingData;

wire detectPulse;
/*[!RisingEdge]*/
wire risingDetectPulse;
endmodule