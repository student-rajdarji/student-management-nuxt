-- Student Management System Database Schema
-- Run this in your MySQL console, MySQL Workbench, or phpMyAdmin

CREATE DATABASE IF NOT EXISTS student_management CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE student_management;

CREATE TABLE IF NOT EXISTS students (
  id INT AUTO_INCREMENT PRIMARY KEY,
  student_id VARCHAR(30) NOT NULL UNIQUE,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  phone VARCHAR(25) NULL,
  course VARCHAR(100) NOT NULL,
  year_level VARCHAR(20) NOT NULL,
  gpa DECIMAL(3, 2) DEFAULT 0.00,
  status ENUM('Active', 'Inactive', 'Graduated', 'Suspended') DEFAULT 'Active',
  enrollment_date DATE NOT NULL,
  address VARCHAR(255) NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_status (status),
  INDEX idx_course (course),
  INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Optional Initial Seed Data
INSERT INTO students (student_id, first_name, last_name, email, phone, course, year_level, gpa, status, enrollment_date, address)
VALUES
  ('STU-1001', 'Alex', 'Johnson', 'alex.johnson@university.edu', '+1 555-0101', 'Computer Science', '3rd Year', 3.85, 'Active', '2023-09-01', '123 Campus Way, Apt 4B'),
  ('STU-1002', 'Sophia', 'Martinez', 'sophia.m@university.edu', '+1 555-0102', 'Data Science', '2nd Year', 3.92, 'Active', '2024-09-01', '45 Elm Street, Suite 12'),
  ('STU-1003', 'Liam', 'Patel', 'liam.patel@university.edu', '+1 555-0103', 'Electrical Engineering', '4th Year', 3.65, 'Active', '2022-09-01', '789 Oak Avenue'),
  ('STU-1004', 'Emma', 'Williams', 'emma.w@university.edu', '+1 555-0104', 'Business Administration', '1st Year', 3.40, 'Active', '2025-09-01', '321 Pine Road'),
  ('STU-1005', 'Noah', 'Brown', 'noah.brown@university.edu', '+1 555-0105', 'Mechanical Engineering', '4th Year', 3.78, 'Graduated', '2021-09-01', '654 Maple Blvd')
ON DUPLICATE KEY UPDATE student_id=student_id;

-- Authentication Users Table
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  role ENUM('admin', 'staff', 'student') DEFAULT 'admin',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_user_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

