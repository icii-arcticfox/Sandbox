module Sandbox(
    /*[Clock]*/ input clk,
    /*[Reset]*/ input reset
);


//***Whether we are pipelining data or analyzing the change in a signal over multiple clock cycles,
//***delaying a signal, or flopping it multiple times, is a common task. That is why we created the
//***Delay automation. Delay takes a signal name and a delay count, and is attached to a reg.


//S***Specifying Item Names
//***Delay is not a complicated automation, so let's just show it. The two items are --name and --delay.
//***The signal we are delaying is initial1, and it's delayed value will be set to the attached wire,
//***named delayedValue1. Delay will use the Previous automation n times to delay the signal.

reg [7:0] initial1;
/*[Delay --name initial1 --delay 3]*/
wire [7:0] delayedValue1;



//S***Using Item Positions
//***As with most automations, Delay can be used based on the position of the items. The
//***following is the same example using item position rather than item names, and the delay
//***amount is changed to 4.

reg [7:0] initial2;
/*[Delay initial2 4]*/
wire [7:0] delayedValue2;


endmodule