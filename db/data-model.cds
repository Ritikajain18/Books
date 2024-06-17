namespace my.bookshop;

using {
  Currency,
  Country,
  managed
} from '@sap/cds/common';

entity Books {
  key ID       : Integer                @title: 'ID';
      title    : localized String(111)  @title: 'Title';
      descr    : localized String(1111) @title: 'Description';
      author   : Association to Authors @title: 'Author';
      stock    : Integer                @title: 'Stock';
      price    : Decimal(9, 2)          @title: 'Price';
      currency : Currency               @title: 'Currency';
}

entity Authors {
  key ID           : Integer     @title: 'Author ID';
      name         : String(111) @title: 'Author Name';
      dateOfBirth  : Date        @title: 'Date of Birth';
      dateOfDeath  : Date        @title: 'Date of Death';
      placeOfBirth : String      @title: 'Place of Birth';
      placeOfDeath : String      @title: 'Place of Death';
      books        : Association to many Books
                       on books.author = $self;
}

entity Orders : managed {
  key ID      : UUID;
      country : Country;
      amount  : Integer;
      book    : Association to one Books;
}
