extends Area2D

@onready var collision_shape_2d = $CollisionShape2D

func _ready():
	global_position = get_spawn_coordinates()
	
func get_spawn_coordinates() -> Vector2:
	return get_parent().find_child("ShieldSpot").global_position
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func got_hit():
	collision_shape_2d.set_deferred("disabled", true)
	visible = false
	$CooldownTimer.start()


func _on_cooldown_timer_timeout():
	collision_shape_2d.set_deferred("disabled", false)
	visible = true


func _on_area_entered(area):
	got_hit()


func _on_body_entered(body):
	got_hit()

func decrease_cooldown_time():
	if not $CooldownTimer.is_stopped():
		$CooldownTimer.wait_time -= 1
