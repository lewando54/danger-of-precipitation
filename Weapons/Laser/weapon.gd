extends Node2D

var scale_y
var m_scale_y
@export var bullet_speed = 1
@export var shoot_speed = 1.0
@export var ammo_capacity = 10
@export var reload_speed = 1.0
@export var bullet : PackedScene
@export var bullet_spawners: Array[Marker2D]

var can_shoot = true
var timer := Timer.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.on_player_shoot.connect(_on_player_shot)
	scale_y = $AnimatedSprite2D.scale.y
	m_scale_y = -scale_y
	add_child(timer)
	timer.wait_time = shoot_speed
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)


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

func _on_player_shot():
	if can_shoot:
		for spawner in bullet_spawners:
			var bullet_instance = bullet.instantiate()
			bullet_instance.global_transform = spawner.global_transform
			get_tree().root.add_child(bullet_instance)
		can_shoot = false
		
	if timer.is_stopped():
		timer.start()
	
func _on_timer_timeout():
	can_shoot = true
