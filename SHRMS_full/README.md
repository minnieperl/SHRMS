# 🏢 Smart HRMS — College Major Project

A full-featured HR Management System built with **Spring Boot 3.2**, **JSP + JSTL**, **Spring Security**, **JPA**, and **MySQL**.

---

## 🚀 Quick Start

### Prerequisites
- Java 17+
- Maven 3.8+
- MySQL 8.x running on localhost:3306

### 1. Database Setup
Run the full SQL schema in MySQL:
```sql
CREATE DATABASE smart_HRMS;
USE smart_HRMS;
-- (paste the full schema from the project brief)
```

Then insert the first ADMIN user manually:
```sql
-- BCrypt hash of "admin123" 
INSERT INTO employee (employee_code, first_name, last_name, email, phone, role_id, department_id, joining_date, base_salary, status, password)
VALUES ('EMP0001', 'Admin', 'User', 'admin@hrms.com', '9876543210',
        (SELECT role_id FROM role WHERE role_name='ADMIN'),
        (SELECT department_id FROM department WHERE department_name='Human Resources'),
        CURDATE(), 100000.00, 'ACTIVE',
        '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhy');
```
> Default login: **admin@hrms.com** / **admin123**

### 2. Configure Database
Edit `src/main/resources/application.properties`:
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/smart_HRMS?useSSL=false&serverTimezone=UTC
spring.datasource.username=root
spring.datasource.password=YOUR_PASSWORD
```

### 3. Build & Run
```bash
./mvnw spring-boot:run
```
Open: **http://localhost:8080**

---

## 📁 Project Structure
```
src/main/
├── java/com/example/SHRMS/
│   ├── model/          → JPA Entities (11 entities)
│   ├── repository/     → Spring Data JPA Repositories
│   ├── service/        → Business Logic Layer
│   ├── controller/     → Spring MVC Controllers
│   ├── config/         → Security, MVC, Session
│   └── exception/      → Global Exception Handler
└── webapp/WEB-INF/
    ├── views/          → JSP Pages (35+ pages)
    │   ├── auth/       → login.jsp
    │   ├── dashboard/  → dashboard.jsp (role-aware)
    │   ├── employee/   → list, add, edit, view
    │   ├── attendance/ → mark, history, all
    │   ├── leave/      → list, apply, manage
    │   ├── task/       → list (Kanban), assign
    │   ├── meeting/    → list, schedule, view+MOM
    │   ├── payroll/    → list, generate, slip
    │   ├── performance/→ list, add
    │   ├── holiday/    → list, add
    │   ├── common/     → sidebar, topbar, alerts, head
    │   └── error/      → 403, 500
    ├── css/style.css   → Custom professional stylesheet
    └── js/main.js      → UI interactions
```

## 🔐 Default Roles
| Role     | Access Level |
|----------|-------------|
| ADMIN    | Full access — manage employees, payroll, holidays |
| HR       | Employee + payroll + leave management |
| MANAGER  | Team tasks, leave approvals, meetings |
| EMPLOYEE | Own attendance, leaves, tasks, payslips |

## 🧩 Modules
1. **Authentication** — BCrypt passwords, role-based dashboards, session management
2. **Employee Management** — CRUD, photo upload, search, directory
3. **Attendance** — Check-in/out with photo, late detection, history
4. **Leave Management** — Apply, approve/reject workflow, history
5. **Task Management** — Kanban board (Todo → In Progress → Done)
6. **Meetings + MOM** — Schedule, attendees, minutes of meeting
7. **Performance** — Star ratings, scores, period-based reviews
8. **Payroll** — Generate, view, print payslip
9. **Holiday Calendar** — Company holidays with types
