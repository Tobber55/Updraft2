extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	$Stamina.value = Global.stamina 
	$Health.value = Global.health
	$XP.value = Global.xp
	
	pass
