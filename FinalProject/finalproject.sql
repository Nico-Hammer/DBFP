CREATE DATABASE IF NOT EXISTS Bank;
DROP DATABASE Bank;
USE Bank;

CREATE TABLE customers (customer_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL UNIQUE, first_name VARCHAR(50) NOT NULL, 
last_name VARCHAR(100) NOT NULL, email VARCHAR(255), phone_number VARCHAR(9) NOT NULL UNIQUE);

INSERT INTO customers (first_name, last_name, email, phone_number) VALUES
('John', 'Doe', 'john.doe@example.com', '123456789'),
('Jane', 'Smith', 'jane.smith@example.com', '987654321'),
('Michael', 'Brown', 'michael.brown@example.com', '112233445'),
('Emily', 'Davis', 'emily.davis@example.com', '556677889'),
('Daniel', 'Wilson', 'daniel.wilson@example.com', '998877665'),
('Emma', 'Johnson', 'emma.johnson@example.com', '443322110'),
('Liam', 'Miller', 'liam.miller@example.com', '665544332'),
('Olivia', 'Anderson', 'olivia.anderson@example.com', '778899001'),
('Noah', 'Taylor', 'noah.taylor@example.com', '334455667'),
('Ava', 'Moore', 'ava.moore@example.com', '221133445');


CREATE TABLE accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT UNIQUE NOT NULL,
    customer_id INT NOT NULL,
    account_type VARCHAR(3) NOT NULL,
    account_balance DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

INSERT INTO accounts (customer_id, account_type, account_balance) VALUES
(1, 'SAV', 1500.75),
(2, 'CHK', 2300.50),
(3, 'SAV', 1200.00),
(4, 'CHK', 450.25),
(5, 'SAV', 3000.00),
(6, 'CHK', 1785.60),
(7, 'SAV', 2100.90),
(8, 'CHK', 995.40),
(9, 'SAV', 500.00),
(10, 'CHK', 750.30);

DROP TABLE transactions;

CREATE TABLE transactions (transaction_id VARCHAR(36) NOT NULL PRIMARY KEY UNIQUE ,
account_id INT NOT NULL,
transaction_date DATE NOT NULL,
transaction_amount DECIMAL NOT NULL,
sender_id INT NOT NULL,
receiver_id INT NOT NULL,
FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

INSERT INTO transactions (transaction_id, account_id, transaction_date, transaction_amount, sender_id, receiver_id) VALUES
(UUID(), 1, '2025-03-30', 200.00, 2, 1),
(UUID(), 1, '2025-03-31', -500.00, 1, 2),

(UUID(), 2, '2025-03-30', 500.00, 1, 2),
(UUID(), 2, '2025-04-01', -200.00, 2, 1);

(UUID(), 3, '2025-03-28', 50.00, 1, 3),
(UUID(), 3, '2025-03-29', -150.00, 3, 6),

(UUID(), 4, '2025-03-27', 700.00, 4, 7),
(UUID(), 4, '2025-03-28', -500.00, 4, 2),

(UUID(), 5, '2025-03-26', 1000.00, 5, 9),
(UUID(), 5, '2025-03-27', -200.00, 5, 10),

(UUID(), 6, '2025-03-25', 450.00, 6, 1),
(UUID(), 6, '2025-03-26', -75.00, 6, 2),

(UUID(), 7, '2025-03-24', 1200.00, 7, 3),
(UUID(), 7, '2025-03-25', -300.00, 7, 4),

(UUID(), 8, '2025-03-23', 600.00, 8, 5),
(UUID(), 8, '2025-03-24', -100.00, 8, 6),

(UUID(), 9, '2025-03-22', 250.00, 9, 7),
(UUID(), 9, '2025-03-23', -50.00, 9, 8),

(UUID(), 10, '2025-03-21', 900.00, 10, 9),
(UUID(), 10, '2025-03-22', -125.00, 10, 1);

select *  from customers

CREATE OR REPLACE VIEW customer_balance as
WITH total_transaction AS (
    SELECT account_id, SUM(transaction_amount) AS total_trans
    FROM transactions
    GROUP BY account_id
)
SELECT 
    c.first_name, 
    (a.account_balance + COALESCE(tt.total_trans, 0)) AS updated_balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
LEFT JOIN total_transaction tt ON a.account_id = tt.account_id;

SELECT * FROM customer_balance;





































