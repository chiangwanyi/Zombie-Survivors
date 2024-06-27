extends Node

func unique_key(length := 8) -> String:
    var characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    var code = ""
    for i in range(length):
        var index = randi() % characters.length()
        code += characters[index]
    return code
