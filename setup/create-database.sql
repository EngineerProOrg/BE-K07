CREATE DATABASE DB;

USE DB;

CREATE TABLE
  Stocks (
    stock_name VARCHAR(255),
    operation ENUM ('Buy', 'Sell'),
    operation_day INT,
    price INT,
    PRIMARY KEY (stock_name, operation_day)
  );

INSERT INTO
  Stocks (stock_name, operation, operation_day, price)
VALUES
  ('Leetcode', 'Buy', 1, 1000),
  ('Corona Masks', 'Buy', 2, 10),
  ('Leetcode', 'Sell', 5, 9000),
  ('Handbags', 'Buy', 17, 30000),
  ('Corona Masks', 'Sell', 3, 1010),
  ('Corona Masks', 'Buy', 4, 1000),
  ('Corona Masks', 'Sell', 5, 500),
  ('Corona Masks', 'Buy', 6, 1000),
  ('Handbags', 'Sell', 29, 7000),
  ('Corona Masks', 'Sell', 10, 10000);

CREATE TABLE
  Accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    income INT
  );

INSERT INTO
  Accounts (account_id, income)
VALUES
  (3, 108939),
  (2, 12747),
  (8, 87709),
  (6, 91796);