extends Node

const INITIAL_FOOD_COUNT := 5
const REFILL_COUNT_ONEAT := 3
const REFILL_COUNT_ONTIME := 5
const FOOD_SIZE := Vector2(100, 100)
@export var Comida: PackedScene
var score

@onready var screen_size: Vector2 = get_viewport().get_visible_rect().size
@onready var events := get_node("/root/Events")


func _ready():
	spawn_x_food(INITIAL_FOOD_COUNT)
	$Timer.timeout.connect(func (): 
		spawn_x_food(REFILL_COUNT_ONTIME)
	)
	events.food_eaten.connect(func (_score): 
		spawn_x_food(REFILL_COUNT_ONEAT)
		$Timer.start()
	)


func spawn_food() -> void:
	var new_comida = Comida.instantiate()
	new_comida.position = spawn_point()
	while is_occupied(new_comida.position):
		new_comida.position = spawn_point()
	$Foods.add_child.call_deferred(new_comida)


func is_occupied(point: Vector2, offset = FOOD_SIZE) -> bool:
	var point_rect = rect_from_point(point, offset)
	return $Foods.get_children() \
	.map(func (food): 
		return rect_from_point(food.position, offset)
	) \
	.any(func (rect):
		return point_rect.intersects(rect)
	)


func spawn_x_food(x) -> void: for _i in range(x): spawn_food()
func spawn_point(): return Vector2(randf() * screen_size.x, randf() * screen_size.y)
func rect_from_point(point: Vector2, size: Vector2): return Rect2(point - size/2, size)
