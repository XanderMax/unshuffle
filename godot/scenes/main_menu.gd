extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$NewGameButton.pressed.connect(_on_new_game_button_pressed)
	$UiAnimation.play_backwards("ui_animation")
	
func _on_new_game_button_pressed():
	$UiAnimation.play("ui_animation")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
