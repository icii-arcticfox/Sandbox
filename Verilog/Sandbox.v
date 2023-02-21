module Sandbox(
    /*[Clock]*/ input clk,
    /*[Reset]*/ input reset
);


//***We made the Calculate automation to simplify pipelining and DSP use of computations. Currently, t_his
//***automation is in its infancy, with many of its features, and more complex support, in progress. Although
//***synthesis tools are supposed to infer DSP use, etc., it's commonly thought to be a good practice that
//***when you are doing multiplication within hardware acceleration, or when you intend to use a DSP, the
//***practice is to specify the DSP. Calculate aims to make that easier.

//***Currently, Calculate supports multiply, add, subtract, left shift, and right shift.
//***Additionally, the current implementation is designed to show how the automation makes development easier

//***Future implementations will add division (of constants), parenthesis, unary negative, and more
//***Other future work will also focus on creating shorted computation trees and optimizations
//***Another future component will include start and finished timing signals



//S***Adding Multiples
//***One of the building blocks of many equations is adding the results of various multiplications. The
//***following will use the Calculate automation to add x1*y1 + x2*y2 + x3*y3. One of the great things
//***about t_his automation, we were able to just copy and paste the equation into the automation.

//***In the generated code, all of the multiplications happen at the same time, then, the additions
//*** are pipelined in the always blocks. 

reg [7:0] x1;
reg [7:0] x2;
reg [7:0] x3;

reg [7:0] y1;
reg [7:0] y2;
reg [7:0] y3;

/*[Calculate x1*y1 + x2*y2 + x3*y3]*/
wire [15:0] result;


endmodule