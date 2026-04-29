extends CanvasLayer
@onready var go_dig_btn: TextureButton = $Skilltree/GoDigBtn
@onready var skills: Node2D = $Skills

func _ready() -> void:
	go_dig_btn.connect("pressed", _GoDig)
	
	if PS.SkillsBought.size() > 0:
		for n:SkillBase in skills.get_children():
			if PS.SkillsBought.has(n._Name):
				n = PS.SkillsBought[n._Name]
				print(n._Finished)

func _GoDig() -> void:
	GM.load_scene(GM.Scenes.DIGAREA)
