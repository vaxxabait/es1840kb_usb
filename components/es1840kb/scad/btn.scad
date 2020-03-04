// TODO
//		fix wide left, wide right btn width

///////////////////////////////////////////
// Button caps

// Standard
module btn_cap() {
	difference() {
		polyhedron(
			points = [
				[9.5, 9.5, 0],
				[-9.5, 9.5, 0],
				[-9.5, -9.5, 0],
				[9.5, -9.5, 0],
				[0, 0, 30]
			],
			faces = [
				[0, 1, 2, 3],
				[4, 1, 0],
				[4, 2, 1],
				[4, 3, 2],
				[4, 0, 3]
			]
		);
		translate ([0,0,33]) sphere(30);
	}
}

// Wide left oriented
module btn_cap_wl() {
	btn_cap();
	translate ([-5,0,0]) difference() {
		cube([29,19,2],center = true);
		translate ([-10,0,-2]) cylinder(4,2.5,2.5);
	}
}

// TODO fix width

// Wide right oriented
module btn_cap_wr() {
	btn_cap();
	translate ([5,0,0]) difference() {
		cube([29,19,2],center = true);
		translate ([10,0,-2]) cylinder(4,2.5,2.5);
	}
}

// Space
module btn_cap_space() {
	difference(){
		polyhedron(
			points = [
				[69.5, 9.5, 0],
				[-69.5, 9.5, 0],
				[-69.5, -9.5, 0],
				[69.5, -9.5, 0],
				[60, 0, 30],
				[-60, 0, 30]
			],
			faces = [
				[0, 1, 2, 3],
				[0,3,4],
				[2,1,5],
				[0,4,5,1],
				[2,5,4,3]
			]
		);
		translate ([60,0,33]) sphere(30);
		translate ([-60,0,33]) sphere(30);
		translate ([-60,0,33]) rotate ([0,90,0])
			cylinder(120,30,30);
	}
}



///////////////////////////////////////////
// Buttons

module button() {

	translate ([9.5,9.5,0]){
		color("Red") translate ([0,0,15])
			btn_cap();
		color("Black") translate ([0,0,13])
			cube([12,12,6],center = true);
		color("Green") translate ([0,0,5])
			cube([19,19,10],center = true);
	}
}

module button_wl() {

	translate ([9.5,9.5,0]){
		color("Red") translate ([0,0,15])
			btn_cap_wl();
		color("Black") translate ([0,0,13])
			cube([12,12,6],center = true);
		color("Green") translate ([0,0,5])
			cube([19,19,10],center = true);
	}
}

module button_wr() {

	translate ([9.5,9.5,0]){
		color("Red") translate ([0,0,15])
			btn_cap_wr();
		color("Black") translate ([0,0,13])
			cube([12,12,6],center = true);
		color("Green") translate ([0,0,5])
			cube([19,19,10],center = true);
	}
}

module button_space() {

	translate ([9.5,9.5,0]){
		color("Red") translate ([0,0,15])
			btn_cap_space();
		color("Black") translate ([0,0,13])
			cube([12,12,6],center = true);
		color("Green") translate ([0,0,5])
			cube([19,19,10],center = true);
	}
}
