// ReSolve — dashboard bootstrap (vanilla JS)
(function () {
  "use strict";

  var isAdminPage = /admin\.html$/.test(location.pathname);

  function go(url) {
    location.replace(url);
  }

  var active = null;
  try {
    active = JSON.parse(sessionStorage.getItem("resolve.session") || "null");
  } catch (e) {
    active = null;
  }

  if (!active || !active.email) {
    go("index.html");
    return;
  }

  fetch("users.json")
    .then(function (res) {
      return res.json();
    })
    .then(function (data) {
      var users = data.users || [];
      var user = null;
      for (var i = 0; i < users.length; i++) {
        if (users[i].email.toLowerCase() === String(active.email).toLowerCase()) {
          user = users[i];
          break;
        }
      }
      if (!user) return go("index.html");
      if (user.role === "admin" && !isAdminPage) return go("admin.html");
      if (user.role !== "admin" && isAdminPage) return go("student.html");

      document.getElementById("welcome").textContent = "Welcome, " + user.name;

      if (isAdminPage) {
        document.getElementById("department").textContent = user.department || "";
      } else {
        document.getElementById("room").textContent = "Room " + user.room;
        document.getElementById("residence").textContent = user.residence;
      }
    })
    .catch(function () {
      go("index.html");
    });

  document.getElementById("signout-btn").addEventListener("click", function () {
    sessionStorage.removeItem("resolve.session");
    go("index.html");
  });
})();
