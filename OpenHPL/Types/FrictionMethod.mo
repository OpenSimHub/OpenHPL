within OpenHPL.Types;
type FrictionMethod = enumeration(
    PipeRoughness "Direct pipe roughness height (p_eps)",
    MoodyFriction "Moody friction factor (f)",
    ManningFriction "Manning roughness coefficient (M or n)") "Enumeration defining method for specifying pipe friction";
