extends Camera2D

onready var vignette_intensity = $ColorRect.material.get_shader_param("vignette_intensity")
onready var vignette_opacity = $ColorRect.material.get_shader_param("vignette_opacity")
onready var vignette_rgb = $ColorRect.material.get_shader_param("vignette_rgb")

func _ready():
	pass
	
	Global.connect("sanity_changed", self, "update_vignette")
	
func update_vignette(new_sanity):
	if new_sanity < 10:
		vignette_intensity = 5.0
	elif new_sanity < 20:
		vignette_intensity = 3.0
	elif new_sanity < 30:
		vignette_intensity = 2.5
	elif new_sanity < 40:
		vignette_intensity = 2.0
	elif new_sanity < 50:
		vignette_intensity = 1.0
	elif new_sanity < 70:
		vignette_intensity = 0.75
	elif new_sanity < 90:
		vignette_intensity = 0.5
