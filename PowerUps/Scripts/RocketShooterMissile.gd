extends Area2D

const BULLET_DAMAGE: int = 10
const BULLET_SPEED: int = 600

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	global_position.x += BULLET_SPEED*delta

func spawn(spawn_coordinates: Vector2):
	global_position = spawn_coordinates
	$ExpiryTimer.start()

func _on_body_entered(body):
	if body.is_in_group("Damageable"):
		body.take_damage(BULLET_DAMAGE)
	queue_free()

func _on_expiry_timer_timeout():
	queue_free()
