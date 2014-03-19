
$(function() {
    socket_subscribe();
});


function socket_subscribe() {
    var dispatcher = new WebSocketRails('localhost:1212/websocket');
    var channel = dispatcher.subscribe('posts');
    channel.bind('new', function(post) {
	console.log('a new post about arrived!');
    });

}


