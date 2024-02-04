extends Node2D

@onready var _pm = $BuildingMenu

var building_menu = false
var screen_size
var menusize = 200
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = self.get_viewport_rect().size
	_pm.popup(Rect2(0, screen_size.y - menusize,menusize,menusize))
	_pm.visible = building_menu


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	#passar para map
	if event is InputEventKey:
		if Input.is_key_pressed(KEY_B):
			building_menu = not building_menu
			_pm.visible = building_menu
			#_menu_bar.set_menu_disabled(0,not _menu_bar.is_menu_disabled(0))
			
	if event is InputEventMouse and building_menu:
		get_viewport().set_input_as_handled()

