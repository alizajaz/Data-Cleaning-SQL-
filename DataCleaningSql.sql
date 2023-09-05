--Cleaning Data in SQL Queries
SELECT *
FROM PortfolioProject.dbo.NashvilleHousing

--change the sale date 
--Standardize Date Format
SELECT SaleDateConverted, CONVERT(Date,SaleDate)
FROM PortfolioProject.dbo.NashvilleHousing

UPDATE NashvilleHousing
SET SaleDate = CONVERT(Date,SaleDate)
--if it doesnot uodate properly 

ALTER TABLE NashvilleHousing
ADD SaleDateConverted Date;

Update NashvilleHousing
SET SaleDateConverted = CONVERT(Date,SaleDate)




--Populate Property Address data 

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


	
 --Breaking out Address into Individual Columns(Address, City,State)
 SELECT PropertyAddress
FROM PortfolioProject.dbo.NashvilleHousing
--WHERE PpropertyAddress is null
--order by ParcelID

SELECT 
SUBSTRING (PropertyAddress, 1,CHARINDEX(',',PropertyAddress)-1) as Address
,SUBSTRING (PropertyAddress,CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress)) as Address
FROM PortfolioProject.dbo.NashvilleHousing


ALTER TABLE NashvilleHousing
ADD PropertySplitAddress Nvarchar(255);

Update NashvilleHousing
SET PropertySplitAddress = SUBSTRING (PropertyAddress, 1,CHARINDEX(',',PropertyAddress)-1) 

ALTER TABLE NashvilleHousing
ADD PropertySplitCity Nvarchar(255);

Update NashvilleHousing
SET PropertySplitCity= SUBSTRING (PropertyAddress,CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress)) 

SELECT *
FROM PortfolioProject.dbo.NashvilleHousing





--OWNERADDRESS
SELECT OwnerAddress
FROM PortfolioProject.dbo.NashvilleHousing

SELECT
PARSENAME(REPLACE(OwnerAddress,',','.'),3)
,PARSENAME(REPLACE(OwnerAddress,',','.'),2)
,PARSENAME(REPLACE(OwnerAddress,',','.'),1)
FROM PortfolioProject.dbo.NashvilleHousing


ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress Nvarchar(255);

UPDATE NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)

ALTER TABLE NashvilleHousing
ADD PropertySplitCity Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)

ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

Select *
FROM PortfolioProject.dbo.NashvilleHousing




------------------------------------------------------------------------------------------------
--CHANGE Y AND N TO YES AND NO IN "SoldAsVacant" FIELD
 SELECT DISTINCT(SoldAsVacant),Count(SoldAsVacant)
 FROM PortfolioProject.dbo.NashvilleHousing
 GROUP BY SoldAsVacant
 ORDER BY 2 



SELECT SoldAsVacant
, CASE WHEN SoldAsVacant='Y' THEN 'Yes'
	 WHEN SoldAsVacant='N' THEN 'No'
	 ELSE SoldAsVacant
	 END

 FROM PortfolioProject.dbo.NashvilleHousing


 UPDATE NashvilleHousing
 SET SoldAsVacant = CASE WHEN SoldAsVacant='Y' THEN 'Yes'
	 WHEN SoldAsVacant='N' THEN 'No'
	 ELSE SoldAsVacant
	 END





	 -------------------------------------------------------------------------------



	-- REMOVE DUPLICATE
	WITH RowNumCTE AS(
	SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY 
	ParcelID,
	PropertyAddress,
	SaleDate,
	LegalReference
	ORDER BY
	UniqueID
	) row_num
	 

	FROM PortfolioProject.dbo.NashvilleHousing
	--ORDER BY ParcelID
	)

	SELECT *
	FROM RowNumCTE
	WHERE row_num >1
	--ORDER BY PropertyAddress


SELECT *
From PortfolioProject.dbo.NashvilleHousing





-----------------------------------------------------------------------------------

--DELETE UNUSED COLUMNS

SELECT *
From PortfolioProject.dbo.NashvilleHousing

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN OwnerAddress,TaxDistrict,PropertyAddress

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN SaleDate

