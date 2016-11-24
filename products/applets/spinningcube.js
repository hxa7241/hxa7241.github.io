/*--------------------------------------------------------------------

   just some stuff to practice browser javascript
   Copyright (c) 2005, Harrison Ainsworth. All rights reserved.

   http://www.hxa7241.org/

--------------------------------------------------------------------*/


/**
 * A spinning cube, drawn as corners, with depth-cues.
 *
 * @implementation
 * simplified, procedure-oriented.
 *
 * @todo
 * * better rotation -- changing ?
 * * levels ?
 * * motion blur ?
 */


// parameters
var CANVAS_ID      = 'canvas';
var TIMER_INTERVAL = 30;  // (33 fps)
var PERSPECTIVE    = 0.5;
var SCREEN_SIZE    = 100;
var SCREEN_POS_X   = 320;
var SCREEN_POS_Y   = 110;


// www.quirksmode.org/js/ dom accessor
function getObjectById( id )
{
	var object = null;

	if( document.getElementById )
	{
		object = document.getElementById(id);
	}
	else if( document.all )
	{
		object = document.all[id];
	}
	else if( document.layers )
	{
		object = document.layers[id];
	}

	return object;
}


// www.quirksmode.org/js/ position finder
function findPosition( obj )
{
	var left = 0;
	var top  = 0;
	if( obj.offsetParent )
	{
		while( obj.offsetParent )
		{
			left += obj.offsetLeft
			top  += obj.offsetTop
			obj = obj.offsetParent;
		}
	}
	else if( obj.x && obj.y )
	{
		left += obj.x;
		top  += obj.y;
	}

	return [left, top];
}


// initialize
function doLoad()
{
	// make centered double-unit cube vertexs
	var cube =
	[
		[-1,-1,-1], [+1,-1,-1], [-1,+1,-1], [+1,+1,-1],
		[-1,-1,+1], [+1,-1,+1], [-1,+1,+1], [+1,+1,+1]
	];

	var MAX_EXTENT = 1.73205080756888;  // max extent from origin of hull (derived from cube vertexs)

	// make rotation
	var rotation =
	[
		[ 0.9989930701470172,    0.0006050244947756744, -0.04486067034242447 ],
		[ 0.0006050244947756744, 0.999636464607534,      0.02695501015194035 ],
		[ 0.044860670342424525,  -0.02695501015194038,   0.9986295347545677  ]
	];

	// make projection
	var projection =
	{
		translationZ : MAX_EXTENT,
		scalingZ     : 1 / (MAX_EXTENT * 2),
		perspective  : PERSPECTIVE,
		screenS      : SCREEN_SIZE,
		screenX      : SCREEN_POS_X,
		screenY      : SCREEN_POS_Y
	};

	// set containing dom object
	var canvas = getObjectById( CANVAS_ID );
	canvas.style.height          = "270px";
	//canvas.style.backgroundColor = "white";

	// make stats display dom objects
	var stats = document.createElement( "p" );
	stats.appendChild( document.createTextNode( "frame: " ) );
	stats.id = "stats";
	canvas.appendChild( stats );

	// make cube corner dom objects
	for( var i = cube.length; i-- > 0; )
	{
		var corner = document.createElement( "div" );
		corner.appendChild( document.createTextNode( "\u2022" ) );   // bullet: &bull;
		corner.style.position = "absolute";
		corner.style.left     = "0px";
		corner.style.top      = "0px";
		corner.style.fontSize = "1em";
		corner.style.color    = "black";
		corner.id = "point" + i;

		canvas.appendChild( corner );
	}


	// setup timer
	window.setInterval( doUpdate, TIMER_INTERVAL, cube, rotation, projection );
}


// for each timestep
function doUpdate( object, rotation, projection )
{
	var containerPos = findPosition( getObjectById( CANVAS_ID ) );

	// transform and draw object corners
	for( var i = object.length; i-- > 0; )
	{
		// rotate object
		var point = [ object[i][0], object[i][1], object[i][2] ];
		object[i][0] = (point[0] * rotation[0][0]) + (point[1] * rotation[0][1]) + (point[2] * rotation[0][2]);
		object[i][1] = (point[0] * rotation[1][0]) + (point[1] * rotation[1][1]) + (point[2] * rotation[1][2]);
		object[i][2] = (point[0] * rotation[2][0]) + (point[1] * rotation[2][1]) + (point[2] * rotation[2][2]);

		// project (view transform, projection, screen transform)
		var perspective = 1 / ((object[i][2] + projection.translationZ) * projection.perspective + 1);
		var multiplier  = projection.screenS * perspective;
		var projected   = [ (object[i][0] * multiplier) + containerPos[0] + projection.screenX,
		                    (object[i][1] * multiplier) + containerPos[1] + projection.screenY,
		                    (object[i][2] + projection.translationZ) * projection.scalingZ ];

		// get corner element
		var corner = getObjectById( 'point' + i );

		// set element positions
		corner.style.left = "" + ((projected[0] + 0.5) | 0) + "px";
		corner.style.top  = "" + ((projected[1] + 0.5) | 0) + "px";

		// set element color and size for depth cue
		var scaledZ = ((projected[2] * 200) + 0.5) | 0;
		scaledZ = scaledZ < 0 ? 0 : (scaledZ > 255 ? 255 : scaledZ);
		var gray = scaledZ.toString(16);
		gray = gray.length < 2 ? "0" + gray : gray;
		corner.style.color = "#" + gray + gray + gray;
		corner.style.fontSize = "" + ((((300 * perspective) + 0.5) | 0) * 0.01) + "em";
	}

	// update stats (fps)
	var now                      = new Date().getTime();
	var durationSinceLastMeasure = now - doUpdate.lastTime;
	if( durationSinceLastMeasure > 1000 )
	{
		frameRate = (((1000 * (doUpdate.frameCount - doUpdate.lastCount)) / durationSinceLastMeasure) + 0.5) | 0;
		doUpdate.lastTime  = now;
		doUpdate.lastCount = doUpdate.frameCount;

		// draw stats (fps)
		var stats = getObjectById( "stats" );
		stats.firstChild.data = " fps: " + frameRate;
	}
	++doUpdate.frameCount;
}

doUpdate.frameCount = 0;
doUpdate.lastTime   = 0;
doUpdate.lastCount  = 0;


// set initializing trigger
window.onload = doLoad;
