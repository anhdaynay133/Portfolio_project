use oltp_usedcar

--Bảng Brand
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER insert_delete_brand1 ON OLTP_UsedCar.dbo.Brand
AFTER INSERT,DELETE
AS 
BEGIN 
DECLARE @ID INT;
DECLARE @TableName VARCHAR(15);
DECLARE @ColName VARCHAR(50);
SET NOCOUNT ON ; -- Ngăn chặn thông báo số lượng bản ghi bị ảnh hưởng bất cứ khi nào trigger trigger được kích hoạt 
--Lấy mã brand đang thao tác
WITH tmp AS (
SELECT Inserted.BrandID,Inserted.BrandName FROM Inserted
UNION 
SELECT Deleted.BrandID,Deleted.BrandName FROM Deleted 
)
SELECT @ID = BrandID FROM tmp 
--Thêm vào bảng Dim_Brand
INSERT INTO OLAP_UsedCar.dbo.Dim_BRAND
(	BrandID,
    BrandName)
    SELECT @ID,
        i.BrandName
    FROM inserted AS i;
--Cập nhật Bảng DIm_brand khi Insert and Delete 
UPDATE OLAP_UsedCar.dbo.Dim_BRAND
SET  @ID = BrandID 
WHERE @ID = BrandID 

SET @TableName = 'Brand';
SET @ColName = 'BrandID';

--Thêm vào bảng AutoInsert
INSERT INTO OLTP_UsedCar.dbo.AutoInsert
(	ID ,  TableName, KeyValues,Colname, StatusOLTP,StatusOLAP,ValuesBefore,ValuesAfter,Update_at)
SELECT
	@ID,@TableName ,i.BrandName,@ColName, 'Inserted', 'Tranformed',  'NULL',  'NULL', GETDATE() FROM inserted AS i 
	UNION SELECT
	@ID,@TableName ,d.BrandName, @ColName, 'Deleted',  'Unaltered', d.BrandName, 'NULL', 
	GETDATE()
    FROM deleted AS d 
END
--Tạo trigger update 
CREATE TRIGGER Update_Brand ON OLTP_UsedCar.dbo.Brand
AFTER UPDATE 
AS BEGIN
DECLARE @ID INT;
DECLARE @TableName VARCHAR(15);
DECLARE @ColName VARCHAR(50);
WITH tmp AS (
SELECT Inserted.BrandID,Inserted.BrandName FROM Inserted
UNION 
SELECT Deleted.BrandID,Deleted.BrandName FROM Deleted )
SELECT @ID = BrandID FROM tmp 
--Cập nhật Bảng Dim_brand khi update
UPDATE OLAP_UsedCar.dbo.Dim_BRAND
SET  BrandName = ( SELECT BrandName FROM Inserted WHERE @ID = BrandID
)WHERE Dim_BRAND.BrandID = (SELECT BrandID FROM Inserted )
SET @TableName = 'Brand';
SET @ColName = 'BrandID';
INSERT INTO  OLTP_UsedCar.dbo.AutoInsert
(	ID ,TableName,KeyValues,Colname,StatusOLTP,StatusOLAP,ValuesBefore,ValuesAfter,Update_at)
SELECT
	@ID,@TableName ,BrandName,@ColName, 'Updated', 'Tranformed', '...', BrandName, GETDATE()
    FROM Inserted as i
END

-----------------------
---Tra cứu
SELECT * FROM dbo.BRAND
SELECT * FROM OLAP_UsedCar.dbo.Dim_BRAND
SELECT * FROM dbo.AutoInsert

--Thêm dữ liệu
INSERT INTO dbo.BRAND
(
    BrandID,
    BrandName
)
VALUES
(    110, -- BrandID - int
    'Future' -- BrandName - varchar(100)
    )
--Xóa dữ liệu 
DELETE FROM dbo.BRAND WHERE BrandID = 110
DELETE FROM OLAP_UsedCar.dbo.Dim_BRAND WHERE BrandID = 110
TRUNCATE TABLE dbo.AutoInsert
--Cập nhật dữ liệu
UPDATE dbo.BRAND 
SET BrandName = 'ODDOO'
WHERE BrandID = 110

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Bảng color

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER insert_delete_color ON OLTP_UsedCar.dbo.Color
AFTER INSERT,DELETE
AS 
BEGIN 
DECLARE @ID INT;
DECLARE @TableName VARCHAR(15);
DECLARE @ColName VARCHAR(50);
SET NOCOUNT ON ; -- Ngăn chặn thông báo số lượng bản ghi bị ảnh hưởng bất cứ khi nào trigger trigger được kích hoạt 
--Lấy mã Color đang thao tác
WITH tmp AS (
SELECT Inserted.ColorID,Inserted.ColorName FROM Inserted
UNION 
SELECT Deleted.ColorID,Deleted.ColorName FROM Deleted 
)
SELECT @ID = ColorID FROM tmp 
--Thêm vào bảng Dim_Color
INSERT INTO OLAP_UsedCar.dbo.Dim_Color
(	ColorID,
    ColorName)
    SELECT @ID,
        i.ColorName
    FROM inserted AS i;
--Cập nhật Bảng DIm_Color khi Insert and Delete 
UPDATE OLAP_UsedCar.dbo.Dim_Color
SET  @ID = ColorID 
WHERE @ID = ColorID 

SET @TableName = 'Color';
SET @ColName = 'ColorID';

--Thêm vào bảng AutoInsert
INSERT INTO OLTP_UsedCar.dbo.AutoInsert
(	ID ,
    TableName,
    KeyValues,
    Colname,
    StatusOLTP,
    StatusOLAP,
    ValuesBefore,
    ValuesAfter,
	Update_at
)
SELECT
	@ID,
	@TableName ,
	i.ColorName,
    @ColName, -- Colname - varchar(50)
    'Inserted', -- StatusOLTP - varchar(20)
    'Tranformed', -- StatusOLAP - varchar(20)
    'NULL', -- ValuesBefore - varchar(50)
    'NULL',  -- ValuesAfter - varchar(50)
	GETDATE()
    FROM inserted AS i 
	UNION 
	SELECT
	@ID,
	@TableName ,
	d.ColorName,-- KeyValues - int
    @ColName, -- Colname - varchar(50)
    'Deleted', -- StatusOLTP - varchar(20)
    'Unaltered', -- StatusOLAP - varchar(20)
    d.ColorName, -- ValuesBefore - varchar(50)
    'NULL',  -- ValuesAfter - varchar(50)
	GETDATE()
    FROM deleted AS d 
END

--Tạo trigger update 
create TRIGGER Update_Color ON OLTP_UsedCar.dbo.Color
AFTER UPDATE 
AS 
BEGIN
DECLARE @ID INT;
DECLARE @TableName VARCHAR(15);
DECLARE @ColName VARCHAR(50);
WITH tmp AS (
SELECT Inserted.ColorID,Inserted.ColorName FROM Inserted
UNION 
SELECT Deleted.ColorID,Deleted.ColorName FROM Deleted 
)
SELECT @ID = ColorID FROM tmp 
--Cập nhật Bảng Dim_Color khi update
UPDATE OLAP_UsedCar.dbo.Dim_Color
SET  ColorName = (
SELECT ColorName FROM Inserted WHERE @ID = ColorID
)WHERE Dim_Color.ColorID = (SELECT ColorID FROM Inserted )
SET @TableName = 'Color';
SET @ColName = 'ColorID';
INSERT INTO  OLTP_UsedCar.dbo.AutoInsert
(	ID ,
    TableName,
    KeyValues,
    Colname,
    StatusOLTP,
    StatusOLAP,
    ValuesBefore,
    ValuesAfter,
	Update_at
)
SELECT
	@ID,
	@TableName ,
	ColorName,
    @ColName, -- Colname - varchar(50)
    'Updated', -- StatusOLTP - varchar(20)
    'Tranformed', -- StatusOLAP - varchar(20)
   '...', -- ValuesBefore - varchar(50)
    ColorName,  -- ValuesAfter - varchar(50)
	GETDATE()
    FROM Inserted as i
END

---------------------------------
---Tra cứu Color
SELECT * FROM dbo.COLOR
SELECT * FROM OLAP_UsedCar.dbo.Dim_COLOR
SELECT * FROM dbo.AutoInsert

--Thêm dữ liệu
INSERT INTO dbo.COLOR
(
   ColorID,
   ColorName
)
VALUES
(    20, 
    'Blue_Green' 
    )
--Xóa dữ liệu 
DELETE FROM dbo.COLOR WHERE ColorID = 20
DELETE FROM OLAP_UsedCar.dbo.Dim_COLOR where ColorID = 20 
Delete from AutoInsert where iD = 20
--Cập nhật dữ liệu
UPDATE dbo.COLOR
SET ColorName = 'Red_Orange'
WHERE ColorID = 20




---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Bảng Bodytype
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER insert_delete_Bodytype ON OLTP_UsedCar.dbo.Bodytype
AFTER INSERT,DELETE
AS 
BEGIN 
DECLARE @ID INT;
DECLARE @TableName VARCHAR(15);
DECLARE @ColName VARCHAR(50);
SET NOCOUNT ON ; -- Ngăn chặn thông báo số lượng bản ghi bị ảnh hưởng bất cứ khi nào trigger trigger được kích hoạt 
--Lấy mã Bodytype đang thao tác
WITH tmp AS (
SELECT Inserted.BodyTypeID,Inserted.BodyTypeName FROM Inserted
UNION 
SELECT Deleted.BodyTypeID,Deleted.BodyTypeName FROM Deleted 
)
SELECT @ID = BodyTypeID FROM tmp 
--Thêm vào bảng Dim_Bodytype
INSERT INTO OLAP_UsedCar.dbo.Dim_Bodytype
(	BodyTypeID, BodyTypeName)
    SELECT @ID, i.BodyTypeName
    FROM inserted AS i;
--Cập nhật Bảng DIm_Color khi Insert and Delete 
UPDATE OLAP_UsedCar.dbo.Dim_Color
SET  @ID = BodyTypeID 
WHERE @ID = BodyTypeID 
SET @TableName = 'Bodytype';
SET @ColName = 'BodyTypeID';

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Bảng Engine
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER insert_delete_Engine ON OLTP_UsedCar.dbo.Engine
AFTER INSERT,DELETE
AS 
BEGIN 
DECLARE @ID INT;
DECLARE @TableName VARCHAR(15);
DECLARE @ColName VARCHAR(50);
SET NOCOUNT ON ; -- Ngăn chặn thông báo số lượng bản ghi bị ảnh hưởng bất cứ khi nào trigger trigger được kích hoạt 
--Lấy mã Engine đang thao tác
WITH tmp AS (
SELECT Inserted.EngineID,Inserted.EngineName FROM Inserted
UNION 
SELECT Deleted.EngineID,Deleted.EngineName FROM Deleted 
)
SELECT @ID = EngineID FROM tmp 
--Thêm vào bảng Dim_Engine
INSERT INTO OLAP_UsedCar.dbo.Dim_ENGINE
(	EngineID, EngineName)
    SELECT @ID, i.EngineName
    FROM inserted AS i;
--Cập nhật Bảng DIm_Engine khi Insert and Delete 
UPDATE OLAP_UsedCar.dbo.Dim_ENGINE
SET  @ID = EngineID 
WHERE @ID = EngineID 
SET @TableName = 'Engine';
SET @ColName = 'EngineID';
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Bảng Fuel
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER insert_delete_Fuel ON OLTP_UsedCar.dbo.Fuel
AFTER INSERT,DELETE
AS 
BEGIN 
DECLARE @ID INT;
DECLARE @TableName VARCHAR(15);
DECLARE @ColName VARCHAR(50);
SET NOCOUNT ON ; -- Ngăn chặn thông báo số lượng bản ghi bị ảnh hưởng bất cứ khi nào trigger trigger được kích hoạt 
--Lấy mã Engine đang thao tác
WITH tmp AS (
SELECT Inserted.FuelID,Inserted.FuelType FROM Inserted
UNION 
SELECT Deleted.FuelID,Deleted.FuelType FROM Deleted 
)
SELECT @ID = FuelID FROM tmp 
--Thêm vào bảng Dim_Fuel
INSERT INTO OLAP_UsedCar.dbo.Dim_Fuel
(	FuelID, FuelType)
    SELECT @ID, i.FuelType
    FROM inserted AS i;
--Cập nhật Bảng DIm_Fuel khi Insert and Delete 
UPDATE OLAP_UsedCar.dbo.Dim_Fuel 
SET  @ID = FuelID 
WHERE @ID = FuelID 
SET @TableName = 'Fuel';
SET @ColName = 'FuelID';


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Bảng Model
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER insert_delete_Model ON OLTP_UsedCar.dbo.Model
AFTER INSERT,DELETE
AS 
BEGIN 
DECLARE @ID INT;
DECLARE @TableName VARCHAR(15);
DECLARE @ColName VARCHAR(50);
SET NOCOUNT ON ; -- Ngăn chặn thông báo số lượng bản ghi bị ảnh hưởng bất cứ khi nào trigger trigger được kích hoạt 
--Lấy mã Model đang thao tác
WITH tmp AS (
SELECT Inserted.ModelID,Inserted.ModelName FROM Inserted
UNION 
SELECT Deleted.ModelID,Deleted.ModelName FROM Deleted 
)
SELECT @ID = ModelID FROM tmp 
--Thêm vào bảng Dim_Model
INSERT INTO OLAP_UsedCar.dbo.Dim_Model
(	ModelID, ModelName)
    SELECT @ID, i.ModelName
    FROM inserted AS i;
--Cập nhật Bảng DIm_Fuel khi Insert and Delete 
UPDATE OLAP_UsedCar.dbo.Dim_Model
SET  @ID = ModelID 
WHERE @ID = ModelID 
SET @TableName = 'Model';
SET @ColName = 'ModelID';
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Bảng Seller
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER insert_delete_Seller ON OLTP_UsedCar.dbo.Seller
AFTER INSERT,DELETE
AS 
BEGIN 
DECLARE @ID INT;
DECLARE @TableName VARCHAR(15);
DECLARE @ColName VARCHAR(50);
SET NOCOUNT ON ; -- Ngăn chặn thông báo số lượng bản ghi bị ảnh hưởng bất cứ khi nào trigger trigger được kích hoạt 
--Lấy mã Seller đang thao tác
WITH tmp AS (
SELECT Inserted.SellerID,Inserted.SellerName FROM Inserted
UNION 
SELECT Deleted.SellerID,Deleted.SellerName FROM Deleted 
)
SELECT @ID = SellerID FROM tmp 
--Thêm vào bảng Dim_Seller
INSERT INTO OLAP_UsedCar.dbo.Dim_Seller
(	SellerID, SellerName)
    SELECT @ID, i.SellerName
    FROM inserted AS i;
--Cập nhật Bảng DIm_Seller khi Insert and Delete 
UPDATE OLAP_UsedCar.dbo.Dim_Seller
SET  @ID = SellerID 
WHERE @ID = SellerID 
SET @TableName = 'Seller';
SET @ColName = 'SellerID';

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Bảng Transmission
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER insert_delete_Transmission ON OLTP_UsedCar.dbo.Transmission
AFTER INSERT,DELETE
AS 
BEGIN 
DECLARE @ID INT;
DECLARE @TableName VARCHAR(15);
DECLARE @ColName VARCHAR(50);
SET NOCOUNT ON ; -- Ngăn chặn thông báo số lượng bản ghi bị ảnh hưởng bất cứ khi nào trigger trigger được kích hoạt 
--Lấy mã Transmission đang thao tác
WITH tmp AS (
SELECT Inserted.TransmissionID,Inserted.TransmissionName FROM Inserted
UNION 
SELECT Deleted.TransmissionID,Deleted.TransmissionName FROM Deleted 
)
SELECT @ID = TransmissionID FROM tmp 
--Thêm vào bảng Dim_Transmission
INSERT INTO OLAP_UsedCar.dbo.Dim_Transmission
(	TransmissionID, TransmissionName)
    SELECT @ID, i.TransmissionName
    FROM inserted AS i;
--Cập nhật Bảng DIm_Transmission khi Insert and Delete 
UPDATE OLAP_UsedCar.dbo.Dim_Transmission
SET  @ID = TransmissionID 
WHERE @ID = TransmissionID 
SET @TableName = 'Transmission';
SET @ColName = 'TransmissionID';---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Bảng Wheelsystem
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER insert_delete_Wheelsystem ON OLTP_UsedCar.dbo.Wheelsystem
AFTER INSERT,DELETE
AS 
BEGIN 
DECLARE @ID INT;
DECLARE @TableName VARCHAR(15);
DECLARE @ColName VARCHAR(50);
SET NOCOUNT ON ; -- Ngăn chặn thông báo số lượng bản ghi bị ảnh hưởng bất cứ khi nào trigger trigger được kích hoạt 
--Lấy mã Wheelsystem đang thao tác
WITH tmp AS (
SELECT Inserted.WheelsystemID,Inserted.WheelsystemName FROM Inserted
UNION 
SELECT Deleted.WheelsystemID,Deleted.WheelsystemName FROM Deleted 
)
SELECT @ID = WheelsystemID FROM tmp 
--Thêm vào bảng Dim_Wheelsystem
INSERT INTO OLAP_UsedCar.dbo.Dim_Wheelsystem
(	WheelsystemID, WheelsystemName)
    SELECT @ID, i.WheelsystemName
    FROM inserted AS i;
--Cập nhật Bảng DIm_Wheelsystem khi Insert and Delete 
UPDATE OLAP_UsedCar.dbo.Dim_Wheelsystem
SET  @ID = WheelsystemID 
WHERE @ID = WheelsystemID 
SET @TableName = 'Wheelsystem';
SET @ColName = 'WheelsystemID';
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Bảng TypeCar
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER insert_delete_TypeCar ON OLTP_UsedCar.dbo.TypeCar
AFTER INSERT,DELETE
AS 
BEGIN 
DECLARE @ID INT;
DECLARE @TableName VARCHAR(15);
DECLARE @ColName VARCHAR(50);
SET NOCOUNT ON ; -- Ngăn chặn thông báo số lượng bản ghi bị ảnh hưởng bất cứ khi nào trigger trigger được kích hoạt 
--Lấy mã TypeCar đang thao tác
WITH tmp AS (
SELECT Inserted.TypeCarID,Inserted.TypeName FROM Inserted
UNION 
SELECT Deleted.TypeCarID,Deleted.TypeName FROM Deleted 
)
SELECT @ID = TypeCarID FROM tmp 
--Thêm vào bảng Dim_TypeCar
INSERT INTO OLAP_UsedCar.dbo.Dim_TypeCar
(	TypeCarID, TypeName)
    SELECT @ID, i.TypeName
    FROM inserted AS i;
--Cập nhật Bảng DIm_TypeCar khi Insert and Delete 
UPDATE OLAP_UsedCar.dbo.Dim_TypeCar
SET  @ID = TypeCarID 
WHERE @ID = TypeCarID 
SET @TableName = 'TypeCar';
SET @ColName = 'TypeCarID';