-- DROPPING TABLES IN CASE THEY ALREADY EXIST

DROP TABLE Customer CASCADE CONSTRAINTS;
DROP TABLE Individual CASCADE CONSTRAINTS;
DROP TABLE Corporate CASCADE CONSTRAINTS;
DROP TABLE InsuranceType CASCADE CONSTRAINTS;
DROP TABLE Insurance CASCADE CONSTRAINTS;
DROP TABLE Driver CASCADE CONSTRAINTS;
DROP TABLE AdditionalRequirements CASCADE CONSTRAINTS;
DROP TABLE HireCentre CASCADE CONSTRAINTS;
DROP TABLE Inspector CASCADE CONSTRAINTS;
DROP TABLE VehicleClassification CASCADE CONSTRAINTS;
DROP TABLE VehicleModel CASCADE CONSTRAINTS;
DROP TABLE Vehicle CASCADE CONSTRAINTS;
DROP TABLE RivalHireCompany CASCADE CONSTRAINTS;
DROP TABLE CheckInCentre CASCADE CONSTRAINTS;
DROP TABLE Hire CASCADE CONSTRAINTS;
DROP TABLE FleetHire CASCADE CONSTRAINTS;
DROP TABLE Hire_AddReq CASCADE CONSTRAINTS;
DROP TABLE Hire_Driver CASCADE CONSTRAINTS;
DROP TABLE FleetHire_Driver CASCADE CONSTRAINTS;
DROP TABLE FleetHire_Vehicle CASCADE CONSTRAINTS;
DROP TABLE FleetHire_AddReq CASCADE CONSTRAINTS;
DROP TABLE RivalHireCompany_Vehicle CASCADE CONSTRAINTS;
DROP TABLE CheckInCentre_Vehicle CASCADE CONSTRAINTS;
DROP TABLE Inspector_Vehicle CASCADE CONSTRAINTS;
DROP TABLE HireCentre_Vehicle CASCADE CONSTRAINTS;
DROP TABLE Invoice CASCADE CONSTRAINTS;
DROP TABLE Customer_Insurance CASCADE CONSTRAINTS;



-- CREATING TABLES

     CREATE TABLE Customer (     
    Customer_ID NUMBER(8),
    Customer_Category VARCHAR(15) NOT NULL,           
    Customer_Phone VARCHAR2(15) NOT NULL UNIQUE,     
    Addressline VARCHAR2(250) NOT NULL,     
    City VARCHAR2(50) NOT NULL,
    Country VARCHAR2(50) NOT NULL,
    Postcode VARCHAR2(10) NOT NULL,
    Customer_Email VARCHAR2(30) NOT NULL,   
    FAX NUMBER(15) NOT NULL,
    Account_No VARCHAR2(50) NOT NULL,
    CreditCard_No VARCHAR(20) NOT NULL UNIQUE,   
    CreditCard_Exp_Dt VARCHAR(8),
    CONSTRAINTS pk_customer_id1 PRIMARY KEY (Customer_ID), 
    CONSTRAINTS ch_category CHECK (Customer_Category in('Individual', 'Corporate'))
    );


    CREATE TABLE Individual (     
    Customer_ID NUMBER(8),                                      --implementing subtype
    Customer_Fname VARCHAR2(35) NOT NULL,     
    Customer_Lname VARCHAR2(35) NOT NULL,
    Customer_Dob DATE NOT NULL,     
    Customer_Gender VARCHAR(10) NOT NULL,  
    CONSTRAINTS pk_ind_customer_id1 PRIMARY KEY (Customer_ID), 
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),  --implementing subtype
    CONSTRAINTS ch_gender1 CHECK (Customer_Gender in('Male', 'Female','Other'))
    );


    CREATE TABLE Corporate(     
    Customer_ID NUMBER(8),                                      --implementing subtype
    Corporate_Name VARCHAR2(35) NOT NULL,     
    Tax_ID_Number VARCHAR2(20) NOT NULL,
    Business_Registration_Number VARCHAR2(35) NOT NULL,
    CONSTRAINTS pk_corp_customer_id1 PRIMARY KEY (Customer_ID), --implementing subtype
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
    );


    CREATE TABLE InsuranceType (
    InsuranceType_ID NUMBER(8),
    InsuranceType_Name VARCHAR2(40) NOT NULL UNIQUE,
    CoverageLimit NUMBER(10,3) NOT NULL,
    Deductibles NUMBER(10,3) NOT NULL,
    PremiumsPerDay NUMBER(30,3) NOT NULL,
    CoverageDetails VARCHAR2(300),
    CONSTRAINTS pk_insurancetype_id2 PRIMARY KEY (InsuranceType_ID)
    );


    CREATE TABLE Insurance (
    Insurance_ID NUMBER(8),
    PolicyNumber VARCHAR2(10) NOT NULL UNIQUE,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    InsuranceType_ID REFERENCES InsuranceType(InsuranceType_ID),
    CONSTRAINTS pk_insurance_id2 PRIMARY KEY (Insurance_ID)
    );


    CREATE TABLE Driver (
    Driver_ID NUMBER(8),
    Driver_Fname VARCHAR2(35) NOT NULL,
    Driver_Lname VARCHAR2(35) NOT NULL,
    License_No VARCHAR2(16) NOT NULL UNIQUE,
    Driver_Dob DATE NOT NULL,
    Driver_Gender VARCHAR(10) NOT NULL,  
    CONSTRAINTS pk_driver_id1 PRIMARY KEY (Driver_ID),
    CONSTRAINTS ch_gender2 CHECK (Driver_Gender in('Male', 'Female','Other'))

    );


    CREATE TABLE AdditionalRequirements (
    Requirement_ID NUMBER(8),
    Requirement_Name VARCHAR2(45) NOT NULL,
    Details VARCHAR2(250),
    Available VARCHAR2(16) NOT NULL,
    ReqCostPerDay NUMBER(7,2),
    ReqCondition VARCHAR(250) NOT NULL,
    CONSTRAINTS pk_additionalreq_id1 PRIMARY KEY (Requirement_ID)
    );


    CREATE TABLE HireCentre (
    Centre_ID NUMBER(8),
    Centre_Name VARCHAR2(35) NOT NULL UNIQUE,
    AddressLine1 VARCHAR2(250) NOT NULL,
    City VARCHAR2(35) NOT NULL ,
    Country VARCHAR2(35) NOT NULL,
    Postcode VARCHAR2(30) NOT NULL,
    Contact VARCHAR2(15) NOT NULL UNIQUE,
    Email VARCHAR2(30) NOT NULL UNIQUE,
    CONSTRAINTS pk_hirecentre_id1 PRIMARY KEY (Centre_ID)
    );


    CREATE TABLE Inspector (
    Inspector_ID VARCHAR2(8),
    Inspector_Fname VARCHAR2(35) NOT NULL ,
    Inspector_Lname VARCHAR2(35) NOT NULL ,
    Inspector_Phone VARCHAR2(15) NOT NULL UNIQUE,
    Centre_ID NUMBER(8) REFERENCES HireCentre(Centre_ID),
    CONSTRAINTS pk_inspector_id1 PRIMARY KEY (Inspector_ID)
    ); 


    CREATE TABLE VehicleClassification (     
    Class_ID NUMBER(8),     
    Class_Name VARCHAR2(35) NOT NULL UNIQUE,     
    Class_Description VARCHAR2(250),          
    CONSTRAINTS pk_classification_id1 PRIMARY KEY (Class_ID) 
    );


    CREATE TABLE VehicleModel (
    Model_ID NUMBER(8),
    Model_Name VARCHAR2(35) NOT NULL UNIQUE,
    Manufacturer VARCHAR2(35) NOT NULL ,
    Engine_Type VARCHAR2(25) NOT NULL ,
    Year_Of_Release NUMBER(4) ,
    Class_ID NUMBER(8) REFERENCES VehicleClassification(Class_ID),
    CONSTRAINTS pk_model_id1 PRIMARY KEY (Model_ID)
    );


    CREATE TABLE Vehicle (     
    Vehicle_ID NUMBER(8),     
    Vehicle_RegNo VARCHAR2(35) NOT NULL,     
    Year_Of_Buying NUMBER(4) ,     
    Colour VARCHAR2(15) ,     
    Mileage_Per_Year NUMBER(8) NOT NULL,     
    Status VARCHAR(15), --implementing exclusive arc
    Last_Service_Date DATE,
    Model_ID NUMBER(8) REFERENCES VehicleModel(Model_ID),   
    CONSTRAINT chk_status CHECK (Status IN ('Hire', 'FleetHire', 'HireCentre')),   --implementing exclusive arc
    CONSTRAINTS pk_vehicle_id1 PRIMARY KEY (Vehicle_ID) 
    );


    CREATE TABLE RivalHireCompany (
    RivalHireCompany_ID NUMBER(8),
    RivalHireCompany_Name VARCHAR2(35) NOT NULL UNIQUE,
    AddressLine1 VARCHAR2(250) NOT NULL,
    City VARCHAR2(35) NOT NULL ,
    Country VARCHAR2(35) NOT NULL,
    Postcode VARCHAR2(30) NOT NULL,
    Contact VARCHAR2(15) NOT NULL UNIQUE,
    Email VARCHAR2(30) NOT NULL UNIQUE,
    CONSTRAINTS pk_rivalhirecentre_id1 PRIMARY KEY (RivalHireCompany_ID)
    );

    CREATE TABLE CheckInCentre (
    CIC_ID NUMBER(8),
    CIC_Name VARCHAR2(35) NOT NULL UNIQUE,
    AddressLine1 VARCHAR2(250) NOT NULL,
    City VARCHAR2(35) NOT NULL ,
    Country VARCHAR2(35) NOT NULL,
    Postcode VARCHAR2(30) NOT NULL,
    Contact VARCHAR2(15) NOT NULL UNIQUE,
    Email VARCHAR2(30) NOT NULL UNIQUE,
    CONSTRAINTS pk_checkincentre_id1 PRIMARY KEY (CIC_ID)
    );


    CREATE TABLE Invoice (
    Invoice_ID NUMBER(8),
    HireType VARCHAR2(15) NOT NULL,
    Invoice_Organisation_For_FleetHire REFERENCES Corporate(Customer_ID),  --incase invoice organisation is different from hiring orgaisation
    Invoice_Date DATE NOT NULL,
    Hire_ID_OR_FleetHire_ID NUMBER(8) NOT NULL,
    Receipt_No VARCHAR2(15) NOT NULL,
    Basic_Charge_Per_Day NUMBER(8,3) NOT NULL,
    Discount NUMBER(6,3),
    Surcharge NUMBER(8,3),
    Extra_Pay NUMBER(8,3),
    Fuel_Pay NUMBER(8,3),
    Delivery_Charge NUMBER(8,3),
    AdditionalReq_Charge NUMBER(8,3),
    Total NUMBER(8,3) NOT NULL,
    CONSTRAINT chk_hiretpe CHECK (HireType IN ('Hire', 'FleetHire')),   --Checking HireType
    CONSTRAINTS pk_invoice_id1 PRIMARY KEY (Invoice_ID)
    );



     CREATE TABLE Hire (
    Hire_ID NUMBER(8),
    H_Date DATE NOT NULL,
    H_Time VARCHAR2(15) NOT NULL,
    Customer_ID NUMBER(8) REFERENCES Customer(Customer_ID),
    Vehicle_ID NUMBER(8) REFERENCES Vehicle(Vehicle_ID),
    PlaceFrom VARCHAR2(20) NOT NULL,
    Destination VARCHAR2(20) NOT NULL,
    Discount NUMBER(6,2),
    Exp_RDate DATE NOT NULL,
    Exp_RTime VARCHAR2(15) NOT NULL,
    Accident_or_Breakdown_Reported VARCHAR2(5),
    Reported_Date DATE,
    CONSTRAINTS pk_hire_id1 PRIMARY KEY (Hire_ID)
    );


    CREATE TABLE Hire_AddReq (     
    HAddReq_ID NUMBER(8),     
    Hire_ID NUMBER(8) REFERENCES  Hire (Hire_ID),     
    Requirement_ID NUMBER  REFERENCES  AdditionalRequirements(Requirement_ID),          
    CONSTRAINTS pk_Hire_AddReq1 PRIMARY KEY (HAddReq_ID) 
    );


    CREATE TABLE Hire_Driver (     
    HD_ID NUMBER(8),     
    Hire_ID NUMBER(8) REFERENCES Hire(Hire_ID),     
    Vehicle_ID NUMBER(8) REFERENCES Vehicle(Vehicle_ID),     
    CONSTRAINTS pk_HireDriver_id1 PRIMARY KEY (HD_ID)
   );


   CREATE TABLE FleetHire (     
    FleetHire_ID NUMBER(8),     
    Customer_ID NUMBER(8) REFERENCES  Customer (Customer_ID),     
    No_Of_Vehicles Number(2) NOT NULL,
    Discount NUMBER(6,2),
    CONSTRAINTS pk_FleetHire_id1 PRIMARY KEY (FleetHire_ID)
   );

   CREATE TABLE FleetHire_AddReq (     
    FHAddReq_ID NUMBER(8),     
    FleetHire_ID NUMBER(8) REFERENCES  FleetHire(FleetHire_ID),     
    Requirement_ID NUMBER(8)  REFERENCES  AdditionalRequirements(Requirement_ID),     
    CONSTRAINTS pk_FleetHireAddReq_id1 PRIMARY KEY (FHAddReq_ID)
   );

   CREATE TABLE FleetHire_Driver (     
    FHDriver_ID NUMBER(8),     
    FleetHire_ID NUMBER(8) REFERENCES  FleetHire(FleetHire_ID),     
    Driver_ID NUMBER(8)  REFERENCES  Driver(Driver_ID),     
    CONSTRAINTS pk_FleetHireDriver_id1 PRIMARY KEY (FHDriver_ID)
   );

    CREATE TABLE FleetHire_Vehicle (     
    FHVehicles_ID NUMBER(8),     
    FleetHire_ID NUMBER(8) REFERENCES  FleetHire(FleetHire_ID),     
    Vehicle_ID NUMBER(8)  REFERENCES  Vehicle(Vehicle_ID), 
    H_Date DATE NOT NULL,     
    H_Time VARCHAR2(15) NOT NULL, 
    HFrom VARCHAR2(20) NOT NULL,
    Destination VARCHAR2(20) NOT NULL,
    Exp_RDate DATE NOT NULL,
    Exp_RTime VARCHAR2(15) NOT NULL,
    Accident_or_Breakdown_Reported VARCHAR2(5),
    Reported_Date DATE, 
    CONSTRAINTS pk_FleetHireVehicles_id1 PRIMARY KEY (FHVehicles_ID)
   );

   CREATE TABLE RivalHireCompany_Vehicle (     
    RivalCompanyVehicle_ID NUMBER(8),     
    RivalHireCompany_ID NUMBER(8) REFERENCES  RivalHireCompany(RivalHireCompany_ID),     
    Vehicle_ID NUMBER(8)  REFERENCES  Vehicle(Vehicle_ID),     
    CONSTRAINTS pk_RivalCompanyVehicle_id1 PRIMARY KEY (RivalCompanyVehicle_ID)
   );

   CREATE TABLE CheckInCentre_Vehicle (     
    CICVehicle_ID NUMBER(8),     
    CIC_ID NUMBER(8) REFERENCES  CheckInCentre(CIC_ID),     
    Vehicle_ID NUMBER(8)  REFERENCES  Vehicle(Vehicle_ID),     
    CONSTRAINTS pk_CICVehicle_id1 PRIMARY KEY (CICVehicle_ID)
   );

   CREATE TABLE Inspector_Vehicle (     
    InspectorVehicle_ID NUMBER(8),     
    Inspector_ID VARCHAR2(8) REFERENCES  Inspector(Inspector_ID),     
    Vehicle_ID NUMBER(8)  REFERENCES  Vehicle(Vehicle_ID),
    Inspection_Date VARCHAR2(25),
    Fuel_Tank_Status VARCHAR2(250),
    Interior_Exterior_Condition VARCHAR2(250),
    Light_Signals VARCHAR2(250),
    Tires VARCHAR2(250),
    Engine_Bay VARCHAR2(200),
    AddReq_Status VARCHAR2(250),
    CONSTRAINTS pk_InspectorVehicle_id1 PRIMARY KEY (InspectorVehicle_ID)
   );

   CREATE TABLE HireCentre_Vehicle (     
    HireCentreVehicle_ID NUMBER(8),     
    Centre_ID NUMBER(8) REFERENCES  HireCentre(Centre_ID),     
    Vehicle_ID NUMBER(8)  REFERENCES  Vehicle(Vehicle_ID), 
    CONSTRAINTS pk_HireCentreVehicles_id1 PRIMARY KEY (HireCentreVehicle_ID)
   );

   CREATE TABLE Customer_Insurance (
    Customer_Insurance_ID Number (8),
    Insurance_ID REFERENCES Insurance(Insurance_ID),
    Customer_ID REFERENCES Customer(Customer_ID),
    CONSTRAINTS pk_customerinsurance_id2 PRIMARY KEY (Customer_Insurance_ID)
    );



-- CREATING SEQUENCES FOR TABLES


    -- CUSTOMER
        DROP sequence customer_seq;
        create sequence customer_seq
        start with 1
        increment by 1
        maxvalue 10000
        minvalue 1;

    -- DRIVER
        DROP sequence driver_seq;
        create sequence driver_seq
        start with 1
        increment by 1
        maxvalue 10000
        minvalue 1;

    -- INSURANCETYPE
        DROP sequence insurancetype_seq;
        create sequence insurancetype_seq
        start with 1
        increment by 1
        maxvalue 10000
        minvalue 1;    

    -- HIRECENTRE
        DROP sequence hirecentre_seq;
        create sequence hirecentre_seq
        start with 1
        increment by 1
        maxvalue 10000
        minvalue 1;


    -- VEHICLECLASSIFICATION
        DROP sequence vehicleclass_seq;
        create sequence vehicleclass_seq
        start with 1
        increment by 1
        maxvalue 10000
        minvalue 1;

-- HIRECENTRE_VEHICLE
        DROP sequence hirecentrevehicle_seq;
        create sequence hirecentrevehicle_seq
        start with 1
        increment by 1
        maxvalue 10000
        minvalue 1;



    --Table to log the changes made to the  data 
    
    DROP table vehicle_log cascade constraints;

    CREATE TABLE vehicle_log
    (log_id NUMBER(5) NOT NULL, 
    vehicle_id VARCHAR2(20),
    action_type VARCHAR2(50),
    old_value VARCHAR2(50),
    new_value VARCHAR2(50), 
    status_update_date timestamp);

    drop sequence log_SEQ;
    create sequence log_SEQ
    start with 1
    increment by 1
    maxvalue 10000
    minvalue 1;


    -- trigger to track the changes to vehicle status in vehicle column

    -- DROP TRIGGER vehicle_log;

    CREATE OR REPLACE TRIGGER vehicle_log
    AFTER INSERT OR UPDATE OR DELETE ON Vehicle
    FOR EACH ROW
    BEGIN
    IF INSERTING THEN
        INSERT INTO vehicle_log (log_id, vehicle_id, action_type, old_value, new_value, status_update_date)
        VALUES (log_SEQ.NEXTVAL, :OLD.Vehicle_ID, 'INSERT', 'NA',:NEW.Status, SYSTIMESTAMP);
       ELSIF UPDATING THEN
          INSERT INTO vehicle_log (log_id, vehicle_id, action_type, old_value, new_value, status_update_date)
          VALUES (log_SEQ.NEXTVAL, :OLD.Vehicle_ID, 'UPDATE', :OLD.Status, :NEW.Status, SYSTIMESTAMP);
    ELSIF DELETING THEN
        INSERT INTO vehicle_log (log_id, vehicle_id, action_type, old_value, new_value, status_update_date)
        VALUES (log_SEQ.NEXTVAL, :OLD.Vehicle_ID, 'DELETE', :OLD.Status, 'DELETED', SYSTIMESTAMP);
    END IF;
    END;
    /





 -- To ensure all Vehicle.Vehicle_ID entered into HireCentre_Vehicle table have Vehicle.Status as HireCentre

    -- DROP TRIGGER trg_check_vehicle_status_hirecentre;

    CREATE OR REPLACE TRIGGER trg_check_vehicle_status_hirecentre
    BEFORE INSERT OR UPDATE ON HireCentre_Vehicle
    FOR EACH ROW
    DECLARE
        v_vehicle_status VARCHAR2(15);
    BEGIN
        IF (:NEW.Vehicle_ID IS NOT NULL) THEN
            -- Retrieve the status of the associated vehicle
            SELECT Status INTO v_vehicle_status
            FROM Vehicle
            WHERE Vehicle_ID = :NEW.Vehicle_ID;

            -- Check if the vehicle status is 'HireCentre'
            IF (v_vehicle_status <> 'HireCentre') THEN
                RAISE_APPLICATION_ERROR(-20001, 'Vehicle must have status "HireCentre"');
            END IF;
        END IF;
    END;
    /



-- To ensure all Vehicle.Vehicle_ID entered into FleetHire_Vehicle table have Vehicle.Status as FleetHire

    -- DROP TRIGGER trg_check_vehicle_status_fleethire;

    CREATE OR REPLACE TRIGGER trg_check_vehicle_status_fleethire
    BEFORE INSERT OR UPDATE ON FleetHire_Vehicle
    FOR EACH ROW
    DECLARE
        v_vehicle_status VARCHAR2(15);
    BEGIN
        IF (:NEW.Vehicle_ID IS NOT NULL) THEN
            SELECT Status INTO v_vehicle_status
            FROM Vehicle
            WHERE Vehicle_ID = :NEW.Vehicle_ID;

            IF (v_vehicle_status <> 'FleetHire') THEN
                RAISE_APPLICATION_ERROR(-20001, 'Vehicle must have status "FleetHire"');
            END IF;
        END IF;
    END;
    /



-- To ensure all Vehicle.Vehicle_ID entered into Hire table have Vehicle.Status as Hire

    -- DROP TRIGGER trg_check_vehicle_status_hire;

    CREATE OR REPLACE TRIGGER trg_check_vehicle_status_hire
    BEFORE INSERT OR UPDATE ON Hire
    FOR EACH ROW
    DECLARE
        v_vehicle_status VARCHAR2(15);
    BEGIN
        IF (:NEW.Vehicle_ID IS NOT NULL) THEN
            SELECT Status INTO v_vehicle_status
            FROM Vehicle
            WHERE Vehicle_ID = :NEW.Vehicle_ID;

            IF (v_vehicle_status <> 'Hire') THEN
                RAISE_APPLICATION_ERROR(-20001, 'Vehicle must have status "Hire"');
            END IF;
        END IF;
    END;
    /


-- To ensure all Customer.Customer_ID entered into Hire table have Customer.Customer_Category as Individual

    -- DROP TRIGGER trg_check_customer_category_individual;

    CREATE OR REPLACE TRIGGER trg_check_customer_category_individual
    BEFORE INSERT OR UPDATE ON Hire
    FOR EACH ROW
    DECLARE
        c_customer_category VARCHAR2(15);
    BEGIN
        IF (:NEW.Customer_ID IS NOT NULL) THEN
            SELECT Customer_Category INTO c_customer_category
            FROM Customer
            WHERE Customer_ID = :NEW.Customer_ID;

            IF (c_customer_category <> 'Individual') THEN
                RAISE_APPLICATION_ERROR(-20001, 'Customer must have category "Individual"');
            END IF;
        END IF;
    END;
    /


    -- To ensure all Customer.Customer_ID entered into FleetHire table have Customer.Customer_Category as Corporate

    -- DROP TRIGGER trg_check_customer_category_corporate;

    CREATE OR REPLACE TRIGGER trg_check_customer_category_corporate
    BEFORE INSERT OR UPDATE ON FleetHire
    FOR EACH ROW
    DECLARE
        c_customer_category VARCHAR2(15);
    BEGIN
        IF (:NEW.Customer_ID IS NOT NULL) THEN
            SELECT Customer_Category INTO c_customer_category
            FROM Customer
            WHERE Customer_ID = :NEW.Customer_ID;

            IF (c_customer_category <> 'Corporate') THEN
                RAISE_APPLICATION_ERROR(-20001, 'Customer must have category "Corporate"');
            END IF;
        END IF;
    END;
    /









-- INSERTING VALUES INTO TABLES


    INSERT INTO VehicleClassification VALUES (vehicleclass_seq.nextval,'Luxury Saloon','High-end, luxury sedans with premium features.');
    INSERT INTO VehicleClassification VALUES (vehicleclass_seq.nextval,'Basic Hatchback','Compact and economical hatchback models.');
    INSERT INTO VehicleClassification VALUES (vehicleclass_seq.nextval,'Sports Coupe','High-performance two-door coupes with sleek designs.');
    INSERT INTO VehicleClassification VALUES (vehicleclass_seq.nextval,'SUV (Sport Utility Vehicle)','Versatile and spacious vehicles suitable for various terrains.');
    INSERT INTO VehicleClassification VALUES (vehicleclass_seq.nextval,'Electric Compact','Compact cars with electric powertrains for eco-friendly driving.');
    INSERT INTO VehicleClassification VALUES (vehicleclass_seq.nextval,'Pickup Truck','Robust vehicles designed for cargo hauling and off-road capabilities.');
    INSERT INTO VehicleClassification VALUES (vehicleclass_seq.nextval,'Convertible','Two-door cars with retractable roofs for an open-air driving experience.');
    INSERT INTO VehicleClassification VALUES (vehicleclass_seq.nextval,'Luxury SUV','High-end sport utility vehicles with premium features and spacious interiors.');
    INSERT INTO VehicleClassification VALUES (vehicleclass_seq.nextval,'Hybrid Compact','Compact cars with a combination of gasoline and electric power for increased fuel efficiency.');
    INSERT INTO VehicleClassification VALUES (vehicleclass_seq.nextval,'Minivan','Family-oriented vehicles with spacious interiors, suitable for transporting multiple passengers.');

    -- SELECT * FROM VehicleClassification;


    INSERT INTO VehicleModel VALUES (1,'Ford Fiesta 1.1','Ford', 'Petrol', 2022, 2);
    INSERT INTO VehicleModel VALUES (2,'Fiat Panda','Ford', 'Diesel', 2022, 2);
    INSERT INTO VehicleModel VALUES (3,'BMW 3 Series','BMW', 'Hybrid', 2024, 1);
    INSERT INTO VehicleModel VALUES (4,'Jeep Wrangler','Jeep', 'Gasoline', 2023, 4);
    INSERT INTO VehicleModel VALUES (5,'Tesla Model 3','Tesla', 'Electric', 2023, 5);
    INSERT INTO VehicleModel VALUES (6,'Ford F-150','Ford', 'Diesel', 2023, 6);
    INSERT INTO VehicleModel VALUES (7,'Mercedes-Benz E-Class','Mercedes-Benz', 'Diesel', 2023, 1);
    INSERT INTO VehicleModel VALUES (8,'Toyota RAV4 Hybrid','Toyota', 'Hybrid', 2023, 8);
    INSERT INTO VehicleModel VALUES (9,'Nissan Leaf','Nissan', 'Electric', 2022, 9);    
    INSERT INTO VehicleModel VALUES (10,'Honda Odyssey','Honda', 'Gasoline', 2023, 10);    

    -- SELECT * FROM VehicleModel;


    INSERT INTO AdditionalRequirements VALUES (1,'Roof Rack','Attach a roof rack to the vehicle for additional luggage or equipment', 'Yes', 25, 'Compatible with vehicles with roof rails; weight limit applies.');    
    INSERT INTO AdditionalRequirements VALUES (2,'Child Safety Seat','Request a child car seat for the duration of the rental.', 'Yes', 10, 'Specify the childs age and weight for appropriate seat selection.');    
    INSERT INTO AdditionalRequirements VALUES (3,'Snow Chain/Winter Tyre','Equip the vehicle with snow chains or winter tires for driving in snowy conditions.', 'Yes', 15, 'Recommended for winter driving; availability may vary by location.');    
    INSERT INTO AdditionalRequirements VALUES (4,'GPS Navigation System','Provide a GPS navigation system for the rented vehicle.', 'Yes', 30, 'Subject to availability; additional charges apply.');    
    INSERT INTO AdditionalRequirements VALUES (5,'Satellite Radio','Access satellite radio channels during the rental period.', 'Yes', 12, 'Satellite radio availability may vary by vehicle model.');    
    INSERT INTO AdditionalRequirements VALUES (6,'Portable Wi-Fi Hotspot','Request a portable Wi-Fi hotspot for internet connectivity.', 'Yes', 10, 'Limited data usage; subject to availability');    
    INSERT INTO AdditionalRequirements VALUES (7,'Ski Rack','Attach a ski rack to the vehicle for transporting ski equipment.', 'Yes', 20, 'Suitable for vehicles with roof rails; additional charges apply.');    
    INSERT INTO AdditionalRequirements VALUES (8,'Bike Rack','Attach a bike rack to the vehicle for transporting bicycles.', 'Yes', 20, 'Suitable for vehicles with a hitch; weight and size restrictions apply.');    
    INSERT INTO AdditionalRequirements VALUES (9,'Pet-Friendly Interior','Ensure the vehicle interior is pet-friendly for traveling with pets.', 'Yes', 15, 'Additional cleaning fee may apply; restrictions on pet size and type.');    
    INSERT INTO AdditionalRequirements VALUES (10,'Car Charger/USB Adapter','Provide a car charger or USB adapter for charging electronic devices', 'Yes', 15, 'Compatible with most devices; multiple ports available.');    
    INSERT INTO AdditionalRequirements VALUES (11,'Toll Pass/Electronic Toll Collection',' Include a toll pass or electronic toll collection device for seamless toll payments.', 'Yes', NULL , 'Usage monitored; customer responsible for toll charges.');    

    -- SELECT * FROM AdditionalRequirements;


    INSERT INTO HireCentre VALUES (hirecentre_seq.nextval,'CARS4U CityCar Rentals','456 High Street, CIty Centre', 'Birmingham', 'United Kingdom','BR2 6AS',7125896438, 'info@citycarrentals.co.uk');    
    INSERT INTO HireCentre VALUES (hirecentre_seq.nextval,'CARS4U London Wheels Car Hire','789 Oxford St,Mayfair', 'London', 'United Kingdom','L34 2ONS',7205698743, 'info@londonwheels.com');  
    INSERT INTO HireCentre VALUES (hirecentre_seq.nextval,'CARS4U Highland Hire','25 Royal Mile, Edinburgh', 'Edinburgh', 'Scotland','ED5 6DA',1311234569, 'info@highlandhire.com');  
    INSERT INTO HireCentre VALUES (hirecentre_seq.nextval,'CARS4U Yorkshire Drive Car Rentals','56 Leeds Road', 'Leeds', 'United Kingdom','LS5 3JG',1139876543, 'info@yorkshiredrive.com');  
    INSERT INTO HireCentre VALUES (hirecentre_seq.nextval,'CARS4U WelshWheels Hire','78 Cardiff Road', 'Wales', 'Wales','WL8 6AA',2912345678, 'info@welshwheels.com');  

    -- SELECT * FROM HireCentre;

    INSERT INTO Customer VALUES (customer_seq.nextval, 'Individual', 7741589623, '213 High Street', 'London', 'United Kingdom', 'SW1 2PB', 'H.smith@gmail.com', 2036987541,'3456 7890 1234 5698','xxxx-xxxx-xxxx-2584', '25/12');
    INSERT INTO Customer VALUES (customer_seq.nextval, 'Individual', 7589632145, '62 Park Avenue', 'Manchester', 'United Kingdom', 'M14 5 PU', 'EmilyJohnson98@gmail.com', 4025631878,'3654 2587 1458 2589','xxxx-xxxx-xxxx-5678', '26/11');
    INSERT INTO Customer VALUES (customer_seq.nextval, 'Individual', 1313456789, '18 Queens', 'Edinburgh', 'Scotland', 'EH6 7BT', 'david.wilson@gmail.com',3652148569,'5623 8569 7458 1258 ', 'xxxx-xxxx-xxxx-7789', '28/05');
    INSERT INTO Customer VALUES (customer_seq.nextval, 'Individual', 1412345678, '27 Castle Street', 'Scotland', 'Scotland', 'G4 0RH', 'fiona56macleod@gmail.com',8974523625,'7854 2547 8965 2258','xxxx-xxxx-xxxx-4582', '16/02');
    INSERT INTO Customer VALUES (customer_seq.nextval, 'Individual', 7458963211, '74 Feather Stone St', 'London', 'United Kingdom', 'EC1Y 8SY', 'St.Walk78@yahoo.com', 5896524785,'2541 2585 1456 2588','xxxx-xxxx-xxxx-8574', '18/12');
    INSERT INTO Customer VALUES (customer_seq.nextval, 'Individual', 8754932162, '1 Chapel Hill', 'Bournemouth', 'United Kingdom', 'BH1 1AA', 'Baker.078@gmail.com', 3025698741,'8885 4785 9996 2547','xxxx-xxxx-xxxx-4859', '9/11');
    INSERT INTO Customer VALUES (customer_seq.nextval, 'Individual', 7854932156, '71 Cheery Court', 'South Hampton', 'United Kingdom', 'SO53 5PD', 'Holmesalen56@gmail.com',3025410026,'8569 2365 4125 5874', 'xxxx-xxxx-xxxx-3598', '12/12');
    INSERT INTO Customer VALUES (customer_seq.nextval, 'Individual', 7854968412, '1 My St', 'Bournemouth', 'United Kingdom', 'BH1 1AA', 'J.David6@gmail.com', 2365214782,'9985 2563 5558 4785','xxxx-xxxx-xxxx-7854', '9/09');
    INSERT INTO Customer VALUES (customer_seq.nextval, 'Individual', 7745889655, 'J49 Otterly St', 'Oxford', 'United Kingdom', 'OX2 L34', 'Foster45@gmail.com', 2025236511,'2021 5214 3698 2541','xxxx-xxxx-xxxx-8899', '16/07');
    INSERT INTO Customer VALUES (customer_seq.nextval, 'Individual', 1239885469, '432 Indsutrial St', 'Manchester', 'United Kingdom', 'MH2 6FD', 'Taylorecollins@gmail.com',8896523654, '3301 2584 2145 3698','xxxx-xxxx-xxxx-5522', '26/08');
    INSERT INTO Customer VALUES (customer_seq.nextval, 'Individual', 7755849685, '3 Marry St', 'Oxford', 'United Kingdom', 'OX9 2QW', 'Laith.An09@gmail.com', 2036589254,'2210 2365 8859 2654','xxxx-xxxx-xxxx-4456', '16/09');
    INSERT INTO Customer VALUES (customer_seq.nextval, 'Individual', 2255889648, '10 Down St', 'London', 'United Kingdom', 'SW1 2AA', 'Emmagrace34@gmail.com',5896523665,'1452 2563 8596 2236', 'xxxx-xxxx-xxxx-2255', '27/10');
    INSERT INTO Customer VALUES (customer_seq.nextval, 'Individual', 7788445965, '56 Repon House', 'Wales', 'Wales', 'WL23 5FD', 'A.Esballeh@yahoo.com',2036589214,'3562 5489 5632 1254', 'xxxx-xxxx-xxxx-3698', '16/11');
    INSERT INTO Customer VALUES (customer_seq.nextval, 'Individual', 7744851235, '221 Bakers St', 'London', 'United Kingdom', 'LD1 6XE', 'Alis8965@yahoo.com',3025893254,'5894 5711 2581 8451', 'xxxx-xxxx-xxxx-8577', '28/08');
    INSERT INTO Customer VALUES (customer_seq.nextval, 'Individual', 7312456895, '10 Valley Park', 'Wales', 'Wales', 'CF10 1AA', 'Ray.thomas@gmail.com',3698541258,'5874 3954 1452 1115' ,'xxxx-xxxx-xxxx-7415', '16/11');
    INSERT INTO Customer VALUES (customer_seq.nextval, 'Corporate', 7812456890, '221 Bakers St', 'London', 'United Kingdom', 'LD1 6XE', 'smith.co@yahoo.com', 2236569852,'3363 2252 4458 9965','xxxx-xxxx-xxxx-8576', '28/09');
    INSERT INTO Customer VALUES (customer_seq.nextval, 'Individual', 7313456679, '12 Wayvor Hill', 'Bournemouth', 'United Kingdom', 'BH1 1AA', 'm2.1996@gmail.com',3256845666,'8885 7777 9856 1125', 'xxxx-xxxx-xxxx-4577', '21/01');
    INSERT INTO Customer VALUES (customer_seq.nextval, 'Individual', 7814458890, '23 Park Avenue', 'South Hampton', 'United Kingdom', 'SO53 5PD', 'roman.1999@yahoo.com',8984582665,'7771 1002 3225 7851', 'xxxx-xxxx-xxxx-4123', '21/06');
    INSERT INTO Customer VALUES (customer_seq.nextval, 'Corporate', 5551234567, '123 Main St', 'Anytown', 'United States of America', 'AN1 6TE', 'info@acmecorp.com',2036658965,'7855 2563 1254 7859','xxxx-xxxx-xxxx-1376', '18/07');
    INSERT INTO Customer VALUES (customer_seq.nextval, 'Corporate', 5559876543, '456 Elm St', 'Springfield', 'United States of America', 'SF1 4TG', 'contact@techsolutions.com',5046987524,'8541 25631 7965 2201', 'xxxx-xxxx-xxxx-9301', '18/06');
    INSERT INTO Customer VALUES (customer_seq.nextval, 'Corporate', 5554567890, '789 Maple Ave', 'Metropolis', 'United States of America', 'MP1 4TO', 'support@globex.com',2014587455,'5001 2561 3336 2251','xxxx-xxxx-xxxx-1345', '28/03');
    INSERT INTO Customer VALUES (customer_seq.nextval, 'Corporate', 5554567789, '456 Elm St', 'Springfield', 'United States of America', 'SF1 4TG', 'support@globex.com',1258742364,'5874 6985 2145 3654','xxxx-xxxx-xxxx-1340', '28/9');


    SELECT * FROM Customer;

    INSERT INTO Individual VALUES (1, 'Harry', 'Smith', '10/11/1988', 'Male');
    INSERT INTO Individual VALUES (2, 'Emily', 'Johnson','12/25/1998', 'Female');
    INSERT INTO Individual VALUES (3, 'David', 'Wilson', '7/5/1987', 'Male');
    INSERT INTO Individual VALUES (4, 'Fiona', 'Macleod', '5/21/1990', 'Female');
    INSERT INTO Individual VALUES (5, 'Stevan', 'Walker', '3/15/1987', 'Male');
    INSERT INTO Individual VALUES (6, 'Baker', 'Owaan', '6/24/1992', 'Male');
    INSERT INTO Individual VALUES (7, 'Holmes', 'Alen', '9/10/1993', 'Male');
    INSERT INTO Individual VALUES (8, 'John', 'Davidson', '8/21/2000', 'Male');
    INSERT INTO Individual VALUES (9, 'Matthews', 'Foster', '1/30/2001', 'Male');
    INSERT INTO Individual VALUES (10, 'Taylor', 'Collins', '8/10/2004', 'Female');
    INSERT INTO Individual VALUES (11, 'Laith', 'Antony', '4/3/2004', 'Female');
    INSERT INTO Individual VALUES (12, 'Sofia', 'Mathan', '11/18/1999', 'Female');
    INSERT INTO Individual VALUES (13,'Emma', 'Grace', '12/27/1998', 'Female');
    INSERT INTO Individual VALUES (14, 'Alis', 'Esabellah', '2/4/1997', 'Female');
    INSERT INTO Individual VALUES (15, 'Ray', 'Thomas', '8/24/1996', 'Male');
    INSERT INTO Individual VALUES (17, 'Mishelle', 'Janson', '2/3/1996', 'Female');
    INSERT INTO Individual VALUES (18, 'Roman', 'Mayor', '6/20/1999', 'Male');

    -- SELECT * FROM Individual;


    INSERT INTO Corporate VALUES (16, 'Smith & Co.', '456-78-9012', 'SC345678');
    INSERT INTO Corporate VALUES (19, 'Acme Corporation', '555-55-5555', 'ACM555555');
    INSERT INTO Corporate VALUES (20, 'Tech Solutions Inc.', '111-11-1111', 'TSI111111');
    INSERT INTO Corporate VALUES (21, 'Globex Enterprises', '999-99-9999', 'GEX999999');
    INSERT INTO Corporate VALUES (22, 'Globex Enterprises Springfield', '999-99-9999', 'GEX999999');


    -- SELECT * FROM Corporate;


    INSERT INTO Driver VALUES (driver_seq.nextval,'John','Buyer','UK158745963214', '8/10/1985', 'Male');
    INSERT INTO Driver VALUES (driver_seq.nextval,'Arham','Patel' ,'UK654921098765','8/10/1985', 'Male');
    INSERT INTO Driver VALUES (driver_seq.nextval,'Ewan','Magroger','SC125698743256', '4/3/1987', 'Male');
    INSERT INTO Driver VALUES (driver_seq.nextval,'Emily','Johnson' ,'UK854987452665','12/25/1998', 'Female');
    INSERT INTO Driver VALUES (driver_seq.nextval,'Rebecca','Johnson','LD987654321098', '9/10/1993', 'Female');
    INSERT INTO Driver VALUES (driver_seq.nextval,'Andrew','John' ,'SC876549810987','3/15/1985', 'Male');
    INSERT INTO Driver VALUES (driver_seq.nextval,'Charlie','Scott' ,'UK859623548742','7/22/1986', 'Male');
    INSERT INTO Driver VALUES (driver_seq.nextval,'Chorlatte','Monson' ,'LD589632144568','2/27/1989', 'Male');
    INSERT INTO Driver VALUES (driver_seq.nextval,'Belton','Wilson','UK854932566441', '12/1/1994', 'Male');    
    INSERT INTO Driver VALUES (driver_seq.nextval,'Taylor','Collins', 'LD471239885469','8/10/2004', 'Female');  
    INSERT INTO Driver VALUES (driver_seq.nextval,'Cooper','Terner','LD895463214575', '1/1/1991', 'Female');
    INSERT INTO Driver VALUES (driver_seq.nextval,'Martin','Harrys', 'SC789541256321','5/2/1982', 'Male');
    INSERT INTO Driver VALUES (driver_seq.nextval,'Robinson','Lewis', 'SC854415889654','10/22/1990', 'Male');    
    INSERT INTO Driver VALUES (driver_seq.nextval,'Thomas','Mathew','WL854963258487','3/5/1992', 'Male');  

    -- SELECT * FROM Driver;


    INSERT INTO Vehicle VALUES (1,'UK24 BMW',2024,'Black', 10000, 'Hire', '01/01/2024', 3);
    INSERT INTO Vehicle VALUES (2,'SC22 TSL',2023,'Blue',15000, 'Hire', '01/01/2023', 5);
    INSERT INTO Vehicle VALUES (3,'UK24 BMW',2023,'Grey', 15000, 'Hire','01/01/2023', 6);
    INSERT INTO Vehicle VALUES (4,'LD23 JEP',2023,'Red', 10000, 'Hire','01/01/2023', 4);
    INSERT INTO Vehicle VALUES (5,'ED20 FI2',2022,'White', 7000, 'Hire','01/01/2022', 2);
    INSERT INTO Vehicle VALUES (6,'SC58 K65',2023,'Grey', 12000, 'FleetHire','01/01/2023', 8);
    INSERT INTO Vehicle VALUES (7,'WL88 L65',2023,'Blue', 15000, 'FleetHire','01/01/2023', 5);
    INSERT INTO Vehicle VALUES (8,'UK80 XE',2023,'Red', 10000 , 'FleetHire','01/01/2023', 4);
    INSERT INTO Vehicle VALUES (9,'SC85 558',2022,'Olive', 7000, 'FleetHire','01/01/2022', 1);
    INSERT INTO Vehicle VALUES (10,'ED58 KL6',2022,'Black',7000, 'FleetHire','01/01/2022', 2);
    INSERT INTO Vehicle VALUES (11,'ABC 123',2022,'Red', 10000, 'HireCentre','01/01/2022',  2);
    INSERT INTO Vehicle VALUES (12,'XYZ 456',2022,'Blue', 10000 , 'HireCentre','01/01/2022',  1);
    INSERT INTO Vehicle VALUES (13,'DEF 289',2024,'Green', 20000 , 'HireCentre','01/01/2024',  5);
    INSERT INTO Vehicle VALUES (14,'GHI 123',2022,'Yellow',7000 , 'HireCentre','01/01/2022',  1);
    INSERT INTO Vehicle VALUES (15,'JKL 456',2022,'Black',10000, 'HireCentre','01/01/2022',  1);
    INSERT INTO Vehicle VALUES (16,'MNK 989',2023,'White',10000 , 'HireCentre','01/01/2023',  4);
    INSERT INTO Vehicle VALUES (17,'PJK5 LO3',2022,'Silver', 10000 , 'FleetHire','01/01/2022',  2);
    INSERT INTO Vehicle VALUES (18,'STK 486',2023,'Grey',20000 , 'Hire','01/01/2023',  6);
    INSERT INTO Vehicle VALUES (19,'VJ9 889',2024,'Brown', 15000 , 'HireCentre', '01/01/2024', 3);

    -- SELECT * FROM Vehicle;


   INSERT INTO Inspector VALUES ('INS123','Jordan', 'Wilson', 7896521489, 1);    
   INSERT INTO Inspector VALUES ('LON124','Samuel', 'Sair',1236589478, 2);  
   INSERT INTO Inspector VALUES ('LDS125','Paul', 'Smith', 8549723651,3);  
   INSERT INTO Inspector VALUES ('SCT126','Stephy', 'Woulser',8452198763,4);  
   INSERT INTO Inspector VALUES ('WAL127','Freddy', 'Rays',8954123678, 5);  

--    SELECT * FROM Inspector;


   INSERT INTO InsuranceType VALUES (insurancetype_seq.nextval,'Collision Damage Waiver (CDW)', 25000, 500, 15, 'This cover provides protection against losses incurred as a result from damage to the rental vehicle caused by fire, vandalism, accident or volcanic ash cloud.');  
   INSERT INTO InsuranceType VALUES (insurancetype_seq.nextval,'Loss Damage Waiver(LDW)', 30000, 600, 20, 'Loss damage waiver is an agreement with an auto rental company in which the renter is released from liability for physical damage to the vehicle in exchange for a fee, subject to the terms of the rental agreement or a state statute if one exists.');  
   INSERT INTO InsuranceType VALUES (insurancetype_seq.nextval,'Supplemental Liability Insurance(SLI)', 100000, 1000, 25, 'This additional liability cover means that if you are involved in an accident in your hire car, you are insured against property damage and personal injury. SLI will cover you in the event of a higher claim by increasing third party cover to more comfortable limits.');  
   INSERT INTO InsuranceType VALUES (insurancetype_seq.nextval,'Personal Accident Insurance (PAI)', 50000, 750, 10, 'These insurance policies pay out compensation to people who suffer serious injury or death as the result of an accident. They differ from ordinary life insurance in that the incapacity (or death) must be the result of an accident, not illness or old age');  
   INSERT INTO InsuranceType VALUES (insurancetype_seq.nextval,'Personal Effects Coverage', 5000, 100, 5, 'Personal Effects and Clothing cover is there to protect you against loss of or damage to your possessions while in or on your private car (used for social, domestic and pleasure purposes) by Fire; Theft; or by accidental means.');  
   INSERT INTO InsuranceType VALUES (insurancetype_seq.nextval,'Third-Party Liability Insurance (TPL)', 100000, 1000, 30, 'Third-Party Liability protects the insured against damages caused to a third party, that is, a person or property. Third-Party Liability can cover expenses such as hospital care, lost wages, or repairs to the cars bodywork.');  
   INSERT INTO InsuranceType VALUES (insurancetype_seq.nextval,'Comprehensive Coverage', 75000, 2500, 30, 'Comprehensive car insurance covers everything that a third party, fire and theft policy does, as well as a range of extras. Fire damage, theft and vandalism are therefore included, as well as damage to the other persons (the third partys) car.');  

--    SELECT * FROM InsuranceType;


   INSERT INTO Insurance VALUES (1,'P0012', '01/02/2019', '01/01/2025', 3);  
   INSERT INTO Insurance VALUES (2,'P0013', '11/11/2020', '09/01/2024', 1);  
   INSERT INTO Insurance VALUES (3,'P0023', '12/07/2021', '01/01/2025', 1);  
   INSERT INTO Insurance VALUES (4,'P0056', '01/12/2023', '01/03/2025', 7);  
   INSERT INTO Insurance VALUES (5,'P0082', '09/01/2023', '06/01/2024', 2);  

    -- SELECT * FROM Insurance;


   INSERT INTO Customer_Insurance VALUES (1, 1, 2);  
   INSERT INTO Customer_Insurance VALUES (2, 2, 1);  
   INSERT INTO Customer_Insurance VALUES (3, 3, 5);  
   INSERT INTO Customer_Insurance VALUES (4, 4, 4);  
   INSERT INTO Customer_Insurance VALUES (5, 5, 3);  

    -- SELECT * FROM Customer_Insurance;
    

    INSERT INTO RivalHireCompany VALUES (1,'Enterprise Rent-A-Car','910 Vauxhall Road,Vauxhall', 'London', 'United Kingdom','SE11 5LG',2075200000, 'enquiries@enterprise.co.uk');  
    INSERT INTO RivalHireCompany VALUES (2,'Europcar','13 Sussex Road,Hounslow', 'London', 'United Kingdom','TW3 1UP',3713843403, 'info@londonwheels.com');  
    INSERT INTO RivalHireCompany VALUES (3,'National Car Rental','Cerdiff Airport,Vale of Glamorgan', 'Wales', 'Eales','CF62 3BD',3443893012, 'reservations@europcar.com');  
    INSERT INTO RivalHireCompany VALUES (4,'Arnold Clark Car & Van Rentals','454 Hillingthon Road,Glasglow', 'Glasglow', 'Scotland','G52 4HG',1412855500, 'resevations@nationalcar.co.uk');  
    INSERT INTO RivalHireCompany VALUES (5,'Avis Car Rental','1 Neville St,Leeds', 'Leeds','United Kingdom', 'LS1 4AZ',3445446016, 'customer.service@avis.co.uk');  
    INSERT INTO RivalHireCompany VALUES (6,'Sixt Rent a Car','43 Great Eastern St,London','London','United Kingdom', 'EC2A 3HU', 2077704367, 'reservations@sixt.co.uk');  

    -- SELECT * FROM RivalHireCompany;

    INSERT INTO CheckInCentre VALUES (1,'Elite Drive','547 Riverfront Avenue', 'Newcastle', 'United Kingdom','NE3 6SW',1579654402, 'info@elitedrive.co.uk');    
    INSERT INTO CheckInCentre VALUES (2,'Premier Auto Care','86 Westminster', 'Leeds', 'United Kingdom','LS4 5TT',7236552469, 'info@premierautocare.com');  
    INSERT INTO CheckInCentre VALUES (3,'Aaa Auto','16 City Centre', 'Edinburgh', 'Scotland','ED4 6SD',7747552332, 'info@aaaauto.com');  
    INSERT INTO CheckInCentre VALUES (4,'Discount Automotive','59 Royal Mile', 'Scotland', 'Scotland','SC7 6ZA',7878747402, 'info@discountautomotive.com');  
    INSERT INTO CheckInCentre VALUES (5,'Crossroad Garage','750 Bayview Terrace', 'London', 'United Kindgom','LA1 2AQ',7002245450, 'info@crossroadgarage.com');  

    -- SELECT * FROM CheckInCentre;

    INSERT INTO Hire VALUES (1,'3/20/2022','10:00:00 AM', 1, 1, 'London', 'Scotland', 0, '3/20/2022', '12:20:00 PM', 'Yes', '3/20/2022');    
    INSERT INTO Hire VALUES (2,'2/2/2023','1:30:00 PM', 3, 2, 'Edinburg', 'London', 250, '2/2/2023', '5:30:00 PM', 'No', '');  
    INSERT INTO Hire VALUES (3,'7/24/2023','9:00:00 AM', 5, 3, 'Scotland', 'Wales', 0, '7/24/2023', '11:40:00 AM', 'No', '');  
    INSERT INTO Hire VALUES (4,'11/28/2023','11:50:00 AM', 6, 4, 'Leeds', 'France', 300, '11/28/2023', '3:40:00 PM', 'No', '');  
    INSERT INTO Hire VALUES (5,'1/27/2024','4:15:00 PM', 4, 5, 'Wales', 'Edinburg', 0, '1/27/2024', '8:25:00 PM', 'No', '');  
    INSERT INTO Hire VALUES (6,'1/28/2024','4:15:00 PM', 5, 5, 'Wales', 'Edinburg', 0, '1/28/2024', '8:25:00 PM', 'No', '');  
    INSERT INTO Hire VALUES (7,'1/29/2024','4:15:00 PM', 3, 5, 'Wales', 'Edinburg', 0, '1/29/2024', '8:25:00 PM', 'Yes', '1/29/2024');  

    -- To demonstrate exclusive arc relationship - entering a vehicle id with status not equal to Hire    
    -- INSERT INTO Hire VALUES (8,'1/27/2024','4:15:00 PM', 4, 11, 'Wales', 'Edinburg', 0, '1/27/2024', '8:25:00 PM', 'No', '');  
    -- To demonstrate trigger that checks if customer entered is Individual customer - entering corporate customer
    -- INSERT INTO Hire VALUES (9,'1/27/2024','4:15:00 PM', 16, 11, 'Wales', 'Edinburg', 0, '1/27/2024', '8:25:00 PM','No', '');  

    -- SELECT * FROM Hire;

 
    INSERT INTO Hire_AddReq VALUES (1, 5, 1);    
    INSERT INTO Hire_AddReq VALUES (2, 1, 5);  
    INSERT INTO Hire_AddReq VALUES (3, 3, 2);  

    -- SELECT * FROM Hire_AddReq;


    INSERT INTO Hire_Driver VALUES (1, 2, 1);    
    INSERT INTO Hire_Driver VALUES (2, 5, 4);  
    INSERT INTO Hire_Driver VALUES (3, 3, 2);  
    INSERT INTO Hire_Driver VALUES (4, 4, 5);  
    INSERT INTO Hire_Driver VALUES (5, 1, 3);  

    -- SELECT * FROM Hire_Driver;

    INSERT INTO FleetHire VALUES (1, 16, 1, NULL);    
    INSERT INTO FleetHire VALUES (2, 19, 1, NULL);  
    INSERT INTO FleetHire VALUES (3, 20, 1, NULL);  
    INSERT INTO FleetHire VALUES (4, 21, 1, NULL);  
    INSERT INTO FleetHire VALUES (5, 20, 2, NULL);  
    INSERT INTO FleetHire VALUES (6, 16, 2, NULL);  
    INSERT INTO FleetHire VALUES (7, 20, 2, NULL);  

    -- To demonstrate trigger that checks if customer entered is Individual customer - entering corporate customer
    -- INSERT INTO FleetHire VALUES (8, 1, 1, NULL);  


    -- SELECT * FROM FleetHire;

    INSERT INTO FleetHire_AddReq VALUES (1, 1, 3);    
    INSERT INTO FleetHire_AddReq VALUES (2, 5, 5);  
    INSERT INTO FleetHire_AddReq VALUES (3, 4, 10);  

    -- SELECT * FROM FleetHire_AddReq;

    INSERT INTO FleetHire_Driver VALUES (1, 4, 2);    
    INSERT INTO FleetHire_Driver VALUES (2, 2, 1);  
    INSERT INTO FleetHire_Driver VALUES (3, 5, 3);
    INSERT INTO FleetHire_Driver VALUES (4, 1, 5);  
    INSERT INTO FleetHire_Driver VALUES (5, 3, 4);

    -- SELECT * FROM FleetHire_Driver;

    INSERT INTO FleetHire_Vehicle VALUES (1, 1, 7,'11/23/2022','10:15:00 AM', 'London', 'Scotland', '11/23/2022', '9:20:00 PM', 'Yes', '11/23/2022');    
    INSERT INTO FleetHire_Vehicle VALUES (2, 5, 6,'2/19/2023','1:55:00 PM','Edinburg', 'London', '2/20/2023', '12:25:00 AM', 'No', '');  
    INSERT INTO FleetHire_Vehicle VALUES (3, 3, 8,'5/27/2023','9:30:00 AM','Scotland', 'Wales', '5/27/2023', '4:30:00 PM', 'No', '');
    INSERT INTO FleetHire_Vehicle VALUES (4, 2, 10,'10/15/2023','6:45:00 PM','Leeds', 'France', '10/16/2023', '7:45:00 PM', 'No', '');  
    INSERT INTO FleetHire_Vehicle VALUES (5, 4, 9,'1/1/2024','10:30:00 AM','Wales', 'Edinburg', '1/1/2024', '2:30:00 PM', 'No', '');
    INSERT INTO FleetHire_Vehicle VALUES (6, 5, 17,'1/1/2024','10:30:00 AM','Leeds', 'London', '1/1/2024', '2:30:00 PM', 'Yes', '1/1/2024');
    INSERT INTO FleetHire_Vehicle VALUES (7, 6, 17,'1/21/2024','11:30:00 AM','Leeds', 'London', '1/21/2024', '3:30:00 PM', 'No', '');
    INSERT INTO FleetHire_Vehicle VALUES (8, 7, 17,'1/30/2024','10:30:00 AM','Leeds', 'London', '1/30/2024', '2:30:00 PM', 'Yes', '1/30/2024');

    -- To demonstrate exclusive arc relationship - entering a vehicle id with status not equal to FleetHire    
    -- INSERT INTO FleetHire_Vehicle VALUES (9, 4, 11,'1/1/2024','10:30:00 AM','Leeds', 'London', '1/1/2024', '2:30:00 PM','No', '');


--    SELECT * FROM FleetHire_Vehicle;

    INSERT INTO RivalHireCompany_Vehicle  VALUES (1, 3, 18);    
    INSERT INTO RivalHireCompany_Vehicle  VALUES (2, 4, 1);  
    INSERT INTO RivalHireCompany_Vehicle  VALUES (3, 6, 5);
    INSERT INTO RivalHireCompany_Vehicle  VALUES (4, 2, 3);  
    INSERT INTO RivalHireCompany_Vehicle  VALUES (5, 1, 2);  

    -- SELECT * FROM RivalHireCompany_Vehicle ;

    INSERT INTO CheckInCentre_Vehicle VALUES (1, 2, 2);    
    INSERT INTO CheckInCentre_Vehicle VALUES (2, 5, 4);  
    INSERT INTO CheckInCentre_Vehicle VALUES (3, 4, 6);
    INSERT INTO CheckInCentre_Vehicle VALUES (4, 1, 1);  
    INSERT INTO CheckInCentre_Vehicle VALUES (5, 3, 8);

    -- SELECT * FROM CheckInCentre_Vehicle;

    INSERT INTO Inspector_Vehicle VALUES (1, 'LON124', 10 , '10/17/2023','Full','Minor scratches on driver side door','Working properly','No damage observed','No visible leaks','No Additional Req');
    INSERT INTO Inspector_Vehicle VALUES (2, 'LDS125', 4,'11/29/2023','Not Full','Small dent on the passenger side door','Working properly','Customer complains of a slow puncture in the rear passenger side tire','No visible leaks','No Additional Req');  
    INSERT INTO Inspector_Vehicle VALUES (3, 'WAL127', 7,'11/23/2022','Full','No Damage observed','Brake light no working','No damage observed','Minor oil seepage observed near oil pan gasket','Returned in proper condition');
    INSERT INTO Inspector_Vehicle VALUES (5, 'SCT126', 8,'5/29/2023','Full','No Damage observed','Working properly','No damage observed','No visible leaks','No Additional Req');
    INSERT INTO Inspector_Vehicle VALUES (6, 'LDS125', 2,'2/3/2023','Not Full','Small dent on rear bumper','Working properly','Customer complaints of a vibration at high speeds','No visible leaks','No Additional Req');

    -- SELECT * FROM Inspector_Vehicle;


    INSERT INTO HireCentre_Vehicle VALUES (hirecentrevehicle_seq.nextval, 3, 13);    
    INSERT INTO HireCentre_Vehicle VALUES (hirecentrevehicle_seq.nextval, 2, 12);  
    INSERT INTO HireCentre_Vehicle VALUES (hirecentrevehicle_seq.nextval, 5, 15);
    INSERT INTO HireCentre_Vehicle VALUES (hirecentrevehicle_seq.nextval, 4, 14);  
    INSERT INTO HireCentre_Vehicle VALUES (hirecentrevehicle_seq.nextval, 1, 16);
-- To demonstrate exclusive arc relationship - entering a vehicle id with status not equal to hire centre    
--     INSERT INTO HireCentre_Vehicle VALUES (hirecentrevehicle_seq.nextval, 1, 6);
--    SELECT * FROM HireCentre_Vehicle;


    INSERT INTO Invoice  VALUES (1, 'FleetHire', 19, '10/16/2023', 2, 'RC2024005',60,250,20,0,30,20,0,600.50);    
    INSERT INTO Invoice  VALUES (2, 'Hire', NULL, '11/28/2023', 4,'RC2589641',80,0,30,25,30,60,15,820);  
    INSERT INTO Invoice  VALUES (3, 'Hire', NULL, '7/24/2023',  3,'RC8974521',82,0,25,15,30,20,0,720);
    INSERT INTO Invoice  VALUES (4, 'FleetHire', 22, '1/1/2024', 4, 'RC9845762',92,300,30,30,30,50,0,1050);  
    INSERT INTO Invoice  VALUES (5, 'Hire', NULL, '3/20/2022', 1,'RC5861240',100,0,25,20,30,30,15,1455.50);
    -- SELECT * FROM Invoice ;



-- --QUERIES

-- -- Query 1    
-- -- To display all vehicle models along with their classification type
--         SELECT Model_Name,Class_Name FROM VehicleModel,VehicleClassification WHERE VehicleModel.Class_ID = VehicleClassification.Class_ID;

-- -- Query 2   
-- -- To Display all vehicles with their model type and classification type    
--         SELECT Vehicle_ID, Model_Name, Class_Name FROM VehicleModel, VehicleClassification, Vehicle 
--         WHERE VehicleModel.Class_ID = VehicleClassification.Class_ID AND Vehicle.Model_ID = VehicleModel.Model_ID;

-- -- Query 3   
-- -- To display customers with their insurance type    
--         SELECT Individual.Customer_ID, Individual.Customer_Fname, InsuranceType.InsuranceType_Name FROM Customer_Insurance, Insurance, InsuranceType, Individual 
--         WHERE InsuranceType.InsuranceType_ID = Insurance.InsuranceType_ID  AND Customer_Insurance.Customer_ID = Individual.Customer_ID 
--         AND Customer_Insurance.Insurance_ID = Insurance.Insurance_ID;

-- -- Query 4   
-- -- To display all vehicles with a certain mileage
--         SELECT Vehicle_ID, Mileage_Per_Year, Model_Name, Class_Name FROM VehicleModel, VehicleClassification, Vehicle 
--         WHERE VehicleModel.Class_ID = VehicleClassification.Class_ID AND Vehicle.Model_ID = VehicleModel.Model_ID AND Vehicle.Mileage_Per_Year >= 10000;

-- -- Query 5   
-- -- To check which vehicles with a certain mileage are available at Hire Centre
--         SELECT Vehicle_ID, Mileage_Per_Year, Status, Model_Name, Class_Name FROM VehicleModel, VehicleClassification, Vehicle
--         WHERE VehicleModel.Class_ID = VehicleClassification.Class_ID AND Vehicle.Model_ID = VehicleModel.Model_ID AND Vehicle.Mileage_Per_Year >= 10000
--         AND Vehicle.Status = 'HireCentre';


-- -- Query 6   
-- -- To check if vehicles with a certain classification type are available at Hire Centre
--         SELECT Vehicle_ID,Status, Model_Name, Class_Name FROM VehicleModel, VehicleClassification, Vehicle
--         WHERE VehicleModel.Class_ID = VehicleClassification.Class_ID AND Vehicle.Model_ID = VehicleModel.Model_ID AND 
--         VehicleClassification.Class_Name = 'Basic Hatchback' AND Vehicle.Status = 'HireCentre';

-- -- Query 7   
-- -- To list all the vehicles inspected by a given check in inspector 
--         SELECT Vehicle.Vehicle_ID, Inspector_Fname, Inspector_Lname, Model_Name, Class_Name 
--         FROM VehicleModel, VehicleClassification, Vehicle, CheckInInspector_Vehicle, Inspector
--         WHERE VehicleModel.Class_ID = VehicleClassification.Class_ID AND Vehicle.Model_ID = VehicleModel.Model_ID 
--         AND Inspector.Inspector_Fname ='Paul' AND Inspector.Inspector_ID = CheckInInspector_Vehicle.Inspector_ID AND 
--         CheckInInspector_Vehicle.Vehicle_ID = Vehicle.Vehicle_ID;


-- -- Query 8   
-- --To list the most frequently used vehicle model and classification till now
--     list of mostly hired vehicles from Hire table
--     list of mostly hired vehicles from FleetHire table
--     finding  the sum by grouping by model and classification in result of the union of mostly hired vehicles from Hire and FleetHire results and ordering in desc

--         SELECT Model_Name, Class_Name, SUM(No_Of_Hires) AS No_Of_Hires FROM 
--         (

--         SELECT VehicleModel.Model_Name, VehicleClassification.Class_Name, COUNT(Hire_ID) AS No_Of_Hires FROM
--         Hire JOIN Vehicle ON Hire.Vehicle_ID = Vehicle.Vehicle_ID  
--         JOIN VehicleModel ON Vehicle.Model_ID = VehicleModel.Model_ID
--         JOIN VehicleClassification ON VehicleModel.Class_ID = VehicleClassification.Class_ID
--         WHERE Hire.H_Date <= SYSDATE
--         GROUP BY VehicleModel.Model_Name, VehicleClassification.Class_Name
        
    
--         UNION
        
--         SELECT VehicleModel.Model_Name, VehicleClassification.Class_Name, COUNT(FHVehicles_ID) AS No_Of_Hires FROM
--         FleetHire_Vehicle JOIN Vehicle ON FleetHire_Vehicle.Vehicle_ID = Vehicle.Vehicle_ID 
--         JOIN VehicleModel ON Vehicle.Model_ID = VehicleModel.Model_ID
--         JOIN VehicleClassification ON VehicleModel.Class_ID = VehicleClassification.Class_ID
--         WHERE FleetHire_Vehicle.H_Date <= SYSDATE
--         GROUP BY VehicleModel.Model_Name, VehicleClassification.Class_Name
--         )
--         GROUP BY Model_Name, Class_Name
--         ORDER BY No_Of_Hires DESC; 


-- -- Query 9   
-- --To find the least used (unpopular) vehicles among the customers.


--         SELECT Model_Name, Class_Name, SUM(No_Of_Hires) AS No_Of_Hires FROM 
--         (

--         SELECT VehicleModel.Model_Name, VehicleClassification.Class_Name, COUNT(Hire_ID) AS No_Of_Hires FROM
--         Hire JOIN Vehicle ON Hire.Vehicle_ID = Vehicle.Vehicle_ID  
--         JOIN VehicleModel ON Vehicle.Model_ID = VehicleModel.Model_ID
--         JOIN VehicleClassification ON VehicleModel.Class_ID = VehicleClassification.Class_ID
--         WHERE Hire.H_Date <= SYSDATE
--         GROUP BY VehicleModel.Model_Name, VehicleClassification.Class_Name
        
    
--         UNION
        
--         SELECT VehicleModel.Model_Name, VehicleClassification.Class_Name, COUNT(FHVehicles_ID) AS No_Of_Hires FROM
--         FleetHire_Vehicle JOIN Vehicle ON FleetHire_Vehicle.Vehicle_ID = Vehicle.Vehicle_ID 
--         JOIN VehicleModel ON Vehicle.Model_ID = VehicleModel.Model_ID
--         JOIN VehicleClassification ON VehicleModel.Class_ID = VehicleClassification.Class_ID
--         WHERE FleetHire_Vehicle.H_Date <= SYSDATE
--         GROUP BY VehicleModel.Model_Name, VehicleClassification.Class_Name
--         )
--         GROUP BY Model_Name, Class_Name
--         ORDER BY No_Of_Hires ASC; 


-- --Query 10   
-- -- To list all vehicles active in any type of hire 
--         SELECT Vehicle_ID,Status FROM Vehicle
--         WHERE  Vehicle.Status IN ('FleetHire','Hire');


-- -- Query 11   
-- -- To list all vehicles which had a maintenance check 1 year or more ago 
--         SELECT Vehicle_ID, Last_Service_Date
--         FROM Vehicle
--         WHERE MONTHS_BETWEEN(CURRENT_DATE, Last_Service_Date) >= 12;


-- -- Query 12   
-- -- To alert customers whose insurance is about to expire in 6 months
--      SELECT Individual.Customer_ID, Individual.Customer_Fname, Insurance.EndDate  FROM Customer_Insurance, Insurance, Individual 
--      WHERE Customer_Insurance.Customer_ID = Individual.Customer_ID 
--      AND Customer_Insurance.Insurance_ID = Insurance.Insurance_ID AND  
--      Insurance.EndDate BETWEEN TRUNC(SYSDATE) AND ADD_MONTHS(TRUNC(SYSDATE), 6) ;   




-- -- Query 13  
-- -- To update discount as 25 if no if vehicles is greater than or equal to 2
--     SELECT * FROM FleetHire;
--     UPDATE FleetHire SET Discount = 25 WHERE No_Of_Vehicles >= 2 ;
--     -- AFTER UPDATE
--     SELECT * FROM FleetHire;



-- -- Query 14   
-- -- To update status of a vehicle from hire to hire centre on return and add it to hirecentre_vehicle by allocating to a certain hirecentre

-- -- Update vehicle status to hire centre
--      SELECT * FROM Vehicle;
--      UPDATE Vehicle SET Status = 'HireCentre'  WHERE Vehicle_ID = 1;

-- --      SELECT * FROM Vehicle;
--      SELECT * FROM vehicle_log;


-- --Insert into HireCentre_Vehicle table
--      SELECT * FROM HireCentre_Vehicle;
--      INSERT INTO HireCentre_Vehicle VALUES(hirecentrevehicle_seq.nextval, 1, 1);
--      SELECT * FROM HireCentre_Vehicle;


-- -- Query 15   
-- -- To find the vehicles that were found to have damage to tire upon inspector’s check 

--     SELECT * FROM Inspector_Vehicle WHERE Tires <> 'No damage observed';



    SELECT * FROM Customer_Insurance;


-- Customer
-- Individual
-- Corporate
-- Driver
-- Inspector
-- HireCentre
-- Invoice
-- InsuranceType
-- VehicleClassification
-- VehicleModel
-- Vehicle
-- Hire
-- AdditionalRequirements
-- CheckInCentre
-- Insurance
-- Hire_Driver
-- Hire_AddReq
-- FleetHire
-- FleetHire_AddReq
-- FleetHire_Driver
-- FleetHire_Vehicle
-- HireCentre_Vehicle
-- RivalHireCompany
-- RivalHireCompany_Vehicle
-- CheckInCentre_Vehicle
-- Inspector_Vehicle
-- Customer_Insurance
