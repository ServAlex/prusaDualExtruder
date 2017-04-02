use <e3d_v6_all_metall_hotend.scad>;

distance = 23;
extruderYOffset = -13;

fanWidth = 40;
fanThickness = 10;

rM3Threaded = 1.49;
rM3Through = 1.75;
rM3Head = 3.1;
rm3Nut = 3.3;


module perifery()
{
	translate([distance/2, extruderYOffset,3])
	rotate([0, 180, 0])
	union()
	{
//		rotate([0,0,90])
		e3d();
		translate([distance, 0, 0])
//		rotate([0,0,90])
		e3d();
	}
}

//perifery();
part();

module part()
{
	difference()
	{
		clamp();
		clampHoles();
	}
}

module clamp()
{
	difference()
	{
		translate([0, -distance/2, -13/2])
		cube([distance + (8+11)*2, distance, 13], center = true);

		translate([0,0,-1])
		perifery();
		translate([0,0,1])
		perifery();
	}
}

module clampHoles()
{
	
}
