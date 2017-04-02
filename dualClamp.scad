use <e3d_v6_all_metall_hotend.scad>;

partNumber = 0;

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

rM3Threaded = 1.49;
rM3Through = 1.75;
rM3Head = 3.1;
rm3Nut = 3.3;

dualClamp();
#perifery();

module perifery()
{
	rotate([0,0,90])
	e3d();
	translate([0, distance, 0])
	rotate([0,0,90])
	e3d();
	translate([fanOffset + fanMountingPlateThickness, distance/2 - fanWidth/2, 20+sinkH-fanWidth])
	cube([fanThickness, fanWidth, fanWidth]);
}

module dualClamp()
{
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
							translate([fanOffset, distance/2 - (fanWidth-3)/2, 20+sinkH-fanWidth])
							cube([fanMountingPlateThickness, fanWidth-3, fanWidth]);

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
/*
				translate([fanOffset+fanMountingPlateThickness-2, distance/2 - (fanWidth)/2, 20+sinkH])
				{
					cube([2, fanWidth, 4]);
					translate([-18, 0, 0])
					cube([20, 2, 4]);
					translate([-18, fanWidth-2, 0])
					cube([20, 2, 4]);
				}
*/

				// part fan mounts
/*
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
						cylinder(r = rM3Through, h = 6, $fn=30);

						translate([0, 5.5 - i*1.5, 17])
						rotate([0, 90, 0])
						translate([0,0,-1])
						cylinder(r = rM3Through, h = 6, $fn=30);

						translate([0, 5.5 - i*1.5, 27.0])
						rotate([0, 90, 0])
						translate([0,0,-1])
						cylinder(r = rM3Through, h = 6, $fn=30);
					}
				}
*/

				// inductive sensor mount
				translate([-2, -distance/2-30, 46-3])
				{
					difference()
					{
						cube([17, 20+9+1, 3]);

						translate([17/2, 6 + 2+1, -1])
						cylinder(r = 6, h = 5, $fn=30);

						translate([17/2, 12 + 2 + 2 + 4 + 1, -1-40])
						cylinder(r = 4, h = 50, $fn=30);
					}
				}

//				fanExtension();
			}

			if(partNumber == 2 || partNumber == 0)
			{
				farClamp();
			}
		}

		
		// proximity sensor cut
		translate([-2, -distance/2-29, 46-3])
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

		// part fan cut
		translate([fanOffset - 10, distance/2 - 14.8, sinkH + 17])
		cube([12, 29.6, 4]);

		// inside air transfet tube
		hull()
		{
			translate([fanOffset, distance/2, 20+sinkH-fanWidth/2])
			rotate([0,90,0])
			cylinder(r = (fanWidth)/2-0.6, h = fanMountingPlateThickness-1, $fn=100);

			translate([sinkR, -sinkR, 22])
			cube([0.01,distance+2*sinkR+2*tolerance, sinkH-4]);
		}

		translate([fanOffset, distance/2, 20+sinkH-fanWidth/2])
		rotate([0,90,0])
		cylinder(r = (fanWidth)/2-0.6, h = fanMountingPlateThickness+1, $fn=100);


		// heatsink cylinder cuts
		translate([0, distance, 20-1])
		cylinder(r=sinkR+tolerance, h=sinkH+2, $fn=100);

		translate([0, 0, 20-1])
		cylinder(r=sinkR+tolerance, h=sinkH+2, $fn=100);

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
				cylinder(r = rM3Head, h = 50, $fn = 30);
				translate([0,0,-40.4+55])
				cylinder(r = rM3Through, h = 15, $fn = 30);
			}
		}
		
		// fan mounting holes
		for(i=[-1,1])
		for(j=[-1,1])
		{
			translate([0, 16*i, 16*j])
			translate([fanOffset-4, distance/2, 20+sinkH-fanWidth/2])
			rotate([0,90,0])
			cylinder(r = rM3Threaded, h = 120, $fn=30);
		}

//		translate([-10,distance/2-100,0])
//		cube([100, 100, 100]);
	}

	// devider wall
	difference()
	{
		hull()
		{
			translate([fanOffset - 12+1, -sinkR, sinkH + 18])
			cube([1, distance+2*sinkR, 1]);

			translate([fanOffset+fanMountingPlateThickness, distance/2 - (fanWidth)/2, 5+sinkH])
			cube([0.1, fanWidth, 2]);
		}
		perifery();
	}

	partFan();
}

module fanExtension()
{
	// fan extension tube
	difference()
	{
		extensionLen = 30;
		union()
		{
			translate([fanOffset+10, distance/2, 20+sinkH-fanWidth/2])
			rotate([0,90,0])
			cylinder(r = (fanWidth)/2-0.6 + 1, h = extensionLen, $fn=100);

			translate([fanOffset+13, distance/2, 20+sinkH-fanWidth/2])
			translate([0, - fanWidth/2 + 3, - fanWidth/2 + 3])
			rotate([0,-90,0])
			minkowski()
			{
				cube([fanWidth-6, fanWidth-6, 3]);
				cylinder(r = 3, h = 0.001);
			}

			translate([fanOffset+10 + extensionLen, distance/2, 20+sinkH-fanWidth/2])
			hull()
			{
				translate([0, - fanWidth/2 + 3, - fanWidth/2 + 3])
				rotate([0,-90,0])
				minkowski()
				{
					cube([fanWidth-6, fanWidth-6, 1]);
					cylinder(r = 3, h = 0.001);
				}

				translate([-10,0,0])
				rotate([0,90,0])
				translate([0,0,-1])
				cylinder(r = (fanWidth)/2-0.6, h = 3, $fn=100);
			}
		}

		translate([fanOffset+10, distance/2, 20+sinkH-fanWidth/2])
		rotate([0,90,0])
		translate([0,0,-1])
		cylinder(r = (fanWidth)/2-0.6, h = extensionLen+2, $fn=100);

		// mountin holes
		for(i=[-1,1])
		for(j=[-1,1])
		{
			translate([0, 16*i, 16*j])
			translate([fanOffset-4, distance/2, 20+sinkH-fanWidth/2])
			rotate([0,90,0])
			cylinder(r = rM3Threaded, h = 120, $fn=30);
		}
	}
}

module partFan()
{
	difference()
	{
		union()
		{
			difference()
			{

				hull()
				{
					translate([fanOffset - 12, distance/2 - 15.5, sinkH + 18 + 0.5])
					cube([16, 31, 1.5]);

					translate([8-1, distance/2 - (fanWidth)/2, sinkH+20+17])
					cube([8, fanWidth, 0.1]);
				}

				hull()
				{
					translate([fanOffset - 12 +2 + 1.5, distance/2 - 15 +1, sinkH + 18 - 2])
					cube([11, 28, 2]);

					translate([8+1 -1, distance/2 - (fanWidth)/2 + 1, sinkH+20+17+0.01])
					cube([6, fanWidth-2, 0.1]);
				}

		//		translate([-10,distance/2-100,0])
		//		cube([100, 100, 100]);
			}

			intersection()
			{
				union()
				{
					wallW = 0.8;

					translate([0, distance/2, 50])
					cube([100, wallW, 100], center=true);

					translate([0, distance/2 + distance/3, 50])
					rotate([-6, 0, 0])
					cube([100, wallW, 100], center=true);

					translate([0, distance/2 - distance/3, 50])
					rotate([+6, 0, 0])
					cube([100, wallW, 100], center=true);
				}

				hull()
				{
					translate([fanOffset - 12, distance/2 - 15, sinkH + 18 + 0.5])
					cube([16, 30, 1.5]);

					translate([8-1, distance/2 - (fanWidth)/2, sinkH+20+17])
					cube([8, fanWidth, 0.1]);
				}
			}
		}

		translate([-35, -50, 8])
		rotate([0, -50, 0])
		cube([100, 150, 100]);
	}
}

module farClamp()
{
	// e3d inner clamp

	difference()
	{
		union()
		{
			translate([-15, -(8+11), 4])
			cube([14, distance+(8+11)*2, 12]);

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

		// carridge mounting holes
		rotate([0, 90, 0])
		translate([-10, distance/2 - mountingHoleOffset, -11])
		union()
		{
			cylinder(r = rM3Head, h = 15, $fn = 30);
			translate([0,0,-10])
			cylinder(r = rM3Through, h = 30, $fn = 30);
		}

		rotate([0, 90, 0])
		translate([-10, distance/2 + mountingHoleOffset, -11])
		union()
		{
			cylinder(r = rM3Head, h = 15, $fn = 30);
			translate([0,0,-10])
			cylinder(r = rM3Through, h = 30, $fn = 30);
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
				cylinder(r = rm3Nut, h = 10, $fn = 6);
				translate([0, 0, 9.3])
				cylinder(r = rM3Through, h = 30, $fn = 30);
			}
		}

		/*
		// fin holes
		translate([-16, distance/2,  -wireStandHeight + 4])
		rotate([0,90,0])
		#cylinder(r = rM3Through, h = 50);
		*/

//		translate([-90,-100+distance/2,-10])
//		cube([100, 100, 100]);
/*
		translate([-10,-50+distance/2,-10])
		cube([100, 100, 100]);

		translate([-20,-50+distance/2,-96])
		cube([100, 100, 100]);

		translate([-20,-50+distance/2, 16])
		cube([100, 100, 100]);
*/
	}
}



