class_name SpawnComponent
extends Node

func spawn_instance(scene: PackedScene, parent: Node) -> Node:
	var instance = scene.instantiate()
	parent.add_child(instance)
	return instance
