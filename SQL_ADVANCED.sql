--1
SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary = 
  (SELECT MIN(Salary) FROM Employees)

  --2
SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary > 
(SELECT MIN(Salary) FROM Employees) * 1.1
ORDER BY Salary

--3
SELECT e.FirstName, e.LastName, e.Salary, e.DepartmentID
FROM Employees e
WHERE Salary = 
  (SELECT MIN(Salary) FROM Employees
  WHERE DepartmentID = e.DepartmentID)
ORDER BY DepartmentID

--4
SELECT AVG(Salary) 
FROM Employees
WHERE DepartmentID = 1

--5
SELECT AVG(Salary) 
FROM Employees e
WHERE e.DepartmentID = 
  (SELECT d.DepartmentID FROM Departments d
	WHERE d.Name = 'Sales')

--6
SELECT COUNT(EmployeeID)
FROM Employees e
WHERE e.DepartmentID = 
	(SELECT d.DepartmentID 
	FROM Departments d
	WHERE d.Name = 'Sales')

--7
SELECT COUNT(EmployeeID)
FROM Employees
WHERE ManagerID > 0

--8
SELECT COUNT(EmployeeID)
FROM Employees
WHERE ManagerID IS NULL

--9
SELECT d.Name, AVG(Salary) as [Average Salary]
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
GROUP BY d.Name

--10 .Write a SQL query to find the count of all employees in each department and for each town.
-- 10.1 ..in each department
--SELECT d.Name AS DepName, COUNT(e.EmployeeID) AS [Count Of Employees] 
--FROM Employees e
--JOIN Departments d
--ON e.DepartmentID = d.DepartmentID
--GROUP BY d.Name

----10.2 ...for each town
--SELECT t.Name, COUNT(e.EmployeeID) AS [Count Of Employees] 
--FROM Employees e
--JOIN Towns t
--ON t.TownID = 
--	(SELECT a.TownID
--	 FROM Addresses a
--	 WHERE a.AddressID = e.AddressID)
--GROUP BY t.Name

--10.3 ...together
SELECT COUNT(EmployeeID), DepartmentID, t.Name 
FROM Employees e 
JOIN Addresses a
 ON e.AddressID = a.AddressID
JOIN Towns t
 ON t.TownID = A.TownID
GROUP BY DepartmentID, t.Name


--11. Write a SQL query to find all managers that have exactly 5 employees. 
--Display their first name and last name.
SELECT e.EmployeeID, e.FirstName + ' ' + e.LastName AS Manager, COUNT(m.EmployeeID) AS [Count Of Employees] --e.FirstName, e.LastName
FROM Employees e
JOIN Employees m
ON e.EmployeeID= m.ManagerID 
GROUP BY e.FirstName, e.LastName, e.EmployeeID
HAVING COUNT(*) = 5

--12. Write a SQL query to find all employees along with their managers. 
--For employees that do not have manager display the value "(no manager)".
SELECT  e.FirstName AS Employees, 
		ISNULL(m.FirstName, '(no manager)') AS Manager
FROM Employees e
LEFT OUTER JOIN Employees m
ON e.ManagerID = m.EmployeeID 

--13. Write a SQL query to find the names of all employees whose last name is exactly 
--5 characters long. Use the built-in LEN(str) function.
SELECT * 
FROM Employees
WHERE LEN(LastName) = 5

--14.Write a SQL query to display the current date and time in the following format 
--"day.month.year hour:minutes:seconds:milliseconds". Search in  Google to find h
--ow to format dates in SQL Server.
SELECT FORMAT ( GETDATE(), 'dd.MM.yyyy hh:mm:ss:mmm', 'en-US' ) AS DateConvert

--15. Write a SQL statement to create a table Users. Users should have username, password, f
--ull name and last login time. Choose appropriate data types for the table fields. 
--Define a primary key column with a primary key constraint. Define the primary key
-- column as identity to facilitate inserting records. Define unique constraint to avoid 
--repeating usernames. Define a check constraint to ensure the password is at least 5 characters long.
CREATE TABLE Users (
	UserId int IDENTITY,
	Username nvarchar(50) NOT NULL,
	Password nvarchar(30) NOT NULL,
	Fullname nvarchar(50) NOT NULL,
	LastLogin datetime,
	CONSTRAINT PK_Users PRIMARY KEY(UserId),
	CONSTRAINT CK_UserPassword CHECK (LEN(Password) >= 5),
	CONSTRAINT unq_Users UNIQUE(Username)
)

--16. Write a SQL statement to create a view that displays the users from the Users
-- table that have been in the system today. Test if the view works correctly.
CREATE VIEW [Today Login Users]
AS 
SELECT * 
FROM Users
WHERE DAY(LastLogin) = DAY(GETDATE())

--17. Write a SQL statement to create a table Groups. Groups should
-- have unique name (use unique constraint). Define primary key and identity column.
CREATE TABLE Groups (
	GroupID int IDENTITY,
	Name nvarchar(50) NOT NULL,
	CONSTRAINT PK_GoupID PRIMARY KEY(GroupID),
	CONSTRAINT unq_Name UNIQUE(Name)
)

--18. Write a SQL statement to add a column GroupID to the table Users. 
--Fill some data in this new column and as well in the Groups table. 
--Write a SQL statement to add a foreign key constraint between tables
--Users and Groups tables.
ALTER TABLE Users
ADD [GroupID] int

ALTER TABLE Users
ADD CONSTRAINT FK_Users_GroupID
	FOREIGN KEY (GroupID)
	REFERENCES Groups(GroupID)

--19. Write SQL statements to insert several records in the Users and Groups tables.
INSERT INTO Users
VALUES('pesho', 'parolata', 'petar', '12.12.12', 3)

INSERT INTO Groups
VALUES('ciganski')

 --20. Write SQL statements to update some of the records in the Users and Groups tables.
UPDATE Users
SET Username = 'Mariq'
WHERE Username = 'pesho'

UPDATE Groups
SET Name = 'english'
WHERE Name = 'ciganski'

--21.Write SQL statements to delete some of the records from the Users and Groups tables.
DELETE FROM Users
WHERE Username = 'Mariq'

DELETE FROM Groups
WHERE Name = 'english'

--22. Write SQL statements to insert in the Users table the names of all employees
-- from the Employees table. Combine the first and last names as a full name. For
-- username use the first letter of the first name + the last name (in lowercase).
-- Use the same for the password, and NULL for last login time.
INSERT INTO Users(Username, Password, FullName, LastLogin)
SELECT FirstName + ' ' + LastName, 
	   LOWER(SUBSTRING(FirstName, 0, 1) + LastName + 'salt'), 
	   LOWER(SUBSTRING(FirstName, 0, 1) + LastName),
	   getdate()
FROM Employees


--23. Write a SQL statement that changes the password to NULL for all 
--users that have not been in the system since 10.03.2010.
UPDATE Users
SET Password = 'DEFAULT'
WHERE LastLogin <= CAST('7.11.2013 00:00:00' AS smalldatetime)

--24. Write a SQL statement that deletes all users without passwords (NULL password).
DELETE FROM Users
WHERE Password = 'DEFAULT'


--25. Write a SQL query to display the average employee salary by department and job title.
SELECT e.DepartmentID, d.Name, e.JobTitle, AVG(e.Salary) AS [average employee salary]
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
GROUP BY e.DepartmentID, JobTitle, d.Name
ORDER BY e.DepartmentID

--26. Write a SQL query to display the minimal employee salary by department 
--and job title along with the name of some of the employees that take it.
SELECT d.Name, e.JobTitle, e.FirstName + ' ' + e.LastName as Name, e.Salary 
FROM Employees e
JOIN Departments d 
	ON d.DepartmentID = e.DepartmentID
	WHERE e.Salary 
	IN (SELECT MIN(em.Salary) 
		FROM Employees em
		JOIN Departments d1 
		ON d1.DepartmentID = em.DepartmentID
		WHERE d.DepartmentID = d1.DepartmentID
		GROUP BY d1.Name)

--27. Write a SQL query to display the town where maximal number of employees work.
SELECT TOP 1 t.Name, COUNT(*)
FROM Employees e
JOIN Addresses a 
ON a.AddressID = e.AddressID
JOIN Towns t
 ON t.TownID = a.TownID
GROUP BY t.Name
ORDER BY COUNT(*) DESC

--28. Write a SQL query to display the number of managers from each town.
SELECT  t.Name AS Town, COUNT(e.EmployeeID) AS [number of managers]
FROM Employees e
JOIN Addresses a
ON a.AddressID = e.AddressID
JOIN Towns t
ON a.TownID = t.TownID
WHERE e.EmployeeID IN
	(SELECT DISTINCT ManagerID
	FROM Employees)
GROUP BY t.Name
ORDER BY [number of managers] DESC
