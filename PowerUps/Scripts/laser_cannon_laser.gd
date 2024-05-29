extends Area2D

const LASER_DAMAGE: int = 20
# Called when the node enters the scene tree for the first time.

func spawn(spawn_coordinates: Vector2):
	global_position = spawn_coordinates
	$ExpiryTimer.start()

func _on_body_entered(body):
	if body.is_in_group("Damageable"):
		body.take_damage(LASER_DAMAGE)

func _on_expiry_timer_timeout():
	queue_free()
