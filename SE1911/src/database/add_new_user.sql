USE volunteer_portal;
GO

INSERT INTO users (name, email, password, phone) 
VALUES ('Nguyễn Văn B', 'nguyenvanb@example.com', 'hashed_password_new', '+84955555555');
GO

SELECT * FROM users;
GO