@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Restricted Reuse view - Orders'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZORD_R_ORDER
  as select from ZORD_I_ORDER
  composition [0..*] of ZORD_R_ORDER_ITEMS as _items
{
  key Orderid,
      Customerid,
      Orderdate,
      Currency,
      @Semantics.amount.currencyCode: 'Currency'
      Amount,
      Status,
      Comments,
      Createdby,
      Createdat,
      Lastchangedby,
      Changedat,
      _items // Make association public
}
