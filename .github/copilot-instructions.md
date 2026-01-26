# OpenHPL AI Coding Agent Instructions

## Project Overview
OpenHPL is an open-source **Modelica hydropower library** for modeling hydropower systems of varying complexity. Models range from simple single-component tests to complete hydropower plants with turbines, generators, controllers, and integration with power systems (via OpenIPSL).

**Key Repository:** [GitHub - OpenHPL](https://github.com/USN-OpenHPL/OpenHPL)
**Documentation:** User's Guide at `OpenHPL/Resources/Documents/UsersGuide.pdf`

## Modelica-Specific Conventions

### Package Structure
- Every folder represents a Modelica package with:
  - `package.mo` - Package definition with metadata, dependencies, and documentation
  - `package.order` - Controls display order of components in Modelica IDEs
  - Component `.mo` files for models, records, connectors, functions
- **Namespace rule**: File `OpenHPL/Waterway/Penstock.mo` defines `within OpenHPL.Waterway; model Penstock`

### Standard Data Pattern
Models use `outer Data data` to access shared system parameters (gravity, water density, viscosity, initial conditions):
```modelica
outer Data data "Using standard data set";
// Then reference: data.rho, data.g, data.Vdot_0, data.f_0, etc.
```
The `Data` record is defined at `OpenHPL/Data.mo` with physical constants and initialization settings.

### Connector Pattern
Water flow connections use `OpenHPL.Interfaces.Contact` connectors:
- `SI.Pressure p` - Pressure at connection point
- `flow SI.MassFlowRate mdot` - Mass flow rate (positive = into component)
- Models extend `Interfaces.TwoContacts` for inlet (`i`) and outlet (`o`)

### Multiple Inheritance Pattern
Models commonly extend multiple base classes:
```modelica
model Turbine "Simple turbine model"
  extends BaseClasses.BaseValve;          // Valve-like flow behavior
  extends BaseClasses.Power2Torque(...);   // Power to mechanical torque conversion
  extends Interfaces.TurbineContacts;      // Fluid inlet/outlet connectors
  extends Icons.Turbine;                   // Visual icon
```

### Annotation Conventions
- `experiment(StopTime=1000)` - Simulation time settings in example models
- `Dialog(group="...")` - Parameter grouping in model GUI
- `Documentation(info="<html>...</html>")` - Inline HTML documentation
- `choices(checkBox=true)` - Boolean parameters as checkboxes

## Package Architecture

### Main Component Packages
- **`Waterway/`** - Hydraulic components (pipes, penstocks, reservoirs, surge tanks, valves, gates)
  - `Penstock.mo` (obsolete), `PenstockKP.mo` (recommended elastic penstock with KP method)
  - `Pipe.mo`, `Reservoir.mo`, `SurgeTank.mo`, `OpenChannel.mo`, etc.
- **`ElectroMech/`** - Electromechanical components
  - `Turbines/` - `Turbine.mo` (simple), `Francis.mo`, `Pelton.mo`
  - `Generators/` - `SimpleGen.mo`, `SynchGen.mo`
  - `PowerSystem/` - `Grid.mo` (frequency-power droop model)
- **`Controllers/`** - Governor and control models
- **`Examples/`** - Complete working models (`SimpleGen.mo`, `DetailedGenFrancis.mo`, etc.)
- **`Functions/`** - Utility functions (friction calculations, KP07 method for elastic penstocks)
- **`Interfaces/`** - Base connectors (`Contact.mo`, `TwoContacts.mo`)
- **`Types/`** - Custom type definitions
- **`Icons/`** - Graphical icon definitions

### Test Package
`OpenHPLTest/` contains extensive test models for validation and case studies.

## Development Workflows

### Creating New Models
1. **Choose correct package** - Waterway for hydraulics, ElectroMech for turbines/generators
2. **Use proper namespace**: `within OpenHPL.PackageName;`
3. **Extend appropriate base classes** - Check existing similar models
4. **Add `outer Data data`** if using shared parameters
5. **Update `package.order`** to control display order
6. **Add experiment annotation** for simulation settings

### Modifying Parameters
- Parameters use Modelica SI units (`SI.Height`, `SI.Diameter`, `SI.VolumeFlowRate`)
- Group related parameters: `annotation (Dialog(group="Geometry")))`
- Initialization parameters: `annotation (Dialog(group="Initialization"))`

### Documentation
- Always include `Documentation(info="<html>...</html>")` annotation
- Reference images from `OpenHPL/Resources/Images/` (use SVG format)
- Cite equations and methods from the User's Guide or PhD thesis

### Dependencies
- Library depends on **OpenIPSL** (power system library) and **Modelica Standard Library 4.0.0**
- Specified in `OpenHPL/package.mo`: `uses(OpenIPSL(version="3.0.0"), Modelica(version="4.0.0"))`

## Critical Design Patterns

### Discretization Methods
- **Penstock modeling**: Use KP method (`PenstockKP.mo`) over simple Staggered grid (`Penstock.mo` marked obsolete)
- Finite volume methods with N segments for spatial discretization
- Parameters: `N` (number of segments), `dx` (segment length)

### Friction Calculations
Use `Functions.DarcyFriction.Friction(v, D, L, rho, mu, p_eps)` for pipe friction losses.

### Power-Torque Conversion
Electromechanical models extend `BaseClasses.Power2Torque` to convert hydraulic/electrical power to mechanical torque on shafts.

### Grid Integration
`ElectroMech.PowerSystem.Grid` implements frequency-power droop control using:
- `Lambda` (network power-frequency characteristic)
- `Rgrid` (equivalent droop setting)
- `mu` (self-regulation effect)

## File Naming & Organization
- Model files use PascalCase: `SurgeTank.mo`, `Francis.mo`
- Package files always named `package.mo` and `package.order`
- Examples descriptive: `SimpleGenFrancis.mo`, `DetailedTurbine.mo`

## Common Pitfalls
- Don't forget `within` clause matching file path
- Mark obsolete models with `extends Modelica.Icons.ObsoleteModel;`
- Always update `package.order` when adding new components
- Use `outer Data data` - don't redefine constants per model
- Flow connectors require `flow` qualifier on extensive variables (mdot)

## Typical Model Hierarchy
```
Examples/SimpleGen.mo            (Complete system)
  ├─ Waterway.Reservoir          (Water source)
  ├─ Waterway.PenstockKP         (Elastic penstock)
  ├─ ElectroMech.Turbines.Turbine (Hydro turbine)
  └─ ElectroMech.Generators.SimpleGen (Generator + grid)
       └─ outer Data data         (Shared parameters)
```

## Resources
- User Guide: `OpenHPL/Resources/Documents/UsersGuide.pdf`
- PhD Thesis: http://hdl.handle.net/11250/2608105
- Images/Equations: `OpenHPL/Resources/Images/`
- Contact: OpenHPL@opensimhub.org
