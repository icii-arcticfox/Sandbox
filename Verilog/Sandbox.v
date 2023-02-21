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




endmodule