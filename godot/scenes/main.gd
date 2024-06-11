extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$MainMenu.playInUi()
	$MainMenu.newGame.connect(_on_new_game)
	
func _on_new_game():
	$MainMenu.playOutUi()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
