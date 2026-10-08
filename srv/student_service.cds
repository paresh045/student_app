using {student.db as model} from '../db/schema';
using {API_BUSINESS_PARTNER as external} from './external/API_BUSINESS_PARTNER';
using {EmployeeService as onpremise} from './external/EmployeeService';

//@impl './student_service'
service StudentAPIService {
    entity StudentSet        as projection on model.Students;
    entity Authors           as projection on model.Authors; //due to Composition we need not to expose Books table here//Books will se in metadata
    entity Status            as projection on model.Status;
    entity Products          as projection on model.Products;

    @odata.draft.enabled
    entity Customers         as projection on model.Customers
        actions {
            action updateCustomer() returns String;
        }


    entity Orders            as projection on model.Orders;
    entity OrderItems        as projection on model.OrderItems;

    //unbound Actions
    action updateCustomerStatus(customerID: String, name: String) returns String;

    // entity ITEmployees as select ID, name from model.Employees where department.departmentID = 'IT';

    //External Entity

    entity A_BusinessPartner as projection on external.A_BusinessPartner;
    entity EmployeeSet as projection on onpremise.EmployeeSet;
}
