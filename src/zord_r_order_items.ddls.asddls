@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Restricted Reuse view - Order Items'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZORD_R_ORDER_ITEMS
  as select from ZORD_I_ORDER_ITEMS
  association to parent ZORD_R_ORDER as _header on $projection.Orderid = _header.Orderid
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
      _header // Make association public
}
