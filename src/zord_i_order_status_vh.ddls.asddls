@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value help - Order Status'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZORD_I_ORDER_STATUS_VH
  as select from ZORD_I_ORDER_STATUS_FIX_VAL
  association [0..*] to ZORD_I_ORDER_STATUS_FIX_VAL_T as _FixedValueText on  $projection.domain_name    = _FixedValueText.domain_name
                                                                         and $projection.value_position = _FixedValueText.value_position
                                                                         and _FixedValueText.language   = $session.system_language
{
  key domain_name,
  key value_position,
      value_low,
      _FixedValueText.text
}
