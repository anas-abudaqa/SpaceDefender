extends Area2D


const BULLET_XSPEED: int = 600
const BULLET_YSPEED: int = 500

var bullet_angle: float
var bullet_damage: int = 5

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	move_projectile(delta)

func spawn(spawn_coordinates: Vector2, spawn_rotation: float, shot_damage_modifier: int):
	global_position = spawn_coordinates
	rotation_degrees = spawn_rotation
	bullet_angle = rotation_degrees
	bullet_damage += shot_damage_modifier
	$ExpiryTimer.start()

func move_projectile(delta):
	#diagonal right up
	if rotation_degrees == 40:
		global_position.x += BULLET_XSPEED*delta
		global_position.y += BULLET_YSPEED*delta
	#diagonal right down
	elif rotation_degrees == -40:
		global_position.x += BULLET_XSPEED*delta
		global_position.y -= BULLET_YSPEED*delta
	elif rotation_degrees == 0:
		global_position.x += BULLET_XSPEED*delta
	
func _on_body_entered(body):
	if body.is_in_group("Damageable"):
		body.take_damage(bullet_damage)
	queue_free()

func _on_expiry_timer_timeout():
	queue_free()
