define([], function(){
	return {
		// simple view init
		init: function(){
			console.log(this.name + '.init');
		},

		start: function(){
			console.log(this.name + '.start');
		},
		
		beforeActivate : function(){
			console.log(this.name + '.beforeActivate');
		},
		
		afterActivate : function(){
			console.log(this.name + '.afterActivate');
		},
		
		beforeDeactivate : function(){
			console.log(this.name + '.beforeDeactivate');
		},
		afterDeactivate : function(){
			console.log(this.name + '.afterDeactivate');
		},
		// simple view destroy
		destroy: function(){
			console.log(this.name + '.destroy');
		}
	}
});
