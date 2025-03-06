@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view - Order Items'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZORD_C_ORDER_ITEMS
  as projection on ZORD_R_ORDER_ITEMS
{
  key Orderitemid,
      Orderid,
      Productname,
      Unitfield,
      @Semantics.quantity.unitOfMeasure: 'Unitfield'
      Quantity,
      Cukyfield,
      @Semantics.amount.currencyCode: 'Cukyfield'
      Unitprice,
      Createdby,
      Createdat,
      Lastchangedby,
      Changedat,
      /* Associations */
      _header : redirected to parent ZORD_C_ORDER
}
