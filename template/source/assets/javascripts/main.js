// From index.js in original Bootiful
booty();
function booty() {
  window.bootiful = {};
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
    let selector = '.toast';
    if (which) {
      selector += '.' + which;
    }
    // let toastElList = [].slice.call(document.querySelectorAll(selector));
    // let toastList = toastElList.map(function (toastEl) {
    //   return new bootstrap.Toast(toastEl);
    // });
    const toastElList = document.querySelectorAll('.toast')
    const toastList = [...toastElList].map(toastEl => new bootstrap.Toast(toastEl))

    toastList.forEach(function (element, index) {
      element.show();
    });
  };


  if (bootiful.urlParam('email') === '' || bootiful.urlParam('password') === '') {
    bootiful.displayToasts()
    if (bootiful.urlParam('email') === '') {
      document.getElementById('email').value = ' '
      document.getElementById('email').classList.add("is-invalid")
    }
    if (bootiful.urlParam('password') === '') {
      document.getElementById('password').value = ' '
      document.getElementById('password').classList.add("is-invalid")
    }
  } else {
    if (bootiful.urlParam('commit') === 'Continue') {
      window.location.href = '/admin?successful_login=true'
    }
  }
}

