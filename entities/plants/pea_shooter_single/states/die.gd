extends State

var body : Plant

func enter() -> void:
	body = owner as Plant
	
	GameManager.plants.erase(body)
	
	body.queue_free()
