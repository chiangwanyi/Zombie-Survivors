class_name Plant extends CharacterBody2D

var health: int = 100
var cost: int = 100
var cooldown: float = 1.0  # 攻击冷却
var active: bool = true

signal plant_died

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func take_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		die()
	
func die() -> void:
	active = false
	emit_signal("plant_died", self)
	queue_free()
