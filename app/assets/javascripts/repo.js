var Repo = function(owner, name){
    this.owner = owner;
    this.name = name;
};


Repo.prototype.init_event_committers = function(){
    $('a#committer_link').click(function (event){ 
      	event.preventDefault(); 
      	var url = $(this).attr('href');
      	$.get(url, function(response) {
            $("#chart-div").html(response);
            com_chart = new CommitChart();
            com_chart.draw_chart();
            $('#chart_dimmer').removeClass("active");
      	});
    });
}


Repo.prototype.get_committers = function(){
    var me = this; 
    $.get("/repositories/committers?name="+this.name+"&owner="+this.owner, function(response) {
  	$("#committers-div").html(response);
  	$('#committers_dimmer').removeClass("active");
        me.init_event_committers();
    });
}

Repo.prototype.get_chart = function(){
    $.get("/repositories/chart?name="+this.name+"&owner="+this.owner, function(response) {
  	$("#chart-div").html(response);
  	com_chart = new CommitChart();
  	var data = com_chart.get_data();
  	com_chart.draw_chart(data);
  	$('#chart_dimmer').removeClass("active");
    });
}

Repo.prototype.get_commits = function(){
    $.get("/repositories/commits?name="+this.name+"&owner="+this.owner, function(response) {
  	$("#timeline-div").html(response);
	var objDiv = document.getElementById("navigation");
	objDiv.scrollTop = objDiv.scrollHeight;
  	$('#timeline_dimmer').removeClass("active");
    });
}