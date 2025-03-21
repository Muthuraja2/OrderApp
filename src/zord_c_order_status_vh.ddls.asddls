@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value help - Order Status'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZORD_C_ORDER_STATUS_VH
  as select from ZORD_I_ORDER_STATUS_VH
{
      @UI.hidden: true
  key domain_name,
      @UI.hidden: true
  key value_position,
      @Consumption.filter.hidden: true
      @EndUserText.label: 'Order Status'
      value_low,
      @Consumption.filter.hidden: true
      text
}
