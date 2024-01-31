extends CharacterBody2D

@export var cat_speed = 300 #pixels/sec
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("clickedOn"):
		velocity.x += 100
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
		
