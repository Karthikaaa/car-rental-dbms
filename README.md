Cars4U - Car Rental System
Project Overview
Cars4U is a comprehensive car rental system designed to manage both fleet hires for corporate clients and normal hires for individual customers. This system streamlines the management of rentals, including customer information, vehicle details, hire centers, insurance options, and additional requirements.

Features
1. Customer Management
Manage customer profiles for both individual and corporate clients.
Store essential information, such as names, contact details, and rental history.
2. Vehicle Management
Maintain an extensive database of vehicles, categorized by type (e.g., sedan, SUV, truck).
Track vehicle availability and specifications.
3. Hire Management
Facilitate the process of vehicle hiring for individuals and corporate clients.
Manage fleet hires, including driver assignments and additional requirements.
4. Insurance Management
Offer various types of insurance options for vehicle rentals.
Manage customer insurance selections and ensure compliance with rental policies.
5. Hire Center Management
Administer multiple hire centers to cater to different geographical locations.
Track inventory and availability of vehicles at each hire center.
6. Reporting
Generate reports on rentals, revenue, and customer insights to support decision-making.


Database Tables
The following tables are utilized in the Cars4U system:

1. Customer: Stores details of all customers (both individual and corporate).
2. Individual: Contains specific data for individual customers.
3. Corporate: Contains specific data for corporate clients.
4. InsuranceType: Lists different types of insurance available for rentals.
5. Insurance: Links customers to their selected insurance options.
6. Driver: Manages information regarding drivers assigned to fleet hires.
7. AdditionalRequirements: Handles any additional requirements requested by customers (e.g., GPS, child seats).
8. HireCentre: Represents various centers from where vehicles can be hired.
9. Inspector: Manages data related to vehicle inspectors.
10. VehicleClassification: Categorizes vehicles into different classes.
11. VehicleModel: Stores details about different vehicle models.
12. Vehicle: Maintains information about the fleet of vehicles available for rent.
13. RivalHireCompany: Contains details about competitor car rental companies.
14. CheckInCentre: Represents locations where vehicles can be checked in.
15. Hire: Manages the rental transactions for both individual and corporate customers.
16. FleetHire: Specifically manages corporate hire transactions.
17. Hire_AddReq: Links hires to additional requirements.
18. Hire_Driver: Associates drivers with specific hires.
19. FleetHire_Driver: Associates drivers with fleet hire transactions.
20. FleetHire_Vehicle: Links vehicles to fleet hire transactions.
21. FleetHire_AddReq: Links additional requirements to fleet hire transactions.
22. RivalHireCompany_Vehicle: Tracks vehicles available from rival hire companies.
23. CheckInCentre_Vehicle: Manages vehicle check-ins at different centers.
24. Inspector_Vehicle: Links inspectors to specific vehicles.
25. HireCentre_Vehicle: Associates vehicles with hire centers.
26. Invoice: Manages invoices for rentals.
27. Customer_Insurance: Links customers to their selected insurance plans.


System Architecture
The project is developed with the following components:

1. Frontend: Built using Oracle APEX’s App Builder, which provides an intuitive UI for users to interact with the system.
2. Backend: Managed via Oracle APEX database, allowing storage of entities such as customers, vehicles, hire centres, and more.

   
Business Logic: Embedded SQL queries and procedures handle business rules such as calculating rental costs, managing fleet availability, and ensuring smooth integration between entities.

Key Functionalities
1. Vehicle Availability Check: Ensure vehicles are available at specific hire centres and filter by vehicle type and insurance coverage.
2. Rental Cost Calculation: Automatically calculate rental fees based on vehicle type, duration of hire, and any applicable discounts.
3. Fleet Management: Efficiently manage vehicle distribution across multiple hire centres.
4. User-Friendly Interface: An intuitive and easy-to-navigate interface built using Oracle APEX for quick access to core functionalities.
5. Reports and Analytics: Generate reports on customer usage, vehicle availability, and hire centre performance.
