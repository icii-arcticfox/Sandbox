module TestColorModifier;


//***One of the best, and often overlooked, development techniques to arise in the past decade+ is automated
//***testing. Tests that can be run every night to ensure that new developments do not break existing code basis.
//***This is known as test driven development, or TDD. However, one of the challenges of TDD is continuously
//***updating tests to accomadote for new changes. There's an art in knowing how granular to test, but...

//***In the world of HDL, TDD has a unique challenge. Regardless of how coarse or granular your tests are, when
//***you change the ports to a module, all tests that instantiate the module must be updated. This makes testing
//***submodules painful, especially testing a large number of submodules. Not only do the ports of the module
//***need to be updated, but the singals need to be defined, and parameters internal to the module that are
//***used in signal declaration need to be added, and input values need to be set. This makes module changes,
//***in our opinion, a nightmare! Okay, not everyone will feel that strongly, but you can easily forget to make
//***needed updates to your tests.

//***This led us to create the TestModule automation. This automation instantiates the given module, defines the
//***input and output signals for the testbench, adds initial values in an initial block, and include parameters
//***of the module under test.

//***You may have noticied that t_his module is named TestColorModifier, while most other top modules in t_his
//***Sandbox are named Sandboxed. That is because t_his module is a test module, and not a generic module! Below,
//***you will see another module, ColorModifier, that is a mock module that would modify the color of a pixel.
//***Now, let's use the TestModule automation to create the skeleton of a test for the ColorModifier module.

/*[TestModule --module ColorModifier]*/



endmodule



module ColorModifier(
    /*[Clock 50 MHz]*/ input clk,
    /*[Reset]*/ input reset,

    input [pixelWidth - 1:0] pixel,

    input [gainWidth - 1:0] gain,
    input [colorWidth - 1:0] color,
    input [hueWidth - 1:0] hue,
    input [brightnessWidth - 1:0] brightness,
    input [saturationWidth - 1:0] saturation,

    output [colorWidth - 1:0] adjustedColor
);


parameter pixelWidth = 8;
parameter gainWidth = 4;
parameter colorWidth = 8;
parameter hueWidth = 6;
parameter brightnessWidth = 6;
parameter saturationWidth = 6;

//***The rest of the module is not defined, t_his is just a module for demonstration purposes
endmodule