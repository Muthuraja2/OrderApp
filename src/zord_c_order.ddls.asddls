@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view - Orders'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZORD_C_ORDER
  provider contract transactional_query
  as projection on ZORD_R_ORDER
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
      /* Associations */
      _items : redirected to composition child ZORD_C_ORDER_ITEMS 
}
