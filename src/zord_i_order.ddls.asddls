@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view - Orders'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZORD_I_ORDER
  as select from zord_order
{
  key orderid       as Orderid,
      customerid    as Customerid,
      orderdate     as Orderdate,
      curr          as Currency,
      @Semantics.amount.currencyCode: 'Currency'
      amount        as Amount,
      status        as Status,
      comments      as Comments,
      createdby     as Createdby,
      createdat     as Createdat,
      lastchangedby as Lastchangedby,
      changedat     as Changedat
}
