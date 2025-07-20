
-- Data Cleaning Project on Nashville Housing market


-- this is the second project I am working on for SQL

-- another step into the Journey 

-- I won't be commenting much but I will do if it required.



--using use as I won't be working cross databases 

use PortfolioProject

--looking at what the data looks like before starting

select * from PortfolioProject.dbo.NashvilleHousing





-- Checking what sorts of property are there... bascially seeing the property use


select distinct(Landuse) , COUNT(landuse) as LandCount
from PortfolioProject.dbo.NashvilleHousing

group by landuse

order by LandCount DESC





-- Giving a standard date format


SELECT 
    SaleDate, CONVERT(date, SaleDate) SALE_DATE
FROM PortfolioProject.dbo.NashvilleHousing



update PortfolioProject.dbo.NashvilleHousing

set saledate = CONVERT(date, SaleDate)


select saledate from NashvilleHousing


ALTER TABLE PortfolioProject.dbo.NashvilleHousing

ADD SaleDateConverted Date


update PortfolioProject.dbo.NashvilleHousing

set SaleDateConverted = CONVERT(date, SaleDate)



select saledateconverted from PortfolioProject.dbo.NashvilleHousing



-- Add Values to Property Address

select *

from PortfolioProject.dbo.NashvilleHousing

--where PropertyAddress is NULL

order by ParcelID



select A.ParcelId , A.PropertyAddress , B.ParcelId , B.PropertyAddress
from PortfolioProject.dbo.NashvilleHousing A

JOIN PortfolioProject.dbo.NashvilleHousing B

on A.parcelId = B.parcelID

    and A.[UniqueID] <> B.[UniqueID]

where a.propertyaddress is null

update a
SET PropertyAddress = ISNULL(a.PropertyAddress , b.PropertyAddress)

from PortfolioProject.dbo.NashvilleHousing A

JOIN PortfolioProject.dbo.NashvilleHousing B

on A.parcelId = B.parcelID

    and A.[UniqueID] <> B.[UniqueID]

    where a.propertyaddress is null  -- it totally worked!




-- Dividing the Address into Address, Cities and States Individual columns 


select PropertyAddress 

from PortfolioProject.dbo.NashvilleHousing 



Select 

substring ( PropertyAddress , 1 , CHARINDEX(',', PropertyAddress) -1) as ADDRESS,
substring ( PropertyAddress ,CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as ADDRESS 


from PortfolioProject.dbo.NashvilleHousing 



--Col1

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
ADD PropertySplitAddress Nvarchar(255)

update PortfolioProject.dbo.NashvilleHousing
set PropertySplitAddress = substring ( PropertyAddress , 1 , CHARINDEX(',', PropertyAddress) -1)



-- Col2

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
ADD PropertySplitCity Nvarchar(255)


update PortfolioProject.dbo.NashvilleHousing
set PropertySplitCity  = substring ( PropertyAddress ,CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))



--- checking for state


select * from PortfolioProject.dbo.NashvilleHousing 


select owneraddress from PortfolioProject.dbo.NashvilleHousing 


SELECT PARSENAME (Replace(OwnerAddress, ',', '.'),3) 
,PARSENAME (Replace(OwnerAddress, ',', '.'),2) 
,PARSENAME (Replace(OwnerAddress, ',', '.'),1) from PortfolioProject.dbo.NashvilleHousing 




-- Owner Split Address


ALTER TABLE PortfolioProject.dbo.NashvilleHousing
ADD OwnerSplitAddress Nvarchar(255)

update PortfolioProject.dbo.NashvilleHousing
set OwnerSplitAddress = PARSENAME (Replace(OwnerAddress, ',', '.'),3) 



-- City Split Address

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
ADD OwnerSplitCity Nvarchar(255)


update PortfolioProject.dbo.NashvilleHousing
set OwnerSplitCity  = PARSENAME (Replace(OwnerAddress, ',', '.'),2) 


-- state split address


ALTER TABLE PortfolioProject.dbo.NashvilleHousing
ADD OwnerSplitState Nvarchar(255)


update PortfolioProject.dbo.NashvilleHousing
set OwnerSplitState = PARSENAME (Replace(OwnerAddress, ',', '.'),1)



-- seeing the result now


select OwnerSplitAddress , OwnerSplitCity , OwnerSplitState from PortfolioProject.dbo.NashvilleHousing  --- yup it is so much useful now!






-- Stating Y and N instead of Yes or No in SoldASVaccant column

-- motive behind it is that everything is more streamline as the data in it contains Y or N and Yes or No which is very confusing sometimes....



select distinct(SoldAsVacant) , count(soldasvacant)
from PortfolioProject.dbo.NashvilleHousing
group by SoldAsVacant
order by 2



-- checking the soldasvacant columns

select soldasvacant ,
case

when soldasvacant = 'Y' then 'Yes'
WHEN soldasvacant = 'N' Then 'No'
else soldasvacant 
end 

from PortfolioProject.dbo.NashvilleHousing


-- using the same command to update the columns 

update PortfolioProject.dbo.NashvilleHousing
SET SoldAsVacant =
case

when soldasvacant = 'Y' then 'Yes'
WHEN soldasvacant = 'N' Then 'No'
else soldasvacant 
end 



-- Removing all the duplicates while seeing what seems to be duplicate and what doesn't


WITH RowNumCTE As (
select * , 

ROW_NUMBER() 
over
(partition by ParcelId ,PropertyAddress, SalePrice, SaleDate,LegalReference order by UniqueId) row_num

from PortfolioProject.dbo.NashvilleHousing

--order by UniqueID

)

--DELETE 
--from RowNumCTE
--where row_num>1

SELECT * from RowNumCTE

Where row_num>1

order by ParcelID



-- Deleting unrequired columns 

-- this is better when doing in views meaning when you actually don't require the data for particular view or something like....


select * from PortfolioProject.dbo.NashvilleHousing



Alter Table PortfolioProject.dbo.NashvilleHousing
DROP Column OwnerAddress, Taxdistrict , PropertyAddress , SaleDate



select * from PortfolioProject.dbo.NashvilleHousing

