extends RigidBody2D

@export var speed = 800

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	linear_velocity = Vector2.RIGHT.rotated(rotation) * speed
	position += linear_velocity * delta
	
	if position.x >= get_viewport().get_visible_rect().size.x or position.x <= 0 or position.y >= get_viewport().get_visible_rect().size.y or position.y <= 0:
		queue_free()
