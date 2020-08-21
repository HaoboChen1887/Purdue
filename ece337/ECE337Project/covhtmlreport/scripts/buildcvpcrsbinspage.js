
var lastRowOdd;
var excluded;
var lastClassOdd;

var cellClass      = ["odd",   "even"];
var cellClassRight = ["odd_r", "even_r"];
var cellClassRGrey = ["odd_rGrey", "even_rGrey"];
var cellClassGrey  = ["oddGrey", "evenGrey"];

function createCvgBinRow(newRow, newCell) {
	var classtype;
	var binType;
	var name;
	var celltxt;
	var hrefLnk;
	var lnktxt;
	var relAtt;
	
	tmp = newRow.getAttribute('c');
	switch (tmp) {
		case 'c': {
			newRow.className = 'covered'; break;
		}
		case 'm': {
			newRow.className = 'missing'; break;
		}
		case 'n': {
			newRow.className = 'neutral'; break;
		}
		case 'e': {
			newRow.className = 'excluded'; excluded = 1; show_excl_button = 1; break;
		}
		default: {
			newRow.className = ''; break;
		}
	}
	newCell.className = 'invisible';
	newCell.innerHTML = '&nbsp;';
	
	if (excluded == 0) {
		classtype = cellClass[lastRowOdd];
	} else {
		classtype = cellClassGrey[lastRowOdd];
	}
	lastClassOdd = true;
	
	binType = newCell.getAttribute('bt');
	name = newCell.getAttribute('z');
	if (name) {
		if (name.match(/^<.*>$/)) {
			celltxt = binType + " " + name.replace("&","&amp;").replace(">","&gt;").replace("<","&lt;");
		} else {
			celltxt = binType + " " + name.replace("&","&amp;");
		}
	}
	createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, 0, 0, 0);
	
	if (excluded == 0) {
		if (binRHS) {
			tmp = newCell.getAttribute('rhs');
			// rhs Class
			classtype = cellClass[lastRowOdd];
				
			if (tmp)
				celltxt = tmp;
			else
				celltxt = '&nbsp;';
			createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, 0, 0, 'center');
		}
		
		// AtLeast Class
		tmp = newCell.getAttribute('al');
		if (tmp) {
			celltxt = tmp;
			classtype = cellClassRight[lastRowOdd];
		} else {
			celltxt = '--';
			classtype = cellClass[lastRowOdd];
		}
		createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, 0, 0, 'center');
	} else {
		if (binRHS) {
			// rhs Class
			classtype = cellClassGrey[lastRowOdd];
			createCell(newRow, 'TD', classtype, 0, 0, '&nbsp;', 0, 0, 0, 'center');
		}
		
		// AtLeast Class
		classtype = cellClassGrey[lastRowOdd];
		createCell(newRow, 'TD', classtype, 0, 0, '--', 0, 0, 0, 'center');
	}
	
	// Total Bins
	classtype = cellClass[lastRowOdd];
	createCell(newRow, 'TD', classtype, 0, 0, '&nbsp;', 0, 0, 0, 0);
	
	// Hit Class AKA count
	tmp = newCell.getAttribute('h');
	if (tmp) {
		if (newCell.getAttribute('lnk')) {
			hrefLnk = newCell.getAttribute('lnk').match(/^([^$]*)\$([^$]*)$/i);
			if (hrefLnk && hrefLnk.length == 3) {
				lnktxt = "pertest.htm?bin=g" + hrefLnk[1] + "&scope=" + hrefLnk[2];
			} else {
				lnktxt = newCell.getAttribute('lnk');
			}
			relAtt = 'popup 200 200';
		} else {
			lnktxt = relAtt = 0;
		}
		
		celltxt = tmp;
		if (excluded == 0) {
			classtype = cellClassRight[lastRowOdd];
		} else {
			classtype = cellClassRGrey[lastRowOdd];
		}
		
		lastClassOdd = !lastClassOdd;
	} else {
		celltxt = '--';
		lnktxt = relAtt = 0;
		if (excluded == 0) {
			classtype = cellClass[lastRowOdd];
		} else {
			classtype = cellClassGrey[lastRowOdd];
		}
		
		lastClassOdd = !lastClassOdd;
	}
	
	createCell(newRow, 'TD', classtype, 0, 0, celltxt, lnktxt, relAtt, 0, 'center');
	
	// % Hit
	classtype = cellClass[lastRowOdd];
	createCell(newRow, 'TD', classtype, 0, 0, '&nbsp;', 0, 0, 0, 0);
	
	// Goal class
	classtype = cellClass[lastRowOdd];
	createCell(newRow, 'TD', classtype, 0, 0, '&nbsp;', 0, 0, 0, 0);
	
	// Coverage
	if (excluded == 0) {
		tmp = newCell.getAttribute('c');
		switch (tmp) {
			case 'c': {
				celltxt = 'Covered';
				classtype = 'green';
				break;
			}
			case 'u': {
				celltxt = 'Uncovered';
				classtype = 'red';
				break;
			}
			case 'z': {
				celltxt = 'ZERO';
				if (binType != "illegal_bin")
					classtype = 'red';
				else
					classtype = 'green';
				break;
			}
			case 'o': {
				celltxt = 'Occurred';
				if (binType != "illegal_bin")
					classtype = 'green';
				else
					classtype = 'red';
				break;
			}
			default: {
				classtype = 0;
				celltxt = '&nbsp;';
				break;
			}
		}
	} else {
		celltxt = 'Excluded';
		classtype = 'grey';
	}
	
	createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, 0, 0, 0);
	lastClassOdd = !lastClassOdd; // call this to adjust the order of odd even classes
	
	// % of Goal class
	classtype = cellClass[lastRowOdd];
	createCell(newRow, 'TD', classtype, 0, 0, '--', 0, 0, 0, 0);
	
	// Timestamp info:
	if (g_has_timestamp) {
		var time = newCell.getAttribute('s');
		var timeUnit = newCell.getAttribute('u');
		var testIndex = newCell.getAttribute('r');
		
		if (time && timeUnit && testIndex) {
			createCell(newRow, 'TD', classtype, 0, 0, time+timeUnit, 0, 0, 0, "right"); /* Covered SimTime */
			createCell(newRow, 'TD', classtype, 0, 0, test_names[testIndex], 0, 0, 0, "right"); /* Covered in Test */
		} else {
			createCell(newRow, 'TD', classtype, 0, 0, '--', 0, 0, 0, "right"); /* Covered SimTime */
			createCell(newRow, 'TD', classtype, 0, 0, '--', 0, 0, 0, "right"); /* Covered in Test */
		}
	}
};

function createCvpCrsRow(newRow, newCell) {
	var newElement;
	var name;
	var classtype;
	var celltxt;
	var tmp = newRow.getAttribute('c');
	var tmp2;
	
	switch (tmp) {
		case 'c': {
			newRow.className = 'covered'; break;
		}
		case 'm': {
			newRow.className = 'missing'; break;
		}
		case 'e': {
			newRow.className = 'excluded'; excluded = 1; show_excl_button = 1; break;
		}
		default: {
			newRow.className = ''; break;
		}
	}
	// coverpoint or cross
	if (excluded == 0) {
		newCell.className = cellClass[lastRowOdd];
	} else {
		newCell.className = cellClassGrey[lastRowOdd];
	}
	lastClassOdd = true;
	newCell.colSpan = '2';
	if (newCell.getAttribute('tplnk')) {
		newElement = document.createElement('a');
		newElement.setAttribute("name",newCell.getAttribute('tplnk'));
		newElement.innerHTML = "";
		if (newCell.childNodes.length > 0) {
			// in case there is a <DIV> element which means there is options table
			newCell.insertBefore(newElement,newCell.childNodes[0]);
		} else {
			newCell.appendChild(newElement);
		}
	}
	
	if (newCell.getAttribute('lnk')){
		newElement = document.createElement('a');
		newElement.setAttribute("href",newCell.getAttribute('lnk'));
		name = newCell.getAttribute('z');
		if (name) {
			if (name.match(/^<.*>$/)) {
				newElement.innerHTML = name.replace("&","&amp;").replace(">","&gt;").replace("<","&lt;");
			} else {
				newElement.innerHTML = name.replace("&","&amp;");
			}					
		}

		if (newCell.childNodes.length > 0) {
			// in case there is a <DIV> element which means there is options table
			newCell.insertBefore(newElement,newCell.childNodes[0]);
		} else {
			newCell.appendChild(newElement);
		}
	} else {
		if (newCell.childNodes.length > 0) {
			// in case there is a <DIV> element which means there is options table
			name = newCell.getAttribute('z');
			if (name) {
				if (name.match(/^<.*>$/)) {
					newCell.innerHTML = name.replace("&","&amp;").replace(">","&gt;").replace("<","&lt;") + newCell.innerHTML;
				} else {
					newCell.innerHTML = name.replace("&","&amp;") + newCell.innerHTML;
				}
			}
		} else {
			name = newCell.getAttribute('z');
			if (name) {
				if (name.match(/^<.*>$/)) {
					newCell.innerHTML = name.replace("&","&amp;").replace(">","&gt;").replace("<","&lt;");
				} else {
					newCell.innerHTML = name.replace("&","&amp;");
				}
			}
		}
	}
	tmp = newCell.getAttribute('t');
	if (tmp) {
		if (tmp.match(/^p$/i)) { //coverpoint
			if(pa_scope)
				newCell.innerHTML = "Power State " + newCell.innerHTML;
			else
				newCell.innerHTML = "Coverpoint: " + newCell.innerHTML;
		} else if (tmp.match(/^c$/i)) { // cross
			newCell.innerHTML = "Cross: " + newCell.innerHTML;
		}
	}
	if (excluded == 0) {
		if (binRHS) {
			tmp = newCell.getAttribute('rhs');

			// rhs Class
			classtype = cellClass[lastRowOdd];
			
			if (tmp)
				celltxt = tmp;
			else
				celltxt = '&nbsp;';
			createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, 0, 0, 0);
		}
		
		// Cell for 'al' AtLeast
		tmp = newCell.getAttribute('al');
		// atleast Class
		classtype = cellClass[lastRowOdd];
		
		if (tmp)
			celltxt = tmp;
		else
			celltxt = '&nbsp;';
		createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, 0, 0, 0);


		// Cell for 'tb' Total Bins
		tmp = newCell.getAttribute('tb');
		classtype = cellClass[lastRowOdd];
		if (tmp)
			celltxt = tmp;
		else
			celltxt = '&nbsp;';
		createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, 0, 0, 0);
		
		
		// Cell for 'cb' Covered Bins (for cross/coverpoint/... anything other than a bin)
		tmp = newCell.getAttribute('cb');
		classtype = cellClass[lastRowOdd];
		if (tmp) {
			celltxt = tmp;
		} else {
			// Cell for 'h' Hit (for bins)
			tmp = newCell.getAttribute('h');
			if (tmp) {
				celltxt = tmp;
			} else {
				celltxt = '&nbsp;';
			}
		}
		createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, 0, 0, 0);
		
		
		// Cell for 'q' % Hit
		tmp = newCell.getAttribute('q');
		classtype = cellClass[lastRowOdd];
		if (tmp)
			celltxt = tmp;
		else
			celltxt = '&nbsp;';
		createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, 0, 0, 0);
		
		
		// Cell for 'g' Goal
		tmp = newCell.getAttribute('g');
		// goal Class
		classtype = cellClassRight[lastRowOdd];
		
		if (tmp)
			celltxt = tmp + "%";
		else
			celltxt = '&nbsp;';
		createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, 0, 0, 0);
		
		// Cell for 'p' coverage percentage
		tmp = newCell.getAttribute('p');
		if (tmp)
			celltxt = tmp + "%";
		else
			celltxt = '&nbsp;';
		
		// coverage class
		classtype = cellClassRight[lastRowOdd];
		createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, 0, 0, 0);
		
		// Cell for 'pg' % of Goal 
		tmp = newCell.getAttribute('pg');
		
		tmp2 = newCell.getAttribute("c");
		switch (tmp2) {
			case 'Y': {
				classtype = 'bgYellow'; break;
			}
			case 'R': {
				classtype = 'bgRed'; break;
			}
			case 'G': {
				classtype = 'bgGreen';
			}
			default: {
				classtype = 0;
			}
		}
		if (tmp)
			celltxt = tmp + "%";
		else
			celltxt = '&nbsp;';
		createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, 0, 0, 0);
		
		// Cells for timestamp
		if (g_has_timestamp) {
			classtype = cellClass[lastRowOdd];
			createCell(newRow, 'TD', classtype, 0, 0, '&nbsp;', 0, 0, 0, 0); /* Covered SimTime */
			createCell(newRow, 'TD', classtype, 0, 0, '&nbsp;', 0, 0, 0, 0); /* Covered in Test */
		}
		
	} else {
		if (binRHS) {
			// rhs Class
			classtype = cellClassGrey[lastRowOdd];
			createCell(newRow, 'TD', classtype, 0, 0, '&nbsp;', 0, 0, 0, 0);
		}
		
		// Cell for 'al' AtLeast
		// atleast Class
		classtype = cellClassGrey[lastRowOdd];
		createCell(newRow, 'TD', classtype, 0, 0, '&nbsp;', 0, 0, 0, 0);

		// Cell for 'tb' Total Bins
		classtype = cellClassGrey[lastRowOdd];
		createCell(newRow, 'TD', classtype, 0, 0, '&nbsp;', 0, 0, 0, 0);
		
		// Cell for 'h' Hit/ or for 'cb' covered bins
		// hit Class
		classtype = cellClassGrey[lastRowOdd];
		createCell(newRow, 'TD', classtype, 0, 0, '&nbsp;', 0, 0, 0, 0);
		
		// Cell for 'q' Hit %
		classtype = cellClassGrey[lastRowOdd];
		createCell(newRow, 'TD', classtype, 0, 0, '&nbsp;', 0, 0, 0, 0);
		
		// Cell for 'g' Goal
		// goal Class
		classtype = cellClassRGrey[lastRowOdd];
		createCell(newRow, 'TD', classtype, 0, 0, '--', 0, 0, 0, 0);
		
		// Cell for 'p' coverage percentage
		// coverage class
		classtype = cellClassRGrey[lastRowOdd];
		createCell(newRow, 'TD', classtype, 0, 0, '--', 0, 0, 0, 0);
		
		// Cell for 'pg' % of Goal 
		createCell(newRow, 'TD', 'grey', 0, 0, 'Excluded', 0, 0, 0, 0);
	}
};


function createCell(row, type, classt, span, preTxt, txt, lnk, relAttribute, filterLabel, c_align) {
	var newElement, newCreatedCell;
	
	newCreatedCell = document.createElement(type);
	if (classt) {
		newCreatedCell.className = classt;
	}
	if (span > 1) {
		newCreatedCell.colSpan = span;
	}
	if (c_align) {
		newCreatedCell.align = c_align;
	}
	if (lnk) {
		if (preTxt) {
			newCreatedCell.innerHTML = preTxt;
		}
		newElement = document.createElement('a');
		newElement.setAttribute("href", lnk);
		if (relAttribute) {
			newElement.setAttribute("rel", relAttribute);
		}
		newElement.innerHTML = txt;
		newCreatedCell.appendChild(newElement);
	} else {
		newCreatedCell.innerHTML = txt;
	}
	if (filterLabel) {
		newCreatedCell.innerHTML = newCreatedCell.innerHTML + '&nbsp;';
		newElement = document.createElement('font');
		newElement.color = "#006699";
		newElement.innerHTML = "(Filtering Active)";
		newCreatedCell.appendChild(newElement);
	}
	
	row.appendChild(newCreatedCell);
	return;
};

function createCvgInstanceTableHeader(rowObj) {
	var colNum = 0;
	var celltxt;
	if(pa_scope) {
		celltxt = 'Power States / Bins';
	} else {
		celltxt = 'Coverpoints / Bins';
	}
	
	colNum++;
	colNum++;
	createCell(rowObj, 'TH', 'even', '2', 0, celltxt, 0, 0, 0, 0);
	
	if (binRHS) {
		colNum++;
		createCell(rowObj, 'TH', 'even', 0, 0, 'RHS', 0, 0, 0, 0);
	}

	colNum++; createCell(rowObj, 'TH', 'even', 0, 0, 'At Least', 0, 0, 0, 0);
	colNum++; createCell(rowObj, 'TH', 'even', 0, 0, 'Total Bins', 0, 0, 0, 0);
	colNum++; createCell(rowObj, 'TH', 'even', 0, 0, 'Covered Bins (Hits)', 0, 0, 0, 0);
	colNum++; createCell(rowObj, 'TH', 'even', 0, 0, '% Hit', 0, 0, 0, 0);
	colNum++; createCell(rowObj, 'TH', 'even', 0, 0, 'Goal', 0, 0, 0, 0);
	colNum++; createCell(rowObj, 'TH', 'even', 0, 0, 'Coverage', 0, 0, 0, 0);
	colNum++; createCell(rowObj, 'TH', 'even', 0, 0, '% of Goal', 0, 0, 0, 0);
	
	if (g_has_timestamp) {
		colNum++; createCell(rowObj, 'TH', 'even', 0, 0, 'Covered SimTime', 0, 0, 0, 0);
		colNum++; createCell(rowObj, 'TH', 'even', 0, 0, 'Covered in Test', 0, 0, 0, 0);
	}
	return colNum;
};

function createPreviousDiv () {
	var e = document.createElement("div");
	e.setAttribute("style", "width:15%;float:left;text-align:left;");
	return e;
}

function createNextDiv () {
	var e = document.createElement("div");
	e.setAttribute("style", "width:15%;float:right;text-align:right;");
	return e;
}

function createGotoDiv() {
	var e = document.createElement("div");
	e.setAttribute("style", "width:70%;float:left;text-align:center;");
	
	/* creating a combobox */
	var combo = document.createElement("select");
	/* adding options to the combo box */
	var option;
	// the 1st item in the combobox should be a blank space referring to
	// the current page.
	option = document.createElement("option");
	option.text = "";
	option.value = g_binFileIndex;
	combo.add(option, null);
	for (var i=0 ; i<g_filelist.length ; i++) {
		option = document.createElement("option");
		option.text = i+1;
		option.value = i;
		combo.add(option, null);
	}
	combo.setAttribute("style", "margin-left:5px;margin-right:5px;");
	
	/* adding the Go button */
	var goBtn = document.createElement("input");
	goBtn.type = "button";
	goBtn.value = "Go";
	goBtn.onclick = gotoPage;
	
	
	/* add all these to the div */
	e.innerHTML = "Displaying page " + (g_binFileIndex+1) + " of " + g_filelist.length + " --- Go to page: "
	e.appendChild(combo);
	e.appendChild(goBtn);
	
	return e;
}

function buildNavigationHyperLinks (colsNum, rowObj) {
	
	if (g_filelist.length < 2) {
		/* only one page */
		return;
	}
	
	var td = document.createElement("td");
	td.colSpan = colsNum;
	
	/* adding 4 divs to have something similar to the follosing
	 *	<style>
	 *		div.prev {width:33%;float:left;text-align:left;}
	 *		div.home {width:33%;float:left;text-align:center;}
	 *		div.next {width:33%;float:right;text-align:right;}
	 *	</style>
	 *	<div> <!-- grouping div -->
	 *	<div class="prev"><a class="chapter" href="XXX">« Previous</a></div>
	 *	<div class="home"><a class="chapter" href="XXX">Go to</a></div>
	 *	<div class="next"><a class="chapter" href="XXX">Next »</a></div>
	 *	</div>
	 */
	var groupingDiv = document.createElement("div");
	var previousDiv = createPreviousDiv();
	var gotoDiv = createGotoDiv();
	var nextDiv = createNextDiv();
	groupingDiv.appendChild(previousDiv);
	groupingDiv.appendChild(gotoDiv);
	groupingDiv.appendChild(nextDiv);
	td.appendChild(groupingDiv);
	rowObj.appendChild(td);
	
	var a, linkText;
	if (g_binFileIndex != 0) {
		// add previous hyper link
		a = document.createElement('a');
		linkText = document.createTextNode(" < Previous");
		a.appendChild(linkText);
		a.href = g_filelist[g_binFileIndex-1];
		previousDiv.appendChild(a);
	} else {
		previousDiv.innerHTML = '&nbsp;';
	}
	
	if (g_binFileIndex != (g_filelist.length - 1)) {
		// add next hyper link
		a = document.createElement('a');
		linkText = document.createTextNode(" Next >");
		a.appendChild(linkText);
		a.href = g_filelist[g_binFileIndex+1];
		nextDiv.appendChild(a);
	} else {
		nextDiv.innerHTML = '&nbsp;';
	}
};

function buildBinsTables () {
	var table = document.getElementById("bindata");
	
	table.cellpadding = "2";
	table.cellspacing = "2";
	
	//buildBinsTableFirstRow(table.rows[0]);
	
	var colsnum = createCvgInstanceTableHeader(table.rows[1]);
	
	buildNavigationHyperLinks(colsnum,table.rows[0]);

	lastRowOdd = 0;
	
	var newRow, newCell;
	//Loop on the rest of the rows in the table
	for (var r = 2; r < table.rows.length; r++) {
		excluded = 0;
		newRow = table.rows[r];
		newCell = newRow.cells[0];
		if (!(newCell.getAttribute('t').match(/^b$/i))) {
			// a coverpoint or cross
			createCvpCrsRow(newRow, newCell);
		} else /* if (newCell.getAttribute('t').match(/^b$/i)) */{
			// covergroup bin
			createCvgBinRow(newRow, newCell);

		}
		lastRowOdd = lastRowOdd ? 0 : 1;
	} // end loop over rest of rows
	
};

buildBinsTables();
