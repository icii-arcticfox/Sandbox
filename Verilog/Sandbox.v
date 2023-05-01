module Sandbox(
    /*[Clock]*/ input clk,
    /*[Reset]*/ input reset,

    input trigger
);


//***The Sequence automation, /*[sequence]*/, will enable you to perform a series of actions. Each
//***action will be performed in subsequent clock cycles. Furthermore, a 
//***sequence will wait until a specified trigger is seen, and will then continue one clock
//***cycle after another until the sequence is finished.

//***Please note, /*[sequence.memory]*/ currently supports true dual port memories. Future iterations
//***will increase the supported memories.

//***Additionally, t_his sandbox does not cover the use of the /*[<=]*/ automation within a memory
//***block. Please refer to the MemoryBlock sandbox which covers these.

//***First, we will make a memory for the /*[sequence.memory]*/ automation to interact with. The
//***--name of the memory will be referred to by the /*[sequence.memory]*/ automation
/*[DualMemory --name myMemory --addressWidth 16 --dataWidth 32]*/

//***Finally, to use the /*[sequence.memory]*/ automation, the first item you pass in is the name of the memory,
//***and the second item you pass in is the port, either A or B. Future support for other memories will
//***use different port options and eliminate it when unneeded.


//***Now, let's get to sandboxing! We will demonstrate two different sequences, one for Port A and one for
//***Port B. For Port A, the sandbox module will receive a writeTrigger that will start the sequence below.
//***This will cause Port A to write the data in dataToStore to addresses 1, 2, 3, and 4 in memory.
//***DataToStore will be separated into 32 bit values and store 1 value per clock cycle for four clock cycles.

/*[RisingEdge]*/
wire risingWriteTrigger;

reg [15:0] sum;

/*[sequence.memory --name myMemory --port A --trigger risingWriteTrigger]*/ begin
    /*[<= dataToStore[31:0] => 1]*/
    /*[<= dataToStore[63:32] => 2]*/
    /*[<= dataToStore[95:64] => 3]*/
    /*[<= dataToStore[127:96] => 4]*/
end


endmodule