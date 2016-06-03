$(function() {
	jQuery.fn.translateRotate = function(x, y, degrees) {
	    $(this).css({'-webkit-transform' : 'translate3d('+ x +'px, '+ y +'px, 0px) rotate('+ degrees +'deg)',
	                 '-moz-transform' : 'translate3d('+ x +'px, '+ y +'px, 0px) rotate('+ degrees +'deg)',
	                 '-ms-transform' : 'translate3d('+ x +'px, '+ y +'px, 0px) rotate('+ degrees +'deg)',
	                 'transform' : 'translate3d('+ x +'px, '+ y +'px, 0px) rotate('+ degrees +'deg)'});
	    return $(this);
	};

	var ball = $("#ball");
	var factor = 10;
	var w = ball.width();
	var h = ball.height();
	var pos = ball.position();
	var rot = 0;
	var vx = 8*factor;
	var vy = 0;
	var t = 0.08;
	var g = -9.8*factor;

	ball.click(function() {
		var max = 100;
		vx = (Math.random()*max - max*0.5)*factor;
		vy = (Math.random()*max - max*0.5)*factor;
	});

	function update() {

		var documentWidth = $(window).width() - w;
		var documentHeight = $(window).height() - h;

		if (pos.top > documentHeight) vy = Math.abs(vy);
		if (pos.left < 0) vx = Math.abs(vx);
		if (pos.left > documentWidth) vx = -Math.abs(vx);

		rot++;

		vy += t*g;

		pos.left += vx*t;
		pos.top -= vy*t;

		if (pos.top > documentHeight && vy > - 0.1) pos.top = documentHeight;

		ball.translateRotate(pos.left, pos.top, rot);
	}

	setInterval(update, t*1000);

});