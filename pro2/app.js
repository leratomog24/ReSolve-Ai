// ReSolve — member login (vanilla JS)
// Credentials are checked against a pre-registered directory of student and
// admin accounts held in users.json.
(function () {
  "use strict";

  var directory = [];
  var directoryReady = false;

  var els = {
    nav: document.getElementById("nav"),
    form: document.getElementById("auth-form"),
    email: document.getElementById("email"),
    password: document.getElementById("password"),
    remember: document.getElementById("remember"),
    submit: document.getElementById("submit-btn"),
    message: document.getElementById("message"),
  };


  function setMessage(text, isError) {
    els.message.textContent = text || "";
    els.message.classList.toggle("error", !!isError);
  }

  // Nav links come from config.json
  fetch("config.json")
    .then(function (res) {
      return res.json();
    })
    .then(function (config) {
      (config.nav || []).forEach(function (label) {
        var a = document.createElement("a");
        a.href = "#";
        a.textContent = label;
        els.nav.appendChild(a);
      });
    })
    .catch(function () {
      /* nav is optional */
    });

  // Pre-registered accounts
  fetch("users.json")
    .then(function (res) {
      return res.json();
    })
    .then(function (data) {
      directory = data.users || [];
      directoryReady = true;
      els.submit.disabled = false;
      restoreSession();
    })
    .catch(function () {
      setMessage("Account directory unavailable. Please try again later.", true);
    });

  function findUser(email, password) {
    for (var i = 0; i < directory.length; i++) {
      var u = directory[i];
      if (u.email.toLowerCase() === email && u.password === password) return u;
    }
    return null;
  }

  function findByEmail(email) {
    for (var i = 0; i < directory.length; i++) {
      if (directory[i].email.toLowerCase() === email) return directory[i];
    }
    return null;
  }

  function goToDashboard(user) {
    location.href = user.role === "admin" ? "admin.html" : "student.html";
  }

  function restoreSession() {
    var remembered = localStorage.getItem("resolve.remember");
    if (remembered) {
      els.email.value = remembered;
      els.remember.checked = true;
    }
    try {
      var active = JSON.parse(sessionStorage.getItem("resolve.session") || "null");
      if (active && active.email) {
        var user = findByEmail(active.email.toLowerCase());
        if (user) goToDashboard(user);
      }
    } catch (e) {
      /* ignore malformed session */
    }
  }


  els.form.addEventListener("submit", function (event) {
    event.preventDefault();

    if (!directoryReady) {
      setMessage("Still loading the account directory — one moment.", true);
      return;
    }

    var email = els.email.value.trim().toLowerCase();
    var password = els.password.value;

    if (!email || email.indexOf("@") === -1) {
      setMessage("Please enter a valid email address.", true);
      return;
    }
    if (!password) {
      setMessage("Please enter your password.", true);
      return;
    }

    var user = findUser(email, password);
    if (!user) {
      setMessage("These credentials don't match a registered ReSolve account.", true);
      return;
    }

    if (els.remember.checked) {
      localStorage.setItem("resolve.remember", user.email);
    } else {
      localStorage.removeItem("resolve.remember");
    }

    sessionStorage.setItem(
      "resolve.session",
      JSON.stringify({ email: user.email, role: user.role })
    );
    els.password.value = "";
    goToDashboard(user);
  });



  document.getElementById("forgot").addEventListener("click", function (event) {
    event.preventDefault();
    setMessage("Contact your residence office to have your ReSolve password reset.");
  });

  els.submit.disabled = true;
})();
