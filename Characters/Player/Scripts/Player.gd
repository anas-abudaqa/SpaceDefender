extends CharacterBody2D

signal Player_Died

const CRUISE_SPEED: float = 125.0
const BACKWARD_SPEED: float = 250
const FORWARD_SPEED: float = 350
const VERTICAL_SPEED: float = 350
const DECELERATION: float = 50
const SPLITLASER_PATH: String = "res://PowerUps/player_split_laser.tscn"
const DOUBLELASER_PATH: String = "res://PowerUps/player_double_laser.tscn"
const REGSHIELD_PATH: String = "res://Skills/reg_shield.tscn"

var maximum_health: int = 50
var current_health: int = 0
var shot_modifier: int = 0
var shot_damage_modifier: int = 0
var direction_vector: Vector2
var animation_playback

var laser1_scene = preload("res://Characters/Player/player_laser_1.tscn")
var splitlaser_scene = preload(SPLITLASER_PATH)
var doublelaser_scene = preload(DOUBLELASER_PATH)

func _ready():
	update_skills()
	$HealthAndShieldNode.set_health(maximum_health)
	print($HealthAndShieldNode.current_health)
	animation_playback = $AnimationTree.get("parameters/playback")

	for powerUp_path in AllKnowing.unlocked_powerups:
		var powerUp_scene = load(powerUp_path)
		var powerUp = powerUp_scene.instantiate()
		add_child(powerUp)
		
	
	#$AnimationTree.set("Parameter/Move/blend_position", direction_vector)

func _physics_process(delta):
	velocity.x = CRUISE_SPEED * delta
	
	direction_vector.x = Input.get_axis("Left", "Right")
	direction_vector.y = Input.get_axis("Up", "Down")

	if direction_vector.x == +1:
		velocity.x = direction_vector.x * FORWARD_SPEED
	elif direction_vector.x == -1:
		velocity.x = direction_vector.x * BACKWARD_SPEED
	else:
		velocity.x = move_toward(velocity.x, CRUISE_SPEED, DECELERATION)
		
	if direction_vector.y == +1:
		velocity.y = direction_vector.y * VERTICAL_SPEED
	elif direction_vector.y == -1:
		velocity.y = direction_vector.y * VERTICAL_SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, DECELERATION)
	
		
	$AnimationTree.set("parameters/Move/blend_position", direction_vector)
	move_and_slide()

func _input(event):
	if event.is_action_pressed("Shoot"):
		shoot_projectile()
	if event.is_action_pressed("Thrust"):
		var thruster_node = get_node("Thruster")
		print("Player: This is our thruster node: ", thruster_node)
		if thruster_node != null:
			thruster_node.boost()
		else:
			return
			
			
func take_damage(damage_value):
	$HealthAndShieldNode.deal_damage(damage_value)
	print("Player: Ouchie")
	animation_playback.travel("Damaged")
	$PhysicsBox.set_deferred("disabled", true)
	$InvincibilityTimer.start()

func shoot_projectile():
	if shot_modifier == 0:
		var projectile = laser1_scene.instantiate()
		## Add it to the root scene of the current scene tree
		get_tree().root.add_child(projectile)
		##call start function and feed it spawn position. Adjusted for player height
		projectile.spawn(global_position + Vector2(40 + 27, 0), shot_damage_modifier)
	
	if shot_modifier == 1:
		var rotation_offset = 40
		var shot_counter = 3
		for shot in shot_counter:
			var projectile = splitlaser_scene.instantiate()
			get_tree().root.add_child(projectile)
			##call start function and feed it spawn position. Adjusted for player width
			projectile.spawn(global_position + Vector2(40 + 27, 0), rotation_offset, shot_damage_modifier)
			rotation_offset -= 40
	
	if shot_modifier == 2:
		var shot_counter = 2
		var y_offset = 7
		for shot in shot_counter:
			var projectile = doublelaser_scene.instantiate()
			get_tree().root.add_child(projectile)
			projectile.spawn(global_position + Vector2(40+27, y_offset), shot_damage_modifier)
			y_offset *= -1
	
func unlock_powerUp(powerUp_path):
	if powerUp_path == SPLITLASER_PATH:
		shot_modifier = 1
	elif powerUp_path == DOUBLELASER_PATH:
		shot_modifier = 2
	else:
		var powerUp_scene = load(powerUp_path)
		var powerUp = powerUp_scene.instantiate()
		add_child(powerUp)

func _on_health_and_shield_node_health_changed(curr_health, _max_health):
	current_health = curr_health
	print("Player: current health is now: ", current_health)

func _on_health_and_shield_node_has_died():
	if AllKnowing.player_lives_left <= 0:
		player_died()
	else:
		AllKnowing.player_lives_left -= 1

func player_died():
	queue_free()
	AllKnowing.add_to_death_counter()
	Player_Died.emit()

func _on_invincibility_timer_timeout():
	$PhysicsBox.set_deferred("disabled", false)


func update_skills():
	var skill_dictionary = AllKnowing.skill_tree_dictionary
	var skill_dictionary_keys = skill_dictionary.keys()
	for skill_name in skill_dictionary_keys:
		match skill_name:
			"HP+": 
				maximum_health += skill_dictionary.get(skill_name) * 10
			"Life+":
				AllKnowing.player_lives_left = skill_dictionary.get(skill_name)
			"DMG+":
				shot_damage_modifier = skill_dictionary.get(skill_name)
			"AutoRepair":
				unlock_autorepair()
			"RegShield":
				unlock_shield()
			"ChrgShot":
				unlock_charge_shot()
			"Absorber":
				unlock_absorber()


func unlock_shield():
	var shield_scene = load(REGSHIELD_PATH)
	var shield = shield_scene.instantiate()
	get_tree().root.add_child(shield)
	
func unlock_charge_shot():
	pass

func unlock_autorepair():
	pass
	
func unlock_absorber():
	pass
