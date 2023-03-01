using ArcticFox.Public;
using ArcticFox.Tokens;
using ArcticFoxBasic.Automations;

namespace Sandbox.Automations;

public class SBAutomation_Counter : VerilogAutomation
{
    //The following three lines are used to generate the snippets for VS Code
    //_____:                                 |
    //Short:basic counter, @reg
    //Description: Creates a counter that counts to a certain constant or variable when start is received, produces done when finished

    //Depenencies require values to be set before the automation can be processed
    //Currently, the Clock automation must be used to set the primary clock for the module
    protected override Dependencies Dependencies => Module.PrimaryClockSet;

	protected override void ApplyAutomation()
	{
        //Get next reg, force it to be a reg, not a wire
        Reg reg = NextReg(forceToReg: true);
        if(reg == null)
            Error("Could not find reg/wire to attach variable to");

        //Get items
        //The string is the item tag, such as --count, captilization is ignored
        //The integer is the position if the item tag is not given
        //Furthermore, the | is followed by the default value if the item isn't present
        string countTo = Items["Count", 0]        | reg.Name + CountSuffix;
        string startSignal = Items["Start", 1]    | reg.Name + StartSuffix;
        string doneSignal = Items["Done", 2]      | reg.Name + DoneSuffix;
        string countEvent = Items["Event", 3]   | Module.PrimaryClock.Name;
        bool noMax = Items.Contains("NoMax");
        
        //Check error conditions
        if(noMax && Items.Contains("Count"))
            Error("Cannot specify both count and nomax, only use one or the other");
        if(noMax && Items.Contains("Done"))
            Error("Cannot specify both count and done, only use one or the other");
        if(Items.Contains("Start") && Items.Contains("Event"))
            Error("Cannot specify both start and event, only use one or the other");
        
        //If no max, set countTo to the max value given the reg's width
        if(noMax)
            countTo = $"{{({reg.WidthSubSections()[0]} - {reg.WidthSubSections()[1]} + 1){{1'b1}}}}";

        //Get the name of the clock for the module
        string clockName = Module.PrimaryClock.Name;

        //Set the CodeAfterNext depending on what items were given
        //CodeAfterNext generates code after then next code clause

        //Normal condition, counting each clock cycle and not unbounded 
        if(countEvent == Module.PrimaryClock.Name && !noMax)
        {
		CodeAfterNext += @$"
assign {doneSignal} = {reg.Name} == {countTo};
always@(posedge {clockName}) begin
    {Reset.IfReset(Module, $"{reg.Name} <= 0;")}
    if({doneSignal})
        {reg.Name} <= 0;
    else if({startSignal} || ({reg.Name} > 0))
        {reg.Name} <= {reg.Name} + 1;
    else
        {reg.Name} <= 0;
end";
        }

        //If counting each clock cycle and unbounded
        else if(countEvent == Module.PrimaryClock.Name && noMax)
        {
		CodeAfterNext += @$"
always@(posedge {clockName}) begin
    {Reset.IfReset(Module, $"{reg.Name} <= 0;")}
    if({reg.Name} == {countTo})
        {reg.Name} <= {reg.Name};
    else if({startSignal} || ({reg.Name} > 0))
        {reg.Name} <= {reg.Name} + 1;
    else
        {reg.Name} <= {reg.Name};
end";
        }

        //If counting an event, not clock cycles, and not unbounded
        else if(!noMax)
        {
		CodeAfterNext += @$"
assign {doneSignal} = {reg.Name} == {countTo};
always@(posedge {clockName}) begin
    {Reset.IfReset(Module, $"{reg.Name} <= 0;")}
    if({doneSignal})
        {reg.Name} <= 0;
    else if({countEvent})
        {reg.Name} <= {reg.Name} + 1;
    else
        {reg.Name} <= {reg.Name};
end";
        }

        //If counting an event, not clock cycles, and unbounded
        else 
        {
		CodeAfterNext += @$"
always@(posedge {clockName}) begin
    {Reset.IfReset(Module, $"{reg.Name} <= 0;")}
    if({reg.Name} == {countTo})
        {reg.Name} <= {reg.Name};
    else if({countEvent})
        {reg.Name} <= {reg.Name} + 1;
    else
        {reg.Name} <= {reg.Name};
end";
        }



//***************************************************************
//***************** Add Base and Member Values ******************
//***************************************************************
//The following code presents to the uset the Values that are created
        CodeBase += $"${reg.Name}";

        if(noMax && Items.Contains("Event"))
            CodeMembers += $"$.event";
        else if(noMax)
            CodeMembers += $"$.start";
        else 
            CodeMembers += $"$.countTo, $.start, $.done";

        Code codePlace = CodeAfterNext;            
     
        if(noMax) { } 
        else if(Module.ContainsVariableOrParameter(countTo) || countTo.IsNumber())
            codePlace += $@"
/*[${reg.Name}.countTo {countTo}]*/";
        else if(countTo.Contains(' '))
            codePlace += $@"
/*[${reg.Name}.countTo]*/ wire {reg.Width} {reg.Name + CountSuffix};
assign {reg.Name + CountSuffix} = {countTo};";
        else
            codePlace += $@"
/*[${reg.Name}.countTo]*/  wire {reg.Width} {countTo};";

        if(Items.Contains("Event") && countEvent != Module.PrimaryClock.Name)
            codePlace += $@"
/*[${reg.Name}.event {countEvent}]*/";
        else if(Module.ContainsVariableOrParameter(startSignal) || startSignal.IsNumber())
            codePlace += $@"
/*[${reg.Name}.start {startSignal}]*/";
        else if(startSignal.Contains(' '))
            codePlace += $@"
/*[${reg.Name}.start]*/ wire {reg.Name + StartSuffix};
assign {reg.Name + StartSuffix} = {startSignal};";
        else
            codePlace += $@"
/*[${reg.Name}.start]*/ wire {startSignal};";

        if(noMax) { }
        else if(Module.ContainsVariableOrParameter(doneSignal) || doneSignal.IsNumber())
            codePlace += $@"
/*[${reg.Name}.done {doneSignal}]*/";
        else
            codePlace += $@"
/*[${reg.Name}.done]*/ wire {doneSignal};";
	}

    public const string StartSuffix = "Start";
    public const string DoneSuffix = "Done";
    public const string CountSuffix = "Count";

}