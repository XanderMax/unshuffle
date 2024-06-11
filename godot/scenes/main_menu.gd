class_name MainMenu extends Control

signal newGame()
signal playout_finished()

# Called when the node enters the scene tree for the first time.
func _ready():
	$NewGameButton.pressed.connect(_on_new_game_button_pressed)
	$UiAnimation.animation_finished.connect(_on_animation_finished)
	
func _on_new_game_button_pressed():
	self.newGame.emit()
	
func _on_animation_finished(animation_name: StringName):
	print("_on_animation_finished ", animation_name)
	if animation_name == "playout":
		self.playout_finished.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func playOutUi():
	if not $UiAnimation.is_playing():
		$UiAnimation.play("playout")

func playInUi():
	if not $UiAnimation.is_playing():
		$UiAnimation.play("playin")
