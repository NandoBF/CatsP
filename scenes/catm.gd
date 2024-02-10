extends CharacterBody2D


@export var stats: Resource

@onready var tile_map = $"../../../NavigationRegion2D/TileMap"
@onready var _pm = $PopupMenu #Popup menu
@onready var _nav_agent = $NavigationAgent2D
@onready var _sprite = $AnimatedSprite2D #Sprites
@onready var _cam = $"../../../Player/CameraWorld"
@onready var _CMenu = $"../CMenu"

var finished
var speed
var move_to
var screen_size # saves the screen size
var selected # Bool that says if the cat is selected

enum PopupIds {
	colorOrange
}


func _ready():
	#self.position = Vector2(100,100)
	speed = stats.moving_speed
	selected = false
	finished = true
	get_node("Timer").start()
	screen_size = get_viewport_rect().size
	move_to = position
	_sprite.play("Idle" + stats.color)
	
	#Adds items to the popup menu
	_pm.add_item("Orange", PopupIds.colorOrange)
	
	
func _physics_process(delta):
	var dir
	#print (tile_map.local_to_map(get_global_mouse_position()))
	if selected: #Fazer menu nova cena
		_CMenu.scale = Vector2(1,1) / _cam.zoom
		_CMenu.position = Vector2(_cam.get_screen_center_position().x + (_cam.get_viewport_rect().size.x / 2)/_cam.zoom.x,_cam.get_screen_center_position().y - (_cam.get_viewport_rect().size.y / 2)/_cam.zoom.y)
		get_node("../CMenu/Panel/AnimatedSprite2D2").animation = _sprite.animation
		_CMenu.visible = true
	else:
		_CMenu.visible = false

	if Input.is_action_pressed("Right_Click") and selected:
		finished = false
		selected = false
		move_to = tile_map.map_to_local(tile_map.local_to_map(get_global_mouse_position()))
		
		
	if not finished and _nav_agent.is_target_reachable():
		dir = (_nav_agent.get_next_path_position() - self.get_global_position()).normalized()
		self.translate(dir * delta * speed)
		if dir.x > 0: _sprite.flip_h = false
		else: _sprite.flip_h = true
		_sprite.play("Running" + stats.color)
		_sprite.speed_scale = speed/50
	else:
		move_to = position
		_sprite.speed_scale = 1
		_sprite.play("Idle" + stats.color)
		
	
	#if self.position.distance_to(move_to) < 1:
		#finished = true
		
	# -- for gravity ---
	#if not is_on_floor():
		#velocity.y = 350
		#move_and_slide()
	# ---------
	self.position = self.position.clamp(Vector2.ZERO, screen_size)
	
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		selected = false

func input_event(_viewport, event, shape_idx):
	#Selects the cat in case the player clicked it
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if selected: 
				selected = false
			else: 
				finished = false
				selected = true

		#Popup menu
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			_pm.popup(Rect2(self.position.x, self.position.y, _pm.size.x, _pm.size.y))
			

func makepath() -> void:
	_nav_agent.target_position = move_to

func _on_timer_timeout():
	makepath()
	
	
func _on_navigation_agent_2d_navigation_finished():
	if not selected:
		finished = true

#-------POPUP MENU FUNCTIONS---------

func _on_popup_menu_id_pressed(id):
	match id:
		PopupIds.colorOrange:
			stats.color = "Orange"


func _on_popup_menu_index_pressed(index):
	pass # Replace with function body.





