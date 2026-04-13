extends Panel

@onready var amount_label: RichTextLabel = $AmountLabel
@onready var itemImg: Sprite2D = $Item

var item_name: String = ""
var item_frame: int = 2
var amount: int = 0

func _ready() -> void:
	updateSlot()

func updateSlot() -> void:
	itemImg.frame = item_frame
	amount_label.text = str("x%s" % amount)
