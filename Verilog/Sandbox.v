module Sandbox(
    /*[Clock]*/ input clk,
    /*[Reset]*/ input reset,

    input [15:0] var1,
    input [15:0] var2,
    input [15:0] var3,

    input trigger
);


//***The Sequence automation, /*[sequence]*/, will enable you to perform a series of actions. Each
//***action will be performed in subsequent clock cycles. Furthermore, a sequence will wait until
//***a specified trigger is seen, and will then continue one clock cycle after another until the
//***sequence is finished.

//***This sandbox does not cover the use of the /*[<=]*/ automation. Please refer to the AlwaysBlock
//***sandbox to learn about the /*[<=]*/ automation.

//***Now, let's get to sandboxing! We will demonstrate a reg name sum that will add 3 variables,
//***var1, var2, and var3, to sum in a parallel fashion. This will occur over 3 clock cycles.
//***In the first clock cycle, sum will be set to var1. In the second clock cycle, the value of
//***var2 will be added to sum. Last, in the third clock cycle, var3 will be added to sum.

//***Also, since we only want to trigger the signal on the rising edge of writeTrigger, we detect
//***the rising edge of risingWriteTrigger.
/*[RisingEdge]*/
wire risingTrigger;

reg [15:0] sum;
/*[sequence --name myMemory  --trigger risingTrigger]*/ begin
    /*[<= var1]*/
    /*[<= sum + var2]*/
    /*[<= sum + var3]*/
end
endmodule