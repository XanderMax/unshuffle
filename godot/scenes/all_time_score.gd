extends VBoxContainer

@export var Title: String = "TITLE"
# Called when the node enters the scene tree for the first time.
func setScore(score:int):
	$CenterContainer/ScoreLable.text = str(score)
	
func _ready():
	$TitleLabel.text = self.Title
	self.setScore(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
