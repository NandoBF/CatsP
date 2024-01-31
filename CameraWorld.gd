extends Camera2D

@onready var cam = get_node (".")
var initial_Position
var screen_size
var screen_position
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_position = get_viewport_rect().position
	screen_size = get_viewport_rect().size
	cam.limit_top = screen_position.y
	cam.limit_bottom = screen_position.y + screen_size.y
	cam.limit_left = screen_position.x 
	cam.limit_right = screen_size.x
	initial_Position = cam.position
	cam.zoom.x = 1
	cam.zoom.y = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	input()
	handlePosition()
#detects scroll wheel inputs to zoom the camera
func input():
	if Input.is_action_just_pressed("ScrollUp") && cam.zoom.x < 4:
		cam.position = get_global_mouse_position()
		cam.zoom.x = cam.zoom.x + 0.2
		cam.zoom.y = cam.zoom.y + 0.2
	if Input.is_action_just_pressed("ScrollDown") && cam.zoom.x > 1:
		cam.zoom.x = cam.zoom.x - 0.2
		cam.zoom.y = cam.zoom.y - 0.2
#returns the position of the camera to the origial when completely zoomed out
func handlePosition():
	if cam.zoom.x == 1:
		cam.position = initial_Position
