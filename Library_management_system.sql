CREATE DATABASE Library;
USE Library;
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    membership_date DATE NOT NULL
);

-- TABLE: Staff (Librarians)
CREATE TABLE Staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    position VARCHAR(50),
    email VARCHAR(100) UNIQUE
);

-- TABLE: Authors
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    biography TEXT
);

-- TABLE: Categories (Genres)
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- TABLE: Books
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    isbn VARCHAR(20) NOT NULL UNIQUE,
    publish_year YEAR,
    author_id INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- TABLE: Book_Categories (Many-to-Many: Books ↔ Categories)
CREATE TABLE Book_Categories (
    book_id INT,
    category_id INT,
    PRIMARY KEY (book_id, category_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
        ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
        ON DELETE CASCADE
);

-- TABLE: Loans (Book Borrowing)
CREATE TABLE Loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    staff_id INT, -- Staff who handled the loan
    loan_date DATE NOT NULL,
    return_date DATE,
    due_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
        ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
        ON DELETE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
        ON DELETE SET NULL
);

-- TABLE: Fines (For Late Returns)
CREATE TABLE Fines (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,
    loan_id INT UNIQUE,
    amount DECIMAL(6,2) NOT NULL,
    paid BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (loan_id) REFERENCES Loans(loan_id)
        ON DELETE CASCADE
);

-- Data insertion
-- Data for Authors
INSERT INTO Authors (name, biography) VALUES
('J.K. Rowling', 'British author best known for the Harry Potter series.'),
('George Orwell', 'English novelist, essayist, and critic.'),
('Chinua Achebe', 'Nigerian novelist and author of Things Fall Apart.');

-- Data for Categories
INSERT INTO Categories (name) VALUES
('Fantasy'),
('Science Fiction'),
('Classic'),
('Historical Fiction');

-- Data for Books
-- Note: author_id references the Authors inserted above
INSERT INTO Books (title, isbn, publish_year, author_id) VALUES
('Harry Potter and the Philosopher\'s Stone', '9780747532699', 1997, 1),
('1984', '9780451524935', 1949, 2),
('Things Fall Apart', '9780385474542', 1958, 3);

-- Data for Book_Categories (M-M)
INSERT INTO Book_Categories (book_id, category_id) VALUES
(1, 1), -- Harry Potter → Fantasy
(2, 2), -- 1984 → Sci-Fi
(2, 3), -- 1984 → Classic
(3, 4); -- Things Fall Apart → Historical Fiction

-- Data for Users
INSERT INTO Users (name, email, phone, membership_date) VALUES
('Alice Johnson', 'alice@example.com', '1234567890', '2022-01-15'),
('Bob Smith', 'bob@example.com', '0987654321', '2023-03-22');

-- Data for Staff
INSERT INTO Staff (name, position, email) VALUES
('Emily Brown', 'Librarian', 'emily@library.com'),
('James Lee', 'Assistant', 'james@library.com');

-- Data for Loans
INSERT INTO Loans (user_id, book_id, staff_id, loan_date, return_date, due_date) VALUES
(1, 1, 1, '2024-04-01', '2024-04-15', '2024-04-14'),
(2, 2, 2, '2024-05-01', NULL, '2024-05-14');

-- Data for Fines (1 fine for late return)
INSERT INTO Fines (loan_id, amount, paid) VALUES
(1, 2.50, TRUE);
