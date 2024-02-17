package entity_manager

import "../entity"
import "core:fmt"

Entity :: entity.Entity

EntityVec :: [dynamic]^Entity
EntityMap :: map[string]EntityVec

EntityManager :: struct {
    entities: EntityVec,
    entities_to_add: EntityVec,
    entity_map: EntityMap,
    total_entities : u32,
}

add_entity :: proc (em : ^EntityManager, tag : string) -> ^Entity {
    em.total_entities += 1
    e := new(Entity)
    e.id = em.total_entities + 1

    append(&em.entities_to_add, e)

    return e
}


get_entities_by_tag :: proc(em : ^EntityManager, tag : string) -> EntityVec {
    return em.entity_map[tag]
}

get_all_entities :: proc (em : ^EntityManager) -> EntityVec {
    return em.entities
}

get_entities :: proc{get_all_entities, get_entities_by_tag}


update :: proc (em : ^EntityManager) {
    for e in em.entities_to_add {
        append(&em.entities, e)
    }
    em.entities_to_add = nil
}


create :: proc () -> EntityManager {
    return EntityManager {
        entities = nil,
        entities_to_add = nil,
        entity_map = nil,
        total_entities = 0,
    }
}



