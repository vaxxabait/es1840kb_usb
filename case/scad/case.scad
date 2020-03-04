// TODO

///////////////////////////////////////////
// Case

module top_shield() {
	color("WhiteSmoke",0.5) linear_extrude(height = 2)
		import(file = "../dxf/case.dxf",
			layer="top_shield");
}

module bot_shield() {
	color("Gray") linear_extrude(height = 2)
		import(file = "../dxf/case.dxf",
			layer="bot_shield");
}

module case(){
	translate ([0,0,16]) top_shield();
	translate ([0,0,-4]) bot_shield();
}
