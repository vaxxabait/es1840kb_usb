// TODO
//		add 2 holes in pcb beetwen fn/num and main

//		add main components on top
//		add protection box on bottom

//		stitch scans
//		use scans as texture for PCB


// Button lib
use <btn.scad>

///////////////////////////////////////////
// Keys

module es1840kb_keys() {
	// Fn block
 	for(j=[0:1]){
		for(i=[0:4]){
			translate ([7+j*20,18+i*20,0])
				button();
		}
	}

	// Line 1 - digits
	for(i=[0:14]){
		translate ([65+i*20,98,0])
			button();
	}

	// Line 2 - letters
	for(i=[0:14]){
		translate ([71+i*20,78,0])
			button();
	}

	// Line 3 - letters
	for(i=[0:14]){
		translate ([76+i*20,58,0])
			button();
	}

	// Line 4 - letters
	for(i=[0:15]){
		translate ([60+i*20,38,0])
			button();
	}

	// Line 5 - space and controls
	translate ([100,18,0]) button_wl();
	translate ([120,18,0]) button();
	translate ([140,18,0]) button();
	translate ([220,18,0]) button_space();
	translate ([300,18,0]) button();
	translate ([320,18,0]) button_wr();

	// Num block
	translate ([391,98,0]) button_wl();
	for(i=[0:3]){
		translate ([391,18+i*20,0])
			button();
	}
 	for(j=[0:1]){
		for(i=[0:4]){
			translate ([411+j*20,18+i*20,0])
				button();
		}
	}

}



///////////////////////////////////////////
// Keyboard

module es1840kb_pcb() {
	linear_extrude(height = 2)
		import(file = "../dxf/es1840kb.dxf",
			layer="pcb");
}

module es1840kb() {
	translate ([0,0,2]) es1840kb_keys();
	es1840kb_pcb();
}

es1840kb();