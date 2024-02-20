extends Node2D

var age_amount_on_timeout = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Age_Progress").start()
	get_node("Character_Update").start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	for ageing_component in get_tree().get_nodes_in_group(AgeingComponent.group_name):
		if (ageing_component is AgeingComponent):
			ageing_component.current_age += age_amount_on_timeout
			#print("age added")
		else: 
			push_error(ageing_component.name + " node is not an ageing component")
