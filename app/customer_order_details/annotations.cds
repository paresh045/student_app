using StudentAPIService as service from '../../srv/student_service';
using from '@sap/cds/common';
using from '../../db/schema';


annotate service.Customers with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : address,
            Label : '{i18n>Address}',
        },
        {
            $Type : 'UI.DataField',
            Value : customerID,
            Label : '{i18n>CustomerId}',
        },
        {
            $Type : 'UI.DataField',
            Value : name,
            Label : '{i18n>Name1}',
        },
        {
            $Type : 'UI.DataField',
            Value : email,
            Label : '{i18n>Email}',
        },
        {
            $Type : 'UI.DataField',
            Value : mobile,
            Label : '{i18n>Mobile}',
        },
        {
            $Type : 'UI.DataField',
            Value : country,
        },
        {
            $Type : 'UI.DataField',
            Value : status.name,
            Label : 'name',
        },
    ],
    UI.SelectionFields : [
        country,
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>CustomerDetails}',
            ID : 'i18nCustomerDetails',
            Target : '@UI.FieldGroup#i18nCustomerDetails',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Order Details',
            ID : 'OrderDetails',
            Target : 'orders/@UI.LineItem#OrderDetails1',
        },
    ],
    UI.FieldGroup #i18nCustomerDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : address,
            },
            {
                $Type : 'UI.DataField',
                Value : customerID,
            },
            {
                $Type : 'UI.DataField',
                Value : email,
            },
            {
                $Type : 'UI.DataField',
                Value : mobile,
            },
            {
                $Type : 'UI.DataField',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Value : country,
            },
            {
                $Type : 'UI.DataField',
                Value : status.name,
                Label : 'Status',
                Criticality : status.criticality,
                CriticalityRepresentation : #WithIcon,
            },
            {
                $Type : 'UI.DataField',
                Value : products.category,
                Label : 'category',
            },
            {
                $Type : 'UI.DataField',
                Value : products.description,
                Label : 'description',
            },
            {
                $Type : 'UI.DataField',
                Value : products.name,
                Label : 'name',
            },
            {
                $Type : 'UI.DataField',
                Value : products.price,
                Label : 'price',
            },
            {
                $Type : 'UI.DataField',
                Value : products.stock,
                Label : 'stock',
            },
            {
                $Type : 'UI.DataField',
                Value : products_productID,
                Label : 'Products',
            },
        ],
    },
    UI.DataPoint #name : {
        $Type : 'UI.DataPointType',
        Value : name,
        Title : 'name',
    },
    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'name',
            Target : '@UI.DataPoint#name',
        },
    ],
    UI.DataPoint #name1 : {
        $Type : 'UI.DataPointType',
        Value : name,
        Title : 'name',
    },
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : name,
        },
        TypeName : 'Customer',
        TypeNamePlural : 'Customers',
    },
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'StudentAPIService.updateCustomer',
            Label : 'Deactivate',
            Criticality : #Negative,
        },
    ],
);

annotate service.Customers with {
    country @(
        Common.ValueListWithFixedValues : true,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Countries',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : country_code,
                    ValueListProperty : 'name',
                },
            ],
            Label : 'Countries',
        },
        Common.ExternalID : country.code,
    )
};

annotate service.Orders with @(
    UI.LineItem #OrderDetails : [
        {
            $Type : 'UI.DataField',
            Value : orderID,
            Label : 'orderID',
        },
        {
            $Type : 'UI.DataField',
            Value : orderDate,
            Label : 'orderDate',
        },
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'OrderDetails',
            ID : 'OrderDetails',
            Target : '@UI.FieldGroup#OrderDetails',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'OrderItems',
            ID : 'OrderItems',
            Target : 'orderItems/@UI.LineItem#OrderItems',
        },
    ],
    UI.FieldGroup #OrderDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : orderDate,
                Label : 'orderDate',
            },
            {
                $Type : 'UI.DataField',
                Value : orderID,
                Label : 'orderID',
            },
        ],
    },
    UI.HeaderInfo : {
        TypeName : '',
        TypeNamePlural : '',
        Title : {
            $Type : 'UI.DataField',
            Value : customers.name,
        },
    },
    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'orderID',
            Target : '@UI.DataPoint#orderID',
        },
    ],
    UI.LineItem #OrderDetails1 : [
        {
            $Type : 'UI.DataField',
            Value : orderDate,
            Label : 'orderDate',
        },
        {
            $Type : 'UI.DataField',
            Value : orderID,
            Label : 'orderID',
        },
        {
            $Type : 'UI.DataField',
            Value : customers_customerID,
            Label : 'customers_customerID',
        },
    ],
    UI.DataPoint #orderID : {
        $Type : 'UI.DataPointType',
        Value : orderID,
        Title : 'orderID',
    },
);

// annotate service.Orders with {
//     customers @Common.FieldControl : #ReadOnly
// };

annotate service.OrderItems with @(
    UI.LineItem #OrderItems : [
        {
            $Type : 'UI.DataField',
            Value : id,
            Label : 'id',
        },
        {
            $Type : 'UI.DataField',
            Value : product,
            Label : 'product',
        },
        {
            $Type : 'UI.DataField',
            Value : quantity,
            Label : 'quantity',
        },
    ]
);

annotate service.Customers with @(
    Common.SideEffects: {
        SourceProperties : [
            'products_productID'
        ],
        TargetProperties : [
            'products/name',
            'products/category',
            'products/description',
            'products/price',
            'products/stock'
        ]
    }
);
annotate service.Customers with {
    products @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Products',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : products_productID,
                    ValueListProperty : 'productID',
                },
            ],
            Label : 'Products',
        },
        Common.ValueListWithFixedValues : true,
)};

annotate service.Products with {
    productID @(
        Common.Text : name,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};

