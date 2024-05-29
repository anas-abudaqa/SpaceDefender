extends Area2D

const CONTACT_DAMAGE: int = 10

func _on_body_entered(body):
	if body.is_in_group("Player"):
		print("Player gonna take some damage")
		body.take_damage(CONTACT_DAMAGE)

#func _ready():
	#print("Rock position is: ", global_position)
