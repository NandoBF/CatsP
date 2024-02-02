extends CharacterBody2D


@export var color = "DarkBlue"

@onready var _pm = $PopupMenu #Popup menu
@onready var _nav_agent = $NavigationAgent2D
@onready var _sprite = $AnimatedSprite2D #Sprites

var speed = 75
var move_to
var screen_size # saves the screen size
var selected = false # Bool that says if the cat is selected

enum PopupIds {
	colorOrange
}


func _ready():
	screen_size = get_viewport_rect().size
	move_to = Vector2(490,200)
	_sprite.play("Idle" + color)
	
	#Adds items to the popup menu
	_pm.add_item("Orange", PopupIds.colorOrange)
	
	
func _physics_process(_delta: float) -> void:
	var dir
	if Input.is_action_pressed("Right_Click") and selected:
		selected = false
		move_to = get_global_mouse_position()
	#dir = self.position.direction_to(move_to) 
	dir = (_nav_agent.get_next_path_position() - global_position).normalized()
	if self.position.distance_to(move_to) < 1:
		get_node("Timer").stop()
		_sprite.speed_scale = 1
		_sprite.play("Idle" + color)
		velocity = Vector2.ZERO
	else: 
		velocity = dir * speed
		if dir.x > 0: _sprite.flip_h = false
		else: _sprite.flip_h = true
		_sprite.play("Running" + color)
		_sprite.speed_scale = speed/50
	move_and_slide()
	print (_nav_agent.get_next_path_position())

func input_event(_viewport, event, _shape_idx):
	var _last_mouse_position # variable that saves the last mouse position
	
	#Selects the cat in case the player clicked it
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if selected: selected = false
			else: selected = true

		#Popup menu
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			_last_mouse_position = get_global_mouse_position()
			_pm.popup(Rect2(_last_mouse_position.x, _last_mouse_position.y, _pm.size.x, _pm.size.y))
			

func makepath() -> void:
	_nav_agent.target_position = move_to

func _on_timer_timeout():
	makepath()

#-------POPUP MENU FUNCTIONS---------

func _on_popup_menu_id_pressed(id):
	match id:
		PopupIds.colorOrange:
			color = "Orange"


func _on_popup_menu_index_pressed(index):
	pass # Replace with function body.

