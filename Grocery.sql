create database GroceryStore;

use GroceryStore;


CREATE TABLE users (
    id int,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    user_type ENUM('buyer', 'shopkeeper') NOT NULL,
    primary key(username));
create table products (
	id int not null auto_increment,
    name varchar(20) default null,
    category varchar(15) default null,
    price float,
    unit varchar(20),
    availableQty int,
    description varchar(100) default null,
	shopkeeper_username varchar(255),
    primary key (id)

);

insert products(name, category, price, unit, availableQty, description,shopkeeper_username)
values ("Tomato", "Vegetable", 12, "g", 1000, "Red Organic Tomato",'NullCommand'),
("Broccoli", "Vegetable", 4.99, "ea", 350, "Green Organic Broccoli",'NullCommand'),
("Eggplant", "Vegetable", 2.52, "g", 500, "Organic Local Eggplant",'NullCommand'),
("Apple", "Fruit", 1.19, "kg", 2500, "Royal Gala Apples",'NullCommand'),
("Mango", "Fruit", 0.99, "ea", 100, "Red Large Mangoes",'NullCommand'),
("Kiwi", "Fruit", 6.99, "g", 800, "Green large Kiwi",'NullCommand'),
("Beef", "Meat", 13.11, "kg", 550, "Striploin Bone In Beef",'NullCommand'),
("Chicken", "Meat", 13.93, "ea", 1200, "Fresh Free Run Chicken",'NullCommand'),
("Pork", "Meat", 11.15, "kg", 500, "Picnic Portion Pork Shoulder Blade Roast",'NullCommand'),
("Milk", "Dairy", 0.27, "ml", 750, "3.25% Fine Filtered Milk 2L",'NullCommand'),
("Yogurt", "Dairy", 3, "ea", 300, "Liberte Classique Strawberry Yogurt",'NullCommand'),
("Twist Cheese", "Dairy", 7.99, "ea", 520, "Mozzarella Cheddar Twists Natural Whole Milk Cheese",'NullCommand');


create table orders (
	id int not null auto_increment,
    username varchar(255) not null,
    total float,
    orderDate date not null,
    deliveryDate date not null,
    primary key (id)
);

create table orderProducts (
	id int not null auto_increment,
    orderid varchar(20) not null,
    productId bigint not null,
    username varchar(255),
    quantity INT NOT NULL,
    price float not null,
    primary key (id)
);

CREATE TABLE Wishlist (
    username VARCHAR(255) NOT NULL, -- Foreign key referencing the user who created the wishlist
    product_id INT, -- Foreign key referencing the product in the store
    quantity INT NOT NULL,
    price float not null,
    primary key(username,product_id));
