extends Node2D

var curr_scene = ""
var puddle_tops = []
var puddles = []
var scrolling = false
var index = 0
var should_move = true

func _ready():
	curr_scene = get_tree().current_scene.name
	if curr_scene == "Hard":
		should_move = false
	puddle_tops.append($PuddleTop)
	puddles.append($Puddle)
	if curr_scene == "Easy" or curr_scene == "Medium":
		puddle_tops.append($PuddleTop2)
		puddle_tops.append($PuddleTop3)
		puddles.append($Puddle2)
		puddles.append($Puddle3)
		if curr_scene == "Medium":
			puddle_tops.append($PuddleTop4)
			puddle_tops.append($PuddleTop5)
			puddles.append($Puddle4)
			puddles.append($Puddle5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if scrolling == true:
		$Background.scroll_offset.x -= 60 * delta

func flask_throw():
	if should_move:
		index = get_parent().question_number
	puddle_tops[index].stop()
	puddle_tops[index].play("default")

func move_forward():
	scrolling = true
	var tween : Tween = create_tween()
	var new_pos = Vector2(self.position[0] + -1152, 0)
	tween.tween_property(self, "position", new_pos, 2)
	await tween.finished
	scrolling = false

func success():
	if should_move:
		index = get_parent().question_number
	puddles[index].stop()
	puddles[index].play("default")

# Load level functions
func _on_level1Btn_pressed():
	load_level("res://path/to/level1.tscn")

func _on_level2Btn_pressed():
	load_level("res://path/to/level2.tscn")

func _on_level3Btn_pressed():
	load_level("res://path/to/level3.tscn")

func _on_level4Btn_pressed():
	load_level("res://path/to/level4.tscn")

func load_level(scene_path):
	var new_scene = load(scene_path)
	if new_scene:
		get_tree().change_scene_to(new_scene)
	else:
		print("Error loading scene: ", scene_path)
