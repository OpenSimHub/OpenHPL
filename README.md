# OpenHPL

OpenHPL is an open-source **Modelica hydropower library** for modelling hydropower systems of varying complexity, from simple single-component tests to complete hydropower plants with integrated power system controls.

## Library description

The OpenHPL library provides comprehensive models for:

- **Hydraulic Components** (`Waterway` package): Penstocks, pipes, reservoirs, surge tanks, open channels, gates, and valves
- **Turbines**: Simple turbine models, Francis turbines, and Pelton turbines with realistic performance characteristics
- **Generators**: Simple generators and synchronous generators for power output modelling
- **Power System Integration**: Grid models with frequency-droop control, seamlessly integrated via OpenIPSL
- **Controllers**: Governor and hydraulic control systems for load governing and system stability
- **Advanced Features**: Elastic penstock modelling using the KP method for pressure transients, discretised flow components for detailed hydraulics

OpenHPL makes it possible to model hydropower systems of different complexity and connect them with models from other libraries, e.g., with models of the power system or other power generating sources. The library is built on Modelica 4.0.0 and integrates with OpenIPSL for power system analysis.

## Current release

Download [OpenHPL v3.0.1 (2026-02-05)](../../releases/tag/v3.0.1)

### Acknowledgements

The very first version 1.0.0 of this library was created as part of the PhD thesis [Vytvytskyi2019](http://hdl.handle.net/11250/2608105), which was supported by the Norwegian Research Council under the project "Hydropower Systems Design and Analysis" (HydroCen Grant No. 257588).

## License

Copyright &copy; 2019-2026
* [University of South-Eastern Norway](https://www.usn.no/english/) (USN)

This Source Code Form is subject to the terms of the [Mozilla Public License, v. 2.0](LICENSE).

## Contact

The maintainers can be contacted by email: [OpenHPL@opensimhub.org](mailto:OpenHPL@opensimhub.org)
