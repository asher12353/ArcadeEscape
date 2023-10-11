extends Area3D

class_name Interactable

@export var tv: StaticBody3D

var world: Node3D
var player: CharacterBody3D

@onready var controller = $"../controller"
@onready var camera_3d = $"../Camera3D"

signal focused(interactor: Interactor)

signal unfocused(interactor: Interactor)

signal interacted(interactor: Interactor)

func _ready():
	world = tv.world
	player = tv.main_character

func _on_focused(_interactor):
	print_debug("focused")


func _on_interacted(interactor):
	print_debug("interacted")
	world.current_character = null
	world.current_game = tv.current_game
	camera_3d.make_current()


func _on_unfocused(_interactor):
	print_debug("unfocused")
