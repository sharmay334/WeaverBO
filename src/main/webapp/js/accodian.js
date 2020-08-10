// JavaScript Document

/*first*/



function openAlertBox(){
	
	var modal = document.getElementById("noti_myModal");

	// Get the button that opens the modal

	// Get the <span> element that closes the modal
	var span = document.getElementsByClassName("noti_close")[0];

	// When the user clicks the button, open the modal 
	  modal.style.display = "block";

	// When the user clicks on <span> (x), close the modal
	span.onclick = function() {
	  modal.style.display = "none";
	}

	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
	  if (event.target == modal) {
	    modal.style.display = "none";
	  }
	}
}
function openAlertBoxPO(){
	
	var modal = document.getElementById("noti_myModal_po");

	// Get the button that opens the modal

	// Get the <span> element that closes the modal
	var span = document.getElementsByClassName("noti_close_po")[0];

	// When the user clicks the button, open the modal 
	  modal.style.display = "block";

	// When the user clicks on <span> (x), close the modal
	span.onclick = function() {
	  modal.style.display = "none";
	}

	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
	  if (event.target == modal) {
	    modal.style.display = "none";
	  }
	}
}

function openAlertBoxSO(){
	
	var modal = document.getElementById("noti_myModal_so");

	// Get the button that opens the modal

	// Get the <span> element that closes the modal
	var span = document.getElementsByClassName("noti_close_so")[0];

	// When the user clicks the button, open the modal 
	  modal.style.display = "block";

	// When the user clicks on <span> (x), close the modal
	span.onclick = function() {
	  modal.style.display = "none";
	}

	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
	  if (event.target == modal) {
	    modal.style.display = "none";
	  }
	}
}

function openAlertBoxCN(){
	
	var modal = document.getElementById("noti_myModal_cn");

	// Get the button that opens the modal

	// Get the <span> element that closes the modal
	var span = document.getElementsByClassName("noti_close_cn")[0];

	// When the user clicks the button, open the modal 
	  modal.style.display = "block";

	// When the user clicks on <span> (x), close the modal
	span.onclick = function() {
	  modal.style.display = "none";
	}

	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
	  if (event.target == modal) {
	    modal.style.display = "none";
	  }
	}
}
function openAlertBoxDN(){
	
	var modal = document.getElementById("noti_myModal_dn");

	// Get the button that opens the modal

	// Get the <span> element that closes the modal
	var span = document.getElementsByClassName("noti_close_dn")[0];

	// When the user clicks the button, open the modal 
	  modal.style.display = "block";

	// When the user clicks on <span> (x), close the modal
	span.onclick = function() {
	  modal.style.display = "none";
	}

	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
	  if (event.target == modal) {
	    modal.style.display = "none";
	  }
	}
}

function openAlertBoxPMT(){
	
	var modal = document.getElementById("noti_myModal_pmt");

	// Get the button that opens the modal

	// Get the <span> element that closes the modal
	var span = document.getElementsByClassName("noti_close_pmt")[0];

	// When the user clicks the button, open the modal 
	  modal.style.display = "block";

	// When the user clicks on <span> (x), close the modal
	span.onclick = function() {
	  modal.style.display = "none";
	}

	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
	  if (event.target == modal) {
	    modal.style.display = "none";
	  }
	}
}
function openAlertBoxRCPT(){
	
	var modal = document.getElementById("noti_myModal_rcpt");

	// Get the button that opens the modal

	// Get the <span> element that closes the modal
	var span = document.getElementsByClassName("noti_close_rcpt")[0];

	// When the user clicks the button, open the modal 
	  modal.style.display = "block";

	// When the user clicks on <span> (x), close the modal
	span.onclick = function() {
	  modal.style.display = "none";
	}

	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
	  if (event.target == modal) {
	    modal.style.display = "none";
	  }
	}
}


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