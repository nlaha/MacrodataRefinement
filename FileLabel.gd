extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var file_num = "01"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = file_num

func _process(delta):
	$"Progress Percent".text = str($ProgressBar.value) + "%"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
