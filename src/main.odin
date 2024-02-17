package main

import "./entity_manager"
import "./game"
import "./component"
import rl "vendor:raylib"
import "core:fmt"

main :: proc() {


	em := entity_manager.create()

	player := entity_manager.add_entity(&em, "player")
    player.cTransform = &component.CTransform{
        pos = rl.Vector2{200.0, 100.0},
        vel = rl.Vector2{4.0, 4.0},
    }

	g := game.create(&em, player, 800, 600)
	game.init(&g)

	for !game.should_close(&g) {
		game.tick(&g)
	}


}
