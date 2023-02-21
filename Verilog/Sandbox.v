/*[InferClocks]*/
module Sandbox(
    /*[Clock]*/ input clk,
    /*[Reset]*/ input reset
);


//***Digital design almsot always use a clock, and various naming conventions for clocks. Additionally,
//***if your design changes to a faster clock, moves to a differnt chip, etc. you may want to use a new
//***clock name for your clock. However, every synchronous always block needs a clock name, and changing
//***each of those clocks is time consuming. A similar situation exists when multiple clock domains are
//***used. Moving code around multiple clock domains can cause issues if clock names are incorrect.

//***The InferClocks automation makes it much easier to transfer code around different named clocks.
//***Below, you will see always blocks that do not specify the clock after posedge. After running Arctic
//***Fox, the clock signals for the module are generated in the sensitivity list.

//***Please note, the InferClocks automation is attached to the module, and placed right before the module
//***definition as seen above.

//S***What To Do In This Sandbox
//***- Run Arctic Fox, see that the clock signal is added to the always block sensitivity list
//***- Change the name of the clock, run Arctic Fox, see how the always block clock names are updated
//***- Add an always block, include posedge or negedge, leave out the clock name, and Run Arctic Fox to
//***  see the clock name added to the always block

wire flipBias;
reg currentBias;
always@(posedge) begin
    if(reset)
        currentBias <= 1;
    else if(flipBias)
        currentBias <= !currentBias;
    else
        currentBias <= currentBias;
end

wire [7:0] bias0;
wire [7:0] bias1;
reg [7:0] dynamicBias;
always@(posedge) begin
    if(reset)
        dynamicBias <= 0;
    else if(flipBias && currentBias == 0)
        dynamicBias <= bias1;
    else if(flipBias && currentBias == 1)
        dynamicBias <= bias0;
    else
        dynamicBias <= dynamicBias;
end


endmodule