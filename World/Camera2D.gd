extends Camera2D

onready var vignette_intensity = $ColorRect.material.get_shader_param("vignette_intensity")
onready var vignette_opacity = $ColorRect.material.get_shader_param("vignette_opacity")
onready var vignette_rgb = $ColorRect.material.get_shader_param("vignette_rgb")

func _ready():
	print(vignette_intensity)
	print(vignette_opacity)
	print(vignette_rgb)
