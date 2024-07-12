extends GameLevel

func _ready() -> void:
    GameManager.current_level = self
    bgm_level_playing.play()


func _on_sfx_zombie_groan_timer_timeout() -> void:
    sfx_zombie_groan.play()
