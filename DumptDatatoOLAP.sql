CREATE PROCEDURE DumptData
As
Begin

INSERT INTO OLAP_UsedCar.dbo.DIM_BODYTYPE  ( BodyTypeID, BodyTypeName)
(
SELECT * FROM OLTP_UsedCar.dbo.BODYTYPE);

INSERT INTO OLAP_UsedCar.dbo.DIM_Brand  ( BrandID,BrandName)
(
SELECT * FROM OLTP_UsedCar.dbo.Brand);

INSERT INTO OLAP_UsedCar.dbo.DIM_Color  ( ColorID ,ColorName)
(
SELECT * FROM OLTP_UsedCar.dbo.Color);

INSERT INTO OLAP_UsedCar.dbo.DIM_Engine  ( EngineID ,EngineType,EngineDisplacement)
(
SELECT * FROM OLTP_UsedCar.dbo.Engine);

INSERT INTO OLAP_UsedCar.dbo.DIM_Fuel ( FuelID ,FuelType)
(
SELECT * FROM OLTP_UsedCar.dbo.Fuel);

INSERT INTO OLAP_UsedCar.dbo.Dim_Transmission (TransmissionID, TransmissionName)
(
SELECT * FROM OLTP_UsedCar.dbo.Transmission);

INSERT INTO OLAP_UsedCar.dbo.Dim_TYPECAR (TypeID, TypeName)
(
SELECT * FROM OLTP_UsedCar.dbo.TYPECAR);

INSERT INTO OLAP_UsedCar.dbo.Dim_WHEELSYSTEM(WHEELSYSTEMID, WHEELSYSTEMName)
(
SELECT * FROM OLTP_UsedCar.dbo.WHEELSYSTEM);

INSERT INTO OLAP_UsedCar.dbo.DIM_Model(  ModelID,ModelName, BodyTypeID, BrandID,FuelID, EngineID, year)
(
SELECT * FROM OLTP_UsedCar.dbo.Model);
INSERT INTO OLAP_UsedCar.dbo.Dim_SELLER(SellerID,SellerName,City)
(
SELECT * FROM OLTP_UsedCar.dbo.Seller);

BULK INSERT OLAP_UsedCar.dbo.Dim_Date
FROM 'D:\Kỳ 20211\Đồ án 2\Date.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
);


--------Dumpt to fact
INSERT INTO OLAP_UsedCar.dbo.Fact_Sales(  CarID ,
  Date ,
  Sales ,
  ModelID,
  TypeID ,
  TransmissionID ,
  WheelSystemID ,
  SellerID ,
  ColorID )
(
SELECT * from oltp_usedcar.dbo.STOCKOUT)


INSERT INTO OLAP_UsedCar.dbo.Fact_Inventory(  CarID ,
  Date ,
  ModelID,
  TypeID ,
  TransmissionID ,
  WheelSystemID ,
  SellerID ,
  ColorID ,
  Inventory)
(
SELECT * from oltp_usedcar.dbo.Car)




INSERT INTO OLAP_UsedCar.dbo.Fact_Quantity(  CarID ,
  Date ,
  Quantity,
  ModelID,
  TypeID ,
  TransmissionID ,
  WheelSystemID ,
  SellerID ,
  ColorID )
(
SELECT * from oltp_usedcar.dbo.STOCKIN)
end 

