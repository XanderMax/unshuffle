extends Control

signal newGame()

# Called when the node enters the scene tree for the first time.
func _ready():
	$NewGameButton.pressed.connect(_on_new_game_button_pressed)
	
func _on_new_game_button_pressed():
	self.newGame.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func playOutUi():
	$UiAnimation.play("ui_animation")
func playInUi():
	$UiAnimation.play_backwards("ui_animation")
