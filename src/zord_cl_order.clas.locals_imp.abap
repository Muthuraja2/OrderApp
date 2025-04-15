CLASS lhc_orderitems DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS valItemLimits FOR VALIDATE ON SAVE
      IMPORTING keys FOR OrderItems~valItemLimits.
    METHODS detOrderAmount FOR DETERMINE ON SAVE
      IMPORTING keys FOR OrderItems~detOrderAmount.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR OrderItems RESULT result.

ENDCLASS.

CLASS lhc_orderitems IMPLEMENTATION.

  METHOD valItemLimits.

    READ ENTITIES OF zord_r_order IN LOCAL MODE
        ENTITY OrderItems
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(lt_order_items).

    DATA(order_id) = VALUE #( lt_order_items[ 1 ]-Orderid OPTIONAL ).

    READ ENTITIES OF zord_r_order IN LOCAL MODE
        ENTITY Order BY \_items
        ALL FIELDS WITH VALUE #( ( %tky-Orderid = order_id ) )
        RESULT DATA(lt_total_items).

    IF lines( lt_total_items ) > 5.
      failed-order = VALUE #( BASE failed-order ( %tky-Orderid = order_id  ) ).
      reported-order = VALUE #( BASE reported-order ( %tky-Orderid = order_id
                                                      %msg = new_message_with_text( text = 'Order Items should be less than 5' ) ) ).
    ENDIF.


  ENDMETHOD.

  METHOD detOrderAmount.

    READ ENTITIES OF zord_r_order IN LOCAL MODE
        ENTITY OrderItems
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(lt_order_items).

    DATA(order_id) = VALUE #( lt_order_items[ 1 ]-Orderid OPTIONAL ).

    READ ENTITIES OF zord_r_order IN LOCAL MODE
        ENTITY Order BY \_items
        FIELDS ( Quantity Unitprice ) WITH VALUE #( ( %tky-Orderid = order_id ) )
        RESULT DATA(lt_total_items).

    DATA(total_amount) = 0.
    LOOP AT lt_total_items INTO DATA(item).
      total_amount += ( item-Quantity * item-Unitprice ).
    ENDLOOP.

    MODIFY ENTITIES OF zord_r_order IN LOCAL MODE
        ENTITY Order
        UPDATE SET FIELDS WITH VALUE #( ( %tky-Orderid = order_id Amount = total_amount ) )
        FAILED DATA(failed_u)
        REPORTED DATA(reported_u).

  ENDMETHOD.

  METHOD get_instance_features.

    READ ENTITIES OF zord_r_order IN LOCAL MODE
        ENTITY OrderItems
        FIELDS ( OrderId )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_order_items).

    LOOP AT lt_order_items INTO DATA(item).

      DATA(order_id) = item-Orderid.

      READ ENTITIES OF zord_r_order IN LOCAL MODE
      ENTITY Order
      FIELDS ( Status )
      WITH VALUE #( ( %tky-%key-OrderId = order_id ) )
      RESULT DATA(lt_order).

      LOOP AT lt_order INTO DATA(order).

        DATA(update_delete_feature) = SWITCH abp_behv_op_ctrl(
            order-Status
            WHEN 'CMP' OR 'CAN' THEN if_abap_behv=>fc-o-disabled
            ELSE if_abap_behv=>fc-o-enabled ).

        result = VALUE #( BASE result ( %tky-%key-Orderitemid = item-%tky-%key-Orderitemid
                                        %is_draft = item-%is_draft
                                        %update = update_delete_feature
                                        %delete = update_delete_feature  ) ).

      ENDLOOP.

    ENDLOOP.


  ENDMETHOD.

ENDCLASS.

CLASS lhc_Order DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS cancel FOR MODIFY
      IMPORTING keys FOR ACTION order~cancel.

    METHODS complete FOR MODIFY
      IMPORTING keys FOR ACTION order~complete.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR order RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR order RESULT result.

ENDCLASS.

CLASS lhc_Order IMPLEMENTATION.

  METHOD cancel.

    READ ENTITIES OF zord_r_order IN LOCAL MODE
      ENTITY Order
      FIELDS ( Comments )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_orders).

    LOOP AT lt_orders INTO DATA(order).
      CHECK order-Comments IS INITIAL.
      failed-order = VALUE #( BASE failed-order ( %tky-%key-Orderid = order-%key-Orderid ) ).
      reported-order = VALUE #( BASE reported-order ( %tky-%key-Orderid = order-%key-Orderid
                                                      %msg = new_message_with_text( text = 'Comment is mandatory for Cancellation' ) ) ).
    ENDLOOP.

    CHECK ( failed-order IS INITIAL AND reported-order IS INITIAL ).

    MODIFY ENTITIES OF zord_r_order IN LOCAL MODE
        ENTITY Order
        UPDATE FIELDS ( Status )
        WITH VALUE #( FOR key IN keys ( %tky-%key-Orderid = key-%key-Orderid
                                        %data-Status = 'CAN' ) )
        FAILED DATA(ls_failed)
        REPORTED DATA(ls_reported).

    IF ( ls_failed-order IS NOT INITIAL OR ls_reported IS NOT INITIAL ).
      failed = CORRESPONDING #( DEEP ls_failed ).
      reported = CORRESPONDING #( DEEP ls_reported ).
    ENDIF.

  ENDMETHOD.

  METHOD complete.

    MODIFY ENTITIES OF zord_r_order IN LOCAL MODE
        ENTITY Order
        UPDATE FIELDS ( Status )
        WITH VALUE #( FOR key IN keys ( %tky-%key-Orderid = key-%key-Orderid
                                        %data-Status = 'CMP' ) )
        FAILED DATA(ls_failed)
        REPORTED DATA(ls_reported).

    IF ( ls_failed-order IS NOT INITIAL OR ls_reported IS NOT INITIAL ).
      failed = CORRESPONDING #( DEEP ls_failed ).
      reported = CORRESPONDING #( DEEP ls_reported ).
    ENDIF.

  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_instance_features.

    READ ENTITIES OF zord_r_order IN LOCAL MODE
        ENTITY Order
        FIELDS ( Status )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_order).

    LOOP AT lt_order INTO DATA(order).

      DATA(create_item_feature) = SWITCH abp_behv_op_ctrl(
          order-Status
          WHEN 'CMP' OR 'CAN' THEN if_abap_behv=>fc-o-disabled
          ELSE if_abap_behv=>fc-o-enabled ).

      result = VALUE #( BASE result ( %tky-%key-Orderid = order-%tky-%key-Orderid
                                      %is_draft = order-%is_draft
                                      %assoc-_items = create_item_feature  ) ).

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
