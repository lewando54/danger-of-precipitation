extends Node2D

var scale_y
var m_scale_y

# Called when the node enters the scene tree for the first time.
func _ready():
	scale_y = $AnimatedSprite2D.scale.y
	m_scale_y = -scale_y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(get_global_mouse_position())
	
	var degrees = abs(rotation_degrees)
	degrees = int(degrees) % 360

	var rotate_in_y = 1
	if degrees > 90 and degrees < 270:
		$AnimatedSprite2D.scale.y = m_scale_y
	else:
		$AnimatedSprite2D.scale.y = scale_y

