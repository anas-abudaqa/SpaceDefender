extends Area2D

var bullet_damage: int = 4
const BULLET_SPEED: int = 700

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	global_position.x += BULLET_SPEED*delta

func spawn(spawn_coordinates: Vector2, shot_damage_modifier: int):
	global_position = spawn_coordinates
	bullet_damage += shot_damage_modifier
	$ExpiryTimer.start()

func _on_body_entered(body):
	if body.is_in_group("Damageable"):
		body.take_damage(bullet_damage)
	queue_free()


func _on_expiry_timer_timeout():
	queue_free()
