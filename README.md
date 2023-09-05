# Data-Cleaning-SQL-
Data Analyst Portfolio Project | Data Cleaning in SQL | Project 3/4
1. DOWNLOAD DATA ()
2. Go to the Microsoft SQL Server Management studio>SQL database>right click>Task>Import Data>SQL Server Import and Export Wizard>Next>Choose Excel file>Excel>next>destinatin(Microsoft OLE DBE PROVIDER FOR SQL )>Server Name>>use window authentication>database(portfolio project)>next>click on copy data from one table or more tables or more>click sheet1>run immediately>next >finish
3. You can rename dbo.sheet1 to dboNashvilleHousing>select top 1000 row
  
****CHANGE THE (SaleDateConverted) INTO STANDARD DAE FORMAT** It has time at the end, doesn't serve any purpose so take that off****
--Select SaleDateConverted table and write query-- 

SELECT SaleDateConverted, CONVERT(Date,SaleDate)
FROM PortfolioProject.dbo.NashvilleHousing

UPDATE NashvilleHousing
SET SaleDate = CONVERT(Date,SaleDate)
--if it doesn't update properly 

ALTER TABLE NashvilleHousing
ADD SaleDateConverted Date;

Update NashvilleHousing
SET SaleDateConverted = CONVERT(Date,SaleDate)

**Populated property address**
You can see the same id and address in ParceId and PropertyAddress.so, the parcelID  will be the same as the property   address. therefore we can do, that if ParceId has a Property address, and another same ParcelID doesn't have a Property address because they have the same PropertyAddress.
1. join two table
From PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b
then use a unique ID that is not equal or the same
Let populate with the previous address.
2. You can see NULL in propertyAddress
3. use ISNULL(check Null)
   
SELECT PropertyAddress
FROM PortfolioProject.dbo.NashvilleHousing
--WHERE PropertyAddress is Null
ORDER BY ParceID


SELECT a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress,ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b
	on a.ParcelID=b.ParcelID
	AND a.[UniqueID ]<>b.[UniqueID ]
	WHERE a.PropertyAddress is Null


UPDATE a
SET PropertyAddress=ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b
	on a.ParcelID=b.ParcelID
	AND a.[UniqueID ]<>b.[UniqueID ]
	WHERE a.PropertyAddress is Null


 

