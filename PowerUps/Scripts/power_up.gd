extends Area2D

signal PowerUpPickedUp(powerUp_ID)

const SPEED: int = 150

var powerUp_ID: int
var number_of_available_powerUps: int = 6

func spawn(spawn_coordinates: Vector2):
	global_position = spawn_coordinates

# Called when the node enters the scene tree for the first time.
func _ready():
	powerUp_ID = choose_powerUp_ID()
	print("PowerUp: I am alive with powerUp ID ", powerUp_ID)
	
#move it at same rate as camera so it stays in middle of screen
func _physics_process(delta):
	global_position.x  += SPEED * delta

##Choose random powerUp 
func choose_powerUp_ID() -> int: 
	return randi_range(1, number_of_available_powerUps)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		print("PowerUp: Player is picking us up right now yo")
		PowerUpPickedUp.emit(powerUp_ID)
		queue_free()
