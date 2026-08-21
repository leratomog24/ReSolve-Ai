:root {
  --brand-deep: #123a9e;
  --brand-mid: #1160cf;
  --brand-bright: #1f7ae0;
  --panel-shadow: 0 30px 80px -30px rgba(8, 24, 66, 0.75);
  --card-shadow: 0 24px 60px -24px rgba(8, 24, 66, 0.55);
  --card-bg: #eef1f4;
  --card-fg: #1c2536;
  --muted-fg: #5d6a80;
  --white: #ffffff;
}

* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body {
  min-height: 100vh;
  font-family: "DM Sans", system-ui, sans-serif;
  color: var(--white);
  background: linear-gradient(135deg, var(--brand-deep), var(--brand-mid) 45%, var(--brand-bright));
  padding: 2rem 1rem;
}

h1,
h2,
.display {
  font-family: "Outfit", system-ui, sans-serif;
}

.frame {
  position: relative;
  max-width: 1200px;
  margin: 0 auto;
}

.frame::after {
  content: "";
  position: absolute;
  left: -12px;
  bottom: -12px;
  width: 100%;
  height: 100%;
  border-left: 8px solid var(--brand-deep);
  border-bottom: 8px solid var(--brand-deep);
  z-index: 0;
}

.panel {
  position: relative;
  z-index: 1;
  overflow: hidden;
  background: linear-gradient(120deg, var(--brand-mid), var(--brand-bright));
  box-shadow: var(--panel-shadow);
  padding: 3rem 4rem;
}

.panel::before,
.panel::after {
  content: "";
  position: absolute;
  border-radius: 50%;
  pointer-events: none;
}

.panel::before {
  inset: -40% -20% auto -60%;
  height: 190%;
  background: linear-gradient(120deg, rgba(255, 255, 255, 0.12), transparent 60%);
}

.panel::after {
  inset: 10% -50% -60% 10%;
  background: linear-gradient(200deg, rgba(255, 255, 255, 0.08), transparent 55%);
}

.topbar,
.layout {
  position: relative;
  z-index: 2;
}

.topbar {
  display: flex;
  flex-wrap: wrap;
  gap: 1rem;
  align-items: center;
  justify-content: space-between;
}

.logo {
  font-family: "Outfit", system-ui, sans-serif;
  font-size: 1.5rem;
  letter-spacing: 0.18em;
  color: var(--white);
  text-decoration: none;
}

.logo strong {
  font-weight: 800;
}

.logo span {
  font-weight: 300;
}

.nav {
  display: flex;
  gap: 1.75rem;
}

.nav a {
  font-family: "Outfit", system-ui, sans-serif;
  font-size: 0.9rem;
  color: rgba(255, 255, 255, 0.85);
  text-decoration: none;
  transition: color 0.2s ease;
}

.nav a:hover {
  color: var(--white);
}

.layout {
  display: grid;
  grid-template-columns: 1.1fr 0.9fr;
  gap: 4rem;
  align-items: center;
  margin-top: 5rem;
}

.hero h1 {
  font-size: clamp(3rem, 6vw, 4.5rem);
  font-weight: 800;
  line-height: 0.95;
}

.hero .tagline {
  font-family: "Outfit", system-ui, sans-serif;
  font-size: 1.4rem;
  font-weight: 600;
  margin-top: 0.75rem;
}

.hero p.copy {
  max-width: 36rem;
  margin-top: 1.5rem;
  font-size: 0.98rem;
  font-weight: 500;
  line-height: 1.65;
  color: rgba(255, 255, 255, 0.87);
}

.btn-outline {
  display: inline-block;
  margin-top: 2rem;
  padding: 0.8rem 2rem;
  border: 2px solid var(--white);
  border-radius: 999px;
  font-family: "Outfit", system-ui, sans-serif;
  font-size: 0.85rem;
  font-weight: 600;
  letter-spacing: 0.05em;
  color: var(--white);
  text-decoration: none;
  transition:
    background 0.2s ease,
    color 0.2s ease;
}

.btn-outline:hover {
  background: var(--white);
  color: var(--brand-mid);
}

.dots {
  display: flex;
  gap: 0.75rem;
  margin-top: 2rem;
}

.dots span {
  width: 0.85rem;
  height: 0.85rem;
  border: 2px solid var(--white);
  border-radius: 50%;
}

.dots span.active {
  background: var(--white);
}

.card {
  background: var(--card-bg);
  color: var(--card-fg);
  border-radius: 1.75rem;
  padding: 3rem 2.5rem;
  box-shadow: var(--card-shadow);
  max-width: 26rem;
  margin: 0 auto;
  width: 100%;
}

.card h2 {
  text-align: center;
  font-size: 0.9rem;
  letter-spacing: 0.35em;
  font-weight: 500;
}

form {
  margin-top: 2.5rem;
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

input[type="text"],
input[type="email"],
input[type="password"] {
  width: 100%;
  padding: 0.8rem 1.5rem;
  border: 2px solid var(--card-fg);
  border-radius: 999px;
  background: transparent;
  text-align: center;
  font-family: "Outfit", system-ui, sans-serif;
  font-size: 0.85rem;
  letter-spacing: 0.05em;
  color: var(--card-fg);
}

.password-field {
  position: relative;
  width: 100%;
}

.password-field input {
  padding-right: 3.25rem;
}

.password-toggle {
  position: absolute;
  top: 50%;
  right: 0.8rem;
  display: grid;
  width: 2rem;
  height: 2rem;
  padding: 0;
  place-items: center;
  border: 0;
  border-radius: 50%;
  background: transparent;
  color: var(--card-fg);
  cursor: pointer;
  transform: translateY(-50%);
}

.password-toggle:hover,
.password-toggle:focus-visible {
  background: rgba(28, 37, 54, 0.1);
}

.password-toggle:focus-visible {
  outline: 2px solid var(--brand-mid);
  outline-offset: 2px;
}

.eye-icon {
  width: 1.1rem;
  height: 1.1rem;
  fill: none;
  stroke: currentColor;
  stroke-linecap: round;
  stroke-linejoin: round;
  stroke-width: 1.8;
}

input::placeholder {
  color: rgba(28, 37, 54, 0.7);
}

input:focus {
  outline: 2px solid var(--brand-mid);
  outline-offset: 2px;
}

.actions {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 1rem;
  padding-top: 0.75rem;
}

.btn-primary {
  padding: 0.65rem 2.25rem;
  border: none;
  border-radius: 999px;
  background: var(--brand-mid);
  color: var(--white);
  font-family: "Outfit", system-ui, sans-serif;
  font-size: 0.85rem;
  font-weight: 600;
  letter-spacing: 0.05em;
  cursor: pointer;
  transition: opacity 0.2s ease;
}

.btn-primary:hover {
  opacity: 0.9;
}

.options {
  font-size: 0.7rem;
  letter-spacing: 0.05em;
  display: flex;
  flex-direction: column;
  gap: 0.35rem;
}

.options label {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  cursor: pointer;
}

.options a {
  color: var(--card-fg);
}

.switch {
  margin-top: 2rem;
  text-align: center;
  font-size: 0.75rem;
  color: var(--muted-fg);
}

.switch button {
  border: none;
  background: none;
  color: var(--brand-mid);
  font-weight: 700;
  cursor: pointer;
  font-size: 0.75rem;
}

.switch button:hover {
  text-decoration: underline;
}

.message {
  margin-top: 1rem;
  text-align: center;
  font-size: 0.78rem;
  color: var(--brand-mid);
  min-height: 1.1rem;
}

.hidden {
  display: none !important;
}

@media (max-width: 960px) {
  .layout {
    grid-template-columns: 1fr;
    gap: 2.5rem;
    margin-top: 3rem;
  }

  .panel {
    padding: 2rem 1.5rem;
  }

  .nav {
    display: none;
  }

  .frame::after {
    display: none;
  }
}

.message.error {
  color: #b3261e;
}

.session {
  margin-top: 2.5rem;
  text-align: center;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.6rem;
}

.role-pill {
  display: inline-block;
  padding: 0.35rem 1.1rem;
  border-radius: 999px;
  background: var(--brand-mid);
  color: var(--white);
  font-family: "Outfit", system-ui, sans-serif;
  font-size: 0.7rem;
  letter-spacing: 0.18em;
  font-weight: 600;
}

.session-name {
  font-family: "Outfit", system-ui, sans-serif;
  font-size: 1.1rem;
  font-weight: 600;
}

.session-meta {
  font-size: 0.78rem;
  color: var(--muted-fg);
  line-height: 1.5;
}

.session .btn-primary {
  margin-top: 0.75rem;
}

.btn-primary:disabled {
  opacity: 0.55;
  cursor: not-allowed;
}

.btn-outline.small {
  margin-top: 0;
  padding: 0.5rem 1.25rem;
  font-size: 0.75rem;
  background: transparent;
  cursor: pointer;
}

.dash {
  position: relative;
  z-index: 2;
  margin-top: 4rem;
}

.dash h1 {
  font-size: clamp(2.25rem, 5vw, 3.5rem);
  font-weight: 800;
  margin-top: 1rem;
  line-height: 1.05;
}

.dash .tagline {
  font-family: "Outfit", system-ui, sans-serif;
  font-size: 1.25rem;
  font-weight: 600;
  margin-top: 0.5rem;
}

.dash .copy {
  margin-top: 0.35rem;
  font-size: 0.95rem;
  color: rgba(255, 255, 255, 0.85);
}

.tiles {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(15rem, 1fr));
  gap: 1.25rem;
  margin-top: 3rem;
}

.signal-layout,
.admin-grid {
  display: grid;
  grid-template-columns: minmax(0, 1.2fr) minmax(18rem, 0.8fr);
  gap: 1.25rem;
  margin-top: 2rem;
}

.signal-card,
.reports-card,
.forecast-card,
.action-card {
  min-width: 0;
}

.section-heading,
.dashboard-heading,
.forecast-title,
.action-item,
.report-item {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 1rem;
}

.section-heading h2,
.dashboard-heading h2 {
  margin-top: 0.25rem;
  font-family: "Outfit", system-ui, sans-serif;
  font-size: 1.35rem;
  line-height: 1.15;
}

.eyebrow {
  color: var(--brand-mid);
  font-family: "Outfit", system-ui, sans-serif;
  font-size: 0.68rem;
  font-weight: 700;
  letter-spacing: 0.16em;
}

.status-dot,
.preview-badge,
.signal-count,
.report-status,
.priority {
  flex: 0 0 auto;
  border-radius: 999px;
  font-family: "Outfit", system-ui, sans-serif;
  font-size: 0.62rem;
  font-weight: 700;
  letter-spacing: 0.1em;
}

.status-dot {
  color: #147a55;
}

.status-dot::before {
  content: "";
  display: inline-block;
  width: 0.45rem;
  height: 0.45rem;
  margin-right: 0.35rem;
  border-radius: 50%;
  background: #31b978;
}

.preview-badge {
  padding: 0.35rem 0.6rem;
  background: #dbe8fa;
  color: var(--brand-mid);
}

.signal-count {
  display: grid;
  width: 2.2rem;
  height: 2.2rem;
  place-items: center;
  background: var(--brand-mid);
  color: var(--white);
  font-size: 0.85rem;
}

.tile-intro {
  margin-top: 1rem;
  color: var(--muted-fg);
  font-size: 0.85rem;
  line-height: 1.5;
}

.report-form {
  display: grid;
  gap: 0.5rem;
  margin-top: 1.5rem;
}

.report-form label {
  margin-top: 0.35rem;
  color: var(--card-fg);
  font-size: 0.75rem;
  font-weight: 700;
}

.report-form input,
.report-form select,
.report-form textarea {
  width: 100%;
  border: 1px solid #c7d0dc;
  border-radius: 0.7rem;
  padding: 0.7rem 0.8rem;
  background: #f8fafc;
  color: var(--card-fg);
  font: inherit;
  font-size: 0.82rem;
}

.report-form textarea {
  resize: vertical;
}

.report-form input:focus,
.report-form select:focus,
.report-form textarea:focus {
  outline: 2px solid var(--brand-mid);
  outline-offset: 1px;
}

.report-form .btn-primary,
.action-card .btn-primary {
  justify-self: start;
  margin-top: 0.5rem;
}

.report-list,
.forecast-list,
.action-list {
  display: grid;
  gap: 0.75rem;
  margin-top: 1.5rem;
}

.report-item {
  align-items: center;
  border-top: 1px solid #d8dee7;
  padding-top: 0.8rem;
}

.report-item strong,
.action-item strong,
.forecast-item strong {
  font-family: "Outfit", system-ui, sans-serif;
  font-size: 0.85rem;
}

.report-item p,
.action-item p,
.forecast-item p,
.forecast-item small {
  margin-top: 0.25rem;
  color: var(--muted-fg);
  font-size: 0.75rem;
  line-height: 1.4;
}

.report-status {
  padding: 0.35rem 0.55rem;
  background: #e3f4ec;
  color: #147a55;
}

.empty-state {
  margin-top: 1.5rem;
  color: var(--muted-fg);
  font-size: 0.82rem;
  line-height: 1.5;
}

.dashboard-heading {
  align-items: end;
  margin-top: 3rem;
}

.metrics {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1rem;
  margin-top: 1.5rem;
}

.metric {
  display: grid;
  gap: 0.35rem;
  border-left: 3px solid rgba(255, 255, 255, 0.5);
  padding: 0.25rem 0 0.25rem 1rem;
}

.metric span,
.metric small {
  color: rgba(255, 255, 255, 0.76);
  font-size: 0.68rem;
  letter-spacing: 0.09em;
}

.metric strong {
  font-family: "Outfit", system-ui, sans-serif;
  font-size: 2rem;
  line-height: 1;
}

.metric-unit {
  font-size: 0.9rem;
  letter-spacing: 0;
}

.metric small {
  letter-spacing: 0;
}

.metric .positive {
  color: #a6f1ca;
}

.forecast-item {
  display: flex;
  gap: 0.8rem;
  border-top: 1px solid #d8dee7;
  padding-top: 0.9rem;
}

.risk-bar {
  width: 0.25rem;
  min-height: 3.2rem;
  border-radius: 999px;
  background: #31b978;
}

.risk-bar.high { background: #e06a4f; }
.risk-bar.medium { background: #e5a33d; }

.forecast-copy {
  flex: 1;
}

.forecast-title {
  align-items: center;
}

.priority {
  padding: 0.28rem 0.45rem;
}

.priority.high { background: #fbe4df; color: #ad3b27; }
.priority.medium { background: #fff0d4; color: #9a6818; }
.priority.low { background: #e3f4ec; color: #147a55; }

.action-item {
  align-items: center;
  border-top: 1px solid #d8dee7;
  padding-top: 0.8rem;
}

.action-number {
  color: var(--brand-mid);
  font-family: "Outfit", system-ui, sans-serif;
  font-size: 0.75rem;
  font-weight: 700;
}

.action-item > div {
  flex: 1;
}

.action-card .message {
  margin-top: 0.6rem;
  text-align: left;
}

.tile {
  background: var(--card-bg);
  color: var(--card-fg);
  border-radius: 1.25rem;
  padding: 1.75rem;
  box-shadow: var(--card-shadow);
}

.tile h3 {
  font-family: "Outfit", system-ui, sans-serif;
  font-size: 1rem;
  letter-spacing: 0.05em;
}

.tile p {
  margin-top: 0.6rem;
  font-size: 0.85rem;
  color: var(--muted-fg);
  line-height: 1.55;
}

.nav-link {
  border: 0;
  background: transparent;
  color: rgba(255, 255, 255, 0.72);
  cursor: pointer;
  font: 600 0.76rem "Outfit", sans-serif;
  letter-spacing: 0.1em;
}

.nav-link.active,
.nav-link:hover { color: var(--white); }
.hero .eyebrow.light, .dashboard-heading .eyebrow.light { color: rgba(255, 255, 255, 0.7); }
.hero h1 em { color: #a9d2ff; font-style: normal; }
.process { display: flex; align-items: center; gap: 0.55rem; margin-top: 2.4rem; color: rgba(255,255,255,.78); font: 700 .66rem "Outfit", sans-serif; letter-spacing: .1em; }
.process span { color: #a9d2ff; }
.process i { display: block; width: 1.5rem; height: 1px; background: rgba(255,255,255,.45); }
.card-heading { display: flex; align-items: center; justify-content: space-between; }
.card h2 { margin-top: .6rem; text-align: left; font-size: 1.6rem; letter-spacing: 0; }
.live-dot { color: #147a55; font: 700 .62rem "Outfit", sans-serif; letter-spacing: .08em; }
.live-dot::before { content: ""; display: inline-block; width: .4rem; height: .4rem; margin-right: .35rem; border-radius: 50%; background: #31b978; }
.report-form, #complaint-form { margin-top: 1.5rem; display: grid; gap: .5rem; }
#complaint-form label { margin-top: .45rem; color: var(--muted-fg); font: 700 .66rem "Outfit", sans-serif; letter-spacing: .1em; }
#complaint-form input, #complaint-form textarea { width: 100%; border: 1px solid #c7d0dc; border-radius: .65rem; padding: .72rem .8rem; background: #f8fafc; color: var(--card-fg); font: .84rem "DM Sans", sans-serif; text-align: left; letter-spacing: 0; }
#complaint-form textarea { resize: vertical; }
#complaint-form input:focus, #complaint-form textarea:focus { outline: 2px solid var(--brand-mid); outline-offset: 1px; }
.field-row { display: grid; grid-template-columns: 1fr .65fr; gap: .75rem; }
.field-row > div { display: grid; gap: .5rem; }
.helper { color: var(--muted-fg); font-size: .72rem; line-height: 1.4; }
#complaint-form .btn-primary { margin-top: .8rem; justify-self: stretch; padding: .85rem 1rem; }
#complaint-form .btn-primary span { margin-left: .4rem; font-size: 1.1rem; }
.analysis-result { margin-top: 1.3rem; border-top: 1px solid #d8dee7; padding-top: 1rem; color: var(--card-fg); font-size: .8rem; line-height: 1.45; }
.analysis-result strong { display: block; margin-top: .35rem; }
.analysis-tags { display: flex; flex-wrap: wrap; gap: .45rem; align-items: center; margin-top: .7rem; color: var(--muted-fg); font-size: .7rem; }
.analysis-tags > span:not(.priority) { border-left: 1px solid #c7d0dc; padding-left: .45rem; }
.dashboard-panel, .insights-panel { margin-top: 1.5rem; border-radius: 1.25rem; background: var(--card-bg); color: var(--card-fg); padding: 1.5rem; box-shadow: var(--card-shadow); }
.dashboard-panel h2, .insights-panel h2 { margin-top: .25rem; font-size: 1.25rem; }
.complaint-list { display: grid; gap: .8rem; margin-top: 1.25rem; }
.complaint-item { display: flex; gap: .8rem; align-items: center; border-top: 1px solid #d8dee7; padding-top: .8rem; }
.complaint-copy { flex: 1; min-width: 0; }
.complaint-title { display: flex; justify-content: space-between; gap: 1rem; align-items: center; }
.complaint-copy p, .complaint-copy small { display: block; margin-top: .3rem; color: var(--muted-fg); font-size: .76rem; line-height: 1.4; }
.complaint-copy small { font-size: .68rem; }
.status-pill { border-radius: 999px; background: #e3f4ec; color: #147a55; padding: .3rem .5rem; font: 700 .6rem "Outfit", sans-serif; letter-spacing: .06em; }
.insights { display: grid; grid-template-columns: repeat(3, 1fr); gap: 1rem; margin-top: 1.2rem; }
.insights p { border-left: 3px solid var(--brand-mid); padding-left: .75rem; color: var(--muted-fg); font-size: .78rem; line-height: 1.5; }
.insights strong { color: var(--card-fg); }
.metric-alert { border-color: #e06a4f; }
.assistant-panel { margin-top: 1.5rem; border-radius: 1.25rem; background: #dbe8fa; color: var(--card-fg); padding: 1.5rem; box-shadow: var(--card-shadow); }
.chat-form { display: grid; grid-template-columns: 1fr auto; gap: .6rem; margin-top: .7rem; }
.chat-form input { min-width: 0; border: 1px solid #b4c8e3; border-radius: .65rem; background: var(--white); color: var(--card-fg); padding: .75rem .8rem; font: .82rem "DM Sans", sans-serif; }
.chat-form input:focus { outline: 2px solid var(--brand-mid); outline-offset: 1px; }
.chat-form .btn-primary { padding: .7rem 1rem; }
.chat-answer { display: none; margin-top: 1rem; border-left: 3px solid var(--brand-mid); background: rgba(255,255,255,.58); padding: .8rem .9rem; color: var(--card-fg); font-size: .82rem; line-height: 1.5; }
.chat-answer.visible { display: block; }
.chat-answer p { margin-top: .3rem; }
.answer-label { color: var(--brand-mid); font: 700 .62rem "Outfit", sans-serif; letter-spacing: .12em; }
.visually-hidden { position: absolute; width: 1px; height: 1px; overflow: hidden; clip: rect(0, 0, 0, 0); white-space: nowrap; }

@media (max-width: 700px) {
  .signal-layout,
  .admin-grid,
  .metrics {
    grid-template-columns: 1fr;
  }

  .dashboard-heading {
    align-items: flex-start;
    flex-direction: column;
    gap: 0.75rem;
  }

  .insights { grid-template-columns: 1fr; }
  .field-row { grid-template-columns: 1fr; }
  .complaint-item { align-items: flex-start; }
  .status-pill { display: none; }
  .chat-form { grid-template-columns: 1fr; }
}
