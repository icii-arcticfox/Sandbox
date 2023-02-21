module Sandbox(
    /*[Clock]*/ input clk,
    /*[Reset]*/ input reset,

    input [15:0] input1,

    output [15:0] output1
);


//***The memory block automation, /*[always.memory]*/ is similar to the always automation and make similar
//***use of the non-blocking automation, /*[<=]*/. This time however, the non-blocking auotmation will infer
//***from the use as to which memory signals to set and how to set them.

//***Please note, /*[always.memory]*/ currently supports true dual port memories. Future iterations will
//***increase the supported memories.

//***First, we will make a memory for the /*[always.memory]*/ automation to interact with. The --name of the
//***memory will be referred to by the /*[always.memory]*/ automation

/*[DualMemory --name myMemory --addressWidth 16 --dataWidth 32]*/


//***The non-blocking automation within an /*[always.memory]*/ block can perform both reads and writes. If
//***the => symbol is used, then a write will occur.
//***- Reads: provide the value to set the address to
//***- Writes: uses the notation "value => address"

//***There are also some special uses.
//***- 0: set all interface signals to 0
//***- @: used to reference the name of the address signal

//***Finally, to use the /*[always.memory]*/ automation, the first item you pass in is the name of the memory,
//***and the second item you pass in is the port, either A or B. Future support for other memories will
//***use different port options and eliminate it when unneeded.


//***Now, let's get to sandboxing! Port A will receive a writeValue signal that when high, will move to the
//***next address and write value to memory. Port B will be a read only port, and read the next value once
//***a readValue signal is received.

wire writeValue;
wire [31:0] value;
/*[always.memory myMemory A]*/ begin
    if(reset)
        //set all of the signals to 0
        /*[<= 0]*/
    else if(writeValue)
        //write value to the next memory address
        /*[<= value => @ + 1]*/
    else
        //hold the address at the current position
        /*[<= @]*/
end

wire readValue;
/*[always.memory myMemory B]*/ begin
    if(reset)
        //set all of the signals to 0
        /*[<= 0]*/
    else if(readValue)
        //move to the next memory address
        /*[<= @ + 1]*/
    else
        //hold the address at the current position
        /*[<= @]*/
end
endmodule