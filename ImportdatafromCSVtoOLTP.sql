--Insert table Color


BULK INSERT COLOR
FROM 'D:\Kỳ 20211\Đồ án 2\COLOR.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
)

--Insert table Bodytype
BULK INSERT Bodytype
FROM 'D:\Kỳ 20211\Đồ án 2\Bodytype.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
)
--Insert table Engine
BULK INSERT Engine
FROM 'D:\Kỳ 20211\Đồ án 2\Engine.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
)


--Insert table Fuel
BULK INSERT Fuel
FROM 'D:\Kỳ 20211\Đồ án 2\Fuel.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
)


--Insert table TypeCar
BULK INSERT TypeCar
FROM 'D:\Kỳ 20211\Đồ án 2\TypeCar.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
)
--Insert table Wheelsystem
BULK INSERT Wheelsystem
FROM 'D:\Kỳ 20211\Đồ án 2\Wheelsystem.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
)
--Insert Seller 
BULK INSERT Seller
FROM 'D:\Kỳ 20211\Đồ án 2\Seller.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
)

--Insert table Transmission
BULK INSERT Transmission
FROM 'D:\Kỳ 20211\Đồ án 2\Transmission.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
)
--Insert table brand
BULK INSERT dbo.BRAND
FROM 'D:\Kỳ 20211\Đồ án 2\brand.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
)
--Insert table Model
BULK INSERT dbo.MODEL
FROM 'D:\Kỳ 20211\Đồ án 2\Model.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
)

--Insert table Stockout
BULK INSERT dbo.STOCKOUT
FROM 'D:\Kỳ 20211\Đồ án 2\Stockout.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
)


--Insert table Stockin
BULK INSERT dbo.STOCKIN
FROM 'D:\Kỳ 20211\Đồ án 2\Stockin.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
)


--Insert table Car
BULK INSERT dbo.CAR
FROM 'D:\Kỳ 20211\Đồ án 2\Car.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n'   --Use to shift the control to next row

);


