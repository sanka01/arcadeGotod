class_name MyEvents
extends Node

signal food_eaten(score)
signal food_lost(score)
signal new_score(score)
signal inc_score(score)
signal dec_score(score)
var score := 0


func _ready():
	inc_score.connect(func (inc: int):
		score += inc
		new_score.emit(score)
	)
	dec_score.connect(func (dec: int):
		var _new_score: int = score - dec
		score = clampi(_new_score, 0, score)
		new_score.emit(score)
	)
	food_eaten.connect(func (score): inc_score.emit(score))
	food_lost.connect(func (score): dec_score.emit(score))
