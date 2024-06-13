extends Control

const game_screen_preload: Resource = preload("res://scenes/game_screen.tscn")
var _derangements_8: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	$MainMenu.playInUi()
	$MainMenu.newGame.connect(_on_new_game)
	_read_derangments()

func _read_derangments():
	const file_name: String = "res://derangements/8.json"
	assert(FileAccess.file_exists(file_name))
	var file_data = FileAccess.open(file_name, FileAccess.READ)
	var parse_result = JSON.parse_string(file_data.get_as_text())
	assert(parse_result is Array)
	assert(parse_result.size() > 0)
	self._derangements_8 = parse_result
	
func _get_random_derangement() -> Array[int]:
	assert(self._derangements_8.size() > 0)
	var random_index = randi() % self._derangements_8.size()
	var random_array: Array = self._derangements_8[random_index]
	assert(random_array.size() == 8)
	var random_array_int: Array[int]
	for value in random_array:
		random_array_int.push_back(int(value))
	return random_array_int

func _on_new_game():
	if $MainMenu.playout_finished.is_connected(_on_new_game_playout_finished):
		return
	$MainMenu.playOutUi()
	$MainMenu.playout_finished.connect(_on_new_game_playout_finished)

func _on_new_game_playout_finished():
	print("_on_new_game_playout_finished")
	var game_screen: GameScreen = game_screen_preload.instantiate() as GameScreen
	game_screen.set_secret_sequence(self._get_random_derangement())
	if game_screen:
		get_parent().add_child(game_screen) # TODO: figure out why get_parent is needed
		game_screen.play_in()
		
	$MainMenu.playout_finished.disconnect(_on_new_game_playout_finished)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
