extends Node2D

var game_screen_preload: Resource = preload("res://scenes/game_screen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$MainMenu.playInUi()
	$MainMenu.newGame.connect(_on_new_game)
	
func _on_new_game():
	if $MainMenu.playout_finished.is_connected(_on_new_game_playout_finished):
		return
	$MainMenu.playOutUi()
	$MainMenu.playout_finished.connect(_on_new_game_playout_finished)

func _on_new_game_playout_finished():
	print("_on_new_game_playout_finished")
	var game_screen: GameScreen = game_screen_preload.instantiate() as GameScreen
	if game_screen:
		get_parent().add_child(game_screen) # TODO: figure out why get_parent is needed
		
	$MainMenu.playout_finished.disconnect(_on_new_game_playout_finished)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
