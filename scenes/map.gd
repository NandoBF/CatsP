extends Node2D


var building_menu = false
var screen_size
var menusize = 200
# Called when the node enters the scene tree for the first time.
func _ready():
	print("YOU CANNOT MOVE THE CATS WHILE BUILDING MENU IS OPEN")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventKey:
		if Input.is_key_pressed(KEY_ESCAPE):
			get_tree().quit()
