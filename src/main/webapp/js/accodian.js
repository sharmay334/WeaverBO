// JavaScript Document

/*first*/
var isOpen1 = true;

function open1() {
	if (!isOpen1) {

		document.getElementById('accordian_content1').style.display = "block";
		isOpen1 = true;
		document.getElementById('min').className = "minus1";
		if (isOpen2) {
			isOpen2 = true;
			open2();
		} else if (isOpen3) {
			isOpen3 = true;
			open3();
		}

	} else {
		document.getElementById('accordian_content1').style.display = "none";
		isOpen1 = false;
		document.getElementById('min').className = "plus1";
	}

}

/* second */
var isOpen2 = false;

function open2() {
	if (!isOpen2) {
		document.getElementById('accordian_content2').style.display = "block";
		isOpen2 = true;
		document.getElementById('min2').className = "minus1";
		if (isOpen1) {
			isOpen1 = true;
			open1();
		} else if (isOpen3) {
			isOpen3 = true;
			open3();
		}
	} else {
		document.getElementById('accordian_content2').style.display = "none";
		isOpen2 = false;
		document.getElementById('min2').className = "plus1";
	}
}

/* third */
var isOpen3 = false;

function open3() {
	if (!isOpen3) {
		document.getElementById('accordian_content3').style.display = "block";
		isOpen3 = true;
		document.getElementById('min3').className = "minus1";
		if (isOpen2) {
			isOpen2 = true;
			open2();
		} else if (isOpen1) {
			isOpen1 = true;
			open1();
		}
	} else {
		document.getElementById('accordian_content3').style.display = "none";
		isOpen3 = false;
		document.getElementById('min3').className = "plus1";
	}
}