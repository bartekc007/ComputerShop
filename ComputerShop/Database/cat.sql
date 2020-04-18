create database cat;
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
VALUES ('MSI','GeForce GTX2070 SUPER', 1800, 6, 'GDDR6', 'HDMI - 1 szt. DisplayPort - 3 szt.');
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
VALUES ('Toshiba', 'P300', 'HDD', 1000, NULL, NULL, 7200,'SATA III (6 Gbit/s)');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Toshiba', 'P300', 'HDD', 2000, NULL, NULL, 7200,'SATA III (6 Gbit/s)');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('WD', 'BLUE', 'HDD', 2000, NULL, NULL, 5400,'SATA III (6 Gbit/s)');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Toshiba', 'P300', 'HDD', 3000, NULL, NULL, 7200,'SATA III (6 Gbit/s)');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Toshiba', 'L200', 'HDD', 1000, NULL, NULL, 5400,'SATA III (6 Gbit/s)');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Plextor', ' ', 'SSD', 512, 560, 520, NULL,'SATA III (6 Gbit/s)');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('GOODRAM', ' ', 'SSD', 480, 550, 460, NULL,'SATA III (6 Gbit/s)');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('ADATA', ' ', 'SSD', 512, 3500, 2300, NULL,'M.2 PCIe NVMe 3.0 x4');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Crucial', ' ', 'SSD', 240, 540, 500, NULL,'SATA III (6 Gbit/s)');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Crucial', ' ', 'SSD', 500, 560, 510, NULL,'SATA III (6 Gbit/s)');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Samsung', ' ', 'SSD', 500, 550, 520, NULL,'SATA III (6 Gbit/s)');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('PNY', ' ', 'SSD', 240, 535, 500, NULL,'SATA III (6 Gbit/s)');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Plextor', ' ', 'SSD', 512, 3200, 2000, NULL,'M.2 PCIe NVMe 3.0 x4');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Silicon Power', ' ', 'SSD', 256, 3400, 3000, NULL,'M.2 PCIe NVMe 3.0 x4');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Crucial', ' ', 'SSD', 1024, 2000, 1700, NULL,'M.2 PCIe NVMe 3.0 x4');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Patriot', ' ', 'SSD', 2048, 3100, 3000, NULL,'M.2 PCIe NVMe 3.0 x4');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Corsair', ' ', 'SSD', 2048, 4950, 4250, NULL,'M.2 PCIe NVMe 3.0 x4');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Intel', ' ', 'SSD', 2048, 1800, 1800, NULL,'M.2 PCIe NVMe 3.0 x4');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Silicon Power', ' ', 'SSD', 1024, 2200, 1600, NULL,'M.2 PCIe NVMe 3.0 x4');
INSERT INTO hard_drives (Brand, Name, Type, Capacity, Max_Sequential_Read_Speed, Max_Sequential_Write_Speed, Hard_Disk_Rotational_Speed, Internal_interface)
VALUES ('Samsung', ' ', 'SSD', 1024, 3500, 3300, NULL,'M.2 PCIe NVMe 3.0 x4');


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
VALUES ('Corsair', 'RMx', 750, 92);
INSERT INTO power_supply_units (Brand, Name, DC_Output, Efficiency)
VALUES ('Chieftec', 'GPE-700S', 700, 80);


##### RAM #####

INSERT INTO rams (Brand, Name, RAM_type, RAM_capacity, Number_of_items, Clock_speed)
VALUES ('G.SKILL', 'FlareX Black Ryzen', 'DDR4', 16, 2, 3200);
INSERT INTO rams (Brand, Name, RAM_type, RAM_capacity, Number_of_items, Clock_speed)
VALUES ('G.SKILL', 'Trident Z', 'DDR4', 16, 2, 3000);
INSERT INTO rams (Brand, Name, RAM_type, RAM_capacity, Number_of_items, Clock_speed)
VALUES ('G.SKILL', 'CL16 Aegis', 'DDR4', 4, 1, 2400);
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
VALUES ('HyperX', 'Predator RGB', 'DDR3', 8, 1, 1600);
INSERT INTO rams (Brand, Name, RAM_type, RAM_capacity, Number_of_items, Clock_speed)
VALUES ('GOODRAM', ' ', 'DDR3', 4, 1, 1333);
INSERT INTO rams (Brand, Name, RAM_type, RAM_capacity, Number_of_items, Clock_speed)
VALUES ('HyperX', 'Fury Red', 'DDR3', 16, 2, 1600);
INSERT INTO rams (Brand, Name, RAM_type, RAM_capacity, Number_of_items, Clock_speed)
VALUES ('HyperX', 'Fury White', 'DDR3', 4, 1, 1600);
INSERT INTO rams (Brand, Name, RAM_type, RAM_capacity, Number_of_items, Clock_speed)
VALUES ('Patriot ', ' ', 'DDR3', 4, 1, 1600);
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
VALUES (NULL,NULL,NULL,NULL,NULL,30,NULL);

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

insert into user (Name, Surname, AddressID, Login, Password, Email, Phone_number, Is_a_client, Is_a_company_client) VALUES ('a','a',NULL,'a','a','a','a',1,1);