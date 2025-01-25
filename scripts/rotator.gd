extends Node2D

const rotate_speed = 30
const spawn_point_count = 4
const radius = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var step = 2 * PI / spawn_point_count
	for i in range(spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		add_child(spawn_point)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var new_rotation = rotation_degrees + rotate_speed * delta
	rotation_degrees = fmod(new_rotation, 360)
