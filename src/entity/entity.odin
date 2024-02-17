package entity

import "../component"


Entity :: struct {
	id:         u32,
	active:     bool,
	tag:        string,
	cTransform: ^component.CTransform,
	cShape:     ^component.CShape,
	cInput:     ^component.CInput,
}


new :: proc() -> Entity {
	return(
		Entity {
			id = 0,
			active = true,
			tag = "default",
			cTransform = nil,
			cShape = nil,
			cInput = nil,
		} \
	)
}
