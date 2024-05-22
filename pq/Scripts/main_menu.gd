extends Node

var music_playing = true
var background_music: AudioStreamPlayer2D
var masterVolume = 1
var musicVolume = 1
var sfxVolume = 1
@onready var button_order = ["mapMenu/map-title/OptionButton/level1Btn", "mapMenu/map/level2Btn", "mapMenu/map/level3Btn"]

func _ready():
	background_music = $"background-music"
	background_music.play()
	congrats()

func _process(delta):
	$background.scroll_offset.x -= 60 * delta

# --------------------------------------------------------------
# Main Menu code
# --------------------------------------------------------------

# Start Button - Go to the Map
func _on_mainstart_btn_pressed():
	$"sound-effect".play()
	$mapMenu.visible = true
	$mainMenu.visible = false
	$optionMenu.visible = false
	$descMenu.visible = false
	for x in range(button_order.size()):
		if Global.pq_progress[x]:
			get_node(button_order[x]).add_theme_color_override("font_color", "Green")

# Options Button - Go to the option
func _on_mainoption_btn_pressed():
	$"sound-effect".play()
	$mapMenu.visible = false
	$mainMenu.visible = false
	$optionMenu.visible = true
	$descMenu.visible = false

# Description Button - Go to the description
func _on_maindesc_btn_pressed():
	$"sound-effect".play()
	$mapMenu.visible = false
	$mainMenu.visible = false
	$optionMenu.visible = false
	$descMenu.visible = true

# Complete Game
func _complete_game():
	$"sound-effect".play()
	$mapMenu.visible = false
	$mainMenu.visible = false
	$optionMenu.visible = false
	$descMenu.visible = true
	$"descMenu/desc/desc-title".hide()
	$"descMenu/desc/desc-content".hide()

# Congrats
func congrats():
	for lvl in Global.pq_progress:
		if not lvl:
			return
	$finishMenu/confetti.play()
	$finishMenu/confetti2.play()
	$finishMenu/dolphin.play()
	$finishMenu.show()

# --------------------------------------------------------------
# Options code
# --------------------------------------------------------------

# Back Button: Go back to the main menu
func _on_optionback_btn_pressed():
	$"sound-effect".play()
	$mapMenu.visible = false
	$mainMenu.visible = true
	$optionMenu.visible = false
	$descMenu.visible = false

# Volume setup
func volume(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))

# Master slider
func _on_master_value_changed(value):
	volume(0, value)
	masterVolume = value

# Music slider
func _on_music_value_changed(value):
	volume(1, value)
	musicVolume = value

# Sound fx slider
func _on_sfx_value_changed(value):
	volume(2, value)
	sfxVolume = value

# Master mute button
func _on_optionmaster_box_toggled(toggled_on):
	if toggled_on:
		volume(0, 0)
	else:
		volume(0, masterVolume)

# Music mute button
func _on_optionmusic_box_toggled(toggled_on):
	if toggled_on:
		volume(1, 0)
	else:
		volume(1, musicVolume)

# Sound effect mute button
func _on_optionsfx_box_toggled(toggled_on):
	if toggled_on:
		volume(2, 0)
	else:
		volume(2, sfxVolume)

# --------------------------------------------------------------
# Map code
# --------------------------------------------------------------

# Switch scene
func _on_mapbtn_pressed(level):
	$"sound-effect".play()
	$mapMenu.visible = false
	$mainMenu.visible = false
	$optionMenu.visible = false
	$descMenu.visible = false
	get_tree().change_scene_to_file("res://pq/" + level + ".tscn")

# Back Button: Go back to the main menu
func _on_mapback_btn_pressed():
	$"sound-effect".play()
	$mapMenu.visible = false
	$mainMenu.visible = true
	$optionMenu.visible = false
	$descMenu.visible = false

# OptionButton item selected handler
func _on_option_button_item_selected(index):
	match index:
		0:
			load_level("res://path/to/level1.tscn")
		1:
			load_level("res://path/to/level2.tscn")
		2:
			load_level("res://path/to/level3.tscn")

func load_level(scene_path):
	var new_scene = load(scene_path)
	if new_scene:
		get_tree().change_scene_to(new_scene)
	else:
		print("Error loading scene: ", scene_path)
