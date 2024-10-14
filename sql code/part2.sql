-- DROPPING TABLES IN CASE THEY ALREADY EXIST

DROP TABLE Corporate CASCADE CONSTRAINTS;
DROP TABLE FleetHire CASCADE CONSTRAINTS;
DROP TABLE Driver CASCADE CONSTRAINTS;
DROP TABLE FleetHire_Driver CASCADE CONSTRAINTS;
DROP TABLE Vehicle CASCADE CONSTRAINTS;
DROP TABLE FleetHire_Vehicle CASCADE CONSTRAINTS;
DROP VIEW FleetHireDetails CASCADE CONSTRAINTS;


-- CREATING TABLES


  CREATE TABLE Corporate(     
    Customer_ID NUMBER(8),                                      
    Corporate_Name VARCHAR2(35) NOT NULL,     
    Tax_ID_Number VARCHAR2(20) NOT NULL,
    Business_Registration_Number VARCHAR2(35) NOT NULL,
    Customer_Phone VARCHAR2(15) NOT NULL UNIQUE,     
    Addressline1 VARCHAR2(150) NOT NULL,  
    Addressline2 VARCHAR2(150),   
    City VARCHAR2(50) NOT NULL,
    Country VARCHAR2(50) NOT NULL,
    Postcode VARCHAR2(10) NOT NULL,
    Customer_Email VARCHAR2(30) NOT NULL,   
    FAX NUMBER(15) ,
    Account_No VARCHAR2(25) NOT NULL,
    CreditCard_No VARCHAR(20) NOT NULL UNIQUE,   
    CreditCard_Exp_Dt VARCHAR(8) NOT NULL,
    CONSTRAINTS pk_corp_customer_id1 PRIMARY KEY (Customer_ID)   -- added data which were common to both individual and corporate from parent table customer  to corporate table in this implementation
    );



  CREATE TABLE FleetHire (     
    FleetHire_ID NUMBER(8),     
    Customer_ID NUMBER(8) REFERENCES  Corporate(Customer_ID),     -- changed foreign key to customer id in Corporate in this implementation Customer table in previous
    No_Of_Vehicles Number(2) NOT NULL,
    Discount NUMBER(6,2),
    CONSTRAINTS pk_FleetHire_id1 PRIMARY KEY (FleetHire_ID)
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



   CREATE TABLE FleetHire_Driver (     
    FHDriver_ID NUMBER(8),     
    FleetHire_ID NUMBER(8) REFERENCES  FleetHire(FleetHire_ID),     
    Driver_ID NUMBER(8)  REFERENCES  Driver(Driver_ID),     
    CONSTRAINTS pk_FleetHireDriver_id1 PRIMARY KEY (FHDriver_ID)
   );



  CREATE TABLE Vehicle (     
    Vehicle_ID NUMBER(8),     
    Vehicle_Image BLOB, 
    Vehicle_RegNo VARCHAR2(35) NOT NULL,     
    Year_Of_Buying NUMBER(4) ,     
    Colour VARCHAR2(15) ,     
    Mileage_Per_Year NUMBER(8) NOT NULL,     
    Status VARCHAR(15), --implementing exclusive arc
    Last_Service_Date DATE,
    Model_Name VARCHAR2(35) NOT NULL ,     -- changed from model_id to model_name in this implementation to have a meaningful report
    FILENAME VARCHAR2(50),
    MIMETYPE VARCHAR2(50),
    CONSTRAINT chk_status CHECK (Status IN ('Hire', 'FleetHire', 'HireCentre')),   --implementing exclusive arc but this implementation will use only fleethire data
    CONSTRAINTS pk_vehicle_id1 PRIMARY KEY (Vehicle_ID) 
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
    Accident_or_Breakdown_Reported VARCHAR2(5) DEFAULT 'NA',
    Reported_Date DATE, 
    CONSTRAINTS pk_FleetHireVehicles_id1 PRIMARY KEY (FHVehicles_ID)
   );



   -- CREATING SEQUENCES FOR TABLES


    -- DRIVER
        DROP sequence driver_seq;
        create sequence driver_seq
        start with 1
        increment by 1
        maxvalue 10000
        minvalue 1;


  -- VEHICLE
        DROP sequence vehicle_seq;
        create sequence vehicle_seq
        start with 1
        increment by 1
        maxvalue 10000
        minvalue 1;



   -- CREATING TRIGGERS FOR TABLES FOR SEQ GENERATION UPON INSERTION

  -- DRIVER
        CREATE OR REPLACE TRIGGER driver_trigger
        BEFORE INSERT ON DRIVER
        FOR EACH ROW
        BEGIN
         SELECT driver_seq.NEXTVAL
         INTO :NEW.driver_id
         FROM dual;
        END;
        /



     -- VEHICLE
        CREATE OR REPLACE TRIGGER vehicle_trigger
        BEFORE INSERT ON vehicle
        FOR EACH ROW
        BEGIN
         SELECT vehicle_seq.NEXTVAL
         INTO :NEW.vehicle_id
         FROM dual;
        END;
        /

    -- TO ENSURE A VEHICLE IS NOT ASSIGNED TO FLEET WITHOUT SERVICE CHECK IF AN ACCIDENT HAS BEEN REPORTED PREVIOUSLY
        CREATE OR REPLACE TRIGGER check_reported_date_and_last_service
        BEFORE INSERT ON FleetHire_Vehicle
        FOR EACH ROW
        DECLARE
            v_Reported_Date DATE;
            v_last_service_date DATE;
        BEGIN
            -- Check if the Vehicle_ID has been inserted previously into FleetHire_Vehicle
            SELECT MAX(Reported_Date)
            INTO v_Reported_Date
            FROM FleetHire_Vehicle
            WHERE Vehicle_ID = :NEW.Vehicle_ID;

            IF v_Reported_Date IS NOT NULL THEN
                -- Check if the Reported_Date is not null
            
                    -- Get the last service date for the current Vehicle_ID from the Vehicle table
                    SELECT Last_Service_Date INTO v_last_service_date
                    FROM Vehicle
                    WHERE Vehicle_ID = :NEW.Vehicle_ID;

                    -- Raise an error if the last service date is not after the reported date
                    IF v_last_service_date IS NOT NULL AND v_last_service_date <= v_Reported_Date THEN
                        RAISE_APPLICATION_ERROR(-20001, 'Vehicle needs to be serviced after last accident report');
                    END IF;

            END IF;
        END;
/


      -- TO ENSURE THE FROM AND DESTINATION LOCATIONS ARE NOT SAME
   
            CREATE OR REPLACE TRIGGER check_same_hire_from_and_destination
            BEFORE INSERT OR UPDATE ON FleetHire_Vehicle
            FOR EACH ROW
            BEGIN
               IF UPPER(:NEW.HFrom) = UPPER(:NEW.Destination) THEN 
                    RAISE_APPLICATION_ERROR(-20002, 'Hire from and destination location cannot be the same!');
                END IF;
            END;
            /
   




-- INSERTING VALUES INTO TABLES


    INSERT INTO Corporate VALUES (16, 'Smith & Co.', '456-78-9012', 'SC345678', 7812456890, '221 Bakers St', NULL, 'London', 'United Kingdom', 'LD1 6XE', 'smith.co@yahoo.com', 2236569852,'3363 2252 4458 9965','xxxx-xxxx-xxxx-8576', '28/09');
    INSERT INTO Corporate VALUES (19, 'Acme Corporation', '555-55-5555', 'ACM555555', 5551234567, '123 Main St', NULL, 'Anytown', 'United States of America', 'AN1 6TE', 'info@acmecorp.com', 2036658965,'7855 2563 1254 7859','xxxx-xxxx-xxxx-1376', '18/07');
    INSERT INTO Corporate VALUES (20, 'Tech Solutions Inc.', '111-11-1111', 'TSI111111', 5559876543, '456 Elm St', NULL, 'Springfield', 'United States of America', 'SF1 4TG', 'contact@techsolutions.com', 5046987524,'8541 25631 7965 2201', 'xxxx-xxxx-xxxx-9301', '18/06');
    INSERT INTO Corporate VALUES (21, 'Globex Enterprises', '999-99-9999', 'GEX999999', 5554567890, '789 Maple Ave', NULL, 'Metropolis', 'United States of America', 'MP1 4TO', 'support@globex.com', 2014587455,'5001 2561 3336 2251','xxxx-xxxx-xxxx-1345', '28/03');
    INSERT INTO Corporate VALUES (22, 'Globex Enterprises Springfield', '999-99-9999', 'GEX999999', 5554567789, '456 Elm St', NULL, 'Springfield', 'United States of America', 'SF1 4TG', 'support@globex.com', 1258742364,'5874 6985 2145 3654','xxxx-xxxx-xxxx-1340', '28/9');
    INSERT INTO Corporate VALUES (23, 'Sansiro Tech', '890-19-0999', 'SAN999999', 1124897719, '456 Elm St', NULL, 'Springfield', 'United States of America', 'SF1 4TG', 'support@sansiro.com', 1299042313,'12804 1905 2115 1390','xxxx-xxxx-xxxx-2193', '16/6');
    INSERT INTO Corporate VALUES (24, 'Arizona Smart Logics', '899-12-9999', 'AZE999999', 2254567789, '156 Az St', NULL, 'Arizona', 'United States of America', 'AR1 4TG', 'support@azl.com', 1250002364,'5872 0185 1145 3611','xxxx-xxxx-xxxx-1230', '26/9');
    INSERT INTO Corporate VALUES (25, 'Marks Sol Ltd', '119-99-9765', 'MSX999129', 5554122789, '129 SM St', NULL, 'Springfield', 'United States of America', 'SF1 4TG', 'info@marksol.com', 22345742364,'1274 3485 2109 5604','xxxx-xxxx-xxxx-2841', '18/7');
    INSERT INTO Corporate VALUES (26, 'Anyzia Ent.', '999-99-34509', 'ANZ999111', 5554567012, '89 Maple Ave', NULL, 'Metropolis', 'United States of America', 'MP1 4TO', 'support@anz.com', 93318742364,'6774 0085 1205 3458','xxxx-xxxx-xxxx-8990', '12/10');
    INSERT INTO Corporate VALUES (27, 'Miolix Enterprises', '567-12-9912', 'MIX890999', 2234567180, '456 Elm St', NULL, 'Anytown', 'United States of America', 'AN1 6TE', 'contact@lix.com', 77897401113,'1124 1905 9801 1254','xxxx-xxxx-xxxx-4347', '20/12');


    INSERT INTO FleetHire VALUES (1, 16, 1, NULL);    
    INSERT INTO FleetHire VALUES (2, 19, 1, NULL);  
    INSERT INTO FleetHire VALUES (3, 20, 1, NULL);  
    INSERT INTO FleetHire VALUES (4, 21, 1, NULL);  
    INSERT INTO FleetHire VALUES (5, 20, 2, NULL);  
    INSERT INTO FleetHire VALUES (6, 16, 2, NULL);  
    INSERT INTO FleetHire VALUES (7, 20, 2, NULL);  
    INSERT INTO FleetHire VALUES (8, 21, 1, NULL);
    INSERT INTO FleetHire VALUES (9, 23, 1, NULL);
    INSERT INTO FleetHire VALUES (10, 22, 1, NULL);
    INSERT INTO FleetHire VALUES (11, 24, 3, NULL);
    INSERT INTO FleetHire VALUES (12, 25, 1, NULL);
    INSERT INTO FleetHire VALUES (13, 26, 1, NULL);
    INSERT INTO FleetHire VALUES (14, 25, 2, NULL);
    INSERT INTO FleetHire VALUES (15, 27, 2, NULL);


    INSERT INTO Driver (Driver_Fname, Driver_Lname, License_No, Driver_Dob, Driver_Gender) VALUES ('John','Buyer','UK158745963214', '8/10/1985', 'Male');
    INSERT INTO Driver (Driver_Fname, Driver_Lname, License_No, Driver_Dob, Driver_Gender) VALUES ('Arham','Patel' ,'UK654921098765','8/10/1985', 'Male');
    INSERT INTO Driver (Driver_Fname, Driver_Lname, License_No, Driver_Dob, Driver_Gender) VALUES ('Ewan','Magroger','SC125698743256', '4/3/1987', 'Male');
    INSERT INTO Driver (Driver_Fname, Driver_Lname, License_No, Driver_Dob, Driver_Gender) VALUES ('Emily','Johnson' ,'UK854987452665','12/25/1998', 'Female');
    INSERT INTO Driver (Driver_Fname, Driver_Lname, License_No, Driver_Dob, Driver_Gender) VALUES ('Rebecca','Johnson','LD987654321098', '9/10/1993', 'Female');
    INSERT INTO Driver (Driver_Fname, Driver_Lname, License_No, Driver_Dob, Driver_Gender) VALUES ('Andrew','John' ,'SC876549810987','3/15/1985', 'Male');
    INSERT INTO Driver (Driver_Fname, Driver_Lname, License_No, Driver_Dob, Driver_Gender) VALUES ('Charlie','Scott' ,'UK859623548742','7/22/1986', 'Male');
    INSERT INTO Driver (Driver_Fname, Driver_Lname, License_No, Driver_Dob, Driver_Gender) VALUES ('Chorlatte','Monson' ,'LD589632144568','2/27/1989', 'Male');
    INSERT INTO Driver (Driver_Fname, Driver_Lname, License_No, Driver_Dob, Driver_Gender) VALUES ('Belton','Wilson','UK854932566441', '12/1/1994', 'Male');    
    INSERT INTO Driver (Driver_Fname, Driver_Lname, License_No, Driver_Dob, Driver_Gender) VALUES ('Taylor','Collins', 'LD471239885469','8/10/2004', 'Female');  
    INSERT INTO Driver (Driver_Fname, Driver_Lname, License_No, Driver_Dob, Driver_Gender) VALUES ('Cooper','Terner','LD895463214575', '1/1/1991', 'Female');
    INSERT INTO Driver (Driver_Fname, Driver_Lname, License_No, Driver_Dob, Driver_Gender) VALUES ('Martin','Harrys', 'SC789541256321','5/2/1982', 'Male');
    INSERT INTO Driver (Driver_Fname, Driver_Lname, License_No, Driver_Dob, Driver_Gender) VALUES ('Robinson','Lewis', 'SC854415889654','10/22/1990', 'Male');    
    INSERT INTO Driver (Driver_Fname, Driver_Lname, License_No, Driver_Dob, Driver_Gender) VALUES ('Thomas','Mathew','WL854963258487','3/5/1992', 'Male');  


    INSERT INTO FleetHire_Driver VALUES (1, 4, 2);    
    INSERT INTO FleetHire_Driver VALUES (2, 2, 1);  
    INSERT INTO FleetHire_Driver VALUES (3, 5, 3);
    INSERT INTO FleetHire_Driver VALUES (4, 1, 5);  
    INSERT INTO FleetHire_Driver VALUES (5, 3, 4);
    INSERT INTO FleetHire_Driver VALUES (6, 6, 14);
    INSERT INTO FleetHire_Driver VALUES (7, 7, 6);
    INSERT INTO FleetHire_Driver VALUES (8, 5, 12);
    INSERT INTO FleetHire_Driver VALUES (9, 3, 4);
    INSERT INTO FleetHire_Driver VALUES (10, 6, 10);
    INSERT INTO FleetHire_Driver VALUES (11, 7, 7);
    INSERT INTO FleetHire_Driver VALUES (12, 11, 8);
    INSERT INTO FleetHire_Driver VALUES (13, 11, 9);
    INSERT INTO FleetHire_Driver VALUES (14, 11, 2);
    INSERT INTO FleetHire_Driver VALUES (15, 8, 1);
    INSERT INTO FleetHire_Driver VALUES (16, 9, 13);
    INSERT INTO FleetHire_Driver VALUES (17, 10, 14);
    INSERT INTO FleetHire_Driver VALUES (18, 10, 14);
    INSERT INTO FleetHire_Driver VALUES (19, 12, 11);
    INSERT INTO FleetHire_Driver VALUES (20, 13, 6);
    INSERT INTO FleetHire_Driver VALUES (21, 14, 2);
    INSERT INTO FleetHire_Driver VALUES (22, 14, 1);
    INSERT INTO FleetHire_Driver VALUES (23, 15, 7);
    INSERT INTO FleetHire_Driver VALUES (24, 15, 3);


    INSERT INTO Vehicle (Vehicle_ID, Vehicle_RegNo, Year_Of_Buying, Colour, Mileage_Per_Year, Status, Last_Service_Date, Model_Name) VALUES (NULL,'UK24 BMW',2024,'Black', 10000, 'Hire', '01/01/2024', 'BMW 3 Series');
    INSERT INTO Vehicle (Vehicle_ID, Vehicle_RegNo, Year_Of_Buying, Colour, Mileage_Per_Year, Status, Last_Service_Date, Model_Name) VALUES (NULL,'SC22 TSL',2023,'Blue',15000, 'Hire', '01/01/2023', 'Tesla Model 3');
    INSERT INTO Vehicle (Vehicle_ID, Vehicle_RegNo, Year_Of_Buying, Colour, Mileage_Per_Year, Status, Last_Service_Date, Model_Name) VALUES (NULL,'UK24 BMW',2023,'Grey', 15000, 'Hire','01/01/2023', 'Ford F-150');
    INSERT INTO Vehicle (Vehicle_ID, Vehicle_RegNo, Year_Of_Buying, Colour, Mileage_Per_Year, Status, Last_Service_Date, Model_Name) VALUES (NULL,'LD23 JEP',2023,'Red', 10000, 'Hire','01/01/2023', 'Jeep Wrangler');
    INSERT INTO Vehicle (Vehicle_ID, Vehicle_RegNo, Year_Of_Buying, Colour, Mileage_Per_Year, Status, Last_Service_Date, Model_Name) VALUES (NULL,'ED20 FI2',2022,'White', 7000, 'Hire','01/01/2022', 'Fiat Panda');
    INSERT INTO Vehicle (Vehicle_ID, Vehicle_RegNo, Year_Of_Buying, Colour, Mileage_Per_Year, Status, Last_Service_Date, Model_Name) VALUES (NULL,'SC58 K65',2023,'Grey', 12000, 'FleetHire','01/01/2023', 'Toyota RAV4 Hybrid');
    INSERT INTO Vehicle (Vehicle_ID, Vehicle_RegNo, Year_Of_Buying, Colour, Mileage_Per_Year, Status, Last_Service_Date, Model_Name) VALUES (NULL,'WL88 L65',2023,'Blue', 15000, 'FleetHire','01/01/2023', 'Tesla Model 3');
    INSERT INTO Vehicle (Vehicle_ID, Vehicle_RegNo, Year_Of_Buying, Colour, Mileage_Per_Year, Status, Last_Service_Date, Model_Name) VALUES (NULL,'UK80 XE',2023,'Red', 10000 , 'FleetHire','01/01/2023', 'Jeep Wrangler');
    INSERT INTO Vehicle (Vehicle_ID, Vehicle_RegNo, Year_Of_Buying, Colour, Mileage_Per_Year, Status, Last_Service_Date, Model_Name) VALUES (NULL,'SC85 558',2022,'Olive', 7000, 'FleetHire','01/01/2022', 'Ford Fiesta 1.1');
    INSERT INTO Vehicle (Vehicle_ID, Vehicle_RegNo, Year_Of_Buying, Colour, Mileage_Per_Year, Status, Last_Service_Date, Model_Name) VALUES (NULL,'ED58 KL6',2022,'Black',7000, 'FleetHire','01/01/2022', 'Fiat Panda');
    INSERT INTO Vehicle (Vehicle_ID, Vehicle_RegNo, Year_Of_Buying, Colour, Mileage_Per_Year, Status, Last_Service_Date, Model_Name) VALUES (NULL,'ABC 123',2022,'Red', 10000, 'HireCentre','01/01/2022', 'Fiat Panda');
    INSERT INTO Vehicle (Vehicle_ID, Vehicle_RegNo, Year_Of_Buying, Colour, Mileage_Per_Year, Status, Last_Service_Date, Model_Name) VALUES (NULL,'XYZ 456',2022,'Blue', 10000 , 'HireCentre','01/01/2022', 'Ford Fiesta 1.1');
    INSERT INTO Vehicle (Vehicle_ID, Vehicle_RegNo, Year_Of_Buying, Colour, Mileage_Per_Year, Status, Last_Service_Date, Model_Name) VALUES (NULL,'DEF 289',2024,'Green', 20000 , 'HireCentre','01/01/2024', 'Tesla Model 3');
    INSERT INTO Vehicle (Vehicle_ID, Vehicle_RegNo, Year_Of_Buying, Colour, Mileage_Per_Year, Status, Last_Service_Date, Model_Name) VALUES (NULL,'GHI 123',2022,'Yellow',7000 , 'HireCentre','01/01/2022', 'Ford Fiesta 1.1');
    INSERT INTO Vehicle (Vehicle_ID, Vehicle_RegNo, Year_Of_Buying, Colour, Mileage_Per_Year, Status, Last_Service_Date, Model_Name) VALUES (NULL,'JKL 456',2022,'Black',10000, 'HireCentre','01/01/2022', 'Ford Fiesta 1.1');
    INSERT INTO Vehicle (Vehicle_ID, Vehicle_RegNo, Year_Of_Buying, Colour, Mileage_Per_Year, Status, Last_Service_Date, Model_Name) VALUES (NULL,'MNK 989',2023,'White',10000 , 'HireCentre','01/01/2023', 'Jeep Wrangler');
    INSERT INTO Vehicle (Vehicle_ID, Vehicle_RegNo, Year_Of_Buying, Colour, Mileage_Per_Year, Status, Last_Service_Date, Model_Name) VALUES (NULL,'PJK5 LO3',2022,'Silver', 10000 , 'FleetHire','01/01/2022', 'Fiat Panda');
    INSERT INTO Vehicle (Vehicle_ID, Vehicle_RegNo, Year_Of_Buying, Colour, Mileage_Per_Year, Status, Last_Service_Date, Model_Name) VALUES (NULL,'STK 486',2023,'Grey',20000 , 'Hire','01/01/2023', 'Ford F-150');
    INSERT INTO Vehicle (Vehicle_ID, Vehicle_RegNo, Year_Of_Buying, Colour, Mileage_Per_Year, Status, Last_Service_Date, Model_Name) VALUES (NULL,'VJ9 889',2024,'Brown', 15000 , 'HireCentre', '01/01/2024', 'BMW 3 Series');


    INSERT INTO FleetHire_Vehicle VALUES (1, 1, 7,'11/23/2022','10:15:00 AM', 'London', 'Scotland', '11/23/2022', '9:20:00 PM', 'Yes', '11/23/2022');    
    INSERT INTO FleetHire_Vehicle VALUES (2, 5, 6,'2/19/2023','1:55:00 PM','Edinburg', 'London', '2/20/2023', '12:25:00 AM', 'No', '');  
    INSERT INTO FleetHire_Vehicle VALUES (3, 3, 8,'5/27/2023','9:30:00 AM','Scotland', 'Wales', '5/27/2023', '4:30:00 PM', 'No', '');
    INSERT INTO FleetHire_Vehicle VALUES (4, 2, 10,'10/15/2023','6:45:00 PM','Leeds', 'France', '10/16/2023', '7:45:00 PM', 'No', '');  
    INSERT INTO FleetHire_Vehicle VALUES (5, 4, 9,'1/1/2024','10:30:00 AM','Wales', 'Edinburg', '1/1/2024', '2:30:00 PM', 'No', '');
    INSERT INTO FleetHire_Vehicle VALUES (6, 5, 17,'1/1/2024','10:30:00 AM','Leeds', 'London', '1/1/2024', '2:30:00 PM', 'Yes', '1/1/2024');
    INSERT INTO FleetHire_Vehicle VALUES (7, 6, 17,'1/21/2024','11:30:00 AM','Leeds', 'London', '1/21/2024', '3:30:00 PM', 'No', '');
    INSERT INTO FleetHire_Vehicle VALUES (8, 7, 17,'1/30/2024','10:30:00 AM','Leeds', 'London', '1/30/2024', '2:30:00 PM', 'Yes', '1/30/2024');
    INSERT INTO FleetHire_Vehicle VALUES (9, 8, 19,'1/10/2024','10:30:00 AM','Leeds', 'London', '1/10/2024', '2:30:00 PM', 'No', '');
    INSERT INTO FleetHire_Vehicle VALUES (10, 7, 3,'1/11/2024','10:30:00 AM','Leeds', 'London', '1/11/2024', '2:30:00 PM', 'No', '');
    INSERT INTO FleetHire_Vehicle VALUES (11, 6, 12,'1/28/2024','10:30:00 AM','London', 'Scotland', '1/28/2024', '2:30:00 PM', 'No', '');
    INSERT INTO FleetHire_Vehicle VALUES (12, 9, 4,'2/03/2024','10:30:00 AM','Leeds', 'Norwich', '2/03/2024', '2:30:00 PM', 'No', '');
    INSERT INTO FleetHire_Vehicle VALUES (13, 10, 2,'1/12/2024','10:30:00 AM','Leeds', 'London', '1/12/2024', '2:30:00 PM', 'No', '');
    INSERT INTO FleetHire_Vehicle VALUES (14, 11, 17,'2/13/2024','10:30:00 AM','Leeds', 'London', '2/12/2024', '2:30:00 PM', 'No', '');
    INSERT INTO FleetHire_Vehicle VALUES (15, 11, 7,'2/16/2024','10:30:00 AM','Leeds', 'London', '2/16/2024', '2:30:00 PM', 'No', '');
    INSERT INTO FleetHire_Vehicle VALUES (16, 11, 4,'2/16/2024','10:30:00 AM','Leeds', 'London', '2/16/2024', '2:30:00 PM', 'No', '');
    INSERT INTO FleetHire_Vehicle VALUES (17, 12, 6,'2/27/2024','10:30:00 AM','Norwich', 'London', '2/27/2024', '2:30:00 PM', 'No', '');
    INSERT INTO FleetHire_Vehicle VALUES (18, 13, 6,'3/01/2024','10:30:00 AM','Leeds', 'London', '3/01/2024', '2:30:00 PM', 'No', '');
    INSERT INTO FleetHire_Vehicle VALUES (19, 14, 1,'3/04/2024','10:30:00 AM','Leeds', 'London', '3/04/2024', '2:30:00 PM', 'No', '');
    INSERT INTO FleetHire_Vehicle VALUES (20, 14, 2,'3/04/2024','10:30:00 AM','Leeds', 'London', '3/04/2024', '2:30:00 PM', 'No', '');
    INSERT INTO FleetHire_Vehicle VALUES (21, 15, 1,'4/01/2024','10:30:00 AM','Leeds', 'London', '4/01/2024', '2:30:00 PM', 'No', '');
    INSERT INTO FleetHire_Vehicle VALUES (22, 15, 8,'4/07/2024','10:30:00 AM','Leeds', 'London', '4/07/2024', '2:30:00 PM', 'No', '');
    -- INSERT INTO FleetHire_Vehicle VALUES (23, 7, 17,'1/30/2024','10:30:00 AM','Leeds', 'London', '1/30/2024', '2:30:00 PM', 'No', '');
    -- INSERT INTO FleetHire_Vehicle VALUES (24, 7, 17,'1/30/2024','10:30:00 AM','Leeds', 'London', '1/30/2024', '2:30:00 PM', 'No', '');


    -- Creating view for Fleet Hire details


    CREATE VIEW FleetHireDetails AS
    SELECT FleetHire.FleetHire_ID, Vehicle.Vehicle_RegNo , Driver.Driver_Fname, Corporate.Corporate_Name, FleetHire_Vehicle.hfrom, FleetHire_Vehicle.Destination,
    FleetHire_Vehicle.h_date, FleetHire_Vehicle.Exp_RDate
    FROM FleetHire, Driver, Vehicle, FleetHire_Driver, FleetHire_Vehicle, Corporate  
    WHERE FleetHire_Vehicle.Vehicle_ID = Vehicle.Vehicle_ID AND  FleetHire.FleetHire_ID = FleetHire_Vehicle.FleetHire_ID
    AND FleetHire_Driver.Driver_ID = Driver.Driver_ID AND FleetHire.FleetHire_ID = FleetHire_Driver.FleetHire_ID
    AND FleetHire.Customer_ID = Corporate.Customer_ID
    ORDER BY FleetHire.FleetHire_ID ASC;





    SELECT * FROM FleetHireDetails;



