class StudentAPIService extends cds.ApplicationService {
    async init() {     //initialization method for this class

        const externalDb = await cds.connect.to('API_BUSINESS_PARTNER');
        const onpremise = await cds.connect.to('EmployeeService');

        const { Customers , Orders , A_BusinessPartner, EmployeeSet} = this.entities

        this.before('UPDATE', Customers.drafts, req => {
            const { email } = req.data;
            if (email) {
                const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                const isValid = emailRegex.test(email);

                if (!isValid) {
                    return req.reject({
                        status: 400,
                        message: "Invalid Email Address!!!",
                        target: "email"
                    });

                }
            }
        });

        this.before('CREATE',Orders.drafts, async (req) => {
            req.data.orderDate = new Date();
            return req;
        });

        this.on("updateCustomerStatus", async (req) => {
            const {customerID, name} = req.data;
            if(customerID){
                let customerData = await SELECT.one.from(Customers).where({
                    "customerID":customerID
                });

                if(!customerData){
                    return req.reject(404, "Customer record not found!");
                }

                await UPDATE(Customers).set({
                    status_id:1
                }).where({
                    "customerID": customerID
                });
                return "Status updated Successfully!";
            }
        });

        this.on("updateCustomer", async (req) =>{
            const {customerID} = req;
            
            if(customerID){
                await UPDATE(Customers).set({
                    status_id:2
                }).where({
                    "customerID": customerID
                });
            }
            return;
        });

        // this.after('READ', Books, books => {...})
        // this.on('submitOrder', req => {...})


        this.on('READ', A_BusinessPartner, async (req) => {
            return await externalDb.run(req.query);
        });

        this.on('READ', EmployeeSet, async (req) => {
            return await onpremise.run(req.query);
        });

        return super.init()
    }
}
module.exports = StudentAPIService;
