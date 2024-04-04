extends Node

var is_dragging = false
var near_glass = "null"
var alcool_type = null
var alcool_bar = 0
var alcool_bar_type = ["null", "null"]
var client_gone = false
var client_come = false


const MAX_REPUTATION = 250

var Command = ["Nothing", "Nothing"]
var Drink_Served = ["Nothing", "Nothing"]
var ClientName = "Client"
var client_id: int = 0
var is_client_installed: bool = false

var reputation_level: float = 50.0
var bottles_unlocked: int = 3

var wait_time: int = 0
var Karen_wait: int = 0
