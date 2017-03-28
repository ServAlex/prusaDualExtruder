use <e3d_v6_all_metall_hotend.scad>;

partNumber = 2;

mountingHoleOffset = 15;

distance = 23;
sinkR = 11.15;
sinkH = 26;
tolerance = 0.2;

fanWidth = 40;
fanThickness = 10;
fanMountingPlateThickness = 5;
fanOffset = 25;

wireStandWidth = 20;
wireStandHeight = 10;

/*
rotate([0,0,90])
#e3d();
#translate([0, distance, 0])
rotate([0,0,90])
e3d();
//translate([fanOffset + fanMountingPlateThickness, distance/2 - fanWidth/2, 20+sinkH-fanWidth])
//cube([fanThickness, fanWidth, fanWidth]);
*/

difference()
{
	union()
	{
		if(partNumber == 1 || partNumber == 0)
		{
			// main shroud
			minkowski()
			{
				union()
				{
					translate([0, -sinkR, 20])
					cube([sinkR,distance+2*sinkR+2*tolerance, sinkH]);

					hull()
					{
						translate([fanOffset, distance/2 - (fanWidth-4)/2, 20+sinkH-fanWidth])
						cube([fanMountingPlateThickness, fanWidth-4, fanWidth]);

						translate([sinkR, -sinkR, 20])
						cube([0.01,distance+2*sinkR+2*tolerance, sinkH]);
					}
				}
				// half-cylinder for smoothing
				difference()
				{
					cylinder(r=2, h = 0.01, $fn=20);
					translate([0, -5, -5])
					cube([10,10,10]);
				}
			}

			// e3d outter clamp
			difference()
			{
				translate([0, -(8+11), 4])
				cube([30, distance+(8+11)*2, 12]);
			}

			// led shroud
			translate([fanOffset+fanMountingPlateThickness-2, distance/2 - (fanWidth)/2, 20+sinkH])
			{
				cube([2, fanWidth, 4]);
				translate([-18, 0, 0])
				cube([20, 2, 4]);
				translate([-18, fanWidth-2, 0])
				cube([20, 2, 4]);
			}

			// part fan mounts
			for(i=[-1,1])
			{
				translate([fanOffset+fanMountingPlateThickness-4, distance/2 -5.5 -((fanWidth)/2 + 5.5 - 1.5)*i, 20+sinkH - 32])
				difference()
				{
					minkowski()
					{
						cube([4, 11.0, 31]);
						
						rotate([0,90,0])
		//				intersection()
						{
							cylinder(r = 1, h = 0.001, $fn = 15);
						}
					}

					translate([0, 5.5 - i*1.5, 7])
					rotate([0, 90, 0])
					translate([0,0,-1])
					cylinder(r = 1.5, h = 6, $fn=30);

					translate([0, 5.5 - i*1.5, 17])
					rotate([0, 90, 0])
					translate([0,0,-1])
					cylinder(r = 1.5, h = 6, $fn=30);

					translate([0, 5.5 - i*1.5, 27.0])
					rotate([0, 90, 0])
					translate([0,0,-1])
					cylinder(r = 1.5, h = 6, $fn=30);
				}
			}

			// inductive sensor mount
			translate([-7.5, -distance/2-29, 46-3])
			{
				difference()
				{
					cube([15, 20+9, 3]);

					translate([15/2, 6 + 2, -1])
					cylinder(r = 6, h = 5, $fn=30);

					translate([15/2, 12 + 2 + 2 + 4, -1-40])
					cylinder(r = 4, h = 50, $fn=30);
				}
			}
		}

		if(partNumber == 2 || partNumber == 0)
		{
			farClamp();
		}
	}

	
	// proximity sensor cut
	translate([-7.5, -distance/2-29, 46-3])
	translate([15/2, 12 + 2 + 2 + 4, -1-60])
	cylinder(r = 5, h = 50, $fn=30);


	// inside space around heat sinks
	hull()
	{
		translate([sinkR, -sinkR, 22])
		cube([0.01,distance+2*sinkR+2*tolerance, sinkH-4]);

		translate([0, -sinkR, 22])
		cube([sinkR,distance+2*sinkR+2*tolerance, sinkH-4]);
	}

	// inside air transfet tube
	hull()
	{
		translate([fanOffset, distance/2, 20+sinkH-fanWidth/2])
		rotate([0,90,0])
		cylinder(r = (fanWidth)/2-1, h = fanMountingPlateThickness+1);

		translate([sinkR, -sinkR, 22])
		cube([0.01,distance+2*sinkR+2*tolerance, sinkH-4]);
	}


	// heatsink cylinder cuts
    translate([0, distance, 20-1])
    cylinder(r=sinkR+tolerance, h=sinkH+2);

    translate([0, 0, 20-1])
    cylinder(r=sinkR+tolerance, h=sinkH+2);

	// cleanup of junk between cylinders
	translate([-3, distance/2 - 1, 19])
	cube([4, 2, sinkH+2]);
    translate([0, distance, 1])
    cylinder(r=3, h=16);
    translate([0, 0, 1])
    cylinder(r=3, h=16);

	// e3d cuts
	translate([0,0,1])
	union()
	{
		rotate([0,0,90])
		e3d();
		translate([0, distance, 0])
		rotate([0,0,90])
		e3d();
	}

	translate([0,0,-1])
	union()
	{

		rotate([0,0,90])
		e3d();
		translate([0, distance, 0])
		rotate([0,0,90])
		e3d();
	}


	// clamp mounting holes
	for(i=[-1, 0, 1])
	{
		rotate([0, 90, 0])
		translate([-10, distance/2+(distance+2)*i, -15])
		union()
		{
			translate([0,0,30])
			rotate([0,0,-30])
			cylinder(r = 3, h = 50, $fn = 30);
			translate([0,0,-40.4+55])
			cylinder(r = 1.5, h = 15, $fn = 30);
		}
	}
	
	// fan mounting holes
	for(i=[-1,1])
	for(j=[-1,1])
	{
		translate([0, (fanWidth-4)/2*i, (fanWidth-4)/2*j])
		translate([fanOffset-4, distance/2, 20+sinkH-fanWidth/2])
		rotate([0,90,0])
		cylinder(r = 1.3, h = 17, $fn=30);
	}

//	translate([-10,distance/2,0])
//	cube([100, 100, 100]);
}


module farClamp()
{
	// e3d inner clamp

	difference()
	{
		union()
		{
			translate([-15, -(8+11), 4])
			cube([15, distance+(8+11)*2, 12]);

			// top fin
			hull()
			{
				translate([-15, -15+distance/2, 4])
				cube([3, 30, 3]);

				translate([-15, -wireStandWidth/2 +distance/2, 4-wireStandHeight])
				cube([3, wireStandWidth, 3]);
			}

			hull()
			{
				translate([-15, -1.5+distance/2, 4])
				cube([10, 3, 3]);

				translate([-15, -1.5+distance/2, 4-wireStandHeight*2/3])
				cube([3, 3, wireStandHeight*2/3]);
			}

			// bottom fin
			bottomFinHeight = 10;
			hull()
			{
				translate([-15, -15+distance/2, 4+12-3])
				cube([3, 30, 3]);

				translate([-15, -wireStandWidth/2 +distance/2, 4+12 + bottomFinHeight])
				cube([3, wireStandWidth, 3]);
			}

			hull()
			{
				translate([-15, -1.5+distance/2, 4+12-3])
				cube([7, 3, 3]);

				translate([-15, -1.5+distance/2, 4+12])
				cube([3, 3, bottomFinHeight]);
			}
		}

		// caridge mounting holes
		rotate([0, 90, 0])
		translate([-10, distance/2 - mountingHoleOffset, -11])
		union()
		{
			cylinder(r = 3, h = 15, $fn = 30);
			translate([0,0,-10])
			cylinder(r = 1.5, h = 30, $fn = 30);
		}

		rotate([0, 90, 0])
		translate([-10, distance/2 + mountingHoleOffset, -11])
		union()
		{
			cylinder(r = 3, h = 15, $fn = 30);
			translate([0,0,-10])
			cylinder(r = 1.5, h = 30, $fn = 30);
		}

		// clamp mounting holes
		for(i=[-1, 0, 1])
		{
			rotate([0, 90, 0])
			translate([-10, distance/2+(distance+2)*i, -15])
			union()
			{
				translate([0,0,-1])
				rotate([0,0,30])
				cylinder(r = 2.9, h = 10, $fn = 6);
				translate([0, 0, 9.3])
				cylinder(r = 1.5, h = 30, $fn = 30);
			}
		}

		/*
		// fin holes
		translate([-16, distance/2,  -wireStandHeight + 4])
		rotate([0,90,0])
		#cylinder(r = 1.5, h = 50);
		*/

//		translate([-90,0,10])
//		cube([100, 100, 100]);
	}
}



