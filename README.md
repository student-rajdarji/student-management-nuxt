# 🎓 Student Management System (Nuxt 3 + MySQL)

A full-stack, responsive Student Management CRUD web application built with **Nuxt 3**, **Nitro Engine**, and **MySQL**.

---

- **Authentication (Login & Signup)**:
  - Secure password hashing using Node.js `scrypt` with unique cryptographic salts.
  - Session state managed with secure cookies.
  - Default Administrator account pre-seeded (`admin@university.edu` / `admin123`).
  - Ability for new administrators, staff, or students to create accounts directly.
- **Full CRUD Operations**:
  - **Create**: Add new student with automatic ID generation, personal details, academic details, and address.
  - **Read**: List students with real-time live search, filters (Course, Status, Year Level), and sorting.
  - **Update**: Edit existing student records in a sleek popup modal with client-side & server-side validation.
  - **Delete**: Soft confirmation dialog before permanent deletion from MySQL.
- **Auto Database Initialization**:
  - Automatically creates the `student_management` database, `students` table, and `users` table if they do not exist.
  - Optional 1-click **"Seed Sample Data"** button to populate 6 realistic demo student records immediately.
- **Dashboard Metrics**:
  - Overview cards: Total Students, Active Students, Graduated Alumni, Average GPA, Distinct Courses.
- **Modern UI / UX**:
  - Responsive layout powered by Tailwind CSS.
  - GPA color coding, status badges, avatar initials, and toast notifications.

---

## 🛠️ Project Structure

```text
student-management-nuxt/
├── .env                     # MySQL database credentials (host, port, user, password)
├── .env.example             # Template for environment configuration
├── app.vue                  # Main single-page application dashboard & data table
├── components/
│   ├── AuthCard.vue            # Login & Signup tabbed card
│   ├── DeleteConfirmModal.vue  # Confirmation dialog for student deletion
│   ├── StatCard.vue            # Dashboard metric summary card
│   ├── StudentModal.vue        # Add / Edit Student modal form
│   └── Toast.vue               # Notification toast banner
├── nuxt.config.ts           # Nuxt 3 & Tailwind configuration
├── schema.sql               # MySQL database schema & sample data
├── server/
│   ├── api/
│   │   ├── auth/
│   │   │   ├── register.post.ts    # POST /api/auth/register (user signup)
│   │   │   ├── login.post.ts       # POST /api/auth/login (user sign in)
│   │   │   ├── logout.post.ts      # POST /api/auth/logout (clear session)
│   │   │   └── me.get.ts           # GET /api/auth/me (current user profile)
│   │   ├── seed.post.ts            # POST /api/seed (sample data population)
│   │   ├── stats.get.ts            # GET /api/stats (metrics & aggregations)
│   │   └── students/
│   │       ├── index.get.ts        # GET /api/students (list, search, filter, sort)
│   │       ├── index.post.ts       # POST /api/students (create student)
│   │       ├── [id].get.ts         # GET /api/students/:id (read single student)
│   │       ├── [id].put.ts         # PUT /api/students/:id (update student)
│   │       └── [id].delete.ts      # DELETE /api/students/:id (delete student)
│   └── utils/
│       ├── auth.ts                 # Password hashing & verification
│       └── db.ts                   # MySQL connection pool & auto-init
├── package.json
└── tailwind.config.js
```

---

## ⚙️ Configuration (.env)

Open `.env` in the root folder and update your MySQL password:

```env
DB_HOST=127.0.0.1
DB_PORT=3306
DB_USER=root
DB_PASSWORD=YOUR_MYSQL_PASSWORD
DB_NAME=student_management
PORT=3001
```

---

## 🔐 Default Admin Credentials

When the app runs, it automatically seeds an administrator account:
- **Email:** `admin@university.edu`
- **Password:** `admin123`

*(You can also click the "Create Account" tab on the sign-in screen to register your own custom user account).*

---

## 🏃 Running the Application

### 1. Start Development Server
```bash
npm run dev
```
Open [http://127.0.0.1:3001](http://127.0.0.1:3001) in your browser.

---

## 📡 REST API Reference

### Authentication Endpoints
| Method | Endpoint | Description |
|---|---|---|
| `POST` | `/api/auth/register` | Register a new user (`name`, `email`, `password`, `role`) |
| `POST` | `/api/auth/login` | Sign in with `email` and `password` |
| `POST` | `/api/auth/logout` | Clear user session cookie |
| `GET` | `/api/auth/me` | Get current logged-in user profile |

### Student Management Endpoints
| Method | Endpoint | Description |
|---|---|---|
| `GET` | `/api/students` | Get all students (supports `?search=`, `?course=`, `?status=`, `?sort_by=`, `?order=`) |
| `POST` | `/api/students` | Create a new student |
| `GET` | `/api/students/:id` | Get details of a single student by ID |
| `PUT` | `/api/students/:id` | Update student details by ID |
| `DELETE`| `/api/students/:id` | Delete student by ID |
| `GET` | `/api/stats` | Get dashboard statistics (total, active, graduated, avg GPA) |
| `POST` | `/api/seed` | Insert demo student records into MySQL |

---

## 🐙 How to Push this Project to GitHub

Follow these steps in your terminal:

1. **Open PowerShell in this project folder**:
   ```powershell
   cd C:\Users\rajda\OneDrive\Desktop\student-management-nuxt
   ```

2. **Initialize Git repository**:
   ```bash
   git init
   ```

3. **Stage all project files**:
   ```bash
   git add .
   ```

4. **Make initial commit**:
   ```bash
   git commit -m "Initial commit: Student Management System with Nuxt 3, MySQL, and Authentication"
   ```

5. **Create a new repository on [GitHub](https://github.com/new)** (e.g. `student-management-nuxt`).

6. **Link your local repository and push**:
   ```bash
   git branch -M main
   git remote add origin https://github.com/YOUR_GITHUB_USERNAME/student-management-nuxt.git
   git push -u origin main
   ```
