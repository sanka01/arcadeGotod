class_name Comida
extends Node2D

const FOOD_SCORE_ONEAT := 9
const FOOD_SCORE_ONLOST := 2
const MAX_WAIT := 5
const MIN_WAIT := 1
@onready var initial_time := randi_range(MIN_WAIT, MAX_WAIT)
@onready var time_left := initial_time
@onready var events = get_node("/root/Events")


func _ready():
	$Area2D.body_entered.connect(func (body: Node2D):
		if body.is_in_group("jogador"):
			events.food_eaten.emit(FOOD_SCORE_ONEAT)
			queue_free()
	)
	$Destroy.timeout.connect(func ():
		events.food_lost.emit(FOOD_SCORE_ONLOST)
		queue_free()
	)
	$Update.timeout.connect(update_counter)
	$TimeLeft.text = str(time_left)
	$Destroy.start(time_left)
	$Update.start()


func update_counter():
	time_left -= 1
	$TimeLeft.text = str(time_left)
