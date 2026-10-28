class_name SpawnComponent
extends Node

func spawn_instance(scene: PackedScene, position: Vector2, parent: Node) -> Node:
	var instance = scene.instantiate()
	instance.global_position = position
	parent.add_child(instance)
	return instance
