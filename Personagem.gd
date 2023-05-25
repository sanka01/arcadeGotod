extends CharacterBody2D

const SPEED = 300.0
var direction = Vector2.ZERO

func _physics_process(_delta):
	move_and_slide()


func _input(event):
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
