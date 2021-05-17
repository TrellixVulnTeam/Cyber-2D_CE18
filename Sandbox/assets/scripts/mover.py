﻿import Cyber
import glm
speed=6
def Start():
	Cyber.Log.Error("Error")
	Cyber.Log.Warn("Warning")
	Cyber.Log.Info("Info")
	Cyber.Log.Trace("Trace")

def Update(ts,transform):

	if(Cyber.Input.IsKeyPressed("LEFT")):
		transform.Translation.x-=speed*ts
	elif(Cyber.Input.IsKeyPressed("RIGHT")):
		transform.Translation.x+=speed*ts

	if(Cyber.Input.IsKeyPressed("UP")):
		transform.Translation.y+=speed*ts
	elif(Cyber.Input.IsKeyPressed("DOWN")):
		transform.Translation.y-=speed*ts

	if(Cyber.Input.IsKeyPressed("E")):
		transform.Rotation-=2*ts;
	elif(Cyber.Input.IsKeyPressed("Q")):
		transform.Rotation+=2*ts;

	if(Cyber.Input.IsKeyPressed("R")):
		transform.Translation=glm.vec3()
		transform.Rotation=0
	

def Event(e):
	pass

def Destroy():
	Cyber.Log.Info("Destroy")
