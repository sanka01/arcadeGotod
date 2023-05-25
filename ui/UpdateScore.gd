extends Control

@onready var events: MyEvents = get_node("/root/Events")
const inc_fmt = "+%d"
var dec_acc = 0
const dec_fmt = "-%d"
const default = ""

func _ready():
	events.inc_score.connect(func (inc): add_label(inc_fmt, inc))
	events.dec_score.connect(func (dec): dec_acc += dec)
	$Update.timeout.connect(func ():
		if (dec_acc > 0):
			add_label(dec_fmt, dec_acc)
			dec_acc = 0
	)

func add_label(fmt: String, value: Variant, timeout = 1) -> void:
	var label = Label.new()
	label.text = fmt % value
	get_tree().create_timer(timeout).timeout.connect(label.queue_free)
	add_child(label)
