extends RichTextLabel

@onready var events = get_node("/root/Events")
const score_fmt = "Score: %d"

func _ready():
	events.new_score.connect(update_text)
	update_text(events.score)


func update_text(score):
	text = score_fmt % score
