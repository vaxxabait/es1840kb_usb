// TODO
//		draw and add additional PCB with ctrl


///////////////////////////////////////////
// Controller

module ctrl_pcb() {
	linear_extrude(height = 2)
		import(file = "../dxf/case.dxf",
			layer="ctrl_brd_shape");
}

module ctrl() {
	ctrl_pcb();
}
