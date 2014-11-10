gapWidth = 45;
gapHalfHeight = 20;

bandAttachGap = 4;
bandAttachClipLength = 6;
bandAttachClipThickness = 4;
bandAttachArmThickness = 4;
bandAttachArmWidth = 5;
bandAttachArmGap = 25;

baseThickness = 4;
armSupportHeight = gapHalfHeight-bandAttachGap/2;

supportThickness = 0.2;

mountHoleSize = 6;
mountHoleDepth = 6;

totalLength = bandAttachArmWidth*2+bandAttachArmGap;
totalWidth = gapWidth+bandAttachArmThickness;
armHeight = gapHalfHeight+bandAttachGap/2+bandAttachClipLength;


translate([-totalWidth/2, -baseThickness]) cube([totalWidth,baseThickness,totalLength]);
translate([totalWidth/2, 0]) wall();
translate([-totalWidth/2, 0]) mirror([1,0]) wall();

module wall() {
	arm();
	translate([0, 0, totalLength-bandAttachArmWidth]) arm();
}

module arm() {
	translate([-bandAttachArmThickness, 0]) cube([bandAttachArmThickness, armHeight, bandAttachArmWidth]);
	translate([-1,armHeight-bandAttachClipThickness]) cube([bandAttachClipLength+1, bandAttachClipThickness, bandAttachArmWidth]);
	translate([-1,armHeight-bandAttachClipThickness*2-bandAttachGap]) cube([bandAttachClipLength+1, bandAttachClipThickness, bandAttachArmWidth]);
}