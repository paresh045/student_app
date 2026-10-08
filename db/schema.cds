namespace student.db;

using {
    cuid,
    managed,
    Country
} from '@sap/cds/common';

type nameType : String(50);

aspect customAspect {
    status : String;
}

entity Students : cuid, managed, customAspect {
    //key studentID : UUID;
    name    : nameType;
    address : String;
    email   : nameType;
    mobile  : String;
    age     : Integer;
    gender  : String;
}

entity Courses : cuid, managed {
    //key courseID: UUID;
    name     : nameType;
    cost     : Decimal(10, 2);
    trainer  : String;
    duration : Integer;
}

entity Address {
    key addressID   : Integer;
        description : String;
        city        : String;
        country     : String;
        pincode     : Integer;
}

entity Books : cuid {
    name        : String;
    title       : String;
    publishDate : String;
    author      : Association to one Authors; //managed Association we can use $ sign
}

entity Authors : cuid {
    name  : String;
    books : Composition of many Books
                on books.author = $self;
}

entity Departments {
    key departmentID : Integer;
        name         : String(50);
//employee : Association to one Employees;
}

entity Employees {
    key ID         : UUID;
        name       : String(50);
        address    : String(50);
        email      : String(50);
        department : Association to Departments; //Association to one Departments
}

entity Orders {
    key orderID    : UUID;
        orderDate  : Date;
        customers  : Association to one Customers;
        orderItems : Composition of many OrderItems
                         on orderItems.order = $self;
}

entity Customers {
    key customerID : UUID;
        name       : String(50) @title: '{i18n>name}';
        address    : String     @title: '{i18n>Address}';
        email      : String     @title: '{i18n>Email}';
        mobile     : String     @title: '{i18n>Mobile}';
        orders     : Composition of many Orders
                         on orders.customers = $self;
        country    : Country;
        status     : Association to Status;
        products     : Association to Products;
}


entity OrderItems {
    key id       : UUID;
        product  : String(100);
        quantity : Integer;
        order    : Association to one Orders;
}

entity Status {
    key id          : Integer;
        name        : String;
        criticality : Integer;
}

entity Products {
    key productID: Integer;
    name: String;
    price: Decimal(10,2);
    category: String;
    description: String;
    stock: Integer;
}