$(function() {

   var data = {
    	labels : $('.chart_information').data('labels'),
    	datasets : [
    	    {
    		fillColor : "rgba(220,220,220,0.5)",
    		strokeColor : "rgba(220,220,220,1)",
    		pointColor : "rgba(220,220,220,1)",
    		pointStrokeColor : "#fff",
    		data : $('.chart_information').data('count'),
    	    },
    	    {
    		fillColor : "rgba(151,187,205,0.5)",
    		strokeColor : "rgba(151,187,205,1)",
    		pointColor : "rgba(151,187,205,1)",
    		pointStrokeColor : "#fff",
    		data : $('.chart_information').data('user-count')
    	    }
    	]
   }; 
   draw_chart(data) ;
});

function draw_chart(data){
    var ctx = document.getElementById("myChart").getContext("2d");
    new Chart(ctx).Line(data);
}
