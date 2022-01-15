-- CLEANING DATA IN SQL.
-- using nashville_housing dataset for data cleaning and data transformation in SQL.

SELECT * FROM portfolio_project.nashville_housing;

-- populating missing data in PropertyAddress column.

/*select *
from nashville_housing
where PropertyAddress is null ; */

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull(a.PropertyAddress,b.PropertyAddress)
from nashville_housing a
join nashville_housing b
on a.ParcelID = b.ParcelID and a.UniqueID <> b.UniqueID
where a.PropertyAddress is null;
-- updating missing values
update a
set PropertyAddress = isnull(a.PropertyAddress,b.PropertyAddress)
from nashville_housing a
join nashville_housing b
on a.ParcelID = b.ParcelID and a.UniqueID <> b.UniqueID
where a.PropertyAddress is null;

-- splitting PropertyAddress column in to individual columns namly address, city, state

select PropertyAddress
from nashville_housing;

select PropertyAddress,
	substring(PropertyAddress,1, position(',' in PropertyAddress)-1) as address_1,
    substr(PropertyAddress,position(',' in PropertyAddress)+1, length(PropertyAddress)) as address_2
from nashville_housing;

alter table nashville_housing
add address text;

update nashville_housing
set  address = substring(PropertyAddress,1, position(',' in PropertyAddress)-1);

alter table nashville_housing
add city text;

update nashville_housing
set  city = substr(PropertyAddress,position(',' in PropertyAddress)+1, length(PropertyAddress));

select OwnerAddress ,substring_index(OwnerAddress,',',1),
	substring_index(substring_index(OwnerAddress,',',2),',',-1),
    substring_index(OwnerAddress,',',-1)
from nashville_housing;

alter table nashville_housing
add Owneraddress text;

update nashville_housing
set  Owneraddress = substring_index(OwnerAddress,',',1);

alter table nashville_housing
add OwnerCity text;

update nashville_housing
set  OwnerCity = substring_index(substring_index(OwnerAddress,',',2),',',-1);

alter table nashville_housing
add OwnerState text;

update nashville_housing
set  OwnerState =substring_index(OwnerAddress,',',-1);

-- change Y, N values in SoldAsVacant to yes ,no. 

/*  select distinct(SoldAsVacant)
  from nashville_housing;  */
  
select SoldAsVacant,
		case when SoldAsVacant = 'Y' then 'Yes'
             when SoldAsVacant = 'N' then 'No'
             else SoldAsVacant
		end 
from nashville_housing;

update nashville_housing
set SoldAsVacant = case when SoldAsVacant = 'Y' then 'Yes'
						when SoldAsVacant = 'N' then 'No'
						else SoldAsVacant
				   end;

-- removing duplicates.

with row_nCTE as
(select *,
		row_number() over(partition by ParcelID,
										PropertyAddress,
                                        SalePrice,
                                        SaleDate
						   order by ParcelID) as row_num
from nashville_housing) 
delete
from row_nCTE
where row_num >1;

-- deleting unused columns. 

alter table nashville_housing
drop column PropertyAddress, OwnerAddress,TaxDistrict;







