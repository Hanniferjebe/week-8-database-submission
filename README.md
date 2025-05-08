# 📚 Library Management System

## 📝 Description

This project is a relational **Library Management System** built using **MySQL**. It allows library staff to manage books, categories, authors, users, and book loans efficiently. The system also includes functionality to manage fines for overdue books.

### 🔧 Features

- Manage users and their library memberships
- Store and retrieve book details with author and category relationships
- Track book borrowings (loans) and return dates
- Assign fines for overdue returns
- Manage staff handling book loans

---

## 🚀 How to Run / Setup the Project

### 🔗 Requirements:
- MySQL Server (5.7 or higher)
- MySQL Workbench or any SQL client

### 📂 Setup Steps:
1. **Clone the repository**:
    ```bash
    git clone https://github.com/Hanniferjebe/week-8-database-submission.git
    cd library-management-system
    ```

2. **Create the Database and Import SQL**:
    - Open your MySQL client.
    - Create a new database:
      ```sql
      CREATE DATABASE LibrarY;
      USE Library;
      ```
    - Import the `library_management_system.sql` file:
      ```sql
      SOURCE path/to/library_management_management.sql;
      ```

3. **Test the Setup**:
    Run sample queries to check the data:
    ```sql
    1. SELECT * FROM Books;
    2. SELECT * FROM Loans;
    3. SELECT * FROM library.book_categories;

    4. SELECT u.name, l.loan_date, l.due_date
       FROM Users u
       JOIN Loans l ON u.user_id = l.user_id;

    5. SELECT b.title, c.name AS category
       FROM Books b
       JOIN Book_Categories bc ON b.book_id = bc.book_id
       JOIN Categories c ON bc.category_id = c.category_id;

    6. SELECT u.name, f.amount, f.paid
       FROM Fines f
       JOIN Loans l ON f.loan_id = l.loan_id
       JOIN Users u ON l.user_id = u.user_id;

   7. INSERT INTO Loans (user_id, book_id, staff_id, loan_date, due_date)
      VALUES (1, 2, 1, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 14 DAY));


    ```

## 🗂️ ERD (Entity Relationship Diagram)

The ERD has been uploaded to the repository
---

## 📊 Database Schema Overview

### 📘 Users
- `user_id` (PK)
- `name`
- `email` (UNIQUE)
- `phone`
- `membership_date`

### 👨‍💼 Staff
- `staff_id` (PK)
- `name`
- `position`
- `email` (UNIQUE)

### ✍️ Authors
- `author_id` (PK)
- `name`
- `biography`

### 🗂️ Categories
- `category_id` (PK)
- `name` (UNIQUE)

### 📚 Books
- `book_id` (PK)
- `title`
- `isbn` (UNIQUE)
- `publish_year`
- `author_id` (FK)

### 🏷️ Book_Categories
- `book_id` (FK)
- `category_id` (FK)
- Composite PK: (`book_id`, `category_id`)

### 📄 Loans
- `loan_id` (PK)
- `user_id` (FK)
- `book_id` (FK)
- `staff_id` (FK)
- `loan_date`
- `return_date`
- `due_date`

### 💸 Fines
- `fine_id` (PK)
- `loan_id` (FK, UNIQUE)
- `amount`
- `paid`

---

--
