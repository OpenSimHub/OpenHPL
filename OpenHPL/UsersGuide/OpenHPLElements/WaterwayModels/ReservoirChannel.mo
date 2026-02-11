within OpenHPL.UsersGuide.OpenHPLElements.WaterwayModels;
class ReservoirChannel "Description of Reservoir Channel unit"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h4>Reservoir Channel</h4>
<p>
In order to make a more detailed model of the reservoir, the open channel model is used, where the channel bed is 
assumed to be flat (no slope). Here, the user also specifies the geometry parameters of the channel (reservoir) such as 
length L and width w of the channel (reservoir), height vector H of the reservoir bed with height from the left and right 
sides (should be same number in order to have flatbed), and the number of cells N for the discretization. This unit can 
be initialized by the initial value of the water depth h₀ in the reservoir.
</p>

<p>
The <code>ReservoirChannel</code> unit uses the <code>Contact</code> connector that provides information about the 
outlet pressure and the flow rate from/to the reservoir which can be connected to other waterway units.
</p>
</html>", revisions=""));
end ReservoirChannel;
