extends CharacterBody2D

var missile_scene = preload("res://PowerUps/rocket_shooter_missile.tscn")
var missile_offset: Vector2 = Vector2(15, 0)

func _ready():
	global_position = get_spawn_coordinates()
	$ShootTimer.start()
	
func get_spawn_coordinates() -> Vector2:
	return get_parent().find_child("RocketShooterSpot").global_position


func _on_shoot_timer_timeout():
	var missile = missile_scene.instantiate()
	get_tree().root.add_child(missile)
	missile.spawn(global_position + missile_offset)
