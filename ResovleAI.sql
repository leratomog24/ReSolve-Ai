-- ============================================================
-- ResiAI (ReSolve AI) - Student Accommodation Management Platform
-- MySQL Database Schema
-- ============================================================

DROP DATABASE IF EXISTS resiai_db;
CREATE DATABASE resiai_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE resiai_db;

-- ============================================================
-- TABLE: Students
-- ============================================================
CREATE TABLE Students (
    StudentID   INT AUTO_INCREMENT PRIMARY KEY,
    Name        VARCHAR(100) NOT NULL,
    Email       VARCHAR(150) NOT NULL UNIQUE,
    Residence   VARCHAR(100) NOT NULL,
    RoomNumber  VARCHAR(20),
    Phone       VARCHAR(20),
    CreatedAt   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- TABLE: Staff
-- ============================================================
CREATE TABLE Staff (
    StaffID     INT AUTO_INCREMENT PRIMARY KEY,
    Name        VARCHAR(100) NOT NULL,
    Department  VARCHAR(100) NOT NULL,
    Email       VARCHAR(150) NOT NULL UNIQUE,
    Phone       VARCHAR(20),
    CreatedAt   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- TABLE: Users (login accounts — students and admin/staff)
-- Passwords are hashed with Werkzeug's generate_password_hash()
-- (scrypt), matching check_password_hash() used in app.py.
-- NEVER store plain-text passwords.
-- ============================================================
CREATE TABLE Users (
    UserID       INT AUTO_INCREMENT PRIMARY KEY,
    Email        VARCHAR(255) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    Role         ENUM('student', 'admin') NOT NULL,
    StudentID    INT NULL,               -- FK to Students, only set when Role = 'student'
    Name         VARCHAR(255) NOT NULL,
    CreatedAt    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_users_student
        FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE INDEX idx_users_role ON Users (Role);

-- ============================================================
-- TABLE: Reports (Room / Maintenance Reports)
-- ============================================================
CREATE TABLE Reports (
    ReportID     INT AUTO_INCREMENT PRIMARY KEY,
    StudentID    INT NOT NULL,
    Description  TEXT NOT NULL,
    Category     ENUM('Plumbing', 'Electrical', 'Furniture', 'Cleaning',
                       'Internet', 'Security', 'Appliance', 'Other')
                 NOT NULL DEFAULT 'Other',
    Priority     ENUM('Low', 'Medium', 'High', 'Urgent') NOT NULL DEFAULT 'Medium',
    Status       ENUM('Pending', 'In Progress', 'Resolved', 'Closed') NOT NULL DEFAULT 'Pending',
    DateReported DATETIME DEFAULT CURRENT_TIMESTAMP,
    DateResolved DATETIME NULL,

    CONSTRAINT fk_reports_student
        FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ============================================================
-- TABLE: Assignments (links a Report to the Staff handling it)
-- ============================================================
CREATE TABLE Assignments (
    AssignmentID INT AUTO_INCREMENT PRIMARY KEY,
    ReportID     INT NOT NULL,
    StaffID      INT NOT NULL,
    DateAssigned DATETIME DEFAULT CURRENT_TIMESTAMP,
    Notes        TEXT,

    CONSTRAINT fk_assignments_report
        FOREIGN KEY (ReportID) REFERENCES Reports(ReportID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_assignments_staff
        FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ============================================================
-- INDEXES (speed up common queries)
-- ============================================================
CREATE INDEX idx_reports_status    ON Reports (Status);
CREATE INDEX idx_reports_priority  ON Reports (Priority);
CREATE INDEX idx_reports_category  ON Reports (Category);
CREATE INDEX idx_reports_student   ON Reports (StudentID);
CREATE INDEX idx_assignments_staff ON Assignments (StaffID);
CREATE INDEX idx_assignments_report ON Assignments (ReportID);

-- ============================================================
-- SAMPLE DATA (optional - comment out or remove for production)
-- ============================================================

-- ---------------- Students (StudentID 1-14) ----------------
INSERT INTO Students (Name, Email, Residence, RoomNumber, Phone) VALUES
('Thandiwe Nkosi', 'thandiwe.nkosi@example.edu', 'North Hall', 'N204', '0821234567'),
('Sipho Dlamini', 'sipho.dlamini@example.edu', 'South Hall', 'S117', '0839876543'),
('Naledi Mokoena', 'naledi.mokoena@example.edu', 'North Hall', 'N118', '0827765432'),
('Kagiso Molefe', 'kagiso.molefe@example.edu', 'East Wing', 'E305', '0713345566'),
('Amahle Zondi', 'amahle.zondi@example.edu', 'South Hall', 'S220', '0842219987'),
('Tumelo Mahlangu', 'tumelo.mahlangu@example.edu', 'West Court', 'W101', '0765541230'),
('Refilwe Sithole', 'refilwe.sithole@example.edu', 'East Wing', 'E212', '0798801122'),
('Lwazi Ngcobo', 'lwazi.ngcobo@example.edu', 'North Hall', 'N309', '0844456789'),
('Boitumelo Radebe', 'boitumelo.radebe@example.edu', 'West Court', 'W214', '0731129988'),
('Karabo Sebeko', 'karabo.sebeko@example.edu', 'South Hall', 'S305', '0827741122'),
('Zanele Buthelezi', 'zanele.buthelezi@example.edu', 'East Wing', 'E118', '0763321445'),
('Mpho Tshabalala', 'mpho.tshabalala@example.edu', 'North Hall', 'N412', '0812298765'),
('Ayanda Khumalo', 'ayanda.khumalo@example.edu', 'West Court', 'W309', '0725567788'),
('Dineo Mothibi', 'dineo.mothibi@example.edu', 'South Hall', 'S409', '0788834455');

-- ---------------- Staff (StaffID 1-6) ----------------
INSERT INTO Staff (Name, Department, Email, Phone) VALUES
('Lindiwe Zulu', 'Maintenance', 'lindiwe.zulu@resiai.edu', '0711122334'),
('Johan van der Merwe', 'IT Support', 'johan.vdm@resiai.edu', '0722233445'),
('Precious Mahlaba', 'Housekeeping', 'precious.mahlaba@resiai.edu', '0733344556'),
('Deon Botha', 'Electrical', 'deon.botha@resiai.edu', '0744455667'),
('Nomvula Mbeki', 'Security', 'nomvula.mbeki@resiai.edu', '0755566778'),
('Riaan Pretorius', 'Plumbing', 'riaan.pretorius@resiai.edu', '0766677889');

-- ---------------- Users (login accounts) ----------------
-- Test credentials for local dev / demo purposes only:
--   Admin login:    lindiwe.zulu@resiai.edu     / Admin123
--   Student login:  thandiwe.nkosi@example.edu  / Pass1234
--   (every student below shares the same demo password: Pass1234)
INSERT INTO Users (Email, PasswordHash, Role, StudentID, Name) VALUES
('lindiwe.zulu@resiai.edu', 'scrypt:32768:8:1$VOrhK0rLfB87tmOF$e7a86402694bb709226172a4796d486a1234d9a42b86e400edc1690ce1adb85f9a0ef3fad69896102cb5bfb0ee850444543ded9136719423abcbd657d7acb3b9', 'admin', NULL, 'Lindiwe Zulu'),
('thandiwe.nkosi@example.edu', 'scrypt:32768:8:1$WQkwSU35wKvM2wMp$3d61677965792056ee6bc3acbd7e934eef703dbb9153c37c5d203b437e49fdc3010a840a5529f57828cb345cc5424129a63cc383664b1e6ad164d2fa49f3e3d6', 'student', 1, 'Thandiwe Nkosi'),
('sipho.dlamini@example.edu', 'scrypt:32768:8:1$WQkwSU35wKvM2wMp$3d61677965792056ee6bc3acbd7e934eef703dbb9153c37c5d203b437e49fdc3010a840a5529f57828cb345cc5424129a63cc383664b1e6ad164d2fa49f3e3d6', 'student', 2, 'Sipho Dlamini'),
('naledi.mokoena@example.edu', 'scrypt:32768:8:1$WQkwSU35wKvM2wMp$3d61677965792056ee6bc3acbd7e934eef703dbb9153c37c5d203b437e49fdc3010a840a5529f57828cb345cc5424129a63cc383664b1e6ad164d2fa49f3e3d6', 'student', 3, 'Naledi Mokoena'),
('kagiso.molefe@example.edu', 'scrypt:32768:8:1$WQkwSU35wKvM2wMp$3d61677965792056ee6bc3acbd7e934eef703dbb9153c37c5d203b437e49fdc3010a840a5529f57828cb345cc5424129a63cc383664b1e6ad164d2fa49f3e3d6', 'student', 4, 'Kagiso Molefe'),
('amahle.zondi@example.edu', 'scrypt:32768:8:1$WQkwSU35wKvM2wMp$3d61677965792056ee6bc3acbd7e934eef703dbb9153c37c5d203b437e49fdc3010a840a5529f57828cb345cc5424129a63cc383664b1e6ad164d2fa49f3e3d6', 'student', 5, 'Amahle Zondi');

-- ---------------- Reports (ReportID 1-14) ----------------
INSERT INTO Reports (StudentID, Description, Category, Priority, Status, DateReported, DateResolved) VALUES
(1, 'Leaking tap in bathroom, water pooling on floor.', 'Plumbing', 'High', 'In Progress', '2026-07-02 08:15:00', NULL),
(2, 'Wi-Fi router in room not connecting.', 'Internet', 'Medium', 'Pending', '2026-07-03 10:40:00', NULL),
(3, 'Broken chair leg in study desk area.', 'Furniture', 'Low', 'Resolved', '2026-06-20 09:05:00', '2026-06-25 14:30:00'),
(4, 'Power outlet sparking near bed.', 'Electrical', 'Urgent', 'In Progress', '2026-08-10 19:22:00', NULL),
(5, 'Room not cleaned after scheduled service.', 'Cleaning', 'Low', 'Pending', '2026-08-15 07:50:00', NULL),
(6, 'Window lock broken, security concern.', 'Security', 'High', 'Resolved', '2026-07-28 16:10:00', '2026-07-30 11:00:00'),
(7, 'Fridge in common kitchen not cooling.', 'Appliance', 'Medium', 'Pending', '2026-08-18 13:35:00', NULL),
(8, 'Ceiling light flickering constantly.', 'Electrical', 'Medium', 'In Progress', '2026-08-12 21:05:00', NULL),
(9, 'Shower drain blocked, water backing up.', 'Plumbing', 'High', 'Pending', '2026-08-19 06:45:00', NULL),
(10, 'No internet connection in whole corridor.', 'Internet', 'Urgent', 'In Progress', '2026-08-20 09:00:00', NULL),
(11, 'Wardrobe door came off hinges.', 'Furniture', 'Low', 'Pending', '2026-08-14 12:20:00', NULL),
(12, 'Mould forming on bathroom ceiling.', 'Cleaning', 'Medium', 'Pending', '2026-08-11 15:55:00', NULL),
(13, 'Front door access card not working.', 'Security', 'High', 'Resolved', '2026-07-15 08:30:00', '2026-07-16 10:15:00'),
(14, 'Microwave in kitchenette sparking when used.', 'Appliance', 'Urgent', 'Pending', '2026-08-21 07:10:00', NULL);

-- ---------------- Assignments (AssignmentID 1-14) ----------------
INSERT INTO Assignments (ReportID, StaffID, Notes) VALUES
(1, 6, 'Assigned to plumbing team for inspection.'),
(2, 2, 'Assigned to IT support to check router.'),
(3, 3, 'Chair leg repaired and returned to student.'),
(4, 4, 'Electrician dispatched urgently due to fire risk.'),
(5, 3, 'Housekeeping to reschedule cleaning slot.'),
(6, 5, 'Security team replaced window lock mechanism.'),
(7, 3, 'Maintenance to inspect fridge compressor.'),
(8, 4, 'Electrician checking wiring in ceiling fixture.'),
(9, 6, 'Plumber scheduled for drain unblocking.'),
(10, 2, 'IT team investigating corridor network switch.'),
(11, 1, 'General maintenance to rehang wardrobe door.'),
(12, 3, 'Housekeeping to treat mould and improve ventilation.'),
(13, 5, 'Access card reissued and tested by security.'),
(14, 4, 'Electrician to inspect and replace microwave if unsafe.');

-- ============================================================
-- Example queries
-- ============================================================
-- All open (unresolved) reports with student & assigned staff info:
-- SELECT r.ReportID, s.Name AS Student, r.Description, r.Category,
--        r.Priority, r.Status, st.Name AS AssignedStaff
-- FROM Reports r
-- JOIN Students s      ON r.StudentID = s.StudentID
-- LEFT JOIN Assignments a ON r.ReportID = a.ReportID
-- LEFT JOIN Staff st   ON a.StaffID = st.StaffID
-- WHERE r.Status != 'Resolved';