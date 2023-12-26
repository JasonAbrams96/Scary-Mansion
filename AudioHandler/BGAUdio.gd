extends AudioStreamPlayer


var offset = 0
var current_sound = "nu"
func replay():
	 play_music(current_sound)
	
func _ready():
	connect("finished", self, "replay")
	
func play_music(music_file):
	if music_file != current_music:		
		if sound_file is String:
			var sound = load(sound_file)
			set_stream(sound)
			current_music = music_file

	play(offset)


