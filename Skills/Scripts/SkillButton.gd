extends TextureButton

class_name SkillNode

@onready var panel = $Panel
@onready var label = $MarginContainer/Label
@onready var line_2d = $Line2D

var level: int = 0
@export var max_level: int
@export var skill_name: String
# Called when the node enters the scene tree for the first time.


func _ready():
	panel.show_behind_parent = false
	label.text = str(level) + "/" + str(max_level)
	if get_parent() is SkillNode:
		line_2d.add_point(global_position + size/2)
		line_2d.add_point(get_parent().global_position + size/2)
	
	print(get_children())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	if AllKnowing.available_skill_points >= 1:
		if level < max_level:
			AllKnowing.available_skill_points -= 1
			level = min(level+1, max_level)
			label.text = str(level) + "/" + str(max_level)
			panel.show_behind_parent = true
			line_2d.default_color = Color(1, 1, 0.85)
			AllKnowing.update_skill_tree(skill_name, level)
		unlock_next_tree()
		
		

func unlock_next_tree():
	var skills = get_children()
	for skill in skills:
		if skill is SkillNode and level == max_level:
			#enable the button itself
			#print("SKillButton: Now we gonna enable skill")
			skill.disabled = false
