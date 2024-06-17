using my.bookshop as my from '../db/data-model';

// annotation to provide a path to the service (CAPM uses OData V4 by default since it has lightweight payload, gateway uses V2 so the payload looks different )

service CatalogService {
    // @readonly
    @odata.draft.enabled
    entity Books   as projection on my.Books;
    entity Authors as projection on my.Authors;
    // @odata.draft.enabled
    entity Orders  as projection on my.Orders;
    // annotate my.Orders with @odata.draft.enabled;
}
