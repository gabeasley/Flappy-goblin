extends Node

var game_running : bool
var game_over : bool
var score : int
var scroll_scale : int = 1
 
@export var column_scene : PackedScene
var screen_size : Vector2i
var columns : Array
var ground_height : int

const COLUMN_DELAY : int = 100
const COLUMN_RANGE : int = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_window().size
	ground_height = 0
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_running:
		for column in columns:
			column.position.x -= scroll_scale

func new_game():
	game_running = true
	game_over = false
	$ColumnTimer.start()
	score = 0
	columns.clear()
	generate_columns()
	

func generate_columns():
	var column = column_scene.instantiate()
	column.position.x = screen_size.x + COLUMN_DELAY
	column.position.y = (screen_size.y - ground_height) / 2 + randi_range(-COLUMN_RANGE, COLUMN_RANGE)
	column.hit.connect(flappy_hit)
	add_child(column)
	columns.append(column)


func _on_column_timer_timeout() -> void:
	generate_columns()
	
func flappy_hit():
	pass
