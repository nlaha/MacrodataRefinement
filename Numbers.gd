extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var number
var rng = RandomNumberGenerator.new()

# Instantiate
var noise = OpenSimplexNoise.new()
var noise_lg = OpenSimplexNoise.new()

var instances = []

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	number = preload("res://Macrodata.tscn")
	
	# Configure
	noise.seed = randi()
	noise.octaves = 4
	noise.period = 1.0
	noise.persistence = 2.0

	# Configure
	noise_lg.seed = randi()
	noise_lg.octaves = 4
	noise_lg.period = 100.0
	noise_lg.persistence = 0.1

			
	for x in range(-100, 100):
		instances.append([])
		for y in range(-100, 100):
			var instance = number.instance()
			instance.set_position(Vector2(x * 80, y * 80))
			var rand_number = rng.randi_range(0, 9)
			var rand_float = rng.randf_range(0.0, 100.0)
			instance.get_material().set_shader_param("per_inst", abs(noise.get_noise_2d(x, y) * 2.0 + 1.0))
			instance.get_material().set_shader_param("noise_lg", max(noise.get_noise_2d(x / 20.0, y / 20.0), 0.0) * float(rand_float > 90.0))
			instance.get_material().set_shader_param("coords", Vector2(x, y))
			instance.text = str(rand_number)
			$CanvasLayer2/Node2D.add_child(instance)
			instances[x + 100].append(instance)
			
func _process(delta):
	var offset = Vector2(0.0, 0.0)
	if Input.is_action_pressed("up"):
		offset.y += 1.0
	
	if Input.is_action_pressed("down"):	
		offset.y -= 1.0
			
	if Input.is_action_pressed("left"):
		offset.x += 1.0
				
	if Input.is_action_pressed("right"):
		offset.x -= 1.0
		
	$CanvasLayer2/Node2D.set_position(Vector2($CanvasLayer2/Node2D.get_position().x + offset.x, $CanvasLayer2/Node2D.get_position().y + offset.y))
