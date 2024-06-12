using CatalogService as service from '../../srv/cat-service';
using from '../../db/data-model';

// annotate service.Books with @(
//     SelectionFields: [ ID, title, author.name ],
//     LineItem: [
//             { Value: ID },
//             { Value: title },
//             { Value: author.name },
//             { Value: price },
//             { Value: currency_code }
//         ],
// );
// annotate service.Books with @(
//     UI.FieldGroup #GeneratedGroup1 : {
//         $Type : 'UI.FieldGroupType',
//         Data : [
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'ID',
//                 Value : ID,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'title',
//                 Value : title,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'stock',
//                 Value : stock,
//             },
//         ],
//     },
//     UI.Facets : [
//         {
//             $Type : 'UI.ReferenceFacet',
//             ID : 'GeneratedFacet1',
//             Label : 'General Information',
//             Target : '@UI.FieldGroup#GeneratedGroup1',
//         },
//     ]
// );

annotate service.Books with @(UI: {
    HeaderInfo      : {
        TypeName      : 'Book',
        TypeNamePlural: 'Books',
        Title         : {Value: ID},
        Description   : {Value: title}
    },
    SelectionFields : [
        ID,
        title,
        author.name
    ],
    LineItem        : [
        {Value: ID},
        {Value: title},
        {Value: author.name},
        {Value: price},
        {Value: currency_code}
    ],
    Facets          : [{
        $Type : 'UI.CollectionFacet',
        Label : 'Book Info',
        Facets: [{
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#Main',
            Label : 'Books'
        }
        ]
    },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Orders',
            ID : 'Orders',
            Target : 'texts/@UI.LineItem#Orders',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Author Info',
            ID : 'Books',
            Target : '@UI.FieldGroup#Books',
        }
    
    ],
    
    FieldGroup #Main: {Data: [
        {Value: ID},
        {Value: title},
        {Value: author_ID},
        {Value: price},
        {Value: currency_code}
    ]}
});
annotate service.Books.texts with @(
    UI.LineItem #Orders : [
        {
            $Type : 'UI.DataField',
            Value : title,
            Label : 'Orders',
        },{
            $Type : 'UI.DataField',
            Value : ID,
        },{
            $Type : 'UI.DataField',
            Value : descr,
        },]
);


annotate service.Books with @(
    UI.FieldGroup #Books : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataFieldForAnnotation',
                Target : '@UI.ConnectedFields#connected',
                Label : 'Authors',
            },],
    }
);
annotate service.Books with @(
    UI.ConnectedFields #connected : {
        $Type : 'UI.ConnectedFieldsType',
        Template : '{author_ID} {author_name}',
        Data : {
            $Type : 'Core.Dictionary',
            author_ID : {
                $Type : 'UI.DataField',
                Value : author.ID,
            },
            author_name : {
                $Type : 'UI.DataField',
                Value : author.name,
            },
        },
    }
);
