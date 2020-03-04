// TODO

///////////////////////////////////////////
// Final view

use <case.scad>
use <ctrl_board.scad>
use <../../components/es1840kb/scad/es1840kb.scad>

module top() {
	es1840kb();
	translate ([0,0,12]) ctrl();
	case();
}

top();