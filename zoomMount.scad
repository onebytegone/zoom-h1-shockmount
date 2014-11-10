include <CornerCutout.scad>

gapWidth = 45;
gapHalfHeight = 20;

bandAttachGap = 4;
bandAttachClipLength = 6;
bandAttachClipThickness = 4;
bandAttachArmThickness = 4;
bandAttachArmWidth = 5;
bandAttachArmGap = 25;

baseThickness = 4;
armSupportHeight = gapHalfHeight-bandAttachGap/2-bandAttachClipThickness;

cornerRadius = 3;

supportThickness = 0.2;


mountHoleSize = 6;
mountHoleDepth = 6;

totalLength = bandAttachArmWidth*2+bandAttachArmGap;
totalWidth = gapWidth+bandAttachArmThickness*2;
armHeight = gapHalfHeight+bandAttachGap/2+bandAttachClipThickness;

$fn = 40;


difference() {
	union() {
		base();
		translate([totalWidth/2, 0]) wall();
		translate([-totalWidth/2, 0]) mirror([1,0]) wall();
	}
	
	translate([-totalWidth/2,-baseThickness]) CornerCutout(0, totalLength, cornerRadius);
	translate([totalWidth/2,-baseThickness]) CornerCutout(1, totalLength, cornerRadius);
}


module base() {
	difference() {
		translate([-totalWidth/2, -baseThickness]) cube([totalWidth,baseThickness+cornerRadius,totalLength]);
		rotate([0,-90,-90]) RoundedTop(gapWidth, totalLength, cornerRadius);
	}
}

module wall() {
	arm();
	translate([0, 0, totalLength-bandAttachArmWidth]) arm();
	difference() {
		translate([-bandAttachArmThickness, 0]) cube([bandAttachArmThickness, armSupportHeight+cornerRadius, totalLength]);
		
		translate([0,armSupportHeight,totalLength/2]) rotate([90,0,180]) RoundedTop(totalLength-bandAttachArmWidth*2, bandAttachArmThickness, cornerRadius);
	}
}

module arm() {
	difference() {
		union() {
			translate([-bandAttachArmThickness, 0]) cube([bandAttachArmThickness, armHeight, bandAttachArmWidth]);
			translate([-1,armHeight-bandAttachClipThickness]) cube([bandAttachClipLength+1, bandAttachClipThickness, bandAttachArmWidth]);
			translate([-1,armHeight-bandAttachClipThickness*2-bandAttachGap]) cube([bandAttachClipLength+1, bandAttachClipThickness, bandAttachArmWidth]);
		}
	
		translate([-bandAttachArmThickness, armHeight]) CornerCutout(3, bandAttachArmWidth, cornerRadius);
	}
}


module RoundedTop(outsideLength = 10, width = 2, radius = 3, extra = 1) {
	translate([-extra,outsideLength/2-radius, radius]) rotate([0,90]) cylinder(width+extra*2, cornerRadius, cornerRadius);
	translate([-extra,-outsideLength/2+radius, radius]) rotate([0,90]) cylinder(width+extra*2, cornerRadius, cornerRadius);
	translate([-extra,-outsideLength/2+cornerRadius]) cube([width+extra*2, outsideLength-cornerRadius*2, cornerRadius*2]);
}
