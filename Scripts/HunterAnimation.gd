extends Sprite2D

@onready var p = $".."

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	var tween = create_tween()
	
	tween.tween_property(self.material, "shader_parameter/sideWaysDeformationFactor", p.direction * 5, 0.5)
	
	tween.tween_property(self.material, "shader_parameter/deformation",
	Vector2(clampf(p.velocity.y / -5000, -.25, .25), .07), .2).from_current()
	
