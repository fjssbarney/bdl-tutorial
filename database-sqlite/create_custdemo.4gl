# FOURJS_START_COPYRIGHT(U,2002)
# Property of Four Js*
# (c) Copyright Four Js 2002, 2021. All Rights Reserved.
# * Trademark of Four Js Development Tools Europe Ltd
#   in the United States and elsewhere
# 
# Four Js and its suppliers do not warrant or guarantee that these samples are
# accurate and suitable for your purposes.
# Their inclusion is purely for information purposes only.
# FOURJS_END_COPYRIGHT
MAIN
    CONNECT TO "custdemo"

    CALL db_tables_drop()
    CALL db_tables_create()
    CALL db_tables_load()
END MAIN

FUNCTION db_tables_create()
    CREATE TABLE customer(
        store_num integer not null,
        store_name char(30),
        addr char(20),
        addr2 char(20),
        city char(15),
        state char(2),
        zipcode char(5),
        contact_name char(30),
        phone char(18)
    );

    CREATE TABLE orders(
        order_num integer not null,
        order_date date,
        store_num integer not null,
        fac_code char(3),
        ship_instr char(10),
        promo char(1)
    );

    CREATE TABLE factory(
        fac_code char(3) NOT NULL,
        fac_name char(15)
    );

    CREATE TABLE stock(
        stock_num integer NOT NULL,
        fac_code char(3) NOT NULL,
        description char(15),
        reg_price decimal(8,2),
        promo_price decimal(8,2),
        price_updated date,
        unit char(4)
    );

    CREATE TABLE items(
        order_num integer NOT NULL,
        stock_num integer NOT NULL,
        quantity smallint,
        price decimal(8,2)
    );

    CREATE TABLE state(
        state_code char(2) NOT NULL,
        state_name char(15)
    );
END FUNCTION

FUNCTION db_tables_load()
    INSERT INTO customer VALUES (101,"Bandy's Hardware","110 Main","","Chicago","IL","60068","Bob Bandy","630-221-9055");
    INSERT INTO customer VALUES (102,"The FIX-IT Shop","65W Elm Street Sqr.","","Madison","WI","65454","","630-34343434");
    INSERT INTO customer VALUES (103,"Hill's Hobby Shop","553 Central Parkway","","Eau Claire","WI","54354","Janice Hilstrom","666-4564564");
    INSERT INTO customer VALUES (104,"Illinois Hardware","123 Main Street","","Peoria","IL","63434","Ramon Aguirra","630-3434334");
    INSERT INTO customer VALUES (105,"Tools and Stuff","645W Center Street","","Dubuque","IA","54654","Lavonne Robinson","630-4533456");
    INSERT INTO customer VALUES (106,"TrueTest Hardware","6123 N. Michigan Ave","","Chicago","IL","60104","Michael Mazukelli","640-3453456");
    INSERT INTO customer VALUES (107,"Bob's Bike Shop","1011 Astral Ave","","St. Charles","IL","60606","","774-3433434");
    INSERT INTO customer VALUES (108,"Acme Tools","555 Park St","","Madison","WI","64556","Bill Allen","616-4345456");
    INSERT INTO customer VALUES (109,"Sam and Ed's","616 Driver Ave","","Peoria","IL","54545","","645-5454545");
    INSERT INTO customer VALUES (110,"The Homework","634 Center St","","Ames","IA","46404","","626-3422323");
    INSERT INTO customer VALUES (209,"2nd FIX-IT Shop","65W Elm Street Sqr.","","Madison","WI","65454","","630-34343434");
    INSERT INTO customer VALUES (203,"2nd Hobby Shop","553 Central Parkway","","Eau Claire","WI","54354","Janice Hilstrom","666-4564564");
    INSERT INTO customer VALUES (204,"2nd Hardware","123 Main Street","","Peoria","IL","63434","Ramon Aguirra","630-3434334");
    INSERT INTO customer VALUES (205,"2nd Stuff","645W Center Street","","Dubuque","IA","54654","Lavonne Robinson","630-4533456");
    INSERT INTO customer VALUES (206,"2ndTest Hardware","6123 N. Michigan Ave","","Chicago","IL","60104","Michael Mazukelli","640-3453456");
    INSERT INTO customer VALUES (309,"Third's Hardware","110 Main","","Chicago","IL","60068","Bob Bandy","630-221-9055");
    INSERT INTO customer VALUES (302,"Third FIX-IT Shop","65W Elm Street Sqr.","","Madison","WI","65454","","630-34343434");
    INSERT INTO customer VALUES (303,"Third Hobby Shop","553 Central Parkway","","Eau Claire","WI","54354","Janice Hilstrom","666-4564564");
    INSERT INTO customer VALUES (304,"Third Ill Hardware","123 Main Street","","Peoria","IL","63434","Ramon Aguirra","630-3434334");
    INSERT INTO customer VALUES (305," Third and Stuff","645W Center Street","","Dubuque","IA","54654","Lavonne Robinson","630-4533456");
    INSERT INTO customer VALUES (306,"Third Hardware","6123 N. Michigan Ave","","Chicago","IL","60104","Michael Mazukelli","640-3453456");
    INSERT INTO customer VALUES (409,"Fourth Hardware","110 Main","","Chicago","IL","60068","Bob Bandy","630-221-9055");
    INSERT INTO customer VALUES (402,"Fourth FIX-IT Shop","65W Elm Street Sqr.","","Madison","WI","65454","","630-34343434");
    INSERT INTO customer VALUES (403,"Fourth Hobby Shop","553 Central Parkway","","Eau Claire","WI","54354","Janice Hilstrom","666-4564564");
    INSERT INTO customer VALUES (404,"Fourth Tools","123 Main Street","","Peoria","IL","63434","Ramon Aguirra","630-3434334");
    INSERT INTO customer VALUES (405,"Fourth and Stuff","645W Center Street","","Dubuque","IA","54654","Lavonne Robinson","630-4533456");
    INSERT INTO customer VALUES (406,"Fourth Ill Hardware","6123 N. Michigan Ave","","Chicago","IL","60104","Michael Mazukelli","640-3453456");
    INSERT INTO customer VALUES (509,"Fifth Hardware","110 Main","","Chicago","IL","60068","Bob Bandy","630-221-9055");
    INSERT INTO customer VALUES (502,"Fifth FIX-IT Shop","65W Elm Street Sqr.","","Madison","WI","65454","","630-34343434");
    INSERT INTO customer VALUES (503,"Fifth Hobby Shop","553 Central Parkway","","Eau Claire","WI","54354","Janice Hilstrom","666-4564564");
    INSERT INTO customer VALUES (504,"Fifth Ill Hardware","123 Main Street","","Peoria","IL","63434","Ramon Aguirra","630-3434334");
    INSERT INTO customer VALUES (505,"Ill Tools and Stuff","645W Center Street","","Dubuque","IA","54654","Lavonne Robinson","630-4533456");
    INSERT INTO customer VALUES (506,"Ill TrueTest Hardware","6123 N. Michigan Ave","","Chicago","IL","60104","Michael Mazukelli","640-3453456");
    INSERT INTO customer VALUES (609,"Sixth Hardware","110 Main","","Chicago","IL","60068","Bob Bandy","630-221-9055");
    INSERT INTO customer VALUES (602,"Sixth FIX-IT Shop","65W Elm Street Sqr.","","Madison","WI","65454","","630-34343434");
    INSERT INTO customer VALUES (603,"Sixth Hobby Shop","553 Central Parkway","","Eau Claire","WI","54354","Janice Hilstrom","666-4564564");
    INSERT INTO customer VALUES (604,"Sixth Ill Hardware","123 Main Street","","Peoria","IL","63434","Ramon Aguirra","630-3434334");
    INSERT INTO customer VALUES (605,"6th Tools","645W Center Street","","Dubuque","IA","54654","Lavonne Robinson","630-4533456");
    INSERT INTO customer VALUES (606,"TrueTest Hardware","6123 N. Michigan Ave","","Chicago","IL","60104","Michael Mazukelli","640-3453456");

    INSERT INTO orders VALUES (1,"2003-04-04",103,"ASC","FEDEX","N");
    INSERT INTO orders VALUES (2,"2003-06-06",104,"ASC","FEDEX","Y");

    INSERT INTO items VALUES (1,456,10,5.55);
    INSERT INTO items VALUES (1,310,5,12.85);
    INSERT INTO items VALUES (1,744,60,250.95);
    INSERT INTO items VALUES (2,456,15,5.55);
    INSERT INTO items VALUES (2,310,2,12.85);

    INSERT INTO stock VALUES (456,"ASC","lightbulbs",5.55,5.0,"2003-6-16","ctn");
    INSERT INTO stock VALUES (310,"ASC","sink stoppers",12.85,11.57,"2003-6-16","grss");
    INSERT INTO stock VALUES (744,"ASC","faucets",250.95,225.86,"2003-6-16","6/bx");

    INSERT INTO factory VALUES ("ASC","Assoc. Std. Co.");
    INSERT INTO factory VALUES ("PHL","Phelps Lighting");

    INSERT INTO state VALUES ("IL","Illinois");
    INSERT INTO state VALUES ("IA","Iowa");
    INSERT INTO state VALUES ("WI","Wisconsin");
END FUNCTION

FUNCTION db_tables_drop()
    WHENEVER ERROR CONTINUE
    DROP TABLE customer;
    DROP TABLE orders;
    DROP TABLE factory;
    DROP TABLE stock;
    DROP TABLE items;
    DROP TABLE state;
    WHENEVER ERROR STOP
END FUNCTION
