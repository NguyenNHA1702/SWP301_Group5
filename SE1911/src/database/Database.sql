-- Tạo cơ sở dữ liệu
CREATE DATABASE volunteer_portal;
GO

-- Sử dụng cơ sở dữ liệu
USE volunteer_portal;
GO

-- Tạo bảng users
CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    email NVARCHAR(255) NOT NULL UNIQUE,
    password NVARCHAR(255) NOT NULL,
    phone NVARCHAR(20) NOT NULL,
    created_at DATETIME DEFAULT GETDATE()
);
GO

-- Chèn một tài khoản mẫu để kiểm tra
INSERT INTO users (name, email, password, phone) 
VALUES ('Nguyễn Thế Hoàng Tùng', 'tung.nguyen@example.com', '123123', '+84912345678');
GO