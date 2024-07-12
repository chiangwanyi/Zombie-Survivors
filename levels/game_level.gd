class_name GameLevel extends Control

@export var level: Node2D
@export var zombie_count_label: Label

@export var sfx_zombie_groan: AudioStreamPlayer
@export var sfx_zombie_groan_timer: Timer

@export var bgm_level_playing: AudioStreamPlayer

## 修改僵尸数量
func modify_zombie_count(num: int):
    var zombie_count = int(zombie_count_label.text)
    zombie_count_label.text = str(zombie_count + num)
    
    if zombie_count + num > 0 and sfx_zombie_groan_timer.is_stopped():
        sfx_zombie_groan_timer.start()
    elif zombie_count + num <= 0:
        sfx_zombie_groan_timer.stop()
