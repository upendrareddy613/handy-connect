# Athena LMS - Library Management System

A full-stack, responsive Library Management System built with **React**, **Vite**, **Tailwind CSS**, and **Node.js / Express**.

Users must first **register** and **log in** before accessing the library catalog, searching for required books, and borrowing or returning them.

---

## 🌟 Key Features

1. **Authentication & Authorization**:
   - Secure account registration (Member or Librarian/Admin role).
   - Password hashing with `bcryptjs` and token-based authentication via **JWT**.
   - Auto-generated Unique Library Membership IDs (e.g. `LIB-2026-XXXX`).
   - Instant Demo quick-fill credentials for quick testing.

2. **Book Catalog & Discovery ("Access What He Required")**:
   - Search books instantly by **Title**, **Author**, or **ISBN**.
   - Filter by Genre / Category (Computer Science, Fiction, Science, History, Philosophy, Business, etc.).
   - Toggle to filter only available (in-stock) books.
   - Sort by Newest, Title (A-Z), Author (A-Z), and Publication Year.
   - Comprehensive book modal with synopsis, ISBN, publication year, and available copies.

3. **Borrowing & Return System**:
   - 1-Click book borrowing with automatic inventory stock reduction.
   - 14-day loan duration with automatic due date computation.
   - Maximum active loan limits to prevent hoarding.
   - **My Loans** dashboard to view active loans, remaining days, overdue warnings, and returned history.
   - 1-Click book return that immediately restores catalog stock.

4. **Librarian / Admin Management Console**:
   - Real-time KPI stats (Total Titles, Active Loans Out, Returned Loans, Overdue Loans).
   - Add new books to the catalog with custom covers, categories, and inventory copies.
   - Edit existing book metadata and adjust stock.
   - Delete books (safeguarded against deleting books currently on active loan).
   - System-wide loan transactions log across all members.

---

## 🚀 Quick Start Guide

### Prerequisites
- Node.js (v18 or higher)
- npm (v9 or higher)

### 1. Start the Backend API Server
Open a terminal in the root directory:
```bash
cd server
npm start
```
*The server will start on port `5000` (Health check: `http://localhost:5000/api/health`).*

> **Note**: The database is already pre-seeded with 16 books and demo accounts. To re-seed at any time:
> ```bash
> cd server
> npm run seed
> ```

### 2. Start the Frontend Client
In a second terminal window:
```bash
cd client
npm run dev
```
*Open `http://localhost:5173` in your browser.*

---

## 🔑 Demo Credentials

| Role | Email | Password |
| :--- | :--- | :--- |
| **Reader / Member** | `member@library.com` | `member123` |
| **Chief Librarian (Admin)** | `admin@library.com` | `admin123` |

*(You can also click the quick-login buttons on the Sign In page or register any new account!)*

---

## 📂 Project Structure

```
lms/
├── server/
│   ├── src/
│   │   ├── config/db.js          # Persistent JSON-backed DB with Collection API
│   │   ├── middleware/auth.js    # JWT verification and Admin guards
│   │   ├── routes/auth.js        # Register, Login, Me endpoints
│   │   ├── routes/books.js       # Book CRUD, search & filtering
│   │   ├── routes/loans.js       # Borrow, return, user loans & admin logs
│   │   ├── seed.js               # Database seeding script
│   │   └── server.js             # Express server entry point
│   ├── data/db.json              # Persistent database file
│   └── package.json
├── client/
│   ├── src/
│   │   ├── components/           # Navbar, BookCard, Modals, Toast
│   │   ├── pages/                # Login, Register, Catalog, MyLoans, Admin
│   │   ├── context/AuthContext   # Global auth state and notifications
│   │   ├── services/api.js       # API client with token injection
│   │   ├── App.jsx
│   │   └── main.jsx
│   ├── index.html
│   ├── tailwind.config.js
│   └── package.json
└── README.md
```

---

## 📡 REST API Reference

### Authentication
- `POST /api/auth/register` — Register a new member or admin
- `POST /api/auth/login` — Sign in and retrieve JWT token
- `GET /api/auth/me` — Retrieve current authenticated profile

### Books Catalog
- `GET /api/books` — List books with `search`, `category`, `availableOnly`, `sort`
- `GET /api/books/:id` — Get single book details
- `POST /api/books` *(Admin)* — Add a new book
- `PUT /api/books/:id` *(Admin)* — Edit book details & stock
- `DELETE /api/books/:id` *(Admin)* — Remove book from catalog

### Circulation / Loans
- `POST /api/loans/borrow/:bookId` — Borrow a book (14-day loan)
- `POST /api/loans/return/:loanId` — Return a borrowed book
- `GET /api/loans/my-loans` — List current user's loans
- `GET /api/loans/all` *(Admin)* — List all system loans and statistics
