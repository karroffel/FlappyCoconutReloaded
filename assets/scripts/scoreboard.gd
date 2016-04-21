
extends Node

var cache = 0

var scores = {}

func _ready():
	pass

func send_highscore(name, highscore):
	var http = HTTPClient.new()
	var err = http.connect("www.demus-intergalactical.net", 4242)
	
	if err != OK:
		print("Could not connect")
		return
	
	while http.get_status()==HTTPClient.STATUS_CONNECTING or http.get_status()==HTTPClient.STATUS_RESOLVING:
		http.poll()
	
	if http.get_status() != HTTPClient.STATUS_CONNECTED:
		print("Could not connect")
		return
	
	var headers=[
		"User-Agent: Pirulo/1.0 (Godot)",
		"Accept: */*"
	]
	
	var query_string = name + "," + str(highscore)
	
	err = http.request(HTTPClient.METHOD_POST, "/", headers, query_string)
	
	if err != OK:
		print("Server doesn't wanna talk")
		return
	
	while (http.get_status() == HTTPClient.STATUS_BODY or http.get_status() == HTTPClient.STATUS_CONNECTING):
		http.poll()
	

func get_scoreboard():
	var http = HTTPClient.new()
	var err = http.connect("www.demus-intergalactical.net", 4242)
	
	if err != OK:
		print("Could not connect")
		return scores
	
	while http.get_status()==HTTPClient.STATUS_CONNECTING or http.get_status()==HTTPClient.STATUS_RESOLVING:
		http.poll()
	
	if http.get_status() != HTTPClient.STATUS_CONNECTED:
		print("Could not connect")
		return scores
	
	var headers=[
		"User-Agent: Pirulo/1.0 (Godot)",
		"Accept: */*"
	]
	
	err = http.request(HTTPClient.METHOD_GET, "/" + str(cache), headers)
	
	if err != OK:
		print("Server doesn't wanna talk")
		return scores
	
	while http.get_status() == HTTPClient.STATUS_REQUESTING:
		http.poll()
	
	if http.has_response():
		var code = http.get_response_code()
		if code == 418:
			print("teapod")
			return scores
		
			
		var rb = RawArray()
		
		while(http.get_status()==HTTPClient.STATUS_BODY):
			# While there is body left to be read
			http.poll()
			var chunk = http.read_response_body_chunk() # Get a chunk
			if (chunk.size()==0):
				# Got nothing, wait for buffers to fill a bit
				OS.delay_usec(1000)
			else:
				rb = rb + chunk # Append to read buffer
		
		var text = rb.get_string_from_ascii()
		var d = {}
		d.parse_json(text)
		cache = d["cache"]
		scores = d["scores"]
		return scores