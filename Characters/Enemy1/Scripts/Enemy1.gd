extends CharacterBody2D

signal EnemyDied

const SPEED = -50
var maximum_health: int = 15
var current_health: int = 0
var XP_on_death: int = 5

func _ready():
	current_health = maximum_health
	current_health = clamp(current_health, 0, maximum_health)
	$ExpiryTimer.start()
	
func _physics_process(delta):
	velocity.x = SPEED
	move_and_slide()

func spawn(spawn_coordinates: Vector2):
	global_position = spawn_coordinates

func take_damage(damage_amount: int):
	current_health -= damage_amount
	if current_health <= 0:
		current_health = 0
		is_killed()

func is_killed():
	queue_free()
	AllKnowing.grant_XP(XP_on_death)
	EnemyDied.emit()


func _on_expiry_timer_timeout():
	queue_free()
	EnemyDied.emit()
