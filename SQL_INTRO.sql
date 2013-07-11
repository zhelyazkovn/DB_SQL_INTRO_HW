SELECT * FROM Departments


SELECT Name FROM Departments


SELECT FirstName + ' ' + LastName, Salary FROM Employees


SELECT FirstName + '.' + LastName + '@telerik.com' 
AS [Full Email Adress]
FROM Employees


SELECT Salary AS [Unique Salaries]
FROM Employees
INTERSECT
SELECT Salary
FROM Employees


SELECT JobTitle, FirstName, LastName FROM Employees
WHERE JobTitle = 'Sales Representative'


SELECT FirstName, LastName FROM Employees
WHERE FirstName LIKE 'SA%'


SELECT FirstName, LastName FROM Employees
WHERE LastName LIKE '%ei%'


SELECT LastName, Salary
FROM Employees
WHERE Salary BETWEEN 20000 AND 30000


SELECT LastName, LastName, Salary
FROM Employees
WHERE Salary = 25000
OR Salary = 14000
OR Salary = 12500
OR Salary = 23600


SELECT FirstName, LastName FROM Employees
WHERE ManagerID IS NULL


SELECT FirstName, LastName, Salary FROM Employees
WHERE Salary > 50000
ORDER BY Salary


SELECT TOP 5 Salary, FirstName FROM Employees
ORDER BY Salary DESC


SELECT
  e.FirstName, e.LastName, a.AddressText AS [Employee Adresses]
FROM Employees e INNER JOIN Addresses a 
  ON e.AddressID = a.AddressID

  
SELECT 
 e.FirstName, e.LastName, a.AddressText AS [Employee Adresses]
FROM Employees e, Addresses a 
WHERE e.AddressID = a.AddressID


SELECT
  e.FirstName, e.LastName, m.FirstName AS [Employee Manager]
FROM Employees e INNER JOIN Employees m
  ON e.ManagerID = m.EmployeeID



SELECT e.FirstName, e.LastName, m.FirstName AS [Employee Manager], a.AddressText AS [Employee Adress]
FROM ((Employees e
  JOIN Employees m
    ON e.ManagerID = m.EmployeeID)
  JOIN Addresses a
    ON a.AddressID = e.AddressID)


SELECT Name
FROM Departments
UNION
SELECT Name
FROM Towns


SELECT
  m.FirstName + ' ' + m.LastName AS Employee, e.FirstName + ' ' + e.LastName AS Manager
FROM Employees e RIGHT OUTER JOIN Employees m
  ON e.EmployeeID = m.ManagerID 


  SELECT
  m.FirstName + ' ' + m.LastName AS Employee, e.FirstName + ' ' + e.LastName AS Manager
FROM Employees m LEFT OUTER JOIN Employees e
  ON e.EmployeeID = m.ManagerID 


  SELECT *
  FROM Employees e JOIN Departments d
  ON (e.DepartmentID = d.DepartmentID) 
  AND (d.Name = 'Sales' OR d.Name = 'Finance')
	AND (YEAR(e.HireDate) BETWEEN 1995 AND 2000)
