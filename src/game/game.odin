package game

import "../entity_manager"
import "../entity"
import "core:fmt"
import rl "vendor:raylib"
import "core:math/rand"


EntityManager :: entity_manager.EntityManager
Entity :: entity.Entity

assert :: proc (condition : bool, message : string) {
    if !condition {
        panic(message)
    }
}

Game :: struct {
	entity_manager: ^EntityManager,
    player : ^Entity,
    height: i32,
    width: i32,
}


create :: proc(em: ^EntityManager, player : ^Entity, width : i32, height : i32) -> Game {
    return Game{entity_manager = em, player = player, width = width, height = height}
}

init :: proc(g: ^Game) {
	if rl.GetWindowHandle() != nil {
		panic("Should only initialize once")
	}

    rl.SetTargetFPS(60)

    rl.InitWindow(g.width, g.height, "raylib")
}

update :: proc (g: ^Game) {
    entity_manager.update(g.entity_manager)

    if rl.IsMouseButtonPressed(rl.MouseButton.LEFT) {
        pos := rl.GetMousePosition()
        g.player.cTransform.pos.x = pos.x
        g.player.cTransform.pos.y = pos.y
    }

    g.player.cTransform.pos.x += g.player.cTransform.vel.x
    g.player.cTransform.pos.y += g.player.cTransform.vel.y

    if i32(g.player.cTransform.pos.x + 100) > g.width || i32(g.player.cTransform.pos.x) < 0 {
        g.player.cTransform.vel.x = g.player.cTransform.vel.x * -1
    }

    if i32(g.player.cTransform.pos.y + 100) > g.height || i32(g.player.cTransform.pos.y) < 0 {
        g.player.cTransform.vel.y = g.player.cTransform.vel.y * -1
    }

}

draw :: proc (g: ^Game) {

    rl.ClearBackground(rl.BLACK)
    for e in g.entity_manager.entities {
        if e.cTransform == nil {
            continue
        }

        pos := rl.Vector2([2]f32{e.cTransform.pos.x, e.cTransform.pos.y})

        size := rl.Vector2([2]f32{100.0, 100.0})
        rl.DrawRectangleV(pos, size, rl.BLUE)
    }
}

tick :: proc (g: ^Game) {
    update(g)
    rl.BeginDrawing()
    draw(g)
    rl.EndDrawing()
}


should_close :: proc (g: ^Game) -> bool {
    return rl.WindowShouldClose()
}

