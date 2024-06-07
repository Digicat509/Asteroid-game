extends Node

var crystals = 0
var fireSpeed = .2
var fireAmount = 1
var speed = 150
var physics = false
var damage = 10

func get_crystals():
	return crystals

func set_crystals(new):
	crystals = new

func add_crystals(amount):
	crystals += amount

func get_fireSpeed():
	return fireSpeed

func set_fireSpeed(new):
	fireSpeed = new

func add_fireSpeed(amount):
	fireSpeed += amount

func get_fireAmount():
	return fireAmount

func set_fireAmount(new):
	fireAmount = new

func add_fireAmount(amount):
	fireAmount += amount

func get_speed():
	return speed

func set_speed(new):
	speed = new

func add_speed(amount):
	speed += amount

func get_damage():
	return damage

func set_damage(new):
	damage = new

func add_damage(amount):
	damage += amount
