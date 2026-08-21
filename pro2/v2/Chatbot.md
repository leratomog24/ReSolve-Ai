<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>ReSolve — Student maintenance, sorted</title>
    <meta
      name="description"
      content="Report residence maintenance issues in plain language and let ReSolve route them intelligently."
    />
    <meta property="og:title" content="ReSolve — Student maintenance, sorted" />
    <meta
      property="og:description"
      content="AI-assisted maintenance reporting for student residences."
    />
    <meta property="og:type" content="website" />
    <meta name="twitter:card" content="summary_large_image" />
    <link rel="icon" href="/favicon.ico" type="image/x-icon" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700;800&family=DM+Sans:wght@400;500;700&display=swap"
    />
    <link rel="stylesheet" href="styles.css" />
  </head>
  <body>
    <div class="frame">
      <div class="panel">
        <header class="topbar">
          <a class="logo" href="index.html"><strong>RE</strong><span>SOLVE</span></a>
          <nav class="nav" aria-label="Primary navigation">
            <button class="nav-link active" type="button" data-view="report">REPORT ISSUE</button>
            <button class="nav-link" type="button" data-view="dashboard">MANAGER VIEW</button>
          </nav>
        </header>

        <main class="layout" id="report-view">
          <section class="hero">
            <p class="eyebrow light">STUDENT RESIDENCE MAINTENANCE</p>
            <h1>Say what’s broken.<br /><em>We’ll sort the rest.</em></h1>
            <p class="tagline">Plain-language reporting, intelligently routed.</p>
            <p class="copy">
              Tell us what happened in your own words. ReSolve analyses the issue, flags urgency,
              and sends it toward the right maintenance specialist.
            </p>
            <div class="process"><span>01</span> DESCRIBE <i></i><span>02</span> ANALYSE <i></i><span>03</span> RESOLVE</div>
          </section>

          <section>
            <div class="card">
              <div class="card-heading">
                <p class="eyebrow">NEW COMPLAINT</p>
                <span class="live-dot">AI READY</span>
              </div>
              <h2>What needs attention?</h2>
              <form id="complaint-form" novalidate>
                <label for="name">YOUR NAME</label>
                <input id="name" type="text" placeholder="e.g. Amara Singh" autocomplete="name" required />
                <div class="field-row">
                  <div><label for="residence">RESIDENCE</label><input id="residence" type="text" placeholder="e.g. Riverside Court" required /></div>
                  <div><label for="room">ROOM</label><input id="room" type="text" placeholder="e.g. A112" required /></div>
                </div>
                <label for="description">DESCRIBE THE PROBLEM</label>
                <textarea id="description" rows="5" placeholder="The shower has been leaking since yesterday..." required></textarea>
                <div class="helper">Include when it started and anything that makes it worse.</div>
                <button class="btn-primary" id="submit-btn" type="submit">ANALYSE &amp; SEND <span>→</span></button>
              </form>
              <div class="analysis-result" id="analysis-result" role="status" hidden></div>
              <p class="message" id="message" role="status"></p>
            </div>
          </section>
        </main>

        <main class="dash hidden" id="dashboard-view">
          <div class="dashboard-heading">
            <div><p class="eyebrow light">MANAGER OVERVIEW</p><h1>Maintenance pulse.</h1><p class="copy">A live view of resident complaints, triaged by ReSolve AI.</p></div>
            <button class="btn-outline small" id="refresh-btn" type="button">REFRESH DATA</button>
          </div>
          <div class="metrics" id="metrics"></div>
          <section class="dashboard-panel">
            <div class="section-heading"><div><p class="eyebrow">INBOX</p><h2>Complaints by urgency</h2></div><span class="preview-badge">DEMO DATA</span></div>
            <div class="complaint-list" id="complaint-list"></div>
          </section>
          <section class="insights-panel"><div class="section-heading"><div><p class="eyebrow">AI INSIGHTS</p><h2>What the residence is telling you</h2></div></div><div id="insights" class="insights"></div></section>
          <section class="assistant-panel">
            <div class="section-heading"><div><p class="eyebrow">RESOLVE ASSISTANT</p><h2>Ask about your maintenance data</h2></div><span class="live-dot">ONLINE</span></div>
            <form class="chat-form" id="chat-form">
              <label class="visually-hidden" for="chat-input">Ask ReSolve a question</label>
              <input id="chat-input" type="text" placeholder="Ask a question about your reports..." autocomplete="off" />
              <button class="btn-primary" type="submit" aria-label="Ask ReSolve">ASK <span>→</span></button>
            </form>
            <div class="chat-answer" id="chat-answer" role="status" aria-live="polite"></div>
          </section>
        </main>
      </div>
    </div>

    <script src="app.js"></script>
  </body>
</html>
