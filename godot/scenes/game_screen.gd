class_name GameScreen extends Control

var _secret_sequence: Array[int] = [7, 6, 5, 4, 3, 2, 1, 0]
var _visible_sequence: Array[int] = [0, 1, 2, 3, 4, 5, 6, 7]
var _swaps_count: int = 0

signal game_won()


func _ready():
	$Board.swapped.connect(_on_swapped)


func _on_swapped(index0: int, index1: int):
	print("game_screen::_on_swapped(", index0, ", ", index1, ")")
	self._swap(index0, index1)


func _swap(index0: int, index1: int):
	print("game_screen::_swap(", index0, ", ", index1, ")")
	assert(index0 >= 0 && index0 < self._visible_sequence.size())
	assert(index1 >= 0 && index1 < self._visible_sequence.size())
	if index0 == index1:
		return
	var tmp: int = self._visible_sequence[index1]
	self._visible_sequence[index1] = self._visible_sequence[index0]
	self._visible_sequence[index0] = tmp
	print(_visible_sequence)
	self._increment_swaps_count()
	if self._update_matches() == self._secret_sequence.size():
		self.game_won.emit()


func _increment_swaps_count():
	self._swaps_count = self._swaps_count + 1
	print("game_screen::_increment_swaps_count(", self._swaps_count, ")")
	$SwapsCountLabel.text = str(self._swaps_count)


func _update_matches() -> int:
	var matches: int = _count_matches()
	$Circle/MatchCountLabel.text = "%d/8" % matches
	return matches


func _count_matches() -> int:
	assert(self._secret_sequence.size() == self._visible_sequence.size())
	var counter: int = 0
	for i in range(self._secret_sequence.size()):
		if self._secret_sequence[i] == self._visible_sequence[i]:
			counter = counter + 1
	return counter


func set_secret_sequence(sequence: Array[int]):
	print("game_screen::set_secret_sequence(", sequence, ")")
	assert(sequence.size() == self._visible_sequence.size())
	self._secret_sequence = sequence
	_update_matches()


func get_swaps_count() -> int:
	return self._swaps_count


func _is_playing() -> bool:
	return $Board.is_playing() || $AnimationPlayer.is_playing()


func play_in():
	if not _is_playing():
		$AnimationPlayer.play("play_in")
		$Board.play_in()


func play_out():
	if not _is_playing():
		$AnimationPlayer.play_backwards("play_in")
		$Board.play_out()
