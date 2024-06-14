extends GridContainer


signal card_toggled(bool)


var _cards: Array[Card2]


func _ready():
	for i in range(8):
		var card: Card2 = self.get_node("Card%d" % i) as Card2
		assert(card)
		self._cards.push_back(card)
		card.clicked.connect(func(): _on_card_clicked(i, card))
	
	$PadlockIcon.clicked.connect(self._on_padlock_clicked)


func _on_card_clicked(index: int, card: Card2):
	print("notepad::_on_card_clicked(", index, ")")


func _on_padlock_clicked():
	print("notepad::_on_padlock_clicked")
