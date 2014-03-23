$(function() {
    socket_subscribe();
    com_chart = new CommitChart();
    com_chart.draw_chart();
    new Repo('', '').init_event_committers();
 
    var objDiv = document.getElementById("navigation");
    if (objDiv){
	objDiv.scrollTop = objDiv.scrollHeight;
    }
});

function socket_subscribe() {
    var dispatcher = new WebSocketRails('localhost:3001/websocket');
    var channel = dispatcher.subscribe('repos');
    channel.bind('new', function(repo) {
	if(repo.name == $('.repo_info').data('name') && repo.owner == $('.repo_info').data('owner') ){
	    var repo = new Repo(repo.owner, repo.name);
	    repo.get_committers();
	    repo.get_chart();
	    repo.get_commits();
	}
	console.log('a new repo is created!');
    });
    
    channel.bind('error', function(repo) {
	if(repo.name == $('.repo_info').data('name') && repo.owner == $('.repo_info').data('owner')){
	    $('.ui.red.inverted.segment').html(repo.message);
	    $('.ui.red.inverted.segment').removeClass("hidden");
	    $('.ui.active.dimmer').removeClass("active");
	}
	console.log('a repo with error!');
    });
    
    channel.bind('update', function(repo) {
	if(repo.name == $('.repo_info').data('name') && repo.owner == $('.repo_info').data('owner')){
	    var repo = new Repo(repo.owner, repo.name);
	    repo.get_committers();
	    repo.get_chart();
	    repo.get_commits();
	}
    });

}

