extends GridContainer


signal card_toggled(index: int, state: bool)
signal padlock_toggled(bool)


var _cards: Array[Card2]


var padlock: bool:
	set(val):
		print("notepad::padlock::set(", val, ")")
		if val != padlock:
			padlock = val
			$PadlockIcon.locked = padlock
			padlock_toggled.emit(padlock)


var locked_index: int = -1:
	set(val):
		print("notepad::locked_index::set(", val, ")")
		if val != locked_index:
			locked_index = val


func _ready():
	for i in range(8):
		var card: Card2 = self.get_node("Card%d" % i) as Card2
		assert(card)
		self._cards.push_back(card)
		card.clicked.connect(func(): _on_card_clicked(i, card))
	
	$PadlockIcon.clicked.connect(self._on_padlock_clicked)


func _on_card_clicked(index: int, card: Card2):
	print("notepad::_on_card_clicked(", index, ")")
	if index == self.locked_index:
		return
	card.locked = not card.locked
	self.card_toggled.emit(index, card.locked)


func _on_padlock_clicked():
	print("notepad::_on_padlock_clicked")
	padlock = not padlock


func set_card_state(index: int, state: bool):
	print("notepad::set_card_state(", index, ", ", state, ")")
	assert(index >= 0 && index < self._cards.size())
	var card: Card2 = self._cards[index] as Card2
	assert(card)
	card.locked = state
