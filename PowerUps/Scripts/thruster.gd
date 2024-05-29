extends CharacterBody2D


const SPEED_BOOST: float = 2000
const ACCELERATION: float = 500
const DECELERATION: float = 70

func _ready():
	global_position = get_spawn_coordinates()
	
func get_spawn_coordinates() -> Vector2:
	return get_parent().find_child("ThrusterSpot").global_position

func boost():
	print("Thruster: We starting boost now")
	var player_velocityX = get_parent().velocity.x

	if $CooldownTimer.is_stopped():
		print("Thruster: Thruster GOOOO")
		#get_parent().global_position.x = move_toward(get_parent().global_position.x, get_parent().global_position.x * 2, ACCELERATION*get_physics_process_delta_time())
		#$AnimationPlayer.play("Boost")
		$BoostTimer.start()
	else:
		return

func _on_boost_timer_timeout():
	var player_velocityX = get_parent().velocity.x
	player_velocityX = move_toward(SPEED_BOOST, player_velocityX, DECELERATION)
	$CooldownTimer.start()
