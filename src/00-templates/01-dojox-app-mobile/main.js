require(["dojox/app/main", "dojox/json/ref", "dojo/text!{{app-name}}/config.json"],
	function(Application, json, config){
		Application(json.fromJson(config));
	}
);
