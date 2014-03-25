$(function(){
    $("#q").autocomplete({
	source : function(req, add){
	    $.ajax({
		url:'https://api.github.com/search/repositories?',
		type:"get",
		dataType: 'json',
		data: 'q='+req.term,
		async: true,
		cache: true,
		success: function(data){
                    var suggestions = [];  
                    $.each(data.items, function(i, val){  
                 	suggestions.push({"id": val.full_name, "value": val.name});  
             	    });  
             	    add(suggestions); 
		}
            });
	}
    })
});