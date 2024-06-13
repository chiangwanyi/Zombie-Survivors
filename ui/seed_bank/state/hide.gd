extends State

var body: SeedBank

func _ready() -> void:
    pass

func enter() -> void:
    body = owner as SeedBank
    #var tween := create_tween()
    #tween.tween_property(body, "position", Vector2(0, -120), 0.25)

    
func exit() -> void:
    pass

func _exit_tree() -> void:
    pass

