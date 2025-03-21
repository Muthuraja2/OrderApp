@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Fixed Value CDS view - Order status'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZORD_I_ORDER_STATUS_FIX_VAL
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE( p_domain_name: 'ZORD_STATUS' )
{
  key domain_name,
  key value_position,
      value_low
}
