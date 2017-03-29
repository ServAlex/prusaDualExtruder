include <dualClamp.scad>;


translate([0,-distance/2,43+22])
rotate([0,180,0])
{
	dualClamp();
	#perifery();
}

/*
partFan();
rotate([0,0,180])
partFan();
*/

nozzleRadius = 35;
nozzleHeight = 15;

module partFan()
{
	difference()
	{
		union()
		{
			difference()
			{	
				halfEight(nozzleHeight);
				halfEight(nozzleHeight-2);
			}

			intersection()
			{
				halfEight(nozzleHeight);
				translate([-50,0,0])
				cube([100, 100, 2]);
			}
		}

		translate([0,distance/2, -5])
		for(i = [240:20:360+100])
		{
			rotate([0,0,i+10])
			rotate([90+15,0,0])
			translate([0,0,-(nozzleRadius+nozzleHeight)/2-5])
			#cylinder(r = 2, h = (nozzleRadius+nozzleHeight)/2, $fn=100);
		}
	}
}

module halfEight(rad)
{
	translate([0,distance/2, 0])
	intersection()
	{
		difference()
		{
			translate([0,0,0])
			rotate_extrude(convexity = 10, $fn=20)
			translate([nozzleRadius, 0, 0])
			circle(r = rad, $fn=20);

			translate([0,-distance/2, 0])
			translate([-50, 0, -100])
			cube([100, 100, 100]);

			translate([0,-distance/2, 0])
			translate([-50, -100, -50])
			cube([100, 100, 100]);
		}

		cylinder(r = rad+25, h = rad*0.8);
	}

}

