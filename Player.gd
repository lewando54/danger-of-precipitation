extends CharacterBody2D

var curr_weapon
var curr_weapon_instance
var weapons = ["Basic", "Laser"]

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = get_viewport_rect().size.x / 2
	position.y = get_viewport_rect().size.y / 2
	curr_weapon = load("res://Weapons/"+weapons[0]+"/weapon.tscn")
	curr_weapon_instance = curr_weapon.instantiate()
	add_child(curr_weapon_instance)

var speed = 1200
var acceleration = 10

func _physics_process(delta):
	var target_velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		target_velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		target_velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		target_velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		target_velocity.y -= 1
	target_velocity = target_velocity.normalized() * speed
	velocity = velocity.lerp(target_velocity, acceleration * delta)
	move_and_slide()
	
	if Input.is_action_pressed("shoot"):
		SignalBus.emit_signal("on_player_shoot")
