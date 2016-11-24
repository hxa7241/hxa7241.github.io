// MAW : 2011-02-17 //


function getgridtext(x, y, b)
{
	var lx, ly, hx, hy, w, h;											// grid - lo x y, hi x y, width, height
	var str, tstr, p, len;												// populated string, temp string, pos, len
	var i;																// loop
	var textstr;														// text output string

	lx = 0; hx = 0; ly = 0; hy = 0;

	for (i = 0; i < x.length; i++)										// determine grid boundaries
	{
		lx = lx < x[i] ? lx : x[i];
		hx = hx > x[i] ? hx : x[i];
		ly = ly < y[i] ? ly : y[i];
		hy = hy > y[i] ? hy : y[i];
	}

	w = hx + Math.abs(lx) + 1;
	h = hy + Math.abs(ly) + 1;
	len = w * h;

	str = "";
	for (i = 0; i < len; i++)											// populate string with spaces
	{
		str = str + " ";
	}

	for (i = 0; i < x.length; i++)										// populate string
	{
		p = (w * (y[i] + Math.abs(ly))) + (x[i] + Math.abs(lx));		// position in string

		tstr = "";
		if (p != 0) {
			tstr = str.substring(0, p);
		}
		tstr = tstr + b[i];
		if (p != len - 1) {
		   tstr = tstr + str.substring(p + 1, len);
		}
		str = tstr;
	}

	textstr = "";
	for (i = 0; i < h ; i++)											// format string into text
	{
		textstr = textstr + str.substr(i * w, w) + "\n";
	}

	return textstr;
}


function makelogo()
{
	var x = new Array();												// x coords
	var y = new Array();												// y coords
	var b = new Array();												// bit vals
	var n, f;															// loops, flags
	var t, tx, ty;														// trial bit

	x[0] = 0;															// set up 1st bit
	y[0] = 0;
	b[0] = Math.floor(Math.random()* 2);

	for (n = 1; n < 8; n++) 											// grow 7 new bits
	{
		do																// generate a trial new bit
		{
			t = Math.floor(Math.random()* n);							// get existing bit at random for trial
			tx = x[t]; ty = y[t];
			switch (Math.floor(Math.random()* 4))						// adjust trial right/left/up/down?
			{
				case 0: tx++; break;
				case 1: tx--; break;
				case 2: ty++; break;
				case 3: ty--; break;
			}

         f = false
         for (i = 0; i < x.length; i++)
         {
            if (x[i] == tx && y[i] == ty) {
               f = true;
               break;
            }
         }

		} while (f);												// try again?

		x[n] = tx;														// trial passed - add to array
		y[n] = ty;
		b[n] = Math.floor(Math.random()* 2);
	}

	return getgridtext(x, y, b);
}
