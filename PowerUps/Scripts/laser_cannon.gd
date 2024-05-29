extends CharacterBody2D

const LASER_OFFSET = Vector2(1190, 0)

var laser_scene = preload("res://PowerUps/laser_cannon_laser.tscn")

func _ready():
	global_position = get_spawn_coordinates()
	$CooldownTimer.start()
	
func get_spawn_coordinates() -> Vector2:
	return get_parent().find_child("LaserCannonSpot").global_position


func _on_cooldown_timer_timeout():
	var laser = laser_scene.instantiate()
	add_child(laser)
	laser.spawn(global_position + LASER_OFFSET)
	$CooldownTimer.start()

func decrease_cooldown_time():
	if not $CooldownTimer.is_stopped():
		$CooldownTimer.wait_time -= 1
