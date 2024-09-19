CREATE DATABASE classicmodels;

-- Switch to the newly created database
\c classicmodels

-- Create Customers table
CREATE TABLE customers (
  customer_id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE,
  city VARCHAR(100),
  country VARCHAR(50)
);

-- Create Products table
CREATE TABLE products (
  product_id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  price DECIMAL(10,2) NOT NULL,
  stock INTEGER DEFAULT 0
);

-- Create Orders table
CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  customer_id INTEGER NOT NULL REFERENCES customers(customer_id),
  order_date DATE NOT NULL,
  total_price DECIMAL(10,2) NOT NULL,
  status VARCHAR(50)
);

-- Example data (optional)
INSERT INTO customers (name, email, city, country) VALUES
('John Doe', 'john.doe@email.com', 'New York', 'USA'),
('Jane Smith', 'jane.smith@email.com', 'London', 'UK'),
('Maria Garcia', 'maria.garcia@email.com', 'Madrid', 'Spain');

INSERT INTO products (name, description, price, stock) VALUES
('Classic T-Shirt', 'Comfortable and stylish.', 19.99, 100),
('Coffee Mug', 'Start your day with a classic.', 9.99, 50),
('Leather Notebook', 'Write down your thoughts in style.', 24.99, 25);

INSERT INTO orders (customer_id, order_date, total_price, status) VALUES
(1, '2023-12-19', 59.97, 'Processing'),
(2, '2023-12-15', 29.98, 'Shipped'),
(3, '2023-12-10', 14.99, 'Completed');

-- You can add more example data for the orders table

-- Show tables
SELECT * FROM pg_catalog.information_schema.tables WHERE table_schema = 'public';

-- Select data from each table (optional)
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;