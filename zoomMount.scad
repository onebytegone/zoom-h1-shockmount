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
totalWidth = gapWidth+bandAttachArmThickness;
armHeight = gapHalfHeight+bandAttachGap/2+bandAttachClipThickness;

$fn = 40;


translate([-totalWidth/2, -baseThickness]) cube([totalWidth,baseThickness,totalLength]);
translate([totalWidth/2, 0]) wall();
translate([-totalWidth/2, 0]) mirror([1,0]) wall();

module wall() {
	arm();
	translate([0, 0, totalLength-bandAttachArmWidth]) arm();
	difference() {
		translate([-bandAttachArmThickness, 0]) cube([bandAttachArmThickness, armSupportHeight+cornerRadius, totalLength]);
		translate([1,armSupportHeight+cornerRadius,bandAttachArmWidth+cornerRadius]) rotate([0,-90]) cylinder(bandAttachArmThickness+2, cornerRadius, cornerRadius);
		translate([1,armSupportHeight+cornerRadius,totalLength-bandAttachArmWidth-cornerRadius]) rotate([0,-90]) cylinder(bandAttachArmThickness+2, cornerRadius, cornerRadius);
		translate([-bandAttachArmThickness-1,armSupportHeight,bandAttachArmWidth+cornerRadius]) cube([bandAttachArmThickness+2, cornerRadius*2, totalLength-bandAttachArmWidth*2-cornerRadius*2]);
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
