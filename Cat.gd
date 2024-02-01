extends CharacterBody2D

@export var cat_speed = 300 #pixels/sec
@export var color = "Blue"
@onready var _pm = $PopupMenu #Popup menu
@onready var _sprite = $AnimatedSprite2D #Sprites
var move_to
var _last_mouse_position # variable that saves the last mouse position
var screen_size # saves the screen size
var selected = false # Bool that says if the cat is selected

enum PopupIds {
	test
}


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	move_to = position
	_sprite.animation = "Idle"
	
	#Adds items to the popup menu
	_pm.add_item("Test1", PopupIds.test)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	
	#if the cat is selected the player can right click a place to move the cat there
	if Input.is_action_pressed("Right_Click") and selected:
		selected = false
		move_to = get_global_mouse_position()
	
	cat_movement(delta)
	position = position.clamp(Vector2.ZERO, screen_size)
	#print (direction)

# Called whenever there's an input
func input_event(_viewport, event, _shape_idx):
	#Selects the cat in case the player clicked it
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if selected: selected = false
			else: selected = true

		#Popup menu
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			_last_mouse_position = get_global_mouse_position()
			_pm.popup(Rect2(_last_mouse_position.x, _last_mouse_position.y, _pm.size.x, _pm.size.y))
			

#-------POPUP MENU FUNCTIONS---------

func _on_popup_menu_id_pressed(id):
	match id:
		PopupIds.test:
			print("it works")


func _on_popup_menu_index_pressed(index):
	pass # Replace with function body.


func cat_movement(delta):
	var speed
	
	if position == move_to:
		speed = 0
		_sprite.speed_scale = 1
		_sprite.animation = "Idle"
	else:
		if move_to.x > position.x:
			_sprite.flip_h = false
		else:
			_sprite.flip_h = true
		speed = 75
		_sprite.animation = "Running"
		_sprite.speed_scale = speed/50
		position = position.move_toward(move_to, speed * delta)
