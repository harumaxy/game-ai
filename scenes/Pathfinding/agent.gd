extends Node3D
class_name MoveAgent


@onready var nav_agent = $NavigationAgent3D as NavigationAgent3D
@export var debug := false
var target : Node3D

var speed = 3
var vec : Vector3
var next_path : Vector3


func _ready() -> void:
  target = get_tree().get_first_node_in_group("targets")
  nav_agent.target_position = target.global_position
  PathFindManager.agents.push_back(self)
  
  
  
func _physics_process(delta: float) -> void:
  nav_agent.target_position = target.global_position
  if next_path: 
    var dir = (next_path - self.global_position) as Vector3
    dir.y = 0
    vec = dir.normalized()
    global_translate(vec * speed * delta)
  


  
    

#  var current_pos = global_position
#  var next_path_pos = nav_agent.get_next_path_position()
#  var dir = (next_path_pos - current_pos)
#  dir.y = 0
#  vec = dir.normalized()
