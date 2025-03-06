@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view - Order Items'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZORD_I_ORDER_ITEMS
  as select from zord_order_i
{
  key orderitemid   as Orderitemid,
      orderid       as Orderid,
      productname   as Productname,
      unitfield     as Unitfield,
      @Semantics.quantity.unitOfMeasure: 'Unitfield'
      quantity      as Quantity,
      cukyfield     as Cukyfield,
      @Semantics.amount.currencyCode: 'Cukyfield'
      unitprice     as Unitprice,
      createdby     as Createdby,
      createdat     as Createdat,
      lastchangedby as Lastchangedby,
      changedat     as Changedat
}
