$(function() {

	var marquee = new Marquee();
	marquee.animate();

	var directions = new Directions();

	var game = new Game();
	game.goalKeeper = new GoalKeeper(directions);
	game.ball = new Ball();
	game.goal = new Goal();
	game.mario = new Mario();
	game.resultTable = new ResultTable();

	game.start();

});

//marquee

function Marquee() {
	this.view = $("#marquee");
	this.innerView = $("#marquee > div");
	this.marqueePixelsWidth = this.view.css("width");
	this.marqueeInnerNegativePixelsWidth = "-" + this.innerView.css("width");
	this.innerView.css("margin-left", this.marqueePixelsWidth);
}

Marquee.prototype.animate = function() {
	var ref = this;
	this.innerView.animate({
        "margin-left": this.marqueeInnerNegativePixelsWidth
    }, 10000, "linear", function() {
    	ref.innerView.css("margin-left", ref.marqueePixelsWidth);
    	ref.animate();
    });
};


//directions

function Directions() {
	this.LEFTDOWN = "leftdown";
  	this.LEFTUP = "leftup";
  	this.RIGHTDOWN = "rightdown";
  	this.RIGHTUP = "rightup";
  	this.directions = [
  		this.LEFTDOWN, 
  		this.LEFTUP,
  		this.RIGHTDOWN,
  		this.RIGHTUP
  	];
}

Directions.prototype = {
	getRandomDirection: function() {
		var guess = Math.floor(Math.random() * this.directions.length);
		return this.directions[guess];
	}
};

//goal
function Goal() {
	this.view = $("#goal");
};

//game
function Game() {
	this.view = $("#game");
	this.goal = null;
	this.mario = null;
	this.goalKeeper = null;
	this.ball = null;
	this.difficulty = 10;
};

Game.prototype.start = function() {
	var ref = this;
	this.goal.view.click(function(e) {
		if (ref.mario.shooting) return;
		ref.mario.shooting = true;

        var position = ref.getLocalGoalPosition(e);

        ref.shoot(position);

	});
};

Game.prototype.getLocalGoalPosition = function(e) {
	var posX = this.view.offset().left,
        posY = this.view.offset().top;

    var ballX = e.pageX - posX - this.ball.width*0.5;
    var ballY = e.pageY - posY - this.ball.width*0.5;
    return {x:ballX, y:ballY};
}

Game.prototype.shoot = function(position) {
	
	var ref = this;

	var blocked = Math.floor(Math.random() * this.difficulty) == this.difficulty - 1;
	var goalkeeperPosition = blocked ? position : null;
	
	this.goalKeeper.move(goalkeeperPosition, function() {

    });

    this.ball.shoot(position, function() {
    	ref.scoreGoal();
    });

};

Game.prototype.scoreGoal = function() {
	var ref = this;
	this.mario.goals++;
	this.resultTable.setScore(this.mario.goals);
	this.ball.fall(function() {
		setTimeout(function() {
			ref.ball.reset();
			ref.goalKeeper.reset();
			ref.mario.shooting = false;
		}, 2000);
	});
}

//goalkeeper

function GoalKeeper(directions) {
	this.view = $("#goalkeeper");
	this.shadowView = $("#goalkeeper-shadow");
	this.directions = directions;
	this.positions = {};
	this.positions[this.directions.LEFTDOWN] = [196, 68, "left"];
	this.positions[this.directions.LEFTUP] = [196, 45, "left"];
	this.positions[this.directions.RIGHTDOWN] = [296, 68, "right"];
	this.positions[this.directions.RIGHTUP] = [296, 45, "right"];
	this.basePosition = this.view.position();
	this.baseShadowPosition = this.shadowView.position();
	this.speed = 300;
}

GoalKeeper.prototype.move = function(position, callback) {
	
	var guessedPosition;
	
	if (position) {
		guessedPosition = [position.x, position.y];
	} else {
		var guessedDirection = this.directions.getRandomDirection();
		guessedPosition = this.positions[guessedDirection];
	}
	

	this.view.animate({
        left: guessedPosition[0] + "px",
        top: guessedPosition[1] + "px"
    }, this.speed, "swing", callback);

    this.shadowView.animate({
        left: guessedPosition[0] + "px",
        opacity: 0.1
    }, this.speed, "swing");

    this.view.addClass(guessedPosition[2]);
};

GoalKeeper.prototype.reset = function() {
	this.view.css({
        left: this.basePosition.left + "px",
        top: this.basePosition.top + "px"
    });
    this.shadowView.css({
        left: this.baseShadowPosition.left + "px",
        opacity: 1
    });
    this.view.removeClass("left");
    this.view.removeClass("right");
};

//mario

function Mario() {
	this.shooting = false;
	this.goals = 0;
	this.goalTop = 77;
	this.shootSpeed = 300;
	this.fallSpeed = 50;
};

//ball

function Ball() {
	this.view = $("#ball");
	this.basePosition = this.view.position();
	this.width = this.view.width();
	this.shootSpeed = 300;
	this.fallSpeed = 50;
	this.goalTop = 77;
}

Ball.prototype.shoot = function(position, callback) {
	this.view.animate({
        left: position.x + "px",
        top: position.y + "px"
    }, this.shootSpeed, "swing", callback);
};

Ball.prototype.fall = function(callback) {
	this.view.animate({
        top: this.goalTop + "px"
    }, this.fallSpeed, "swing", callback);
};

Ball.prototype.reset = function() {
	this.view.css({
        left: this.basePosition.left + "px",
        top: this.basePosition.top + "px"
    });
	this.view.removeClass("under");
};

Ball.prototype.setInGoal = function(goal) {
	if (goal) {
		this.view.addClass("under");
	} else {
		this.view.removeClass("under");
	}
};

//result

function ResultTable() {
	this.view = $("#mario-result");
}

ResultTable.prototype.setScore = function(score) {
	this.view.text(score);
};