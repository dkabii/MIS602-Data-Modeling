#Task 1
DROP DATABASE IF EXISTS BuildingGo;
CREATE DATABASE BuildingGo;
USE BuildingGo;
CREATE TABLE Building
(
	Building_ID INT PRIMARY KEY,
	Building_Name VARCHAR(100),
	Building_Address VARCHAR(100),
	Built_Year INT,
	Building_Capacity INT
);

CREATE TABLE Owner
(
	Owner_ID INT PRIMARY KEY,
	Owner_Fname VARCHAR(100),
	Owner_Lname VARCHAR(100),
	Owner_Email VARCHAR(100),
	Owner_Phone VARCHAR(15)
);

CREATE TABLE Apartment
(
	Apartment_ID INT PRIMARY KEY,
	Total_Rooms INT,
	Apartment_Rent DECIMAL,
	Building_ID INT,
	Owner_ID INT,
	INDEX `Building_Ref` (`Building_ID`),
	INDEX `Owner_Ref` (`Owner_ID`)
);

ALTER TABLE `Apartment` ADD CONSTRAINT OWNER_FK FOREIGN KEY (`Owner_ID`) REFERENCES `Owner`(`Owner_ID`) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE `Apartment` ADD CONSTRAINT Building_FK FOREIGN KEY (`Building_ID`) REFERENCES `Building`(`Building_ID`) ON DELETE RESTRICT ON UPDATE CASCADE;

#Task 2
INSERT INTO `Owner` (Owner_ID, Owner_Fname, Owner_Lname, Owner_Email, Owner_Phone) VALUES
(2001,'Hazel','Alex','hazel@gmail.com','04023466'),
(2002,'Saber','Khan','khan@gmail.com','04034566'),
(2003,'Adam','Smith','Adam@gmail.com','04345567'),
(2004,'Lisa','Owen','owen@gmail.com','04078066');


INSERT INTO `Building` (Building_ID, Building_Name, Built_Year, Building_Capacity, Building_Address) VALUES 
(1001,'Lilly Pilli',1995, 5000,'Wakefield street'),
(1002,'Early Settler',2006, 2000,'Finders street'),
(1003,'Horizon East',2018, 5000,'Maldives street'),
(1004,'Ocean Blue',2020, 15000,'Wakefield street');

#Task 3
INSERT INTO `Apartment` (Apartment_ID, Apartment_Rent, Total_Rooms, Building_ID, Owner_ID) VALUES 
(1001, 500, 2, 1001, 2001),
(1002, 600, 3, 1001, 2002),
(1003, 1000, 2, 1001, 2004),
(1004, 389, 1, 1003, 2003),
(1005, 400, 1, 1004, 2001),
(1006, 590, 2, 1001, 2002),
(1007, 345, 2, 1003, 2004),
(1008, 789, 3, 1004, 2001);

#Task 4
SELECT * FROM Building;
#Task 5
SELECT Building_Name FROM Building;
#Task 6
SELECT Building_Name, Building_Capacity FROM Building;
#Task 7
UPDATE Building SET Building_Capacity=2000 WHERE Building_Name='Lilly Pilly';
#Task 8
SELECT Building_ID, Building_Name FROM Building WHERE Building_Capacity>3000;
#Task 9
UPDATE Apartment SET Apartment_Rent=Apartment_Rent*1.02 WHERE Building_ID=(SELECT Building_ID FROM Building WHERE Building_Name='Ocean Blue');
#Task 10
SELECT * FROM Apartment WHERE Owner_ID=2003;
#Task 11
SELECT DISTINCT Building_Name FROM Building;
#Task 12
SELECT Building_Name, Built_Year FROM Building WHERE Built_Year=2001;
#Task 13
SELECT Building_Name, Building_Capacity FROM Building WHERE Building_Capacity>=1000 AND Building_Capacity<=2000 ORDER BY Building_Capacity DESC;
#Task 14
SELECT SUM(Total_Rooms) AS Total_Apartments_Capacity FROM Apartment;
#Task 15
SELECT O.Owner_ID, O.Owner_Fname, SUM(A.Total_Rooms) AS Total_Apartments_Owned FROM Apartment A, Owner O WHERE A.Owner_ID=O.Owner_ID GROUP BY Owner_ID ORDER BY Total_Apartments_Owned ASC;
#Task 16
INSERT INTO `Owner` (Owner_ID, Owner_Fname, Owner_Lname, Owner_Email, Owner_Phone) VALUES
(2021,'James','Hendrinks','hendrinks@gmail.com','04023577');
SELECT * FROM Owner;
DELETE FROM Owner WHERE Owner_Fname LIKE '%James%';
#Task 17
SELECT A.Apartment_ID, A.Apartment_Rent, A.Total_Rooms, A.Building_ID, A.Owner_ID FROM Apartment A, Owner WHERE Owner.Owner_Fname='Hazel' AND A.Owner_ID=Owner.Owner_ID;
#Task 18
SELECT * FROM Apartment A, Building B WHERE A.Building_ID=B.Building_ID;
#Task 19
SELECT A.Apartment_ID, A.Apartment_Rent, A.Total_Rooms, A.Building_ID, A.Owner_ID From Apartment A, Building B WHERE B.Building_Name='Ocean Blue' AND A.Building_ID=B.Building_ID;
#Task 20
SELECT B.Building_Name, SUM(A.Total_Rooms) AS Total_Apartments_Capacity FROM Apartment A, Building B WHERE A.Building_ID=B.Building_ID GROUP BY A.Building_ID HAVING Total_Apartments_Capacity>5;
#Task 21
SELECT O.Owner_ID, O.Owner_Fname, SUM(A.Total_Rooms) AS Total_Apartments_Owned FROM Apartment A, Owner O WHERE A.Owner_ID=O.Owner_ID GROUP BY A.Owner_ID HAVING Total_Apartments_Owned=0;
#Task 22
SELECT Building_Name FROM Building WHERE Building_ID=(SELECT Building_ID FROM Apartment ORDER BY Apartment_Rent DESC LIMIT 1);
#Task 23
SELECT A.Apartment_ID,A.Apartment_Rent,O.Owner_Fname,O.Owner_Lname FROM Apartment A, Owner O WHERE A.Owner_ID=O.Owner_ID AND A.Apartment_Rent>600 ORDER BY O.Owner_Fname DESC; 
#Task 24
SELECT * FROM Apartment A, Owner O, Building B WHERE A.Owner_ID=O.Owner_ID AND A.Building_ID=B.Building_ID; 