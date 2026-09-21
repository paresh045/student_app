namespace student.db;

using {
    cuid,
    managed
} from '@sap/cds/common';

type nameType : String(50);

aspect customAspect{
    status: String;
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
