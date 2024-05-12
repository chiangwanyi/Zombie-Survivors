extends State

var head_animation: AnimatedSprite2D
var stem_animation: AnimatedSprite2D
var plant_audio_player : AudioStreamPlayer

var need_exit := false

func enter() -> void:
	head_animation = owner.get_node(^"HeadAnimatedSprite2D") as AnimatedSprite2D
	stem_animation = owner.get_node(^"StemAnimatedSprite2D") as AnimatedSprite2D
	plant_audio_player = owner.get_node(^"PlantOnGrassAudioPlayer") as AudioStreamPlayer
	
	head_animation.play(&"idle")
	stem_animation.play(&"idle")
	plant_audio_player.play()
	super.enter()

func update(_delta: float) -> void:
	if not head_animation.is_playing() and not need_exit:
		head_animation.play()

	if not stem_animation.is_playing() and not need_exit:
		stem_animation.play()

func exit() -> void:
	need_exit = true
	await head_animation.animation_finished
	await stem_animation.animation_finished
	print('植物 idle 退出')
	super.exit()
