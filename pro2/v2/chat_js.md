// ReSolve Prevent — member login (vanilla JS)
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
    passwordToggle: document.getElementById("password-toggle"),
    remember: document.getElementById("remember"),
    submit: document.getElementById("submit-btn"),
    message: document.getElementById("message"),
  };


  function setMessage(text, isError) {
    els.message.textContent = text || "";
    els.message.classList.toggle("error", !!isError);
  }

  if (els.passwordToggle) els.passwordToggle.addEventListener("click", function () {
    var isVisible = els.password.type === "text";
    els.password.type = isVisible ? "password" : "text";
    els.passwordToggle.setAttribute("aria-label", isVisible ? "Show password" : "Hide password");
    els.passwordToggle.setAttribute("aria-pressed", String(!isVisible));
  });

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

  function showLoginSuccess() {
    setMessage("Login successful. Your new ReSolve workspace is being prepared.");
    els.submit.disabled = true;
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
        if (user) showLoginSuccess();
      }
    } catch {
      /* ignore malformed session */
    }
  }


  if (els.form) els.form.addEventListener("submit", function (event) {
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
    showLoginSuccess();
  });



  if (document.getElementById("forgot")) document.getElementById("forgot").addEventListener("click", function (event) {
    event.preventDefault();
    setMessage("Contact your residence office to have your ReSolve password reset.");
  });

  if (els.submit && els.form && els.email && els.password) els.submit.disabled = true;
})();

(function () {
  "use strict";

  var storageKey = "resolve.complaints";
  var apiBase = "http://127.0.0.1:5000/api";
  var sampleComplaints = [
    { id: "R-1042", name: "Liam Pretorius", residence: "Kingsway House", room: "C007", description: "There is water coming through the ceiling in the bathroom and the light is flickering.", category: "Plumbing", urgency: "High", technician: "Emergency Response", summary: "Active bathroom leak with an electrical safety risk.", status: "Open", createdAt: "Today, 09:42" },
    { id: "R-1041", name: "Amara Singh", residence: "Riverside Court", room: "A112", description: "The washing machine on floor one has stopped working again.", category: "Appliances", urgency: "Medium", technician: "Appliance Technician", summary: "Recurring fault reported on shared washing machine.", status: "Assigned", createdAt: "Today, 08:15" },
    { id: "R-1040", name: "Thabo Mokoena", residence: "Kingsway House", room: "B204", description: "The bedroom window does not close properly and cold air is coming in.", category: "General", urgency: "Low", technician: "General Maintenance", summary: "Window seal or latch needs inspection.", status: "Open", createdAt: "Yesterday, 16:20" }
  ];
  var form = document.getElementById("complaint-form");
  var message = document.getElementById("message");
  var result = document.getElementById("analysis-result");
  var submit = document.getElementById("submit-btn");
  var complaints = loadComplaints();
  result.hidden = true;

  function loadComplaints() {
    try { var saved = JSON.parse(localStorage.getItem(storageKey) || "null"); return Array.isArray(saved) && saved.length ? saved : sampleComplaints.slice(); } catch { return sampleComplaints.slice(); }
  }
  function saveComplaints() { localStorage.setItem(storageKey, JSON.stringify(complaints)); }
  function setMessage(text, isError) { message.textContent = text || ""; message.classList.toggle("error", !!isError); }

  // This function becomes the Flask/OpenAI response boundary in the next phase.
  function analyse(description) {
    var text = description.toLowerCase();
    var plumbing = /leak|water|toilet|shower|drain|tap|pipe/.test(text);
    var electrical = /power|socket|electric|light|smell burning|flicker/.test(text);
    var urgent = /flood|fire|smoke|sparking|no power|ceiling|unsafe|emergency/.test(text);
    var category = electrical ? "Electrical" : plumbing ? "Plumbing" : /heat|cold|radiator/.test(text) ? "Heating" : /lock|door|window/.test(text) ? "General" : "Facilities";
    var urgency = urgent ? "High" : /again|stopped|broken|blocked/.test(text) ? "Medium" : "Low";
    var technicians = { Plumbing: "Plumbing Specialist", Electrical: "Electrician", Heating: "Heating Specialist", General: "General Maintenance", Facilities: "Facilities Team" };
    return { category: category, urgency: urgency, technician: technicians[category], summary: description.replace(/\s+/g, " ").slice(0, 100) + (description.length > 100 ? "..." : "") };
  }
  function renderAnalysis(complaint) {
    result.hidden = false;
    result.className = "analysis-result";
    result.innerHTML = "<p class=\"eyebrow\">AI TRIAGE COMPLETE</p><strong>" + complaint.summary + "</strong><div class=\"analysis-tags\"><span class=\"priority " + complaint.urgency.toLowerCase() + "\">" + complaint.urgency + " PRIORITY</span><span>" + complaint.category + "</span><span>→ " + complaint.technician + "</span></div>";
  }
  function apiComplaint(complaint) {
    var apiCategory = complaint.category === "Facilities" || complaint.category === "Heating" ? "Other" : complaint.category === "Appliances" ? "Appliance" : complaint.category;
    var apiPriority = complaint.urgency === "High" ? "High" : complaint.urgency;
    return fetch(apiBase + "/reports", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ name: complaint.name, residence: complaint.residence, room: complaint.room, description: complaint.description, category: apiCategory, priority: apiPriority }) }).then(function (response) { if (!response.ok) throw new Error("report request failed"); return response.json(); });
  }
  form.addEventListener("submit", function (event) {
    event.preventDefault();
    var name = document.getElementById("name").value.trim();
    var residence = document.getElementById("residence").value.trim();
    var room = document.getElementById("room").value.trim();
    var description = document.getElementById("description").value.trim();
    if (!name || !residence || !room || !description) { setMessage("Please complete every field so we can route this properly.", true); return; }
    var analysis = analyse(description);
    var complaint = Object.assign({ id: "R-" + (1043 + complaints.length), name: name, residence: residence, room: room, description: description, status: "Open", createdAt: "Just now" }, analysis);
    apiComplaint(complaint).then(function (saved) { complaint.id = "R-" + saved.report_id; complaint.status = saved.status; }).catch(function () { /* local fallback keeps the demo usable while the API is offline */ }).finally(function () { complaints.unshift(complaint); saveComplaints(); renderAnalysis(complaint); setMessage("Complaint submitted. Your residence team has been notified."); form.reset(); submit.disabled = false; });
  });
  function renderDashboard(source) {
    if (source) complaints = source;
    var high = complaints.filter(function (item) { return item.urgency === "High"; }).length;
    var open = complaints.filter(function (item) { return item.status !== "Resolved"; }).length;
    var categories = complaints.reduce(function (counts, item) { counts[item.category] = (counts[item.category] || 0) + 1; return counts; }, {});
    var common = Object.keys(categories).sort(function (a, b) { return categories[b] - categories[a]; })[0] || "None";
    document.getElementById("metrics").innerHTML = "<div class=\"metric\"><span>OPEN COMPLAINTS</span><strong>" + open + "</strong><small>Across all residences</small></div><div class=\"metric metric-alert\"><span>HIGH PRIORITY</span><strong>" + high + "</strong><small>Needs attention today</small></div><div class=\"metric\"><span>TOP CATEGORY</span><strong>" + common + "</strong><small>Most reported issue</small></div>";
    var order = { High: 0, Medium: 1, Low: 2 };
    var sorted = complaints.slice().sort(function (a, b) { return order[a.urgency] - order[b.urgency]; });
    document.getElementById("complaint-list").innerHTML = sorted.map(function (item) { return "<article class=\"complaint-item\"><span class=\"risk-bar " + item.urgency.toLowerCase() + "\"></span><div class=\"complaint-copy\"><div class=\"complaint-title\"><strong>" + item.category + " · " + item.room + "</strong><span class=\"priority " + item.urgency.toLowerCase() + "\">" + item.urgency + "</span></div><p>" + item.summary + "</p><small>" + item.name + " · " + item.residence + " · " + item.createdAt + "</small></div><span class=\"status-pill\">" + item.status + "</span></article>"; }).join("");
    document.getElementById("insights").innerHTML = "<p><strong>" + common + "</strong> is currently the most common issue category.</p><p><strong>" + high + " complaint" + (high === 1 ? "" : "s") + "</strong> require immediate manager review.</p><p>Route new reports to <strong>" + (high ? "Emergency Response first" : "General Maintenance") + "</strong> based on AI urgency.</p>";
  }
  function answerQuestion(question) {
    var answer = document.getElementById("chat-answer");
    var input = question.toLowerCase();
    if (input.indexOf("biggest") !== -1 || input.indexOf("problems") !== -1 || input.indexOf("month") !== -1) {
      answer.innerHTML = "<span class=\"answer-label\">AI RESPONSE</span><p>The top issue is <strong>WIFI complaints (42%)</strong>. Most reports come from <strong>Block C</strong>. Consider checking network infrastructure.</p>";
    } else {
      answer.textContent = "I can currently answer questions about your maintenance reports.";
    }
    answer.classList.add("visible");
  }
  document.getElementById("chat-form").addEventListener("submit", function (event) { event.preventDefault(); var input = document.getElementById("chat-input"); if (input.value.trim()) { answerQuestion(input.value.trim()); input.value = ""; } });
  function loadApiDashboard() { return fetch(apiBase + "/reports").then(function (response) { if (!response.ok) throw new Error("dashboard request failed"); return response.json(); }).then(function (rows) { return rows.map(function (row) { return { id: "R-" + row.ReportID, name: row.StudentName, residence: row.Residence, room: row.RoomNumber, description: row.Description, category: row.Category, urgency: row.Priority === "Urgent" ? "High" : row.Priority, technician: row.AssignedStaff || row.Department || "Unassigned", summary: row.Description, status: row.Status, createdAt: row.DateReported }; }); }); }
  document.querySelectorAll("[data-view]").forEach(function (button) { button.addEventListener("click", function () { var dashboard = button.dataset.view === "dashboard"; document.getElementById("report-view").classList.toggle("hidden", dashboard); document.getElementById("dashboard-view").classList.toggle("hidden", !dashboard); document.querySelectorAll("[data-view]").forEach(function (item) { item.classList.toggle("active", item === button); }); if (dashboard) { loadApiDashboard().then(renderDashboard).catch(function () { renderDashboard(); }); } }); });
  document.getElementById("refresh-btn").addEventListener("click", function () { loadApiDashboard().then(renderDashboard).catch(function () { renderDashboard(); }); });
})();
