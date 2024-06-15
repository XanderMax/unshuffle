extends Control

var _cards: Array[NumberCard]
var _selected_card_index: int = -1

signal swapped(index0: int, index1: int)

# Called when the node enters the scene tree for the first time.
func _ready():
	self._cards.push_back($Line0/Card0)
	self._cards.push_back($Line0/Card1)
	self._cards.push_back($Line0/Card2)
	self._cards.push_back($Line0/Card3)
	self._cards.push_back($Line1/Card4)
	self._cards.push_back($Line1/Card5)
	self._cards.push_back($Line1/Card6)
	self._cards.push_back($Line1/Card7)
	
	for i in range(self._cards.size()):
		var card: NumberCard = self._cards[i]
		card.clicked.connect(func(): _on_card_clicked(i, card))
		card.double_clicked.connect(func(): _on_card_double_clicked())
		card.set_text(str(i + 1))


func _on_card_clicked(index: int, card: NumberCard):
	assert(index >= 0 && index < self._cards.size())
	print("board::_on_card_clicked(", index, ", ", card, ")")
	if card.is_locked():
		return
	if self._selected_card_index < 0:
		self._selected_card_index = index
		card.set_selected(true)
		return
	self._cards[self._selected_card_index].set_selected(false)
	var tmp_index: int = self._selected_card_index
	self._selected_card_index = -1
	if tmp_index != index:
		self._swap(tmp_index, index)


func _swap(index0: int, index1: int):
	print("board::_swap(", index0, ", ", index1, ")")
	assert(index0 >= 0 && index0 < self._cards.size())
	assert(index1 >= 0 && index1 < self._cards.size())
	if index1 == index0:
		return
	var tmp: String = self._cards[index0].get_text()
	self._cards[index0].set_text(self._cards[index1].get_text())
	self._cards[index1].set_text(tmp)
	self.swapped.emit(index0, index1)


func _on_card_double_clicked():
	print("board::_on_card_double_clicked")
	if self._selected_card_index >= 0 && self._selected_card_index < self._cards.size():
		self._cards[self._selected_card_index].set_selected(false)
		self._selected_card_index = -1


func play_in():
	if not self.is_playing():
		$AnimationPlayer.play("play_in")


func play_out():
	if not self.is_playing():
		$AnimationPlayer.play_backwards("play_in")


func is_playing() -> bool:
	return $AnimationPlayer.is_playing()
