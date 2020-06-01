create database cat;
CREATE USER 'cat'@'localhost';
GRANT ALL PRIVILEGES ON * . * TO 'cat'@'localhost';
use cat;

create table addresses
(
    ID        int auto_increment
        primary key,
    Street    text null,
    Number    text null,
    City      text null,
    Post_code text null
);

create table cpus
(
    ID             int auto_increment
        primary key,
    Name           text       not null,
    Brand          text       not null,
    CPU_model      text       not null,
    Clock_speed    double     not null,
    Boost_speed    double     not null,
    Physical_cores int        not null,
    Logical_cores  int        not null,
    IGP            tinyint(1) not null,
    Cache          double       not null
);

create table gpus
(
    ID           int auto_increment
        primary key,
    Name         text                                                       not null,
    Brand        text                                                       not null,
    Clock_speed  double                                                     not null,
    RAM_capacity int                                                        not null,
    RAM_type     enum ('GDDR2', 'GDDR3', 'GDDR5', 'GDDR6', 'GDDR7','HBM2')  null,
    Output       text                                                       not null
);


create table hard_drives
(
    ID                 int auto_increment
        primary key,
    Name               text                                                                                                          not null,
    Brand              text                                                                                                          not null,
    Type               enum ('SSD', 'HDD')                                                                                           null,
    Capacity           int                                                                                                           null,
    Internal_interface enum ('SATA III (6 Gbit/s)', 'SATA II (3 Gbit/s)', 'SATA (1.5 Gbit/s)', 'PATA (IDE)', 'mSATA', 'PCI Express', 'M.2 PCIe NVMe 3.0 x4') null,
    Max_Sequential_Write_Speed INT CHECK ( Max_Sequential_Write_Speed > 0 ),
    Max_Sequential_Read_Speed INT CHECK ( Max_Sequential_Read_Speed > 0 ),
    Hard_Disk_Rotational_Speed INT CHECK ( Hard_Disk_Rotational_Speed > 0 )
);

create table mainboards
(
    ID               int auto_increment
        primary key,
    Name             text       not null,
    CPU_model_socket text       not null,
    Chipset          text       not null,
    Brand            text       not null,
    LED              tinyint(1) not null,
    Max_RAM          int        null
);

create table power_supply_units
(
    ID        int auto_increment
        primary key,
    Name      text not null,
    Brand     text not null,
    DC_Output int  not null,
    Efficiency int check ( Efficiency > 0 AND Efficiency < 100 )
);

create table rams
(
    ID           int auto_increment
        primary key,
    Name         text                                  not null,
    Brand        text                                  not null,
    RAM_type     enum ('DDR2', 'DDR3', 'DDR5', 'DDR4') null,
    RAM_capacity int                                   not null,
    Clock_speed  int                                   not null,
    Number_of_items INT NOT NULL DEFAULT 1
);


create table screens
(
    ID                 int auto_increment
        primary key,
    Brand              text                                                                                              not null,
    Type               enum ('Notebook', 'Monitor', 'TV')                                                                null,
    Resolution         enum ('1920 x 1080 (FullHD)', '2560 x 1440 (WQHD)', '3840 x 2160 (UHD 4K)', '1280 x 1024 (SXGA)') null,
    Display_size       decimal(4, 1)                                                                                     null,
    Display_technology enum ('IPS', 'TN', 'VA', 'LED', 'OLED', 'QLED')                                                                         null,
    Curved             boolean                                                                                           not null
);

create table specyfications
(
    ID                int auto_increment
        primary key,
    mainboard         int null,
    CPU               int null,
    GPU               int null,
    RAM               int null,
    Hard_drive        int null,
    Screen            int null,
    Power_supply_unit int null,
    constraint specyfications_ibfk_1
        foreign key (mainboard) references mainboards (ID),
    constraint specyfications_ibfk_2
        foreign key (CPU) references cpus (ID),
    constraint specyfications_ibfk_3
        foreign key (GPU) references gpus (ID),
    constraint specyfications_ibfk_4
        foreign key (RAM) references rams (ID),
    constraint specyfications_ibfk_5
        foreign key (Hard_drive) references hard_drives (ID),
    constraint specyfications_ibfk_6
        foreign key (Screen) references screens (ID),
    constraint specyfications_ibfk_7
        foreign key (Power_supply_unit) references power_supply_units (ID)
);


create table products
(
    ID               int auto_increment
        primary key,
    Category         enum ('Procesory','Karty graficzne','Dyski twarde', 'Płyty główne', 'Zasilacze', 'RAM', 'Telewizory','Monitory', 'Laptopy', 'Komputery') null,
    Price            double                                                                                                     null,
    Brand            text                                                                                                       not null,
    On_stock         int                                                                                                        null,
    Description      text                                                                                                       null,
    Rating           decimal(2, 1)                                                                                              null,
    specyficationsID int                                                                                                        null,
    constraint products_ibfk_1
        foreign key (specyficationsID) references specyfications (ID)
);

create index specyficationsID
    on products (specyficationsID);

create index CPU
    on specyfications (CPU);

create index GPU
    on specyfications (GPU);

create index Hard_drive
    on specyfications (Hard_drive);

create index Power_supply_unit
    on specyfications (Power_supply_unit);

create index RAM
    on specyfications (RAM);

create index Screen
    on specyfications (Screen);

create index mainboard
    on specyfications (mainboard);

create table user
(
    ID                  int auto_increment
        primary key,
    Name                text       null,
    Surname             text       null,
    AddressID           int        null,
    Login               text       not null,
    Password            text       not null,
    Email               text       null,
    Phone_number        text       null,
    Is_a_client         tinyint(1) null,
    Is_a_company_client tinyint(1) null,
    constraint user_ibfk_1
        foreign key (AddressID) references addresses (ID)
);

create table orders
(
    UserID         int                                                                          not null,
    Order_number   int                                                                          not null,
    Order_date     datetime                                                                     not null,
    ProductID      int                                                                          null,
    Product_number int                                                                          null,
    Delivery       enum ('click and collect', 'Inpost', 'DPD', 'DHL', 'Fedex', 'Poczta Polska') null,
    ID             int auto_increment
        primary key,
    constraint orders_ibfk_1
        foreign key (ProductID) references products (ID),
    constraint orders_ibfk_2
        foreign key (UserID) references user (ID)
);

create index ProductID
    on orders (ProductID);

create index UserID
    on orders (UserID);

create index AddressID
    on user (AddressID);


##### Procesory #####

INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Core i9', 'Intel','i9-7980XE',2.6,4.2,18,36,false, 24.5);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Core i9', 'Intel', 'i9-9900', 3.1, 5.0, 8, 16, true, 16);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Core i9', 'Intel', 'i9-9900X', 3.5,4.4,10,20,false,19.25);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Core i9', 'Intel', 'i9-10900X', 3.7,4.5,10,20,false,19.25);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Core i9', 'Intel', 'i9-7940X',3.1,4.3,14,28,false,19.25);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Core i7', 'Intel', 'i7-9700K', 3.6, 4.9, 8, 8, true, 12);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Core i7', 'Intel', 'i7-7700',3.6, 0, 4, 8, true, 8);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Core i7', 'Intel', 'i7-8700',3.2,4.6,6,12,true,12);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Core i7', 'Intel', 'i7-7820X', 3.6,4.3,8,16,false,11 );
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Core i5', 'Intel', 'i5-9400F', 2.9,4.1,6,6,false, 9);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Core i5', 'Intel', 'i5-9600K', 3.7,4.6,6,6,true,9);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Core i5', 'Intel', 'i5-8500', 3.0,4.1,6,6,true,9);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Core i5', 'Intel', 'i5-7500',3.4,3.8,4,4,true,6);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Core i3', 'Intel', 'i3-9100F', 3.6,4.2,4,4,false, 6);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Core i3', 'Intel', 'i3-8100', 3.6, 0, 4,4,true,6);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Core i3', 'Intel', 'i3-9100',3.6,4.2,4,4,true,6);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Pentium', 'Intel', 'G5420',3.8,0,2,4,true,4);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Pentium', 'Intel', 'G5400',3.7,0,2,4,true,4);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Ryzen Threadripper ', 'AMD', '1920X', 3.5,4.0,12,24,false,39);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Ryzen Threadripper ', 'AMD', '3970X', 3.7,4.5,32,64,false,128);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Ryzen Threadripper', 'AMD', '3990X',2.9,4.3,64,128,false,288);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Ryzen 9', 'AMD', '3950X',3.5,4.7,16,32,false, 64);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Ryzen 9', 'AMD', '3900X',3.8,4.6,12,24,false,70);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Ryzen 7', 'AMD', '3700X', 3.6,4.4,8,16,false,36);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Ryzen 7', 'AMD', '3800X',3.9,4.5,8,16,false,36);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Ryzen 7', 'AMD', '2700X',3.7,4.3,8,16,false,20);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Ryzen 7', 'AMD', '2700',3.2,4.1,8,16,false,20);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Ryzen 5', 'AMD', '3600',3.6,4.2,6,12,false,35);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Ryzen 5', 'AMD', '2600',3.4,3.9,6,12,false,19);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Ryzen 5', 'AMD', '2400G',3.6,3.9,4,8,true,6);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Ryzen 3', 'AMD', '1200AF',3.1,3.4,4,4,false,10);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Ryzen 3', 'AMD', '3200G',3.6,4.0,4,4,true,6);
INSERT INTO cpus (Name, Brand, CPU_model, Clock_speed, Boost_speed, Physical_cores, Logical_cores, IGP, Cache)
values ('Ryzen 3', 'AMD', '2200G',3.5,3.7,4,4,true,6);

##### GPU #####

INSERT INTO gpus (Brand, Name, Clock_speed, RAM_capacity, RAM_type, Output)
VALUES ('MSI', 'Radeon RX 570', 1268, 4, 'GDDR5', 'HDMI - 1 szt. DVI - 1 szt. DisplayPort - 3 szt.');
INSERT INTO gpus (Brand,Name, Clock_speed, RAM_capacity, RAM_type, Output)
VALUES ('Gigabyte','GeForce GTX1660', 1860, 6, 'GDDR5', 'HDMI - 1 szt. DisplayPort - 3 szt.');
INSERT INTO gpus (Brand,Name, Clock_speed, RAM_capacity, RAM_type, Output)
VALUES ('Gigabyte','GeForce GTX1660 SUPER', 1860, 6, 'GDDR6', 'HDMI - 1 szt. DisplayPort - 3 szt.');
INSERT INTO gpus (Brand,Name, Clock_speed, RAM_capacity, RAM_type, Output)
VALUES ('Gigabyte','GeForce GTX2060', 1755, 6, 'GDDR6', 'HDMI - 1 szt. DisplayPort - 3 szt.');
INSERT INTO gpus (Brand,Name, Clock_speed, RAM_capacity, RAM_type, Output)
VALUES ('MSI','GeForce GTX2060', 1830, 6, 'GDDR6', 'HDMI - 1 szt. DisplayPort - 3 szt.');
INSERT INTO gpus (Brand,Name, Clock_speed, RAM_capacity, RAM_type, Output)
VALUES ('Gigabyte','GeForce GTX1650', 1755, 4, 'GDDR6', 'HDMI - 1 szt. DVI - 1 szt. DisplayPort - 1 szt.');
INSERT INTO gpus (Brand,Name, Clock_speed, RAM_capacity, RAM_type, Output)
VALUES ('MSI','GeForce GTX2070 SUPER', 1800, 8, 'GDDR6', 'HDMI - 1 szt. DisplayPort - 3 szt.');
INSERT INTO gpus (Brand,Name, Clock_speed, RAM_capacity, RAM_type, Output)
VALUES ('MSI','Radeon RX580', 1800, 8, 'GDDR5', 'HDMI - 2 szt. DVI - 1 szt. DisplayPort - 2 szt.');
INSERT INTO gpus (Brand,Name, Clock_speed, RAM_capacity, RAM_type, Output)
VALUES ('MSI','GeForce GTX1050 Ti', 1379, 4, 'GDDR5', 'HDMI - 1 szt. DVI - 1 szt. DisplayPort - 1 szt.');
INSERT INTO gpus (Brand,Name, Clock_speed, RAM_capacity, RAM_type, Output)
VALUES ('XFX','Radeon RX570', 1286, 8, 'GDDR5', 'HDMI - 1 szt. DVI - 1 szt. DisplayPort - 3 szt.');
INSERT INTO gpus (Brand,Name, Clock_speed, RAM_capacity, RAM_type, Output)
VALUES ('Gainward','GeForce GTX2070 SUPER', 1770, 8, 'GDDR6', 'HDMI - 1 szt. DisplayPort - 3 szt.');
INSERT INTO gpus (Brand,Name, Clock_speed, RAM_capacity, RAM_type, Output)
VALUES ('AMD','Radeon Pro SSG VEGA', 1500, 16, 'HBM2', 'mini DisplayPort - 6 szt.');
INSERT INTO gpus (Brand,Name, Clock_speed, RAM_capacity, RAM_type, Output)
VALUES ('Gigabyte','GeForce RTX 2080 Ti', 1770, 11,'GDDR6', 'HDMI - 3 szt. DisplayPort - 3 szt. USB-C (VirtualLink) - 1 szt.');
INSERT INTO gpus (Brand,Name, Clock_speed, RAM_capacity, RAM_type, Output)
VALUES ('ASUS','GeForce GT 710', 954, 1, 'GDDR5', 'HDMI - 1 szt. DVI - 1 szt. VGA (D-Sub) - 1 szt.');
INSERT INTO gpus (Brand,Name, Clock_speed, RAM_capacity, RAM_type, Output)
VALUES ('PNY','GeForce GT 1030', 1500, 2, 'GDDR5', 'HDMI - 1 szt. DVI - 1 szt.');
INSERT INTO gpus (Brand,Name, Clock_speed, RAM_capacity, RAM_type, Output)
VALUES ('ASRock','Radeon RX 5700XT', 1810, 8,'GDDR6', 'HDMI - 2 szt. DisplayPort - 4 szt.');
INSERT INTO gpus (Brand,Name, Clock_speed, RAM_capacity, RAM_type, Output)
VALUES ('Sapphire','Radeon RX 5500XT', 1737, 4,'GDDR6', 'HDMI - 1 szt. DisplayPort - 3 szt.');
INSERT INTO gpus (Brand,Name, Clock_speed, RAM_capacity, RAM_type, Output)
VALUES ('ASRock','Radeon RX 5600XT ', 1235, 6,'GDDR6', 'HDMI - 1 szt. DisplayPort - 3 szt.');
INSERT INTO gpus (Brand,Name, Clock_speed, RAM_capacity, RAM_type, Output)
VALUES ('PNY','GeForce RTX 2080 SUPER', 1650, 8,'GDDR6', 'HDMI - 1 szt. DisplayPort - 3 szt.');


##### Dyski Twarde #####


INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Toshiba', 'P300', 'HDD', 1000, NULL, NULL, 7200,'SATA III (6 Gbit/s)');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Seagate', 'BARRACUDA', 'HDD', 1000, NULL, NULL, 7200,'SATA III (6 Gbit/s)');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('WD', 'BLUE', 'HDD', 1000, NULL, NULL, 7200,'SATA III (6 Gbit/s)');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('WD', 'RED', 'HDD', 4000, NULL, NULL, 5400,'SATA III (6 Gbit/s)');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Toshiba', 'P300', 'HDD', 2000, NULL, NULL, 7200,'SATA III (6 Gbit/s)');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Toshiba', 'P300', 'HDD', 2000, NULL, NULL, 7200,'SATA III (6 Gbit/s)');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('WD', 'BLUE', 'HDD', 2000, NULL, NULL, 5400,'SATA III (6 Gbit/s)');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Toshiba', 'P300', 'HDD', 3000, NULL, NULL, 7200,'SATA III (6 Gbit/s)');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Toshiba', 'L200', 'HDD', 1000, NULL, NULL, 5400,'SATA III (6 Gbit/s)');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Plextor', 'M8VC', 'SSD', 512, 560, 520, NULL,'SATA III (6 Gbit/s)');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('GOODRAM', 'CL100', 'SSD', 480, 550, 460, NULL,'SATA III (6 Gbit/s)');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('ADATA', 'SX8200', 'SSD', 512, 3500, 2300, NULL,'M.2 PCIe NVMe 3.0 x4');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Crucial', 'BX500', 'SSD', 240, 540, 500, NULL,'SATA III (6 Gbit/s)');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Crucial', 'MX500', 'SSD', 500, 560, 510, NULL,'SATA III (6 Gbit/s)');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Samsung', 'EVO860', 'SSD', 500, 550, 520, NULL,'SATA III (6 Gbit/s)');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('PNY', 'CS900', 'SSD', 240, 535, 500, NULL,'SATA III (6 Gbit/s)');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Plextor', 'M9PGN', 'SSD', 512, 3200, 2000, NULL,'M.2 PCIe NVMe 3.0 x4');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Silicon Power', 'A55', 'SSD', 256, 3400, 3000, NULL,'M.2 PCIe NVMe 3.0 x4');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Crucial', 'P1', 'SSD', 1024, 2000, 1700, NULL,'M.2 PCIe NVMe 3.0 x4');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Patriot', 'VPN100', 'SSD', 2048, 3100, 3000, NULL,'M.2 PCIe NVMe 3.0 x4');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Corsair', 'MP600', 'SSD', 2048, 4950, 4250, NULL,'M.2 PCIe NVMe 3.0 x4');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Intel', '660p', 'SSD', 2048, 1800, 1800, NULL,'M.2 PCIe NVMe 3.0 x4');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Silicon Power', 'A60', 'SSD', 1024, 2200, 1600, NULL,'M.2 PCIe NVMe 3.0 x4');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Samsung', 'EVO970', 'SSD', 1024, 3500, 3300, NULL,'M.2 PCIe NVMe 3.0 x4');


##### Płyty główne #####


INSERT INTO mainboards (Brand, Name, CPU_model_socket, Chipset, LED, Max_RAM)
VALUES ('MSI', 'B450 GAMING PLUS MAX', 'AM4', 'AMD B450', false,64);
INSERT INTO mainboards (Brand, Name, CPU_model_socket, Chipset, LED, Max_RAM)
VALUES ('Gigabyte', 'B450 AORUS ELITE', 'AM4', 'AMD B450', true,64);
INSERT INTO mainboards (Brand, Name, CPU_model_socket, Chipset, LED, Max_RAM)
VALUES ('MSI', 'B450-A PRO MAX', 'AM4', 'AMD B450', true,64);
INSERT INTO mainboards (Brand, Name, CPU_model_socket, Chipset, LED, Max_RAM)
VALUES ('MSI', 'MPG Z390 GAMING PLUS', '1151', 'Intel Z390', false,128);
INSERT INTO mainboards (Brand, Name, CPU_model_socket, Chipset, LED, Max_RAM)
VALUES ('Gigabyte', 'Z390 GAMING X', '1151', 'Intel Z390', false,128);
INSERT INTO mainboards (Brand, Name, CPU_model_socket, Chipset, LED, Max_RAM)
VALUES ('ASUS', 'TUF GAMING X570-PLUS', 'AM4', 'AMD X570', true,128);
INSERT INTO mainboards (Brand, Name, CPU_model_socket, Chipset, LED, Max_RAM)
VALUES ('ASUS', 'PRIME B450M-A', 'AM4', 'AMD B450', true,64);
INSERT INTO mainboards (Brand, Name, CPU_model_socket, Chipset, LED, Max_RAM)
VALUES ('Gigabyte', 'B450 AORUS PRO', 'AM4', 'AMD B450', false,64);
INSERT INTO mainboards (Brand, Name, CPU_model_socket, Chipset, LED, Max_RAM)
VALUES ('Gigabyte', 'B365M D3H', '1151', 'Intel B365', false,64);
INSERT INTO mainboards (Brand, Name, CPU_model_socket, Chipset, LED, Max_RAM)
VALUES ('ASUS', 'ROG MAXIMUS XI EXTREME', '1151', 'Intel Z390', true,64);
INSERT INTO mainboards (Brand, Name, CPU_model_socket, Chipset, LED, Max_RAM)
VALUES ('Gigabyte', 'X299X AORUS MASTER', '2066', 'Intel X299', true,256);
INSERT INTO mainboards (Brand, Name, CPU_model_socket, Chipset, LED, Max_RAM)
VALUES ('MSI', 'TRX40 PRO 10G', 'sTRX4', 'AMD TRX40', false,256);
INSERT INTO mainboards (Brand, Name, CPU_model_socket, Chipset, LED, Max_RAM)
VALUES ('ASUS', 'WS Z390 PRO', '1151', 'Intel Z390', true,128);
INSERT INTO mainboards (Brand, Name, CPU_model_socket, Chipset, LED, Max_RAM)
VALUES ('Gigabyte', 'GA-A320M-H', 'AM4', 'AMD A320', true, 32);


##### Zasilacze #####

INSERT INTO power_supply_units (Brand, Name, DC_Output, Efficiency)
VALUES ('SilentiumPC', 'Vero L2', 500, 87);
INSERT INTO power_supply_units (Brand, Name, DC_Output, Efficiency)
VALUES ('SilentiumPC', 'Vero L2', 600, 87);
INSERT INTO power_supply_units (Brand, Name, DC_Output, Efficiency)
VALUES ('SilentiumPC', 'Elementum E2', 550, 88);
INSERT INTO power_supply_units (Brand, Name, DC_Output, Efficiency)
VALUES ('SilentiumPC', 'Supremo FM2', 750, 92);
INSERT INTO power_supply_units (Brand, Name, DC_Output, Efficiency)
VALUES ('be quiet!', 'System Power 9', 600, 89);
INSERT INTO power_supply_units (Brand, Name, DC_Output, Efficiency)
VALUES ('be quiet!', 'System Power 11', 750, 94);
INSERT INTO power_supply_units (Brand, Name, DC_Output, Efficiency)
VALUES ('be quiet!', 'System Power 11', 650, 91);
INSERT INTO power_supply_units (Brand, Name, DC_Output, Efficiency)
VALUES ('Seasonic', 'Focus GX', 650, 90);
INSERT INTO power_supply_units (Brand, Name, DC_Output, Efficiency)
VALUES ('Corsair', 'RMx', 650, 90);
INSERT INTO power_supply_units (Brand, Name, DC_Output, Efficiency)
VALUES ('Gigabyte', 'G750H', 750, 90);
INSERT INTO power_supply_units (Brand, Name, DC_Output, Efficiency)
VALUES ('Corsair', 'HX750i', 750, 93);
INSERT INTO power_supply_units (Brand, Name, DC_Output, Efficiency)
VALUES ('Chieftec', 'GPE-700S', 700, 80);


##### RAM #####

INSERT INTO rams (Brand, Name, RAM_type, RAM_capacity, Number_of_items, Clock_speed)
VALUES ('G.SKILL', 'FlareX Black Ryzen', 'DDR4', 16, 2, 3200);
INSERT INTO rams (Brand, Name, RAM_type, RAM_capacity, Number_of_items, Clock_speed)
VALUES ('G.SKILL', 'Trident Z', 'DDR4', 16, 2, 3000);
INSERT INTO rams (Brand, Name, RAM_type, RAM_capacity, Number_of_items, Clock_speed)
VALUES ('G.SKILL', 'CL16 Aegis', 'DDR4', 8, 1, 2400);
INSERT INTO rams (Brand, Name, RAM_type, RAM_capacity, Number_of_items, Clock_speed)
VALUES ('GOODRAM', 'IRIDIUM Black', 'DDR4', 8, 1, 2133);
INSERT INTO rams (Brand, Name, RAM_type, RAM_capacity, Number_of_items, Clock_speed)
VALUES ('GOODRAM', 'IRDM X White', 'DDR4', 16, 2, 3000);
INSERT INTO rams (Brand, Name, RAM_type, RAM_capacity, Number_of_items, Clock_speed)
VALUES ('Patriot', 'Viper RGB LED Black', 'DDR4', 16, 2, 3200);
INSERT INTO rams (Brand, Name, RAM_type, RAM_capacity, Number_of_items, Clock_speed)
VALUES ('GOODRAM', 'IRDM X Black', 'DDR4', 8, 1, 2666);
INSERT INTO rams (Brand, Name, RAM_type, RAM_capacity, Number_of_items, Clock_speed)
VALUES ('GOODRAM', 'Iridium Black', 'DDR4', 8, 1, 3000);
INSERT INTO rams (Brand, Name, RAM_type, RAM_capacity, Number_of_items, Clock_speed)
VALUES ('Corsair', 'Vengeance LPX Black', 'DDR4', 8, 1, 2666);
INSERT INTO rams (Brand, Name, RAM_type, RAM_capacity, Number_of_items, Clock_speed)
VALUES ('G.SKILL', 'Ripjaws V', 'DDR4', 64, 4, 3200);
INSERT INTO rams (Brand, Name, RAM_type, RAM_capacity, Number_of_items, Clock_speed)
VALUES ('G.SKILL', 'TridentZ Royal Silver', 'DDR4', 16, 2, 4600);
INSERT INTO rams (Brand, Name, RAM_type, RAM_capacity, Number_of_items, Clock_speed)
VALUES ('HyperX', 'Predator RGB', 'DDR4', 16, 2, 3200);
INSERT INTO rams (Brand, Name, RAM_type, RAM_capacity, Number_of_items, Clock_speed)
VALUES ('HyperX', 'Predator RGB', 'DDR3', 8, 1, 3200);
INSERT INTO rams (Brand, Name, RAM_type, RAM_capacity, Number_of_items, Clock_speed)
VALUES ('GOODRAM', '-', 'DDR3', 4, 1, 1333);
INSERT INTO rams (Brand, Name, RAM_type, RAM_capacity, Number_of_items, Clock_speed)
VALUES ('HyperX', 'Fury Red', 'DDR3', 16, 2, 1600);
INSERT INTO rams (Brand, Name, RAM_type, RAM_capacity, Number_of_items, Clock_speed)
VALUES ('HyperX', 'Fury White', 'DDR3', 4, 1, 1600);
INSERT INTO rams (Brand, Name, RAM_type, RAM_capacity, Number_of_items, Clock_speed)
VALUES ('Patriot ', '-', 'DDR3', 4, 1, 1600);
INSERT INTO rams (Brand, Name, RAM_type, RAM_capacity, Number_of_items, Clock_speed)
VALUES ('Corsair', 'Vengeance XMP Black', 'DDR3', 16, 2, 1600);
INSERT INTO rams (Brand, Name, RAM_type, RAM_capacity, Number_of_items, Clock_speed)
VALUES ('G.SKILL', 'RipjawsX', 'DDR3', 8, 2, 1600);
INSERT INTO rams (Brand, Name, RAM_type, RAM_capacity, Number_of_items, Clock_speed)
VALUES ('Crucial', 'Ballistix Sport', 'DDR3', 8, 2, 1600);


##### Ekrany ####


INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('AOC', 'Monitor', '1920 x 1080 (FullHD)', 23.8, 'IPS', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('Dell', 'Monitor', '1920 x 1080 (FullHD)', 23.8, 'IPS', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('ASUS', 'Monitor', '1920 x 1080 (FullHD)', 21.5, 'IPS', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('HP', 'Monitor', '1920 x 1080 (FullHD)', 23.8, 'IPS', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('Acer', 'Monitor', '2560 x 1440 (WQHD)', 27.0, 'VA', true);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('Acer', 'Monitor', '1920 x 1080 (FullHD)', 27.0, 'TN', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('Acer', 'Monitor', '1920 x 1080 (FullHD)', 23.8, 'IPS', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('Iiyama', 'Monitor', '1920 x 1080 (FullHD)', 24.5, 'TN', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('Eizo', 'Monitor', '1920 x 1080 (FullHD)', 23.8, 'IPS', true);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('Samsung', 'Monitor', '2560 x 1440 (WQHD)', 27.0, 'VA', true);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('AOC', 'Monitor', '1920 x 1080 (FullHD)', 24.0, 'VA', true);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('Dell', 'Monitor', '2560 x 1440 (WQHD)', 25.0, 'IPS', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('AOC', 'Monitor', '1280 x 1024 (SXGA)', 17.0, 'TN', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('ASUS', 'Monitor', '1280 x 1024 (SXGA)', 19.0, 'IPS', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('Dell', 'Monitor', '1280 x 1024 (SXGA)', 19.0, 'IPS', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('Iiyama', 'Monitor', '1280 x 1024 (SXGA)', 19.0, 'IPS', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('MSI', 'Monitor', '3840 x 2160 (UHD 4K)', 31.0, 'VA', true);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('Acer', 'Monitor', '3840 x 2160 (UHD 4K)', 27.0, 'VA', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('Philips', 'Monitor', '3840 x 2160 (UHD 4K)', 31.5, 'VA', true);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('Philips', 'TV', '3840 x 2160 (UHD 4K)', 50.0, 'LED', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('Philips', 'TV', '3840 x 2160 (UHD 4K)', 65.0, 'OLED', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('Samsung', 'TV', '3840 x 2160 (UHD 4K)', 49.0, 'QLED', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('LG', 'TV', '3840 x 2160 (UHD 4K)', 55.0, 'LED', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('Sony', 'TV', '3840 x 2160 (UHD 4K)', 55.0, 'LED', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('Sony', 'TV', '3840 x 2160 (UHD 4K)', 85.0, 'LED', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('LG', 'TV', '1920 x 1080 (FullHD)', 43.0, 'LED', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('Sony', 'TV', '3840 x 2160 (UHD 4K)', 43.0, 'LED', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('Philips', 'TV', '3840 x 2160 (UHD 4K)', 70.0, 'LED', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('Philips', 'TV', '3840 x 2160 (UHD 4K)', 55.0, 'OLED', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('', 'Notebook', '3840 x 2160 (UHD 4K)', 17.3, 'IPS', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('', 'Notebook', '3840 x 2160 (UHD 4K)', 15.6, 'IPS', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('', 'Notebook', '3840 x 2160 (UHD 4K)', 14.0, 'IPS', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('', 'Notebook', '3840 x 2160 (UHD 4K)', 14.1, 'IPS', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('', 'Notebook', '3840 x 2160 (UHD 4K)', 13.3, 'IPS', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('', 'Notebook', '3840 x 2160 (UHD 4K)', 17.3, 'TN', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('', 'Notebook', '3840 x 2160 (UHD 4K)', 15.6, 'TN', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('', 'Notebook', '3840 x 2160 (UHD 4K)', 14.0, 'TN', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('', 'Notebook', '3840 x 2160 (UHD 4K)', 14.1, 'TN', false);
INSERT INTO screens (Brand, Type, Resolution, Display_size, Display_technology, Curved)
VALUES ('', 'Notebook', '3840 x 2160 (UHD 4K)', 13.3, 'TN', false);

###### Specyfikacje #####

INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (1,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (2,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (3,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (4,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (5,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (6,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (7,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (8,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (9,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (10,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (11,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (12,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (13,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (14,NULL,NULL,NULL,NULL,NULL,NULL);

INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,1,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,2,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,3,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,4,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,5,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,6,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,7,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,8,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,9,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,10,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,11,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,12,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,13,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,14,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,15,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,16,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,17,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,18,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,19,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,20,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,21,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,22,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,23,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,24,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,25,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,26,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,27,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,28,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,29,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,30,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,31,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,32,NULL,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,33,NULL,NULL,NULL,NULL,NULL);


INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,1,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,2,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,3,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,4,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,5,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,6,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,7,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,8,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,9,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,10,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,11,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,12,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,13,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,14,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,15,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,16,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,17,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,18,NULL,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,19,NULL,NULL,NULL,NULL);

INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,1,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,2,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,3,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,4,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,5,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,6,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,7,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,8,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,9,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,10,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,11,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,12,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,13,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,14,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,15,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,16,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,17,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,18,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,19,NULL,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,20,NULL,NULL,NULL);


INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,1,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,2,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,3,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,4,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,5,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,6,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,7,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,8,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,9,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,10,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,11,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,12,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,13,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,14,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,15,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,16,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,17,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,18,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,19,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,20,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,21,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,22,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,23,NULL,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,24,NULL,NULL);

INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,1,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,2,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,3,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,4,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,5,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,6,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,7,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,8,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,9,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,10,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,11,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,12,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,13,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,14,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,15,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,16,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,17,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,18,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,19,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,20,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,21,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,22,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,23,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,24,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,25,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,26,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,27,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,28,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,29,NULL);

INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,NULL,1);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,NULL,2);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,NULL,3);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,NULL,4);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,NULL,5);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,NULL,6);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,NULL,7);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,NULL,8);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,NULL,9);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,NULL,10);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,NULL,11);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,NULL,NULL,NULL,NULL,NULL,12);

###### Specyfikacje laptopów #####

# i9 9
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,2,4,1,16,35,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,2,7,2,24,31,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,2,13,5,9,35,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,2,19,6,5,36,NULL);

#i7 8
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,8,7,11,7,30,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,8,4,15,13,31,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,8,13,18,23,31,NULL);

#i7 7
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,7,6,19,14,36,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,7,9,6,8,35,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,7,6,9,16,30,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,7,9,18,1,35,NULL);

#i5 8

INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,12,9,20,10,38,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,12,17,19,16,30,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,12,18,13,19,35,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,12,9,5,23,33,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,12,17,12,7,31,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,12,5,7,10,33,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,12,5,4,23,38,NULL);



#i5 7
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,13,15,4,24,30,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,13,10,13,23,30,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,13,17,6,9,33,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,13,10,11,23,35,NULL);

#i3 9

INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,16,15,19,14,39,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,16,6,4,2,33,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,16,10,15,1,33,NULL);


#i3 8
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,15,15,9,22,38,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,15,6,8,6,36,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,15,3,11,11,38,NULL);

#ryzen 9

INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,23,19,2,19,31,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,22,8,6,16,36,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,23,8,12,2,31,NULL);


#ryzen 7

INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,25,16,18,23,36,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,26,11,1,9,30,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,27,8,5,19,36,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,25,11,20,19,30,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,26,13,6,17,33,NULL);

#ryzen 5

INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,29,1,20,20,35,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,29,2,13,2,36,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,29,17,8,1,31,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,30,1,4,18,31,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,30,2,11,2,30,NULL);


#ryzen 3

INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,32,1,8,10,33,NULL);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (NULL,33,17,14,11,35,NULL);


##### Specyfikacje Komputerów #####

INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (3,19,8,10,2,NULL,12);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (12,2,18,18,22,NULL,8);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (5,30,13,11,14,NULL,9);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (2,4,8,2,24,NULL,10);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (1,18,16,4,14,NULL,8);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (3,32,15,9,20,NULL,1);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (5,3,19,18,9,NULL,12);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (13,30,15,1,20,NULL,6);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (9,25,7,10,19,NULL,12);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (4,6,19,18,16,NULL,2);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (10,15,3,19,21,NULL,4);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (12,32,16,11,6,NULL,1);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (9,13,10,8,11,NULL,12);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (6,8,7,9,16,NULL,9);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (4,32,17,7,22,NULL,8);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (2,23,10,8,23,NULL,3);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (7,11,9,4,2,NULL,8);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (6,7,10,15,15,NULL,12);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (14,22,16,16,11,NULL,1);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (4,15,4,8,24,NULL,9);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (5,18,7,14,4,NULL,5);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (13,33,11,2,9,NULL,11);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (10,2,6,8,21,NULL,5);
INSERT INTO specyfications (mainboard, CPU, GPU, RAM, Hard_drive, Screen, Power_supply_unit)
VALUES (12,21,13,19,11,NULL,2);


##### płyty główne #####

INSERT INTO products (Category, Price, Brand, On_stock, Description, Rating, specyficationsID)
VALUES ('Płyty główne', 529.00, 'MSI', 30,
        'MSI B450 GAMING PLUS MAX -
Wykorzystaj wydajność procesorów AMD Ryzen 3. lub 2. generacji oraz modułów RAM DDR4 o taktowaniu nawet 4133 MHz (w trybie OC) z płytą główną MSI B450 GAMING PLUS MAX. Podłącz do niej najwydajniejsze komponenty, skorzystaj z wbudowanych w CPU układów graficznych lub stwórz konfigurację wielu kart graficznych AMD CrossFire. Wybór należy do Ciebie.',
        4.5, 1);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Płyty główne', 499.00, 'Gigabyte', 16, 'Gigabyte B450 AORUS ELITE -
Wybierz sprzęt nie wymuszający żadnych kompromisów i dołącz do elitarnego grona posiadaczy sprzętu sygnowanego marką AORUS. Oferowana płyta główna, napędzana chipsetem B450, umożliwia wykorzystanie procesorów AMD Ryzen 2. generacji oraz zintegrowanych z nimi układów graficznych AMD Vega. Cztery sloty DIMM obsłużą moduły DDR4 o taktowaniu nawet 3200 MHz (O.C.), a slot M.2 umożliwi podłączenia najszybszych dysków SSD na rynku.',
      4.3 ,2 );
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Płyty główne', 519.00, 'MSI', 6,'MSI B450-A PRO MAX
Najlepsza jakość, wysoką wydajność oraz sprytne rozwiązania dla biznesu, aby spełnić oczekiwania najbardziej wymagających profesjonalistów. To cechy płyt głównych MSI z serii PRO, takich jak B450-A PRO MAX. Umożliwi Ci ona wykorzystanie w swojej firmie procesorów AMD Ryzen 3. i 2. generacji, wspieranych przez moduły RAM DDR4 o taktowaniu nawet 4133 MHz (OC). Ponadto, możesz wykorzystać układy graficzne AMD Vega wbudowane w procesory Ryzen lub połączyć dwie karty graficzne w konfiguracji AMD CrossFire.' ,
        4.7, 3);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Płyty główne', 599.00, 'MSI', 3, 'Odkryj MSI MPG Z390 GAMING PLUS w 360 stopniach
Wejdź na nowy poziom gamingu wykorzystując procesory Intel Core 8. i 9. generacji, których obsługę umożliwi płyta główna MPG Z390 GAMING PLUS. Ponadto, pozwoli Ci ona skorzystać z pamięci RAM DDR4 o taktowaniu nawet 4400 MHz, ultra wydajnych dysków SSD M.2 oraz konfiguracji wielu kart graficznych AMD CrossFire. Agresywna kolorystyka oraz czerwone podświetlenie z łatwością odnajdą się we wnętrzu każdego gamingowego komputera. A dzięki połączeniu wszystkich dotychczasowych aplikacji MSI w centrum sterowania Dragon Center, możesz zarządzać wszystkimi aspektami systemu z poziomu jednego interfejsu.',
        4.0, 4);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Płyty główne', 659.00, 'Gigabyte', 50, 'Odkryj Gigabyte Z390 GAMING X w 360 stopniach
Z procesorami Intel Core 8. i 9. generacji zyskasz wyjątkową wydajność na potrzeby gier. Wystarczy tylko, że umieścisz je w solidnej podstawie, jaką jest Gigabyte Z390 GAMING X. Ta bogata w funkcjonalności płyta główna pozwala na obsługę modułów RAM DDR4 o taktowaniu nawet 4000 MHz (O.C.), a także zbudowanie konfiguracji wielu kart graficznych AMD CrossFire. Z kolei dyskretne podświetlenie nada Twojej obudowie stylowego blasku.',
        4.6, 5);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Płyty główne', 889.00, 'ASUS', 10, 'Odkryj ASUS TUF GAMING X570-PLUS w 360 stopniach
Dzięki nowej platformie opartej na chipsecie X570 będziesz w stanie wykorzystać moc nowych procesorów AMD Ryzen 2. i 3. generacji. ASUS TUF GAMING X570-PLUS łączy w sobie wysokiej klasy wykonanie o komponenty klasy militarnej, by zagwarantować Ci niezrównaną wydajność i stabilność na potrzeby gier. Jednocześnie, będziesz w stanie skorzystać z wielu nowoczesnych rozwiązań, takich wydajny układ chłodzenia czy obsługa szybkich nośników SSD M.2.',
        3.9, 6);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Płyty główne', 399.00, 'ASUS', 31, 'Odkryj ASUS PRIME B450M-A w 360 stopniach
Płyty główne ASUS z serii PRIME zawierają w sobie najważniejsze rozwiązania i technologie, pozwalające zbudować wydajny i przystępny komputer. PRIME B450M-A obsługuje procesory AMD Ryzen 2. generacji oraz moduły RAM DDR4 o taktowaniu nawet 3200 MHz (OC). Płyta pozwala też na skorzystanie ze zintegrowanych z CPU układów graficznych AMD Vega, dzięki wbudowanym złączom HDMI, DVI oraz VGA. Zapewnia przy tym wiele technologii poprawiających bezpieczeństwo i chłodzenie całego komputera.',
        3.7, 7);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Płyty główne', 549.00, 'Gigabyte', 19, 'Gigabyte B450 AORUS PRO
Wykorzystaj w pełni wydajność procesorów AMD Ryzen 2. generacji, z płyta główną B450 AORUS PRO. Dzięki złączom wideo możesz użyć zintegrowanego z CPU układu graficznego AMD Vega lub podłączyć zewnętrzne karty graficzne, również w konfiguracji AMD CrossFire. Podłącz moduły RAM DDR4 o taktowaniu nawet 3200 MHz oraz ultra wydajne dyski SSD do złączy M.2. Wielostrefowe podświetlenie LED nada Twojemu komputerowi stylowego blasku.',
        4.5, 8);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Płyty główne', 399.00, 'Gigabyte', 22, 'Gigabyte B365M D3H
Przystępna i oferująca wiele funkcji płyta główna Gigabyte B365M D3H pozwoli Ci wykorzystać wydajność oferowaną przez procesory Intel 8. i 9. generacji. Wbudowane porty wideo dodatkowo pozwolą skorzystać z wbudowanego CPU układu graficznego. Rozmaite opcje składowania danych oraz łączności z peryferiami pozwolą Ci stworzyć komputer dopasowany do Twoich potrzeb. Zarówno na potrzeby gier, jak i codziennych zadań.',
        4.8, 9);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Płyty główne', 2399.00, 'ASUS', 3, 'ASUS ROG MAXIMUS XI EXTREME
Sięgnij po ekstremalną wydajność. ROG MAXIMUS XI EXTREME to potężna konstrukcja, dzięki której wykorzystasz maksimum możliwości procesorów Intel Core 8. i 9. generacji. Możesz mieć pewność absolutnej stabilności pracy wszystkich podzespołów, nawet pod wysokim obciążeniem.

Podkręcaj osiągi jednym kliknięciem, ciesz się połączeniem sieciowym o przepustowości nawet 5 Gb/s, chłódź cały system z niespotykaną wydajnością oraz dostosowuj wygląd płyty głównej do swojego własnego gustu. Wybór należy do Ciebie.',
        0.0, 10);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Płyty główne', 49.00, 'Gigabyte', 4, 'Gigabyte X299X AORUS MASTER
X299X AORUS MASTER to mistrzowska konstrukcja, która wyzwala pełnię mocy procesorów Intel Core X-series oraz modułów RAM DDR4 o taktowaniu nawet 4333 MHz (OC). Możesz również skorzystać z wyjątkowej wydajności oferowanej przez złącza dla dysków M.2, a także połączyć wiele kart graficznych w konfiguracjach NVIDIA SLI lub AMD CrossFire. A dzięki technologii RGB Fusion 2.0 przejmiesz kontrolę nie tylko nad podświetleniem płyty głównej, ale też wszystkich zgodnych podzespołów.',
        0.0,11);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Płyty główne', 2299.00, 'MSI', 1, 'MSI TRX40 PRO 10G
Sięgnij po potężne, wielordzeniowe procesory AMD Ryzen Threadripper, dodaj nawet 8 modułów DIMM DDR4 oraz wykorzystaj interfejs PCI-E 4.0 do podłączenia nowoczesnych kart graficznych i dysków SSD NVMe. Płyta główna MSI TRX40 PRO 10G oferuje szereg technologii pozwalających w pełni wykorzystać wydajne podzespoły na potrzeby rozmaitych zastosowań. Ponadto w zestawie znajdują się dwie karty rozszerzeń, poszerzające jej możliwości.',
        0.0,12);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Płyty główne', 1899.00, 'ASUS', 7, 'ASUS WS Z390 PRO
Płyta główna ASUS WS Z390 PRO została zaprojektowana z myślą o zadaniach intensywnie obciążających zasoby systemu i zapewnia ogromny potencjał przetwarzania grafiki w połączeniu z szerokim zestawem opcji dostrajania oraz niezawodnymi opcjami połączeń dla prosumentów i twórców treści.

Wykorzystaj moc procesorów Intel 8. lub 9. generacji, wykorzystaj moduły RAM DDR4 o taktowaniu nawet 4266 MHz oraz podłącz najlepsze podzespoły, które pomogą Ci w codziennej pracy.',
        3.5, 13);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Płyty główne', 239.00, 'Gigabyte', 29, 'Gigabyte GA-A320M-H
Sięgnij po wydajność procesorów AMD oraz płytą główną Gigabyte GA-A320M-H. Dzięki podstawce AM4, wspiera ona 7 generację CPU A-Series/Athlon, a także jednostki AMD Ryzen. Możesz dzięki temu korzystać z szybkiej pamięci RAM DDR4 o taktowaniu nawet 3200 MHz (w trybie OC). Wykorzystaj również grafikę zintegrowaną w procesorze oraz dwa wyjścia płyty głównej (HDMI, DVI), aby podłączyć własne wyświetlacze, bez konieczności stosowania osobnej karty graficznej. Port HDMI wspiera przy tym rozdzielczość 4K.',
        3.9, 14);

##### procesory #####

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 9399.00, 'Intel', 3, 'Intel Core i9-7980X
Poznaj najbardziej zaawansowane narzędzie do obsługi gier i wirtualnej rzeczywistości, jakie możesz otrzymać. Procesor Intel® Core™ i9-7940X posiada 18 rdzeni i 36 wątków oraz taktowanie rdzenia na poziomie 2.60 GHz z dużym zapasem mocy, przez co jest jednym z najszybszych układów Intel''a w historii. Ponadto model ten został wyposażony cztero-kanałowy kontroler pamięci RAM typu DDR4-2666 i może obsłużyć moduły o łącznej pojemności do 128 GB. Dzięki niemu możesz zmienić komputer w profesjonalne studio do obróbki niezwykłych filmów w formacie 4K i filmów sferycznych, nadzwyczajnej jakości zdjęć lub niesamowitej muzyki.',
       5.0, 15 );

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 2149.00, 'Intel', 22, 'Intel Core i9-9900
Poznaj nowy procesor Intel® Core™ dziewiątej generacji do komputerów stacjonarnych. i9-9900 zapewnia maksymalną wydajność i bezkompromisową rozgrywkę dzięki ośmiu fizycznym rdzeniom 3,1 GHz. Częstotliwość turbo do 5 GHz i 16-wątkowa praca wielozadaniowa pozwalają osiągnąć nowy poziom kreatywności. Uwolnij moc procesora Intel Core i9-9900 i przenieś wydajność na nowy poziom.',
        4.4, 16);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 2799.00, 'Intel', 13, 'Intel Core i9-9900X
Poznaj najbardziej zaawansowane narzędzie do obsługi gier i wirtualnej rzeczywistości, jakie możesz otrzymać. Procesor Intel® Core™ i9-9900X posiada 10 rdzeni i 20 wątków oraz taktowanie rdzenia na poziomie 3.50 GHz z dużym zapasem mocy, przez co jest jednym z najszybszych układów Intel''a w historii. Ponadto model ten został wyposażony cztero-kanałowy kontroler pamięci RAM typu DDR4-2666 i może obsłużyć moduły o łącznej pojemności do 128 GB. Dzięki niemu możesz zmienić komputer w profesjonalne studio do obróbki niezwykłych filmów w formacie 4K i filmów sferycznych, nadzwyczajnej jakości zdjęć lub niesamowitej muzyki.',
        0.0, 17);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 2999.00, 'Intel', 13, 'Procesor Intel Core i9-10900X
Intel® Core™ i9-10900X wyznacza nowe standardy wydajności i został zaprojektowany z myślą o zaawansowanych pracach twórczych o zróżnicowanych wymaganiach, takich jak edycja zdjęć i filmów, efekty wizualne, ruchoma grafika, projektowanie gier i animacja 3D. Procesor Intel® Core™ i9-10900X posiada 10 rdzeni i 20 wątków oraz bazowe taktowanie rdzenia na poziomie 3.70 GHz, mogące dochodzić do 4,50 GHz w trybie Boost.

Ponadto model ten został wyposażony czterokanałowy kontroler pamięci RAM typu DDR4-2933 i może obsłużyć moduły o łącznej pojemności nawet 256 GB. Dzięki Intel® Core™ i9-10900X możesz zmienić komputer w profesjonalne studio do obróbki niezwykłych filmów w formacie 4K i filmów sferycznych, nadzwyczajnej jakości zdjęć lub niesamowitej muzyki.',
        0.0, 18);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 6599.00, 'Intel', 2,'Intel Core i9-7940X
Poznaj najbardziej zaawansowane narzędzie do obsługi gier i wirtualnej rzeczywistości, jakie możesz otrzymać. Procesor Intel® Core™ i9-7940X posiada 14 rdzeni i 28 wątków oraz taktowanie rdzenia na poziomie 3.10 GHz z dużym zapasem mocy, przez co jest jednym z najszybszych układów Intel''a w historii. Ponadto model ten został wyposażony cztero-kanałowy kontroler pamięci RAM typu DDR4-2666 i może obsłużyć moduły o łącznej pojemności do 128 GB. Dzięki niemu możesz zmienić komputer w profesjonalne studio do obróbki niezwykłych filmów w formacie 4K i filmów sferycznych, nadzwyczajnej jakości zdjęć lub niesamowitej muzyki.',
        4.1, 19);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 1849.00, 'Intel', 14, 'Intel Core i7-9700K
Intel Core i7-9700K wprowadza nowy porządek. Ten stworzony dla wymagających graczy oraz profesjonalistów procesor posiada aż 8 rdzeni fizycznych o bazowym taktowaniu zegara na poziomie 3,6 GHz. Do tego 12 MB pamięci SmartCache oraz obsługa pamięci o taktowaniu nawet 2666 MHz. Z Intel Core i7-9700K możesz więcej.',
        4.3, 20);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 1599.00, 'Intel', 18,'Intel Core i7-7700 3.60 GHz
Przedstawiamy Intel Core i7-7700 3.60 GHz. Procesor siódmej generacji zaprojektowany z myślą o graczach i zastosowaniach profesjonalnych. Dysponuje zoptymalizowaną architekturą Kaby Lake oraz czterema ośmiowątkowymi rdzeniami o taktowaniu 3.60 GHz. Bez trudu poradzi sobie z ustawieniami Ultra w grach, renderowaniem grafik, obróbką zdjęć, a także z montażem filmów. System oraz aplikacje startują szybciej. Ty działasz więc sprawniej, skuteczniej i wydajniej.',
        4.0, 21);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 1699.00, 'Intel', 7,'Intel Core i7-8700
Wybierając procesor Intel Core i7-8700 sięgasz po nowy standard CPU, który wyłamuje się z dotychczasowych schematów. Dostarcza nawet do 40% więcej mocy. Posiada nie 4, ale 6 rdzeni. I nie 8, ale 12 wątków. Dysponuje ponadto 12 MB pamięci cache i może się pochwalić wsparciem dla dwukanałowej pamięci RAM DDR4 2666 MHz. Intel Core i7-8700 gwarantuje dzięki temu szybkość i sprawność do zadań profesjonalnych, w tym do renderowania, projektowania oraz płynnej edycji wideo. Ta ogromna moc jest do Twojej dyspozycji.',
        3.7, 22);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 2899.00, 'Intel', 3, 'Ekstremalna wielozadaniowość
Procesor Intel® Core™ i7-7820X posiada 8 rdzeni i 16 wątków, przez co jest jednym z szybszych układów w historii. Dzięki niemu możesz zmienić komputer w profesjonalne studio do obróbki niezwykłych filmów w formacie 4K i filmów sferycznych, nadzwyczajnej jakości zdjęć lub niesamowitej muzyki. To także najbardziej zaawansowane narzędzie do obsługi gier i wirtualnej rzeczywistości, jakie możesz otrzymać.',
        3.4, 23);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 759.00, 'Intel', 30,'Intel Core i5-9400F 2.90GHz 9MB
Intel Core i5-9400F to zaawansowany procesor 9-tej generacji pozbawiony zintegrowanego układu graficznego. CPU posiada 6 rdzeni, 6 wątków, 9MB pamięci SmartCache oraz częstotliwość bazową 2.90GHz, którą można zwiększyć do 4.10GHz w trybie Turbo. Poczuj moc 9. generacji procesorów Intel Core.',
        4.1, 24);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 999.00, 'Intel', 37, 'Intel Core i5-9600K
Intel Core i5-9600K to zaawansowany procesor stworzony z myślą o profesjonalnych zastosowaniach oraz gamingu na najwyższym poziomie. CPU posiada 6 rdzeni, 6 wątków, 9 MB pamięci SmartCache oraz odblokowany mnożniki, dzięki czemu możesz zwiększyć moc Twojego komputera. Poczuj moc 9. generacji procesorów Intel Core.',
        4.6, 25);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 949.00, 'Intel', 5,'Intel Core i5-8500
Intel Core Coffee Lake to zaawansowana technologicznie platforma, stworzona z myślą o zastosowaniach profesjonalnych. Wybierając Intel Core i5-8500 zyskasz nawet 40% więcej mocy do renderowania, projektowania oraz edycji wideo w 4K. Jednostka posiada 6 rdzeni, 6 wątków i 9 MB pamięci cache, wyłamując się tym samym z dotychczasowych schematów. Kompatybilna jest także z pamięcią RAM DDR4 2666 MHz.

Oto Twoje narzędzie do pracy twórczej. Wykorzystaj je jak najlepiej.',
        4.0, 26);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 969.00, 'Intel', 22,'Intel Core i5-7500 3.40 GHz
Najnowszy procesor Intel Core i5-7500 3.40 GHz to idealne rozwiązanie na rosnące oczekiwania względem wydajności komputerów. Dynamiczna praca, zoptymalizowana architektura Kaby Lake oraz wyższe taktowanie bazowe, które liczy 3.4 GHz, już na starcie dają Ci lepsze wyniki. W rezultacie obsługa programów i multimediów staje się dzięki temu odczuwalnie lepsza. System oraz aplikacje startują szybciej. Ty działasz więc sprawniej, skuteczniej i wydajniej.',
        4.5, 27);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 329.00, 'Intel', 19, 'Intel Core i3-9100F 3.60GHz 6MB BOX
Intel Core i3-9100F to niezwykle wydajny procesor 9-tej generacji, który został pozbawiony zintegrowanego układu graficznego. CPU posiada 4 rdzenie, 4 wątki, 6MB pamięci SmartCache oraz częstotliwość bazową 3.60GHz. Co więcej, dzięki technologii Intel Turbo Boost 2.0 częstotliwość można podkręcić do 4.20GHz, zwiększając wydajność procesora. Poczuj moc 9. generacji procesorów Intel Core.',
        4.1, 28);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 519.00, 'Intel', 11, 'Intel Core i3-8100
Działaj szybciej i sprawniej z procesorem Intel Core i3-8100, należącym do generacji Coffee Lake. Wprowadza ona istotne zmiany w budowie procesorów, gdyż po raz pierwszy w historii jednostka i3 posiada 4 rdzenie i 4 wątki. Zyskasz tym samym nawet 40% więcej mocy do obsługi profesjonalnych programów i zwiększysz swą produktywność. Intel Core i3-8100 posiada także nowy układ graficzny – Intel UHD, który znakomicie radzi sobie z multimediami w rozdzielczości 4K. Twórz i dziel się pomysłami. Teraz to takie proste.',
        4.3, 29);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 629.00, 'Intel', 3,'Intel Core i3-9100
Intel Core i3-9100 to niezwykle wydajny procesor 9-tej generacji, posiadający 4 rdzenie, 4 wątki oraz 6MB pamięci Intel SmartCache. Co więcej, dzięki technologii Intel Turbo Boost 2.0 częstotliwość można podkręcić, zwiększając wydajność procesora. Intel Core i3-9100 posiada także nowy układ graficzny Intel UHD, który znakomicie radzi sobie z multimediami w rozdzielczości 4K.',
        3.7, 30);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 299.00, 'Intel', 22,'Intel Pentium Gold G5420
Odkryj nowe komputery o niesamowitym stosunku jakości do ceny z procesorem Intel Pentium: od smukłych laptopów, urządzeń 2w1 i minikomputerów po eleganckie komputery stacjonarne o doskonałym czasie pracy baterii i odpowiedniej wydajności do popularnych zastosowań, takich jak czat, robienie zakupów i przeglądanie Internetu.

Intel Pentium Gold G5420 posiada dwa rdzenie i cztery wątki. Taktowane zegara liczy z kolei 3,8 GHz. Jednostka dysponuje także pamięcią SmartCache wielkości 4 MB. Dzięki temu znakomicie radzi sobie z obsługą wielu zadań, gwarantując płynną pracę z aplikacjami. Każde zadanie wykonasz od teraz szybciej i sprawniej.',
        0.0, 31);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 1849.00, 'Intel', 12,'Intel Pentium Gold G5400
Odkryj nowe komputery o niesamowitym stosunku jakości do ceny, z procesorem Intel® Pentium® – od smukłych laptopów, urządzeń 2w1 i minikomputerów po eleganckie komputery stacjonarne o doskonałym czasie pracy baterii i odpowiedniej wydajności do popularnych zastosowań, takich jak czat, robienie zakupów i przeglądanie Internetu. Intel Pentium Gold G5400 posiada dwa rdzenie i cztery wątki. Taktowane zegara liczy z kolei 3.7 GHz. Jednostka dysponuje także pamięcią SmartCache w liczbie 4 MB. Dzięki temu znakomicie radzi sobie z obsługą wielu zadań, gwarantując płynną pracę z aplikacjami. Każde zadanie wykonasz od teraz szybciej i sprawniej.',
        4.7, 32);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 989.00, 'AMD', 25,'AMD Ryzen Threadripper 1920X 3.5 GHz
Poznaj nowe narzędzie od AMD, stworzone do zdobycia przewagi na rynku procesorów przeznaczonych do profesjonalnych zastosowań. Nowy procesor AMD Threadripper 1920X z rodziny Ryzen to konstrukcja oferująca nieporównywalną wydajność - 24 wątki oraz 12 rdzeni o taktowaniu 3.5 GHz. Dodatkowo możesz skorzystać z wyjątkowego trybu Turbo, zwiększającego częstotliwość taktowania rdzeni do 4 GHz. Zyskujesz więc niesamowitą szybkość oraz bezbłędną wielozadaniowość, niezbędną do zaawansowanych obliczeń oraz pracy z profesjonalnymi programami.',
        4.8, 33);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 9999.00, 'AMD', 7,'AMD Ryzen Threadripper 3970X 3.7 GHz
Poznaj Ryzen Threadripper od AMD. Nową serię potężnych procesorów, zaprojektowanych aby zdobyć niepodważalną przewagę na rynku jednostek do profesjonalnych zastosowań. Threadripper 3970X posiada 64 wątki oraz 32 rdzenie, taktowane z częstotliwością 3,7 GHz, która w trybie turbo może wzrosnąć nawet do 4.5 GHz. Tak duże możliwości pozwalają na przetwarzanie zaawansowanych obliczeń oraz obsługę profesjonalnego oprogramowania graficznego. Wybierz Ryzen Threadripper, a zyskasz potężne narzędzie, które nigdy Cię nie zawiedzie.',
        0.0, 34);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 18299.00, 'AMD', 8,'AMD Ryzen Threadripper 3990X
Poznaj Ryzen Threadripper od AMD. Nową serię potężnych procesorów zaprojektowanych aby zdobywać niepodważalną przewagę na rynku jednostek do profesjonalnych zastosowań. Threadripper 3990X posiada 128 wątków oraz 64 rdzenie taktowane z częstotliwością 2.9 GHz, która w trybie turbo może wzrosnąć nawet do 4.3 GHz. Tak duże możliwości pozwalają na przetwarzanie zaawansowanych obliczeń oraz obsługę profesjonalnego oprogramowania graficznego. Wybierz Ryzen Threadripper, a zyskasz potężne narzędzie, które nigdy Cię nie zawiedzie.',
        4.5, 35);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 3699.00, 'AMD', 19,'Procesor AMD Ryzen 9 3950X
Poznaj niewiarygodną moc i zaskakującą wydajność płynące z 16 rdzeni procesora AMD Ryzen 9 3950X. Ten potężny, 32-wątkowy CPU taktowany jest zegarem 3,5 GHz. Ale to nie koniec jego możliwości. Tryb Turbo pozwala na podwyższenie taktowania do 4.7 GHz. Ryzen 9 3950X wprowadza zupełnie nową jakość pracy, czerpiąc z całego spektrum możliwości architektury Zen 2. Przygotuj się na pionierskie rozwiązania z procesorem AMD Ryzen 9 3950X.',
        4.1, 36);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 2169.00, 'AMD', 25,'Procesor AMD Ryzen 9 3900X
Odkryj moc i wydajność płynące z 12 rdzeni procesora AMD Ryzen 9 3900X. Potężnego, 24-wątkowego CPU Ryzen 3. gen, taktowanego zegarem 3,80 GHz (4,60 GHz w trybie Turbo). Nowy procesor wprowadza zupełnie nową jakość pracy, czerpiąc z całego spektrum możliwości architektury Zen 2. Jednostka chłodzona jest cichym wentylatorem Wraith Prism, który znakomicie rozprasza nadmiar ciepła i zachwyca podświetleniem RGB LED.',
        4.6, 37);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 1449.00, 'AMD', 5,'Procesor AMD Ryzen 7 3700X
Czerpiąc z nowatorskiej architektury Zen 2, procesor AMD Ryzen 7 3700X dysponuje olbrzymią mocą obliczeniową. Pozwól działać potędze 8 rdzeni i 16 wątków wspartych przez 36 MB pamięci cache. Bazowe taktowanie rdzeni liczy 3,60 GHz, a w trybie Turbo przyspiesza do 4,40 GHz, obsługując bezbłędnie każdą grę, każdy program i każdy proces. Potęgę jednostki Ryzen 7 3700X zwiększysz jeszcze bardziej, korzystając z odblokowanego mnożnika.',
        4.4, 38);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 1559.00, 'AMD', 13,'Procesor AMD Ryzen 7 3800X
Procesor AMD Ryzen 7 3800X wprowadzi Cię na nowym poziom wydajności. Ten potężny CPU posiada 8 rdzeni o bazowej częstotliwości taktowania zegarów 3,90 GHz. W trybie Turbo przyspiesza ono do 4,50 GHz, zapewniając ogromną moc do płynnego gamingu oraz bezbłędny multitasking zaawansowanych operacji. Jednostka czerpie z całego spektrum możliwości architektury Zen 2, jej chłodzeniem zajmuje się wentylator Wraith Prism z oświetleniem RGB LED.',
        3.9, 39);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 899.00, 'AMD', 36,'AMD Ryzen 7 2700X 3.7 GHz
Procesor AMD Ryzen 7 2700X 2. generacji to elitarna jednostka, stworzona w oparciu o udoskonaloną mikroarchitekturę Zen+. Poczuj wzrost wydajności. Więcej mocy do szybszej i płynniejszej obsługi zaawansowanych zadań, a także rozgrywek z wymagającymi grami. Zyskaj lepszą sprawność energetyczną oraz przyspieszenie Precision Boost, zwiększające taktowanie zegarów do maksimum.

Ryzen 7 2700X posiada 8 rdzeni, 16 wątków i 20 MB pamięci cache. Bazowa częstotliwość taktowania zegarów CPU liczy 3.7 GHz, wzrastająca w trybie Turbo do 4.3 GHz. Mało tego, odblokowany mnożnik pozwoli osiągać jeszcze lepsze wyniki. TDP procesora wynosi 105 W.',
        4.8, 40);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 759.00, 'AMD', 25,'AMD Ryzen 7 2700
Jednostka AMD Ryzen 7 2700 jest potężnym procesorem, posiadającym 8 rdzeni i 16 wątków. Taktowanie zegarów liczy 3.2 GHz, przyspieszając do 4.1 GHz w trybie Turbo. TDP tego modelu wynosi 65 W, pamięć cache liczy z kolei 20 MB.

Ryzen 7 2700 zarządzany jest ulepszoną mikroarchitekturą Zen+, która wprowadza wyższą wydajność oraz lepszą sprawność energetyczną. Zyskujesz tym samym więcej mocy do gier i pracy z wymagającymi programami. Dodatkowe przyspieszenie dostarcza technika Precision Boost, która płynnie zwiększa taktowanie zegarów do maksimum.',
        4.0, 41);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 819.00, 'AMD', 33,'Procesor AMD Ryzen 5 3600
Procesor AMD Ryzen 5 3600 korzysta z nowatorskiej architektury Zen 2. To dzięki niej CPU osiąga znakomite wyniki w grach i podczas obsługi profesjonalnych aplikacji, utrzymując stale wysoką wydajność. Jednostka posiada 6 rdzeni i 12 wątków, a pamięć cache liczy 35 MB. Rdzenie taktowane są zegarami bazowymi 3,60 GHz, które wzrasta w trybie Turbo do 4,20 GHz i dostarcza jeszcze więcej mocy do pracy oraz rozrywki.',
        4.2, 42);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 569.00, 'AMD', 44,'AMD Ryzen 5 2600
Procesor AMD Ryzen 5 2600 to idealny wybór do gamingu i do pracy z profesjonalnymi aplikacjami. Taktowanie bazowe 3.4 GHz wzrasta do 3.9 GHz w trybie Turbo, podnosząc efektywność pracy i zapobiegając spadkom fps-ów w grach. Jednostka posiada 6 rdzeni, 12 wątków oraz 19 MB pamięci podręcznej.

Siła napędową procesora jest udoskonalona mikroarchitektura Zen+, wprowadzająca wyższą wydajność i lepszą sprawność energetyczną. CPU dysponuje ponadto techniką Precision Boost, która płynnie zwiększa taktowanie zegarów do maksimum.',
        4.0, 43);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 709.00, 'AMD', 5,'AMD Ryzen 5 2400G z grafiką Radeon RX Vega
Poznaj efekt połączenia mocy obliczeniowej procesora AMD Ryzen 5 2400G z genialnymi efektami wizualnymi grafiki Radeon RX Vega. Wyjdź poza dotychczasowe schematy, grając w popularne gry e-sportowe ze zintegrowaną platformą CPU + GPU, która rewolucjonizuje podejście do gamingu. Teraz możesz zrezygnować z dedykowanej karty graficznej, czerpiąc pełnymi garściami ze współpracy inteligentnej architektury ZEN z wysokowydajną architekturą GPU Vega. Wszystko w kompaktowej formie, która bez trudu zmieści się w obudowie ITX.',
        3.9, 44);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 249.00, 'AMD', 21,'Procesor AMD Ryzen 3 1200 AF
Stań do e-sportowych zmagań, uzbrojony w procesor AMD Ryzen 3 1200 AF. Ta nowoczesna jednostka, wykonana w procesie technologicznym 12nm, posiada 4 rdzenie, 4 wątki oraz 10 MB pamięci podręcznej, dostarczając moc do wielozadaniowej pracy. Bazowe taktowanie rdzeni liczy 3,1 GHz, sięgając 3,4 GHz w trybie Turbo. Jeśli wymagasz więcej, skorzystaj z możliwości, jakie daje odblokowany mnożnik i podkręć wydajność CPU.

Procesor obsługuje też 2-kanałowy kontroler pamięci DDR4-2933. Uzupełnieniem jest technologia SenseMI, pełna inteligentnych rozwiązań optymalizujących pracę komputera.',
        3.7, 45);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 1849.00, 'AMD', 1,'Procesor AMD Ryzen 3 3200G
Oto jednostka stworzona dla graczy. Poznaj procesor AMD Ryzen 3 3200G, który posiada 4 rdzenie oraz 4 wątki. Pamięć cache liczy łącznie 6 MB. Ryzen 3 3200G dysponuje również zintegrowanym układem graficznym Radeon Vega 8, umożliwiając płynny gaming z wieloma tytułami. Bazowe taktowanie rdzeni wynosi 3,60 GHz, w trybie Turbo zegary przyspieszają do 4,0 GHz, podnosząc w odczuwalny sposób wydajność komputera.',
        3.9, 46);
INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Procesory', 399.00, 'AMD', 17,'AMD Ryzen 3 2200G z grafiką Radeon RX Vega
Skorzystaj z potencjału, jaki dostarcza układ AMD Ryzen 3 2200G ze zintegrowaną grafiką Radeon RX Vega. Dzięki połączeniu inteligentnej architektury CPU Zen z wysokowydajną architekturą GPU Vega powstała platforma gamingowa, umożliwiająca płynną rozgrywkę z popularnymi tytułami. Przygotuj się na bezbłędną wielozadaniowość oraz wspaniałe efekty wizualne. Wszystko w kompaktowej formie, która bez trudu zmieści się w obudowie ITX.',
        4.6, 47);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Karty graficzne', 699.00, 'MSI', 12, 'Odkryj MSI RX 570 ARMOR 4G OC w 360 stopniach
Architektura GCN czwartej generacji została zaprojektowana z myślą o graczach, którzy grają we wszystkie możliwe rodzaje gier, począwszy od najnowszych gier MOBA (Multiplayer Online Battle Arena) na najpopularniejszych, wysokobudżetowych nastawionych na najwyższą jakość produkcjach klasy AAA skończywszy. Asynchroniczne shadery (jednostki cieniujące) i udoskonalony silnik geometrii (Geometry Engine) sprawiają, że karta graficzna przenosi użytkownika na nowy poziom wydajności i płynnej rozgrywki.',
        4.5, 48);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Karty graficzne', 1099.00, 'Gigabyte', 15, 'Odkryj Gigabyte GeForce GTX 1660 GAMING OC w 360 stopniach
Wykorzystaj rewolucyjną architekturę NVIDIA Turing, aby od tej pory napędzała Twoją rozgrywkę dzięki układowi GTX 1660, wspieranemu przez 6GB pamięci GDDR5 o przepustowości 192 GB/s. O stabilność pracy zadba złożony z trzech 80 mm wentylatorów układ chłodzenia Windforce 3X oraz najwyższej klasy komponenty, tworzące m.in. 6+2 fazową sekcję zasilania. Umieszczone z boku karty podświetlane logo Gigabyte możesz spersonalizować według własnego gustu, nadając mu ulubione kolory i efekty świetlne z pomocą RGB Fusion 2.0.',
        4.1, 49);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Karty graficzne', 1299.00, 'Gigabyte', 9, 'Gigabyte GeForce GTX 1660 SUPER GAMING OC
Nowa generacja kart napędzanych architekturą NVIDIA Turing oferuje jeszcze większą wydajność na potrzeby płynnego gamingu. Gigabyte GeForce GTX 1660 SUPER GAMING OC to fabrycznie podkręcana konstrukcja, wspomagana przez 6GB pamięci GDDR6 oraz szynę pamięci 192-bit. Najwyższej jakości podzespoły oraz wydajny układ chłodzenia gwarantują stabilność i niezawodność nawet w trakcie najgorętszej rozgrywki.',
        4.2, 50);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Karty graficzne', 1719.00, 'Gigabyte', 13,'Odkryj Gigabyte RTX 2060 GAMING OC PRO w 360 stopniach
Pozwól porwać się do świata gamingu, jakiego niedane Ci było doświadczyć nigdy wcześniej. Karta graficzna Gigabyte RTX 2060 GAMING OC PRO przeniesie Cię w zupełnie nowy świat gamingu, dzięki najbardziej zaawansowanej architekturze GPU, oszałamiającym efektom świetlnym technologii ray tracing oraz bezbłędnej płynności i dynamice obrazu.',
        3.9, 51);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Karty graficzne', 12239.00, 'MSI', 15,'Odkryj MSI Geforce RTX 2060 SUPER GAMING X w 360 stopniach
Oto długo wyczekiwana karta graficzna MSI Geforce RTX 2060 SUPER GAMING X, oparta na rewolucyjnej architekturze NVIDIA Turing i wyposażona w system chłodzenia z dwoma wentylatorami MSI. Karta charakteryzuje się stylistyką będącą polaczeniem czerni oraz metalicznych szarości, które komponują się z eleganckimi kształtami i klasyczną tylna płytą mocującą wykonaną ze szczotkowanego metalu. Mistrzowskie wzornictwo najwyższej klasy współgra z widocznymi na zewnątrz wspaniałymi, płynnymi efektami świetlnymi RGB. Nowa karta MSI Geforce RTX 2060 SUPER GAMING X po prostu mają zadziwiać.',
        4.2, 52);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Karty graficzne', 919.00, 'Gigabyte', 5, 'Gigabyte GeForce GTX 1650 SUPER WINDFORCE OC
Wykorzystaj nowoczesną architekturę NVIDIA Turing zamkniętą w przystępnej i kompaktowej formie. Karta graficzna Gigabyte GeForce GTX 1650 SUPER WINDFORCE OC oferuje nawet dwukrotnie wyższą wydajność niż model GeForce GTX 1050, dzięki czemu możesz cieszyć się wyjątkowo płynną rozgrywką. Zyskujesz też gwarancję długiej i stabilnej pracy, gdyż kartę zbudowano w oparciu o najwyższej jakości komponenty, wyposażono w układ chłodzenia Windforce 2X oraz zabezpieczono stylowym backplatem.',
        4.1, 53);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Karty graficzne', 2799.00, 'MSI', 31, 'Odkryj MSI Geforce RTX 2070 SUPER GAMING X TRIO w 360 stopniach
Karta graficzna MSI Geforce RTX 2070 SUPER GAMING X TRIO to powrót prawdziwej, trójwentylatorowej graficznej bestii MSI. Linia TRIO, która zarezerwowana jest wyłącznie dla najpotężniejszych procesorów graficznych. Karta charakteryzuje się stylistyką będącą połączeniem czerni oraz metalicznych szarości, które komponują się z eleganckimi kształtami i klasyczną tylna płytą mocującą wykonaną ze szczotkowanego metalu. Idealnie domyka ona wzornictwo przedniej części karty. Dzięki niezwykłemu podświetleniu RGB, którym można sterować z poziomu oprogramowania MSI Mystic Light, całość wygląda naprawdę niesamowicie.',
        4.3, 54);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Karty graficzne', 789.00, 'MSI', 4, 'Eleganckie, klasyczne czarno-białe wzornictwo
Graj ze stylem i odróżnij się od innych graczy korzystając z wyjątkowych kart graficznych MSI ARMOR. Stylistyka tych urządzeń zainspirowana została wyglądem zaawansowanego opancerzenia i połączona została z klasycznym czarno-białym wykończeniem. Karty graficzne z serii ARMOR idealnie nadają się dla graczy oraz moderów, którzy szukają wydajnych i jednocześnie wyróżniających się pod względem wzornictwa urządzeń.',
        3.8, 55);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Karty graficzne', 759.00, 'MSI', 15, 'Odkryj MSI GeForce GTX 1050 Ti Gaming X w 360 stopniach
Znudzony dotychczasową rozgrywką? Przełącz się na zupełnie nowe doznania z MSI GeForce GTX 1050 Ti Gaming X. Ten ogromnie wydajny układ zapewni Ci płynną obsługę najnowszych gier, możliwość gry na monitorach 4K, a także rozgrywkę w rzeczywistości wirtualnej. Zyskaj stabilność w najgorętszych bitwach krystalicznie czysty obraz w każdym starciu. Twój gaming właśnie się odmienia.',
        4.0, 56);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Karty graficzne', 699.00, 'XFX', 7, 'Karta graficzna XFX Radeon RX 570 8GB GDDR5
Zbudowana dla graczy, na bazie architektury AMD Polaris, karta graficzna Radeon RX 570 8GB GDDR5 pozwoli Ci zagrać w swoje ulubione gry na ustawieniach ultra i w rozdzielczości 1080p. Od gier e-sportowych, przez MOBA, po oszałamiające wizualnie tytuły AAA. Dzięki wiodącej wydajności DirectX12 oraz stale aktualizowanym pod kątem gier sterownikom możesz mieć pewność, że XFX Radeon RX 570 8GB GDDR5 będzie inwestycją na długie lata.',
        3.7, 57);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Karty graficzne', 2549.00, 'Gainward', 30, 'Odkryj Gainward GeForce RTX 2070 SUPER Phantom GS w 360 stopniach
Realizm, jakiego jeszcze nie było w grach. Efekty specjalne, od których nie oderwiesz wzroku. Wyjątkowo płynna rozgrywka. To wszystko oferuje karta graficzna Gainward GeForce RTX 2070 SUPER Phantom GS. Zbudowana w oparciu o rewolucyjną architekturę NVIDIA Turing dostarczy Ci niezapomnianych wrażeń z gry. Wejdź do świata VR, który zachwyci Cię bogactwem szczegółów. Graj w topowe tytułu w rozdzielczości 4K. Naciesz swoje oczy efektami technologii ray tracing w czasie rzeczywistym.',
        4.7, 58);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Karty graficzne', 21399.00, 'AMD', 2, 'AMD Radeon Pro SSG Vega 16 GB HBM2
AMD Radeon Pro SSG Vega 16 GB HBM2 jest potężną kartą graficzną dla profesjonalistów, wykonaną w procesie technologicznym 14nm. Posiada pełen rdzeń oferujący 64 Compute Units, czyli 4096 procesory strumieniowe oraz 16 GB pamięci HBM2 o przepustowości 484 GB/s., pracujące pod kontrolą architektury AMD Vega. Karta posiada też dysk SSG 2 TB, który usprawnia pracę z materiałami wymagającymi dużej przestrzeni dyskowej. Radeon Pro SSG jest dzięki temu idealnym narzędziem do pracy z aplikacjami Adobe Effects, Autodesk Maya i Blender, jak i do obróbki wideo 8K.',
        5.0, 59);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Karty graficzne', 5699.00, 'gigabyte', 10, 'Odkryj Gigabyte GeForce RTX 2080 Ti GAMING OC 11 GB w 360 stopniach
Gigabyte GeForce RTX 2080 Ti GAMING OC 11 GB to rewolucja w gamingu. Zapewnia wyższą wydajność, jeszcze lepsze doznania wizualne, a także znakomitą sprawność energetyczną. A wszystko to dzięki nowej architekturze NVIDIA Turing, która gwarantuje ray tracing w czasie rzeczywistym oraz zaawansowane SI.',
        4.9, 60);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Karty graficzne', 169.00, 'ASUS', 19, 'ASUS GeForce GT 710
ASUS GeForce GT 710 to bezgłośna karta o niskim profilu. 1GB pamięci zapewni płynne działanie aplikacji. Zmodernizuj swój stary komputer i dostarcz mu dodatkową energię. Niski profil kart pozwoli Ci zamontować ją w nawet najbardziej kompaktowych modelach.',
        4.1, 61);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Karty graficzne', 399.00, 'PNY', 3, 'PNY GeForce GT 1030
Przyspiesz swój komputer PC z pomocą wydajnej karty graficznej PNY GeForce GT 1030. Wielokrotnie nagradzana architektura NVIDIA Pascal, potężny silnik graficzny i najnowocześniejsze technologie oddają w Twoje ręce wydajność, która jest niezbędna do obsługi wymagających aplikacji na PC.',
        4.4, 62);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Karty graficzne', 2199.00, 'ASRock', 15, 'Odkryj ASRock Radeon RX 5700 XT Phantom GAMING D OC w 360 stopniach
Wyjątkowe układy AMD w architekturze RDNA, zapewniające m.in. wsparcie dla PCI-E 4.0, pozwolą Ci doświadczyć zupełnie nowej jakości w grach. Karta graficzna ASRock Radeon RX 5700 XT Phantom GAMING D OC zapewnia wysoką wydajność, dzięki której będziesz się cieszyć płynnym i stabilnym gamingiem. Prz tym karta będzie się prezentować wyjątkowo stylowo w obudowie, gdyż środkowy wentylator posiada podświetlenie RGB, a tył karty zamyka metalowy backplate.',
        3.4, 63);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Karty graficzne', 899.00, 'Sapphire', 17, 'Odkryj Sapphire Radeon RX 5500 XT PULSE w 360 stopniach
Zbudowany w nowatorskiej architekturze AMD RDNA układ graficzny Radeon RX 5500 XT zapewnia oszałamiającą wydajność, która zadowoli każdego fana elektronicznej rozrywki. Za chłodzenie GPU odpowiadają dwa ciche wentylatory, dzięki czemu karta zachowuje wyjątkową kulturę pracy.. Zapewnij sobie maksymalne wrażenia z gier ogrywanych na PC, dzięki karcie graficznej Sapphire Radeon RX 5500 XT PULSE.',
        4.7, 64);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Karty graficzne', 1429.00, 'ASRock', 21, 'ASRock Radeon RX 5600 XT Phantom Gaming D2 6G OC
Korzystaj z nowatorskich technologii AMD, takich jak FreeSync oraz nowego oprogramowania Adrenalin 2020 Edition, za sprawą wyjątkowej karty ASRock Radeon RX 5600 XT Phantom Gaming D2 6G OC. GPU wyprodukowane w architekturze AMD RDNA zapewnia wyjątkowe osiągi, które wykorzystasz w grach, a dwa wentylatory zadbają o optymalne temperatury. Możesz przy tym rozświetlić wnętrze obudowy za sprawą wbudowanego podświetlenia ARGB i oprogramowania Polychrome SYNC.',
        4.9, 65);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Karty graficzne', 3599.00, 'PNY', 5, 'Odkryj PNY GeForce RTX 2080 SUPER XLR8 TF Gaming OC w 360 stopniach
Potężna karta graficzna PNY należąca do gamingowej serii XLR8 to gwarancja SUPER osiągów i nowej jakości realizmu. Dzięki wykorzystaniu GPU stworzonego w zaawansowanej architekturze NVIDIA Turing, PNY GeForce RTX 2080 SUPER XLR8 TF Gaming OC pozwoli Ci nacieszyć się płynną rozgrywką i wyjątkową grafiką, m.in. dzięki wykorzystaniu nowoczesnej technologii Ray Tracing.',
        4.0, 66);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('RAM', 829.00, 'G.SKILL', 31, 'Pamięć RAM DDR4 FlareX Black Ryzen
Pamięć FlareX Black Ryzen została zaprojektowana z myślą o najnowszym procesorze AMD Ryzen. FlareX zapewnia niesamowitą wydajność oraz niezawodność nawet przy dużych obciążeniach. Zagwarantuj sobie najlepszy układ do gier lub dla potężnej stacji roboczej dzięki serii FlareX.',
        0.0, 67 );

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('RAM', 1082.00, 'G.SKILL', 13, 'Trident Z
Najnowsza generacja ekstremalnie wydajnej pamięci DDR4. Opierając się na silnym sukcesie produktów G.SKILL producent stworzył serię Trident Z, która cechuję się najwyższą wydajnością przeznaczona głównie dla entuzjastów PC i ekstremalnych graczy. Podczas produkcji użyte zostały najlepsze w swojej klasie komponenty, zapewniające trwałość oraz wytrzymałość nawet podczas obciążeń systemu.

Aluminiowa konstrukcja zapewnia prawidłowy przepływ powietrza oraz skutecznie odprowadza nagromadzone ciepło. Pamięć zbudowana została z ekranowanych układów, które podczas tworzenia były rygorystycznie testowane pod względem niezawodności, kompatybilności oraz wydajności.',
        4.7, 68);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('RAM', 185.00, 'G.SKILL', 33, 'Pamięć RAM DDR4 G.Skill Aegis
G.SKILL AEGIS oferuje natychmiastowy wzrost wydajności i stabilności dla wszystkich systemów gier PC. Pamięci tej serii to jeden z najprostszych i najbardziej efektywnych kosztowo sposobów, aby uaktualnić swoje wrażenia w grach.

Niezależnie czy jest to gra typu first-person shooter (FPS), strategia czasu rzeczywistego (RTS) czy nawet MMORPG, pamięci G.SKILL Aegis wyzwolą prawdziwą moc Twojego systemu gier bez względu na to w jakie gry grasz!',
        4.1, 69);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('RAM', 389.00, 'GOODRAM', 18, 'GOODRAM IRDM DDR4
GOODRAM IRDM DDR4 to moduły pamięci RAM stworzone z myślą o graczach, entuzjastach i profesjonalistach. Pamięci zostały wykonane z wyselekcjonowanych kości oraz ośmio warstwowej płytki PCB. Całość dopełnia efektowny radiator, który odprowadza nadmiar ciepła. Pamięci GOODRAM IRDM są dostępne w kilku wariantach kolorystycznych.',
        4.0, 70);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('RAM', 389.00, 'GOODRAM', 10,'Pamięć DDR4 GOODRAM IRDM X 3000MHz 16GB (2x8GB)
IRDM X DDR4 to moduły stworzone z myślą o graczach, entuzjastach i profesjonalistach. Pamięci te zbudowane zostały z wyselekcjonowanych kości oraz 8-warstwowej płytki PCB. Całość zamknięto w ulepszone, odprowadzające nadmiar ciepła radiatory w kolorze białym.',
        4.1, 71);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('RAM', 489.00, 'Patriot', 15, 'Pamięć RAM DDR4 Patriot Viper RGB
Moduły pamięci z serii Viper RGB zostały zaprojektowane i skonstruowane z myślą o ekstremalnej wydajności. Są w pełni kompatybilne z najnowszymi platformami Intel oraz AMD, aby zapewnić Twojej konfiguracji najbardziej płynną pracę. Seria Viper RGB zapewnia niezrównaną stabilność i wydajność, a także wyjątkowy design zapewniony przez wielostrefowe podświetlenie RGB. A dzięki taktowaniu 3200 MHz oraz opóźnieniom CL16, pamięci RAM od firmy Patriot to jedne z najlepszych rozwiązań dostępnych na rynku.',
        4.0, 72);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('RAM', 179.00, 'GOODRAM', 8, 'Pamięć DDR4 GOODRAM IRDM X 2666MHz 8GB
IRDM X DDR4 to moduły stworzone z myślą o graczach, entuzjastach i profesjonalistach. Pamięci te zbudowane zostały z wyselekcjonowanych kości oraz 8-warstwowej płytki PCB. Całość zamknięto w ulepszone, odprowadzające nadmiar ciepła radiatory w kolorze czarnym.',
        4.8, 73);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('RAM', 409.00, 'GOODRAM', 29, 'GOODRAM Iridium 8GB 3000MHz CL16
GOODRAM IRDM DDR4 to moduły stworzone z myślą o graczach, entuzjastach i profesjonalistach. Pamięci zbudowane zostały z wyselekcjonowanych kości oraz 8-warstwowej płytki PCB. Całość zamknięto w efektowne, odprowadzające nadmiar ciepła radiatory, dostępne w kilku wariantach kolorystycznych.

Te moduły Iridium Black dostępne są w pojemnościach 8 GB. W każdej z konfiguracji pamięci te gwarantują pracę z częstotliwością na poziomie 3000 MHz z opóźnieniami na poziomie CL16. Takie konfiguracje pomogą spełnić oczekiwania użytkowników wymagających wysokiej wydajności i stabilności systemu.',
        4.9, 74);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('RAM', 209.00, 'Corsair', 16, 'Vengeance LPX
Moduł Vengeance LPX jest zbudowany z ośmiu warstw PCB i wysoko ekranowanych układów pamięci. Skuteczny rozpraszacz ciepła zapewnia skuteczne chłodzenie, aby poprawić potencjał naszego komputera. Wykonana z czystego aluminium szybciej odprowadza ciepło, zapewniając prawidłowo pracę.',
        4.9, 75);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('RAM', 3509.00, 'G.SKILL', 0, '-', 0.0, 76);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('RAM', 2299.00, 'G.SKILL', 19, 'Pamięć RAM DDR4 G.SKILL Trident Z Royal Silver
Moduły z serii Royal są kolejnym członkiem rodziny pamięci Trident Z od G.SKILL. Charakteryzujące się unikatowym designem i wyjątkowymi osiągami, moduły Royal dodadzą wnętrzu Twojej obudowy odrobinę luksusu, a przy tym zapewnią wydajność na potrzeby obsługi najbardziej wymagających aplikacji.

Dzięki wielu testom kompatybilności i niezawodności, masz możliwość zbudowania prawdziwie spersonalizowanego komputera, korzystając z szerokiej gamy płyt głównych na platformach Intel oraz AMD.',
        4.9, 77);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('RAM', 479.00, 'HyperX', 1, 'Pamięć RAM DDR4 HyperX Predator RGB 2x8GB
Jeżeli szukasz ekstra wydajności niezbędnej do utrzymania się na topie, ultraszybka pamięć HyperX Predator DDR4 RGB zapewni Ci niezbędną przewagę. Ciesz się wyższymi ustawieniami grafiki, bezproblemowo odbieraj strumienie multimediów i błyskawicznie renderuj najważniejsze momenty. Drapieżny, czarny radiator pamięci Predator DDR4 zapewnia zarówno doskonałe chłodzenie jak i nietuzinkowy wygląd.',
        4.2, 78);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('RAM', 249.00, 'HyperX', 5, 'Pamięć RAM DDR4 HyperX Predator RGB 8GB
Jeżeli szukasz ekstra wydajności niezbędnej do utrzymania się na topie, ultraszybka pamięć HyperX Predator DDR4 RGB zapewni Ci niezbędną przewagę. Ciesz się wyższymi ustawieniami grafiki, bezproblemowo odbieraj strumienie multimediów i błyskawicznie renderuj najważniejsze momenty. Drapieżny, czarny radiator pamięci Predator DDR4 zapewnia zarówno doskonałe chłodzenie jak i nietuzinkowy wygląd.',
        4.2, 79);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('RAM', 99.00, 'GOODRAM', 2, 'Wydajne pamięci DDR3
Moduły pamięci RAM typu DDR3 są powszechnie stosowane w komputerach PC, gdzie wymagana jest bardzo duża szybkość transferu danych, duża pojemność oraz niski pobór mocy (w przypadku modułów low voltage nawet 1,35 V).

Dzięki topologii „fly-by” oraz terminacji magistrali adresowej na module pamięci możliwe jest taktowanie DDR3 z częstotliwością nawet powyżej 1200 MHz (transfer danych z częstotliwością powyżej 2400 MHz). Niski pobór mocy predysponuje moduły DDR3 do aplikacji mobilnych.',
        5.0, 80);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('RAM', 519.00, 'HyperX', 13, 'HyperX Fury Red
Ruszaj do gry z HyperX® FURY. Nawet żółtodzioby szybko wkręcą się w rozgrywkę, bo pamięć FURY automatycznie rozpoznaje używaną platformę i automatycznie przetaktowuje się do najwyższej dostępnej częstotliwości — do 1600MHz — zapewniając większą moc na kolejny deathmatch.

Asymetryczny projekt radiatora pamięci FURY pozwoli Ci wyróżnić się spośród tłumu „kwadraciaków”. Pamięć ma czarną płytkę drukowaną, a radiator może mieć kolor czarny, niebieski, czerwony oraz — pierwszy raz w historii serii HyperX — biały. Tak więc możesz mieć sprzęt w Twoim stylu i z dumą pokazywać go znajomym.',
        4.9, 81);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('RAM', 499.00, 'HyperX', 13, 'HyperX Fury White
Ruszaj do gry z HyperX® FURY. Nawet żółtodzioby szybko wkręcą się w rozgrywkę, bo pamięć FURY automatycznie rozpoznaje używaną platformę i automatycznie przetaktowuje się do najwyższej dostępnej częstotliwości — do 1600MHz — zapewniając większą moc na kolejny deathmatch.

Asymetryczny projekt radiatora pamięci FURY pozwoli Ci wyróżnić się spośród tłumu „kwadraciaków”. Pamięć ma czarną płytkę drukowaną, a radiator może mieć kolor czarny, niebieski, czerwony oraz — pierwszy raz w historii serii HyperX — biały. Tak więc możesz mieć sprzęt w Twoim stylu i z dumą pokazywać go znajomym.',
        4.0, 82);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('RAM', 159.00, 'Patriot', 1, 'Najwyższa wydajność
Firma Patriot od 30 lat zajmuje się produkowaniem wydajnych pamięci RAM dla komputerów PC, w jej ofercie znajduje się wiele różnorodnych modeli pamięci. Niezależnie od tego, czy składasz komputer, na którym uruchamiać będziesz najbardziej wymagające gry i programy, czy też ulepszasz system do podstawowych zadań, w ofercie firmy Patriot znajdziesz coś dla siebie.',
        0.0, 83);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('RAM', 569.00, 'Corsair', 15, 'Corsair Vengeance XMP
Moduły pamięci DDR3 Vengeance zostały stworzone z myślą o overclockingu. Kości Vengeance przygotowano ze specjalnie wyselekcjonowanych pod względem wysokiej wydajności modułów RAM. Aluminiowe radiatory pomagają odprowadzać ciepło oraz sprawiają, że kości wyglądają agresywnie i stylowo.',
        0.0, 84);


INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('RAM', 259.00, 'G.SKILL', 3, 'Wybrana przez overclockerów
Wybór pasjonatów musi być trafny. Tworząca światowej klasy wydajność, uwzględniająca możliwości podkręcania seria RipjawsX G.Skill, została uznana najlepszą serią pamięci przez społeczność overclockerów w 2011r. Jeśli oczekujesz wysokiej wydajności oraz jakości aby stworzyć swoją potężną maszynę to wybór wydaje się być oczywisty. Pamięci z serii RipjawsX to absolutnie najwyższej jakości produkty, którym możesz zaufać',
        5.2, 85);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('RAM', 326.00, 'Crucial', 19, 'Wydajne pamięci DDR3
W celu zapewnienia najwyższej jakości modułów pamięci, Crucial współpracuje jedynie z najlepszymi dostawcami komponentów, a w produkcji modułów pamięci stosuje wyselekcjonowane kości pamięci światowych marek. Dzięki niesamowicie szerokiej i różnorodnej ofercie firmy Crucial, możesz mieć pewność, że w Twoje ręce trafiają produkty nie tylko o najwyższej niezawodności i jakości wykonania, ale także idealnie trafiające w Twoje potrzeby.',
        4.5, 86);

##### Dyski twarde #####

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Dyski twarde', 285.00, 'Toshiba', 15, 'Dysk twardy SATA 3,5" — seria P300
3,5-calowy wewnętrzny dysk twardy Toshiba P300 to gwarancja wysokiej wydajności dla profesjonalistów. Dzięki technologii Dual-Stage Actuator można liczyć na płynne, szybkie reakcje urządzenia.

Poza tym dane i multimedia są chronione przez technologię Ramp Loading oraz czujnik wstrząsów. Dysk P300 jest dostępny w wersjach o pojemności do 3 TB.',
        4.6, 87);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Dyski twarde', 209.00, 'Seagate', 12, 'Wszechstronny, szybki i niezawodny
Dysk BarraCuda jest liderem w branży, oferując największą pojemność pamięci masowej do komputerów stacjonarnych i przenośnych. Bezkompromisowy dysk BarraCuda Pro łączy największą w branży przestrzeń pamięci masowej z prędkością na poziomie 7200 obr./min, umożliwiając osiągnięcie wysokiej wydajności i niskich czasów ładowania podczas korzystania z gier lub pracy przy dużych obciążeniach.',
        4.1, 88);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Dyski twarde', 209.00, 'WD', 13, 'Sprawdzone rozwiązania
Dyski WD Blue oferują pojemność i funkcje dopasowane do potrzeb typowych użytkowników, a ich konstrukcja spełnia najwyższe standardy jakości i niezawodności firmy WD. WD Blue to sprawdzone dyski do codziennej pracy. Marka, której ufasz, i jakość, której oczekujesz.',
        3.9, 89);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Dyski twarde', 539.00, 'WD', 1, 'Dysk HDD NAS WD RED 4TB
To jeden z najlepszych dysków WD Red, odpowiedni dla wszystkich zgodnych systemów NAS, znakomicie zaspokajający potrzeby związane z przechowywaniem danych. Dyski WD Red oferują szeroki zakres zastosowań z myślą o klientach chcących utworzyć wysoko wydajne magazyny NAS. Dyski twarde WD Red, utworzone dla systemów NAS składających się z 1 do 8 dysków twardych, służą do przechowywania cennych danych w jednej niezwykle wydajnej jednostce.',
        0.0, 90);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Dyski twarde', 285.00, 'Toshiba', 15, 'Dysk twardy SATA 3,5" — seria P300
3,5-calowy wewnętrzny dysk twardy Toshiba P300 to gwarancja wysokiej wydajności dla profesjonalistów. Dzięki technologii dual-stage actuator można liczyć na płynne, szybkie reakcje urządzenia. Poza tym dane i multimedia są chronione przez technologię ramp loading oraz czujnik wstrząsów. Dysk P300 jest dostępny w wersjach o pojemności do 3 TB.',
        4.4, 91);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Dyski twarde', 285.00, 'Toshiba', 15, 'Dysk twardy SATA 3,5" — seria P300
3,5-calowy wewnętrzny dysk twardy Toshiba P300 to gwarancja wysokiej wydajności dla profesjonalistów. Dzięki technologii dual-stage actuator można liczyć na płynne, szybkie reakcje urządzenia. Poza tym dane i multimedia są chronione przez technologię ramp loading oraz czujnik wstrząsów. Dysk P300 jest dostępny w wersjach o pojemności do 3 TB.',
        4.3, 92);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Dyski twarde', 289.00, 'WD', 13, 'Sprawdzone rozwiązania
Dyski WD Blue oferują pojemność i funkcje dopasowane do potrzeb typowych użytkowników, a ich konstrukcja spełnia najwyższe standardy jakości i niezawodności firmy WD. WD Blue to sprawdzone dyski do codziennej pracy. Marka, której ufasz, i jakość, której oczekujesz.',
        4.1, 93);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Dyski twarde', 359.00, 'Toshiba', 18, 'Dysk twardy SATA 3,5" — seria P300
3,5-calowy wewnętrzny dysk twardy Toshiba P300 to gwarancja wysokiej wydajności dla profesjonalistów. Dzięki technologii dual-stage actuator można liczyć na płynne, szybkie reakcje urządzenia. Poza tym dane i multimedia są chronione przez technologię ramp loading oraz czujnik wstrząsów. Dysk P300 jest dostępny w wersjach o pojemności do 3 TB.',
        4.4, 94);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Dyski twarde', 799.00, 'Toshiba', 15, 'Wewnętrzne dyski twarde Toshiba L200 Mobile
2,5-calowy dysk twardy Toshiba L200, przeznaczony do codziennego użytku dla użytkowników laptopów i graczy, to idealny sposób na rozbudowę i zwiększenie pojemności pamięci masowej laptopa lub konsoli do gier o 1 TB — i dodanie buforu o wielkości 128 MB.

Toshiba Dynamic Cache Technology może dodatkowo zwiększyć wydajność operacji dostępu. Dzięki dyskowi L200 Twój notebook lub konsola do gier korzystają ze słynnej wytrzymałości i niezawodności technologii firmy Toshiba.',
        5.0, 95);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Dyski twarde', 289.00, 'Plextor', 8, 'Dysk SSD Plextor 512GB 2,5" SSD M8VC
Seria M8V wyposażona jest w wysokiej jakości kontroler i 64-warstwowe układy 3D NAND, które zapewniają prędkości odczytu/zapisu sekwencyjnego odpowiednio do 560/520 MB/s, a także prędkości losowego odczytu/zapisu do 82 000/ 81 000 operacji we/wy na sekundę. Ponadto seria M8V została wyposażona w mechanizm korekcji błędów LDPC oraz obsługuje unikatowe aplikacje Plextor poprawiające wydajność i zapewniające najwyższą trwałość.',
        4.5, 96);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Dyski twarde', 299.00, 'GOODRAM', 33, 'Dysk SSD GOODRAM CL100 480GB
Ten przystępny dysk SSD CL100 gen.2 od firmy GOODRAM bazuje na wyselekcjonowanych pamięciach TLC NAND flash oraz kontrolerze Marvell 1120. W połączeniu z tradycyjnym interfejsem SATA III (6 Gb/s), CL100 gen.2 pozwoli przyśpieszyć komputer ze zwykłym dyskiem HDD nawet 10-krotnie, zapewniając jednocześnie stabilność pracy i niezawodność przez długi czas. Będzie stanowić również świetną podstawę do budowy konfiguracji zupełnie nowego komputera.',
        4.2, 97);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Dyski twarde', 439.00, 'ADATA', 22, 'Dysk SSD M.2 XPG SX8200 Pro 512GB
Ten przeznaczony dla entuzjastów PC oraz zapalonych graczy i overclockerów dysk SSD jest wyposażony w bardzo szybki interfejs M.2 PCIe Gen3 x4, zapewniający utrzymywane maks. szybkości odczytu/zapisu na poziomie nawet 3500/2300 MB/s, pozostawiając daleko w tyle możliwości tradycyjnego napędu HDD.',
        4.3, 98);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Dyski twarde', 229.00, 'Crucial', 15, 'Dysk SSD Crucial BX500 240GB
Przyspiesz działanie swojego komputera, wyposażając go w nośnik flash Crucial BX500 - najprostszy sposób, aby cieszyć się wydajnością nowoczesnych komputerów niewielkim kosztem. Ten wyposażony w interfejs SATA III, 2,5-calowy dysk SSD stanowi doskonałą bazę pod system operacyjny i programy użytkowe, gwarantując uzyskanie wyjątkowo krótkiego czasu rozruchu komputera i błyskawicznych operacjach na danych.',
        4.5, 99);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Dyski twarde', 359.00, 'Crucial', 11, 'Dysk SSD 2,5 Crucial MX500 500GB
Za każdym razem, gdy uruchamiasz swój komputer, używasz zamontowanego w nim dysku twardego, przechowując tam dane systemowe oraz najważniejsze pliki. Dołącz do użytkowników technologii SSD, wykorzystując dysk SSD Crucial MX500 stworzony przez firmę Micron. Przyspiesz pracę swojego komputera, jednocześnie zmniejszając hałas i zużycie energii. Możesz być przy tym spokojny o swoje dane, dzięki wielu zaawansowanych technologiom, gwarantującym nie tylko niezmienne osiągi, ale także wyjątkowe bezpieczeństwo i niezawodność.',
        4.1, 100);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Dyski twarde', 399.00, 'Samsung', 30, 'Dysk SSD godny zaufania
Samsung 860 EVO to szybki i niezawodny dysk SSD, opracowany z myślą o najbardziej popularnych komputerach PC i laptopach. Posiada najnowszą wersją V-NAND i solidny kontroler oparty na algorytmie, a także jest dostępny w różnych wariantach obudów i pojemności.',
        4.6, 101);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Dyski twarde', 179.00, 'PNY', 3, 'Dysk SSD PNY CS900 240GB
PNY CS900 to wyjątkowo smukły dysk SSD w formacie 2.5'''' o grubości zaledwie 7 mm. Zbudowany w oparciu o pamięć TLC NAND Flash oraz interfejs SATA III, gwarantuje możliwie najszybszy dostęp do danych dla systemu operacyjnego oraz rozmaitych aplikacji.

Dzięki prędkościom odczytu/zapisu danych na poziomie nawet 535/500 MB/s odczujesz znaczącą poprawę pracy swojego laptopa lub desktopa, jak również wyjątkowo wydajną pracę dopiero co zbudowanej konfiguracji.',
        4.3, 102);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Dyski twarde', 799.00, 'Plextor', 26, 'Dysk SSD Plextor M9PGN Plus M.2 PCIe 512GB
Charakteryzujący się niezawodną pracą dysk M9PGN Plus został stworzony w taki sposób, aby zapewnić każdemu graczowi najwyższy poziom rozgrywki. Dysk wspiera protokół NVMe najnowszej generacji, wykorzystuje także pamięć flash zaprojektowaną w zaawansowanej technologii 3D NAND z flagowym kontrolerem. Technologia PlexNitro pozwala na wykorzystanie pełnego potencjału dysku M9PGN Plus.',
        0.0, 103);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Dyski twarde', 229.00, 'Silicon Power', 35, 'Dysk SSD Silicon Power A55 M.2 2280
Dysk SSD A55 łączy zalety najnowocześniejszej technologii półprzewodnikowej oraz kompaktowe rozmiary standardu M.2 2280. Brak obudowy umożliwia montaż dysku w najnowszych komputerach przenośnych jak i stacjonarnych',
        4.0, 104);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Dyski twarde', 799.00, 'Crucial', 15, 'Dysk SSD M.2 Crucial P1 1024GB
Niezależnie od tego, czy chcesz jak najszybciej dostać się do gry lub przechowywać swoje najcenniejsze wspomnienia, dysk SSD Crucial P1 da Ci wydajność i przestrzeń, jakiej potrzebujesz. Ta wyjątkowa konstrukcja została zaprojektowana, z myślą o zostaniu jedynym dyskiem jakiego potrzebujesz: pojemnym, szybkim i niezawodnym.',
        3.9, 105);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Dyski twarde', 1599.00, 'Patriot', 2, 'Dysk SSD M.2 Patriot Viper VPN100 2TB
Dedykowany zastosowaniom gamingowym, wydajny dysk Viper VPN100 oferuje ponadprzeciętną kombinację osiągów, ultra szybkiego transferu oraz wielozadaniowości. Dzięki nawet 5-krotnie większej szybkości niż dyski SATA SSD, jest jednym z najlepszych w swojej klasie dysków dla graczy, jak również entuzjastów technologii, twórców treści, grafików 3D czy profesjonalistów zajmujących się renderowaniem wideo.',
        3.8, 106);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Dyski twarde', 1999.00, 'Intel', 4, 'Dysk SSD M.2 Intel MP600 2TB
Dysk SSD Corsair MP600 wykorzystuje nowoczesny interfejs NVMe PCIe 4.0 x4 M.2, dzięki czemu jest w stanie osiągać wyjątkowe prędkości odczytu/zapisu danych sięgające nawet 4950/4250 MB/s, zapewniając błyskawiczny czas reakcji.',
        0.0, 107);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Dyski twarde', 699.00, 'Intel', 2, 'Dysk SSD M.2 Intel 660p 1TB
Dysk SSD Intel 660p ma to co ważne w klienckich dyskach SSD, aby sprostać stale rosnącym wymaganiom. Został opracowany z wykorzystaniem pamięci 3D NAND QLC oraz specyfikacji NVMe, w celu zapewnianiu inteligentnej pamięci masowej na potrzeby typowych i podstawowych zadań.',
        4.2, 108);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Dyski twarde', 649.00, 'Silicon Power', 8, 'Dysk SSD Silicon Power A60 1TB M.2 PCIe NVMe
Dysk A60 to przystępne i wydajne rozwiązanie pamięci masowej. Jest przeznaczony dla początkujących użytkowników, twórców systemów DIY lub po prostu tych, którzy chcą uaktualnić swój komputer. Interfejs PCIe Gen3x4 oznacza, że aż cztery linie są używane do jednoczesnego przesyłania i odbierania danych. Tym samym dysk A60 osiąga prędkości odczytu/zapisu na poziomie nawet 2200/1600 MB/s.',
        5.0, 109);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Dyski twarde', 999.00, 'Samsung', 15, 'Dysk SSD M.2 Samsung 970 EVO Plus 1TB
Szybszy od swojego poprzednika, dysk 970 EVO Plus wykorzystuje najnowszą technologię V-NAND i zoptymalizowane oprogramowanie sprzętowe. Podzespół maksymalizuje potencjał przepustowości łącza NVMe, zapewniając komputerowi niezrównane działanie. Oferuje przy tym aż 1TB pojemności oraz sekwencyjną prędkość odczytu/zapisu wynoszącą odpowiednio nawet 3500/3300 MB/s.',
        5.0, 110);

##### Ekrany #####

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Monitory', 749.00, 'AOC', 17, 'Monitor gamingowy AOC 24G2U5
Zdominuj pole walki z monitorem dla graczy AOC 24G2U5. Błyskawiczny czas reakcji matrycy da Ci dodatkowe ułamki sekundy w szybkich starciach. Płynność obrazu przełoży się na zwiększoną precyzję celowania, dzięki czemu zyskasz dodatkową przewagę nad przeciwnikiem. Co więcej, dynamika obrazu oraz rewelacyjne barwy sprawią, że jeszcze bardziej zagłębisz się w rozgrywce.',
        4.1, 111);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Monitory', 449.00, 'Dell', 17,'Elegancki wygląd w codziennych zastosowaniach
Przystępny cenowo 24-calowy monitor Dell z większym obszarem wyświetlania dzięki ulepszonej ramce zapewnia elegancki wygląd w codziennych zastosowaniach. Jakość obrazu: szeroki kąt oglądania i maksymalny komfort rozrywki dzięki jaskrawym, głębokim kolorom na ekranie o rozdzielczości Full HD. Niezawodność i łatwa obsługa: zgodność z najnowszymi normami środowiskowymi i przepisami oraz obsługa starszych i nowych portów ze względu na złącza VGA i HDMI. Skuteczna ochrona dzięki zaawansowanej usłudze wymiany i gwarancji.',
        4.2, 112);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Monitory', 419.00, 'AOC', 10, 'Odkryj idealny do domu i biura monitor ASUS VZ229HE w 360 stopniach
Spędzasz wiele godzin, pracując przy arkuszach kalkulacyjnych? A może chcesz się zrelaksować przy filmie? Uniwersalny monitor ASUS VZ229HE sprawdzi się doskonale zarówno w domu, jak i w biurze. Matryca o dużej rozdzielczości zapewni wyraźny obraz i wystarczającą przestrzeń roboczą do wygodnej pracy. Nowoczesna konstrukcja monitora stanowić będzie za to idealne uzupełnienie kompozycji na każdym stanowisku komputerowym.',
        4.2, 113);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Monitory', 439.00, 'HP', 13, 'Odkryj monitor do domu i do biura HP 24W w 360 stopniach
Zapewnij sobie komfort pracy i rozrywki z monitorem HP 24W. Przeznaczony do biura i domowych zastosowań zachwyca swoją funkcjonalnością, a przy tym dba o Twoje oczy dzięki technologiom ochrony wzroku. HP 24W posiada panel o wysokiej rozdzielczości, charakteryzujący się szerokimi kątami widzenia, dzięki czemu sprawdzi się w przypadku pracy z arkuszami kalkulacyjnymi, dokumentami tekstowymi, a także podczas przeglądania stron internetowych czy multimediów.',
        4.1, 114);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Monitory', 1249.00, 'Acer', 17, 'Monitor gamingowy Acer ED273URPBIDPX
Zdominuj pole walki z monitorem dla graczy Acer ED273URPBIDPX. Szybki czas reakcji matrycy da Ci dodatkowe ułamki sekundy w szybkich starciach. Płynność obrazu przełoży się na zwiększoną precyzję celowania, dzięki czemu zyskasz dodatkową przewagę nad przeciwnikiem. Co więcej, dynamika obrazu oraz rewelacyjne barwy sprawią, że jeszcze bardziej zagłębisz się w rozgrywce.',
        4.0, 115);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Monitory', 699.00, 'Acer', 7, 'Monitor dla graczy Acer Nitro QG271BII
To, jak szybko zareagujesz na to, co widzisz, zwykle decyduje o wyniku starcia. Z monitorem gamingowym Acer Nitro QG271BII zyskasz dodatkowe ułamki sekund, które wyłonią zwycięzcę. Błyskawiczny czas reakcji matrycy oznacza wysoką płynność obrazu, którą wykorzystasz, aby zwiększyć precyzję celowania. Dodatkowo rewelacyjne kolory i dynamika wyświetlania sprawią, że rozgrywka pochłonie Cię w całości.',
        4.9, 116);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Monitory', 569.00, 'Acer', 28, 'Odkryj monitor gamingowy Acer Nitro VG240YBMIIX w 360 stopniach
Zdominuj pole walki z monitorem dla graczy Acer Nitro VG240YBMIIX. Błyskawiczny czas reakcji matrycy da Ci dodatkowe ułamki sekundy w szybkich starciach. Płynność obrazu przełoży się na zwiększoną precyzję celowania, dzięki czemu zyskasz dodatkową przewagę nad przeciwnikiem. Co więcej, dynamika obrazu oraz rewelacyjne barwy sprawią, że jeszcze bardziej zagłębisz się w rozgrywce.,',
        4.1, 117);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Monitory', 599.00, 'Iiyama', 9, 'Odkryj Monitor gamingowy iiyama G-Master G2530HSU Black Hawk w 360 stopniach
Zdominuj pole walki z monitorem dla graczy iiyama G-Master G2530HSU Black Hawk. Błyskawiczny czas reakcji matrycy da Ci dodatkowe ułamki sekundy w szybkich starciach. Płynność obrazu przełoży się na zwiększoną precyzję celowania, dzięki czemu zyskasz dodatkową przewagę nad przeciwnikiem. Co więcej, dynamika obrazu oraz rewelacyjne barwy sprawią, że jeszcze bardziej zagłębisz się w rozgrywce.',
        4.2, 118);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Monitory', 1499.00, 'Eizo', 50, 'Monitor do zadań biznesowych Eizo FlexScan EV2451
Eizo FlexScan EV2451 to monitor, który doskonale odnajdzie się w środowisku biznesowym. Wysoka rozdzielczość zapewnia wyraźny i szczegółowy obraz, niezależnie czy przeglądasz dokumenty, czy wykresy graficzne. Eizo FlexScan EV2451 jest bezpieczny dla oczu nawet przy długim korzystaniu, dzięki specjalnym technologiom ochrony wzorku. Ergonomiczna konstrukcja natomiast zapewnia komfortową pracę.',
        0.0, 119);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Monitory', 1499.00, 'Samsung', 35, 'Odkryj monitor dla gracza Samsung C27JG50QQUX Curved w 360 stopniach
Zyskaj dodatkową przewagę nad przeciwnikiem za sprawą gamingowego monitora Samsung C27JG50QQUX Curved. Daj się porwać niezwykłej dynamice i wiernie oddanym kolorom. Zyskaj też dodatkowy oręż w walce w postaci szybkiej reakcji matrycy. To sprawia, że obraz jest płynniejszy, co da Ci więcej czasu na reakcję i umożliwi dokładniejsze celowanie.',
        4.0, 120);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Monitory', 849.00, 'AOC', 17, 'Odkryj monitor dla graczy AOC C24G1 w 360 stopniach
To, jak szybko zareagujesz na to, co widzisz, zwykle decyduje o wyniku starcia. Z monitorem gamingowym AOC C24G1 zyskasz dodatkowe ułamki sekund, które wyłonią zwycięzcę. Błyskawiczny czas reakcji matrycy oznacza wysoką płynność obrazu, którą wykorzystasz, aby zwiększyć precyzję celowania. Dodatkowo rewelacyjne kolory i dynamika wyświetlania sprawią, że rozgrywka pochłonie Cię w całości.',
        4.2, 121);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Monitory', 649.00, 'Dell', 76, 'Biznesowy monitor Dell UP2516D
Sprawuj kontrolę nad wszystkimi zadaniami z biznesowym monitorem Dell UP2516D. Stworzony do codziennego użytku w biurze, charakteryzuje się ergonomicznym designem i nowoczesnymi technologiami ochrony wzroku. Dell UP2516D oferuje jakość obrazu klasy korporacyjnej z oszałamiającą ilością detali. Zapewnij sobie komfortowe warunki pracy, wpływając na większą produktywność w biznesie.',
        3.9, 122);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Monitory', 511.00, 'AOC', 106, 'Idealny do domu i biura monitor AOC E719SDA
Spędzasz wiele godzin, pracując przy arkuszach kalkulacyjnych? A może chcesz się zrelaksować przy filmie? Uniwersalny monitor AOC E719SDA sprawdzi się doskonale zarówno w domu, jak i w biurze. Matryca o rozdzielczości SXGA zapewni dobry obraz i wystarczającą przestrzeń roboczą do wygodnej pracy.',
        0.0, 123);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Monitory', 649.00, 'Acer', 29, 'Idealny do domu i biura monitor ASUS VB199T
Spędzasz wiele godzin, pracując przy arkuszach kalkulacyjnych? A może chcesz się zrelaksować przy filmie? Uniwersalny monitor ASUS VB199T sprawdzi się doskonale zarówno w domu, jak i w biurze. Matryca o dużej rozdzielczości zapewni wyraźny obraz i wystarczającą przestrzeń roboczą do wygodnej pracy. Nowoczesna konstrukcja monitora stanowić będzie za to idealne uzupełnienie kompozycji na każdym stanowisku komputerowym.',
        0.0, 124);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Monitory', 659.00, 'Dell', 38, 'Monitor biznesowy Dell P1917S
Duży ekran i wysoka rozdzielczość monitora Dell P1917S doskonale sprawdzą się do zastosowań biznesowych. Matryca oferuje przestrzeń roboczą wystarczającą do sprawnej pracy, nawet z dużymi arkuszami. Dzięki temu widzisz wszystkie dane bez konieczności przewijania, co ułatwia i przyspiesza pracę. Co więcej, wysoka rozdzielczość zapewnia ostry jak brzytwa obraz, który pokochają Twoje oczy.',
        5.0, 125);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Monitory', 649.00, 'Iiyama', 49, 'Gwarancja zero martwych pikseli
Satysfakcja Klienta jest dla marki iiyama priorytetem. Każdy monitor wykonywany jest z ogromną precyzją oraz dbałością o każdy detal. Dzięki temu masz pewność, że na Twoje biurko trafi pewny i niezawodny sprzęt. Jednak jeśli w ciągu 30 dni od daty zakupu zauważysz na matrycy martwy piksel, wówczas iiyama wymieni Twój monitor na nowy. Tak działa 30-dniowa gwarancja zero martwych pikseli. Oto nowy standard wśród monitorów.',
        0.0, 126);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Monitory', 4299.00, 'MSI', 10, 'Monitor dla graczy MSI Optix MPG341CQR Curved
To, jak szybko zareagujesz na to, co widzisz, zwykle decyduje o wyniku starcia. Z monitorem gamingowym MSI Optix MPG341CQR Curved zyskasz dodatkowe ułamki sekund, które wyłonią zwycięzcę. Błyskawiczny czas reakcji matrycy oznacza wysoką płynność obrazu, którą wykorzystasz, aby zwiększyć precyzję celowania. Dodatkowo rewelacyjne kolory i dynamika wyświetlania sprawią, że rozgrywka pochłonie Cię w całości.',
        4.9, 127);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Monitory', 4999.00, 'Acer', 9, 'Monitor dla graczy Acer Predator CG437KP
Poznaj wyjątkowe funkcje monitora Acer Predator CG437KP i dołącz do rozgrywki. Urządzenie zostało zaprojektowane z myślą o graczach, więc szybko stanie się Twoim oknem na wirtualne światy. Obsługując technologię HDR, monitor oferuje szerszy zakres jasności i kontrastu, czyniąc gry jeszcze bardziej klimatycznymi. Acer Predator CG437KP dostarczy Ci płynnego obrazu w jakości 4K, a technologie ochrony wzroku zmniejszą zmęczenie oczu do minimum.',
        4.7, 128);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Monitory', 1701.00, 'Philips', 4, 'Monitor do domu i biura Philips 328E1CA/00
Niezależnie od tego, czy korzystasz z monitora w domu, czy w biurze, warto zadbać o komfort oczu. Ekran Philips 328E1CA/00 nie tylko zapewnia wystarczającą przestrzeń roboczą do wygodnej pracy, ale też posiada wysoką rozdzielczość. W efekcie rewelacyjnie sprawdzi się zarówno podczas wpisywania danych w programach, jak i podczas oglądania filmów. Co więcej, nowoczesna konstrukcja urządzenia stanowi eleganckie uzupełnienie każdego miejsca pracy.',
        5.0, 129);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Telewizory', 1699.00, 'Philips', 17, 'Telewizor Philips 4K 50PUS6504
Usiądź wygodnie i rozkoszuj się obrazem, jaki emituje dla Ciebie telewizor Philips 50PUS6504. Dzięki technologii Pixel Precise Ultra HD dostrzeżesz świat pełen szczegółów i bogatych kolorów. Zaskoczy Cię także płynność poruszania się obrazu, a także niezwykła głębia. W połączeniu z wyraźnym dźwiękiem oraz łatwym dostępem do najlepszej rozrywki, jaką oferuje platforma SAPHI, telewizor Philips będzie gwarancją doskonałości w Twoim domu.',
        4.1, 130);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Telewizory', 9999.00, 'Philips', 10, 'elewizor Philips OLED 4K 65OLED854
Odkryj prawdziwą głębię obrazu, jaką oferuje Ci telewizor Philips 65OLED854. Wyposażony w matrycę OLED oraz rozdzielczość 4K sprawi, że każda scena będzie niezwykle realistyczna. Przyciemnianie i wyłączanie każdego piksela osobno sprawia, czerń jest wyjątkowo głęboka, a kolory nasycone i pełne kontrastu. Co więcej, zwiększa się kąt widzenia, a dzięki obrotowej podstawie, każdy domownik będzie widział moc szczegółów, niezależnie od miejsca, w którym siedzi. W połączeniu z dźwiękiem wspieranym przez Dolby Atmos oraz łatwym dostępem do najlepszej rozrywki, jaką oferuje system Android TV, telewizor Philips będzie gwarancją doskonałości w Twoim domu.',
        4.0, 131);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Telewizory', 2849.00, 'Samsung', 29, '49-calowy telewizor QLED Samsung QE49Q60RA
Urządź sobie prywatne kino w zaciszu swojego domu. Perfekcyjny obraz i duży, 49-calowy ekran telewizora QLED Samsung QE49Q60RA przeniosą Cię w świat niesamowitej rozrywki i to bez wychodzenia z domu. 100% Natężenie Kolorów uzyskane dzięki technologii Quantum Dot sprawi, że każda scena ożyje, a naturalne barwy i realistyczne odwzorowanie pozwolą Ci się poczuć, jakbyś był jej częścią. Telewizor QLED wypełni Twoje życie miliardem odcieni i to zarówno w jasnych, jak i ciemnych scenach. Od teraz nie tylko dynamiczna akcja będzie zapierać Ci dech w piersiach.',
        3.9, 132);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Telewizory', 2899.00, 'LG', 37, 'Technologia NanoCell w telewizorze LG 55SM8500
Przekonaj się na własne oczy, jak nanocząsteczki przenoszą jakość obrazu wyświetlanego na ekranie telewizora LG 55SM8500 na nowy poziom. Technologia NanoCell™ sprawia, że reprodukowane materiały nabierają jeszcze piękniejszych barw i stają się pełne życia, a każda sena jest doskonale odwzorowana.

Wykorzystanie technologi NanoCell pozwoliło usunąć niepotrzebne fale światła, jak również ograniczyć wyciek kolorów RGB. Dzięki czemu możesz cieszyć się niesamowitymi kolorami na 55-calowym 55SM8500 podczas każdego seansu.',
        5.0, 133);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Telewizory', 4999.00, 'Sony', 11, 'Pełna harmonia w telewizorze Sony KD-55XG9505
Sony KD-55XG9505 to telewizor, który zafunduje Ci autentyczność doznań dzięki brzmieniu Acoustic Multi-Audio™ idealnie zharmonizowanemu z realistycznym odwzorowaniem każdego detalu. Z nim bogaty świat kolorów i szczegółów w jakości 4K HDR staje przed Tobą otworem za pomocą jednego naciśnięcia. Za ekranem tego telewizora kryje się gama wyjątkowych technologii przetwarzania sygnału i popraw obrazu.

KD-55XG9505 ma także pełne podświetleni Full Array LED. Większa liczba diod LED równomiernie rozmieszczonych za 55-calowym ekranem jeszcze lepiej go podświetla. To wraz z technologią precyzyjnego lokalnego przyciemniania umożliwia niezależne zmniejszanie lub zwiększanie jasności, poszczególnych obszarów diod LED. Dzięki czemu możesz cieszyć się dokładniejszym kontrastem i kinowym wrażeniem we własnym salonie.',
        3.7, 134);


INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Telewizory', 11999.00, 'Sony', 5, 'Wydajny procesor w telewizorze Sony KD-85XG8596
Pozwól się porwać w niezwykłe krainy wyświetlane na 85-calowym ekranie telewizora Sony KD-85XG8596. Dzięki doskonałej współpracy wykorzystanych technologii poprawy obrazu z wydajnym procesorem masz wrażenie, że każda scena jest wręcz namacalna. Zobacz jak wszystko to, co oglądasz — ożywa, dzięki większej głębi, lepszemu odwzorowaniu detali i faktur.

Procesor obrazu 4K HDR Processor X1 wykorzystany w KD-85XG8596 idealnie odwzorowuje nawet drobne wzory i tekstury i to z niezwykłym realizmem. Dodatkowo w połączeniu z funkcją Object-based HDR remaster oddaje czyste barwy z większą jasnością. Teraz masz wrażenie, że morze może sięgnąć Twoich stóp.',
        0.0, 135);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Telewizory', 1279.00, 'LG', 31, '43-calowy telewizor Full HD LG 43LM6300
LG Telewizor LG 43LM6300 z ekranem Full HD da Tobie i Twojej rodzinie jeszcze więcej przyjemności płynącej z oglądania ulubionych programów. Cztery szybkie i dokładne procesory usuwają szum oraz zapewniają bogate kolory i dynamiczny kontrast. Rozdzielczość obrazów o niskiej jakości jest podnoszona w celu zwiększenia ostrości i zapewnienia bardziej żywych kolorów. Model 43LM6300 dysponuje także dynamicznym wzmacniaczem kolorów, dzięki któremu obrazy stają się bardziej naturalne. Delektuj się prawdziwymi kolorami natury na ekranie swojego telewizora.',
        0.0, 136);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Telewizory', 2599.00, 'Sony', 17, 'Telewizor Ultra HD Sony KD-43XG8096
Daj pochłonąć się niesamowitemu obrazowi wyświetlanemu na 43-calowym ekranie telewizora Sony KD-43XG8096. Produkt ten to przykład doskonałej współpracy wykorzystanych technologii z wydajnym procesorem. Efektem tego jest niezwykła głębia, piękne kolory i szczegółowość obrazu, a co za tym idzie jeszcze większa przyjemność z oglądania.

Technologia 4K X-Reality™ PRO, wyświetlacz TRILUMINOS Display i platforma Android TV zadbają o najlepszą jakość i niezmierzoną ilość rozrywki. Natomiast technologia Motionflow™ XR sprawi, że nawet podczas wyświetlania najbardziej dynamicznych scen, obraz na ekranie tv KD-43XG8096 wciąż pozostanie niezwykle płynny. Ogląda, graj, baw się i zapomnij o ograniczeniach.',
        4.5, 137);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Telewizory', 3299.00, 'Philips', 30, 'Telewizor Philips 4K 70PUS6504
Usiądź wygodnie i rozkoszuj się obrazem, jaki emituje dla Ciebie telewizor Philips 70PUS6504. Dzięki technologii Pixel Precise Ultra HD dostrzeżesz świat pełen szczegółów i bogatych kolorów. Zaskoczy Cię także płynność poruszania się obrazu, a także niezwykła głębia. W połączeniu z wyraźnym dźwiękiem oraz łatwym dostępem do najlepszej rozrywki, jaką oferuje platforma SAPHI, telewizor Philips będzie gwarancją doskonałości w Twoim domu.',
        4.1, 138);


INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Telewizory', 6999.00, 'Philips', 15, 'Telewizor Philips OLED 4K 55OLED804
Telewizor Philips 55OLED804 to gwarancja doskonałości, która od teraz zawita w Twoim domu. Bogactwo kolorów i fantastyczna głębia zostały uzyskane dzięki wyjątkowej matrycy OLED oraz rozdzielczości 4K. Każdy piksel jest niezależny, a co za tym idzie - wyłączany i przyciemniany osobno. Taki zabieg pozwolił uzyskać jeszcze głębszą czerń, nasycenie barw i zachwycający kontrast. Telewizor Philips to także łatwy dostęp do najlepszej rozrywki, jaką oferuje platforma Android Smart TV. Co więcej, obsługa takich formatów audio i wideo jak Dolby Vision i Dolby Atmos zapewni niemal kinową jakość obrazu i dźwięku. Natomiast dzięki technologii Ambilight, emocje podczas oglądania będą jeszcze lepsze.',
        4.6, 139);

##### zasilacze #####

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Zasilacze', 199.00, 'SilentiumPC', 19, 'SilentiumPC 500W Vero L2 Bronze
Zasilacz SilentiumPC Vero L2 Bronze 500 W to nowoczesna platforma wykorzystującą układ rezonansowy LLC oraz niezależną regulację napięć wyjściowych. Zapewnia to bardzo dobrą stabilność napięć, a także wysoką sprawność energetyczną przekraczającą 85%, co zostało potwierdzone certyfikatem 80 PLUS®Bronze.

Przekłada się to na niższe rachunki za energię elektryczną, niższe temperatury, cichsze działanie wentylatora oraz dłuższą bezawaryjną pracę, co potwierdza 3-letnia gwarancja w systemie door-to-door.',
        4.5, 140);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Zasilacze', 229.00, 'SilentiumPC', 21, 'SilentiumPC 600W Vero L2 Bronze
Zasilacz SilentiumPC Vero L2 Bronze 600 W to nowoczesna platforma wykorzystującą układ rezonansowy LLC oraz niezależną regulację napięć wyjściowych. Zapewnia to bardzo dobrą stabilność napięć, a także wysoką sprawność energetyczną przekraczającą 85%, co zostało potwierdzone certyfikatem 80 PLUS®Bronze.

Przekłada się to na niższe rachunki za energię elektryczną, niższe temperatury, cichsze działanie wentylatora oraz dłuższą bezawaryjną pracę, co potwierdza 3-letnia gwarancja w systemie door-to-door.',
        4.4, 141);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Zasilacze', 169.00, 'SilentiumPC', 7, 'SilentiumPC Elementum E2 550W
SilentiumPC Elementum E2 550W to zasilacz o potwierdzonej certyfikatem, wysokiej sprawności 80 PLUS. Oznacza to, że w najpopularniejszych zestawach komputerowych pobierających realnie od 100 do 300 W, zasilacz Elementum E2 550W oferuje ponadprzeciętną w tym segmencie efektywność, co obniża rachunki za prąd i redukuje generowany hałas. Bogaty zestaw okablowania umożliwia podpięcie aż 6 urządzeń ze złączem SATA/MOLEX oraz kart graficznych z podwójnym złączem zasilającym PCI-Express.',
        4.1, 142);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Zasilacze', 409.00, 'SilentiumPC', 23, 'SilentiumPC 750W Supremo FM2 Gold
Zasilacz SilentiumPC Supremo FM2 Gold 750 W to najnowsza wersja zasilacza z tej linii, który ma być podstawą do budowy najwydajniejszych komputerów.

Za zasilanie podzespołów komputera odpowiada platforma oferująca bardzo wysoką sprawność energetyczną, wynoszącą do 92%, co zostało potwierdzone certyfikatem 80 PLUS®Gold.

Wysoka sprawność przekłada się na niższe rachunki za energię elektryczną, niższe temperatury pracy, a tym samym cichsze działanie wentylatora.',
        3.9, 143);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Zasilacze', 309.00, 'be quiet!', 11, 'Zasilacz be quiet! System Power 9 600W CM
Postaw na sprawdzoną niezawodność i dobrą wydajność. be quiet! System Power 9 CM 600W oferuje ciszę oraz słynną niezawodność be quiet! dla wszystkich integratorów systemów PC. Zasilacz zapewnia stabilność dzięki dwóm liniom 12V, wspiera tryb multi-GPU z dwoma PCIe, a pobór mocy w trybie czuwania osiąga rezultat poniżej 0,15 wattów. Co więcej, sterowany temperaturą wentylator 120 mm znacznie redukuje hałas.',
        5.0, 144);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Zasilacze', 579.00, 'be quiet!', 30, 'be quiet! Straight Power 11 750 W
Zależy Ci na bezkompromisowej stabilności zasilania? Wybierz be quiet! Straight Power 11 750 W – zasilacz stworzony z myślą o zaawansowanych systemach, gdzie liczy się niezachwiana stabilność oraz superciche chłodzenie. Dzięki japońskim kondensatorom zasilacz odznacza się niezawodnością, a także wytrzymałością do 105°. Posiada również w pełni modularne zarządzanie przewodami, gwarantujące maksymalną elastyczność konfiguracji oraz cztery, wysokowydajne linie 12V. be quiet! Straight Power 11 750 W zapewnia ponadto wsparcie dla najmocniejszych GPU z dwoma złączami PCI-e.',
        4.3, 145);


INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Zasilacze', 509.00, 'be quiet!', 11, 'Odkryj be quiet! Straight Power 11 w 360 stopniach
W zaawansowanych systemach zainstaluj be quiet! Straight Power 11 650 W. Skuteczny, a zarazem cichy zasilacz wyposażony w japońskie kondensatory, będące gwarancją wydajności oraz niezawodności. Posiada w pełni modularne zarządzanie przewodami, gwarantujące maksymalną elastyczność konfiguracji oraz cztery, wysokowydajne linie 12V. be quiet! Straight Power 11 650 W oferuje ponadto wsparcie dla najmocniejszych GPU z dwoma złączami PCI-e. Wszystko po to, by zagwarantować Ci bezkompromisową stabilność zasilania.',
        4.9, 146);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Zasilacze', 569.00, 'Seasonic', 2, 'Zasilacz Focus SGX 650W
Nowa linia produktów Seasonic Focus SGX cechuje wszechstronne zastosowanie. Dzięki niewielkim rozmiarom oraz dołączonemu adapterowi, umożliwia montaż zasilacza zarówno w obudowach SFX jak i ATX. Wyjątkowa konstrukcja urządzenia o mocy 650 watów zapewni wszystkim komponentom w Twoim komputerze stabilne i prawidłowe chłodzenie przy dowolnym obciążeniu.',
        3.0, 147);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Zasilacze', 559.00, 'Corsair', 4, 'Zasilacz Corsair RM 650x 650W
Zasilacze modularne z serii RMx dają bardzo ścisłą kontrolę napięcia, cichą pracę oraz w pełni modularny zestaw kabli. Zbudowany został z japońskich 105° C kondensatorów, dlatego jest doskonałym wyborem dla komputerów potrzebujących wydajności i niezawodności.',
        3.4, 148);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Zasilacze', 359.00, 'Gigabyte', 5, 'Zasilacz Gigabyte G750H 750W
Wyposażona w zaawansowane technologie, 750-watowa konstrukcja od Gigabyte, umożliwia stabilne zasilanie komputera wyposażonego nawet w najnowocześniejsze, wydajne podzespoły. Gdy wymagana jest doskonała stabilność i minimalny hałas, sięgnij po Gigabyte G750H, który dodatkowo posiada pół-modularne okablowanie. Dzięki temu skorzystasz wyłącznie z tych przewodów, których aktualnie potrzebujesz. Zasilacz Gigabyte G750H zyskał ponadto certyfikat 80 PLUS Gold, który potwierdza lepszą wydajność energetyczną - mniejsze straty mocy, a w konsekwencji niższe temperatury pracy.',
        3.4, 149);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Zasilacze', 769.00, 'Corsair', 21, 'Pełna kontrola
Rewolucyjny zasilacz HX750i daje Ci możliwość kontrolowania jego pracy za pomocą dołączonej aplikacji Corsair Link. Do zasilacza dołączony jest również specjalny kabel USB, który po pobraniu oprogramowania daje jeszcze więcej opcji monitorowania i sterowania.',
       4.0, 150);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Zasilacze', 239.00, 'Chieftec', 11, 'Chieftec GPS-700A8
Nowa seria smart oferuje zarówno wysoką jakość wykonania jak i sprawność. Zasilacz jest pomalowany na czarno oraz wyposażony w długie kable, przewód zasilający oraz solidny karton, który chroni go w transporcie. Dzięki sprawność zasilacza na poziomie powyżej 80% GPS-700A8 spełnia wymagania zielonego IT, przy umiarkowanej cenie zakupu.',
        4.2, 151);


##### Laptopy ####


INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 1299.00, 'HP', 28, '', 2.9, 152);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 6599.00, 'Lenovo', 73, '', 3.1, 153);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 3999.00, 'HP', 69 , '', 4.2, 154);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 5599.00, 'ASUS', 73, '', 3.9, 155);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 4599.00, 'ASUS', 45, '', 4.4, 156);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 11399.00, 'ASUS', 24, '', 4.3, 157);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 8199.00, 'Lenovo', 53, '', 4.4, 158);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 7099.00, 'MSI', 18, '', 3.2, 159);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 1699.00, 'HP', 53, '', 3.7, 160);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 4899.00, 'Dell', 54, '', 4.1, 161);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 6599.00, 'MSI', 20, '', 3.9, 162);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 4399.00, 'Apple', 79, '', 2.7, 163);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 5999.00, 'ASUS', 42, '', 4.4, 164);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 8899.00, 'HP', 11, '', 4.1, 165);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 8999.00, 'Apple', 13, '', 4.3, 167);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 6599.00, 'Acer', 17, '', 3.3, 168);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 9499.00, 'Acer', 11, '', 3.8, 169);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 4399.00, 'Acer', 30, '', 3.7, 170);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 9299.00, 'Acer', 44, '', 3.4, 171);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 8299.00, 'Microsoft', 24, '', 4.2, 172);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 4799.00, 'Apple', 75, '', 4.2, 173);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 3599.00, 'Acer', 29, '', 4.7, 174);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 4399.00, 'Microsoft', 18, '', 4.6, 175);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 9999.00, 'Microsoft', 46, '', 4.8, 176);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 6599.00, 'Huawei', 16, '', 2.9, 177);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 8999.00, 'Dell', 36, '', 3.2, 178);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 3799.00, 'Huawei', 29, '', 3.2, 179);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 11399.00, 'MSI', 74, '', 3.5, 180);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 3099.00, 'Dell', 26, '', 4.5, 181);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 9299.00, 'HP', 25, '', 3.6, 182);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 1899.00, 'Huawei', 13, '', 4.6, 183);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 3399.00, 'LG ', 64, '', 3.9, 184);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 5999.00, 'LG ', 46, '', 3.5, 185);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 5099.00, 'HP', 33, '', 3.4, 186);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 8399.00, 'Lenovo', 74, '', 4.2, 187);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 10099.00, 'MSI', 19, '', 4.3, 188);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 1499.00, 'Lenovo', 44, '', 4.4, 189);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 12099.00, 'MSI ', 33, '', 3.2, 190);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 10799.00, 'Dell', 28, '', 3.1, 191);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 6499.00, 'Dell', 9, '', 3.6, 192);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 5899.00, 'Lenovo', 17, '', 3.7, 193);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 2099.00, 'Lenovo', 73, '', 4.2, 194);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 8999.00, 'Apple', 13, '', 4.3, 167);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 6599.00, 'Acer', 17, '', 3.3, 170);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 9499.00, 'Acer', 11, '', 3.8, 171);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 4399.00, 'Acer', 30, '', 3.7, 163);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 9299.00, 'Acer', 44, '', 3.4, 153);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 8299.00, 'Microsoft', 24, '', 4.2, 163);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 4799.00, 'Apple', 75, '', 4.2, 176);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 3599.00, 'Acer', 29, '', 4.7, 157);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 4399.00, 'Microsoft', 18, '', 4.6, 191);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 9999.00, 'Microsoft', 46, '', 4.8, 174);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 6599.00, 'Huawei', 16, '', 2.9, 159);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 8999.00, 'Dell', 36, '', 3.2, 154);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 3799.00, 'Huawei', 29, '', 3.2, 186);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 11399.00, 'MSI', 74, '', 3.5, 177);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 3099.00, 'Dell', 26, '', 4.5, 173);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 9299.00, 'HP', 25, '', 3.6, 179);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 1899.00, 'Huawei', 13, '', 4.6, 193);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 3399.00, 'LG ', 64, '', 3.9, 168);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 5999.00, 'LG ', 46, '', 3.5, 164);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 5099.00, 'HP', 33, '', 3.4, 177);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 8399.00, 'Lenovo', 74, '', 4.2, 189);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 10099.00, 'MSI', 19, '', 4.3, 185);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 1499.00, 'Lenovo', 44, '', 4.4, 188);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 12099.00, 'MSI ', 33, '', 3.2, 155);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 10799.00, 'Dell', 28, '', 3.1, 170);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 6499.00, 'Dell', 9, '', 3.6, 190);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 5899.00, 'Lenovo', 17, '', 3.7, 186);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Laptopy', 2099.00, 'Lenovo', 73, '', 4.2, 189);

##### Komputery #####


INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 10799.00, 'Dell', 28, '', 3.1, 195);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 6499.00, 'Cat', 9, '', 3.6, 196);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 5899.00, 'Lenovo', 17, '', 3.7, 197);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 2099.00, 'Lenovo', 73, '', 4.2, 198);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 8399.00, 'Lenovo', 74, '', 4.2, 199);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 10099.00, 'MSI', 19, '', 4.3, 200);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 1499.00, 'Lenovo', 44, '', 4.4, 201);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 12099.00, 'MSI ', 33, '', 3.2, 202);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 4399.00, 'Cat', 18, '', 4.6, 203);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 9999.00, 'Microsoft', 46, '', 4.8, 204);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 6599.00, 'Huawei', 16, '', 2.9, 205);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 8999.00, 'Dell', 36, '', 3.2, 206);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 3799.00, 'Cat', 29, '', 3.2, 207);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 11399.00, 'MSI', 74, '', 3.5, 208);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 1299.00, 'HP', 28, '', 2.9, 209);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 6599.00, 'Lenovo', 73, '', 3.1, 210);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 3999.00, 'HP', 69 , '', 4.2, 211);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 5599.00, 'ASUS', 73, '', 3.9, 212);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 4599.00, 'Cat', 45, '', 4.4, 213);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 11399.00, 'ASUS', 24, '', 4.3, 214);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 8199.00, 'Lenovo', 53, '', 4.4, 215);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 5999.00, 'LG ', 46, '', 3.5, 216);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 5099.00, 'HP', 33, '', 3.4, 217);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 8399.00, 'Lenovo', 74, '', 4.2, 218);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 10799.00, 'Dell', 28, '', 3.1, 204);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 6499.00, 'Cat', 9, '', 3.6, 214);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 5899.00, 'Lenovo', 17, '', 3.7, 204);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 2099.00, 'Lenovo', 73, '', 4.2, 206);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 8399.00, 'Lenovo', 74, '', 4.2, 218);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 10099.00, 'MSI', 19, '', 4.3, 204);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 1499.00, 'Lenovo', 44, '', 4.4, 212);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 12099.00, 'MSI ', 33, '', 3.2, 209);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 4399.00, 'Cat', 18, '', 4.6, 199);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 9999.00, 'Microsoft', 46, '', 4.8, 196);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 6599.00, 'Huawei', 16, '', 2.9, 200);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 8999.00, 'Dell', 36, '', 3.2, 196);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 3799.00, 'Cat', 29, '', 3.2, 199);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 11399.00, 'MSI', 74, '', 3.5, 211);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 1299.00, 'HP', 28, '', 2.9, 199);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 6599.00, 'Lenovo', 73, '', 3.1, 198);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 3999.00, 'HP', 69 , '', 4.2, 210);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 5599.00, 'ASUS', 73, '', 3.9, 206);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 4599.00, 'Cat', 45, '', 4.4, 197);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 11399.00, 'ASUS', 24, '', 4.3, 211);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 8199.00, 'Lenovo', 53, '', 4.4, 210);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 5999.00, 'LG ', 46, '', 3.5, 212);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 5099.00, 'HP', 33, '', 3.4, 195);

INSERT INTO products(category, price, brand, on_stock, description, rating, specyficationsid)
VALUES ('Komputery', 8399.00, 'Lenovo', 74, '', 4.2, 207);

ALTER TABLE orders MODIFY COLUMN Order_date TEXT;
