// Importing JavaScript
//
// You have two choices for including Bootstrap's JS files—the whole thing,
// or just the bits that you need.


// Option 1
//
// Import Bootstrap's bundle (all of Bootstrap's JS + Popper.js dependency)

import "../../node_modules/bootstrap/dist/js/bootstrap.bundle.min.js";


// Option 2
//
// Import just what we need

// If you're importing tooltips or popovers, be sure to include our Popper.js dependency
// import "../../node_modules/popper.js/dist/popper.min.js";

// import "../../node_modules/bootstrap/js/dist/util.js";
// import "../../node_modules/bootstrap/js/dist/modal.js";

// From index.js in original Bootiful
window.bootiful = {}

/*
*
* '' param is present but empty
* null param is not present
* undefined there are no parameters
*/
bootiful.urlParam = function (name) {
  let result = undefined;
  let candidates_array = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
  if ((candidates_array?.length || 0) > 1) {
    if (typeof candidates_array[1] === "string") {
      result = decodeURIComponent(candidates_array[1]); // param present and filled
    }
  } else {
    result = null; // param not present
  }
  return result;
};

bootiful.displayToasts = function (which) {
  let selector = '.toast'
  if (which) {
    selector += '.' + which
  }
  let toastElList = [].slice.call(document.querySelectorAll(selector))
  let toastList = toastElList.map(function (toastEl) {
    return new bootstrap.Toast(toastEl)
  })
  toastList.forEach( function(element, index) {
    element.show()
  })
}
