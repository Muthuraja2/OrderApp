@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Text Fixed Value CDS view - Order Status'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZORD_I_ORDER_STATUS_FIX_VAL_T
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZORD_STATUS' )
{
  key domain_name,
  key value_position,
  key language,
      value_low,
      text
}
