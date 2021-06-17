CLASS zcl_abap_unit_demo DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING io_db TYPE REF TO zif_abap_unit_demo OPTIONAL.
    METHODS get_sales_orders IMPORTING iv_customer            TYPE snwd_bpa-bp_id
                             RETURNING VALUE(et_sales_orders) TYPE zif_abap_unit_demo=>tt_output
                             RAISING
                                       cx_nwdemo_bp.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA mo_db TYPE REF TO zif_abap_unit_demo.

ENDCLASS.



CLASS zcl_abap_unit_demo IMPLEMENTATION.
  METHOD constructor.
    IF io_db IS BOUND.
      mo_db = io_db.
    ELSE.
      mo_db = NEW zcl_abap_unit_demo_db( ).
    ENDIF.
  ENDMETHOD.

  METHOD get_sales_orders.

*  TEST-SEAM get_sales.
*   DATA: lt_output TYPE zif_abap_unit_demo=>tt_output.
*      SELECT FROM snwd_so AS so
*        INNER JOIN snwd_bpa AS bpa
*        ON bpa~node_key = so~buyer_guid
*        FIELDS  gross_amount,
*            net_amount,
*            bpa~company_name,
*            bpa~bp_id as customer_id
*        WHERE bpa~bp_id = @iv_customer INTO CORRESPONDING FIELDS OF TABLE @lt_output.
*    end-test-SEAM.
*    et_sales_orders = CORRESPONDING #( lt_output ).
    et_sales_orders = mo_db->get_rating( iv_customer = iv_customer ).

    LOOP AT et_sales_orders ASSIGNING FIELD-SYMBOL(<ls_order>).
      IF <ls_order>-gross_amount - <ls_order>-net_amount > 10.
        <ls_order>-rating = 'GOLD'.
      ELSEIF <ls_order>-gross_amount - <ls_order>-net_amount > 5 AND <ls_order>-gross_amount - <ls_order>-net_amount <= 10.
        <ls_order>-rating = 'SILVER'.
      ELSEIF <ls_order>-gross_amount - <ls_order>-net_amount > 0.
        <ls_order>-rating = 'BRONZE'.
      ELSE.
        RAISE EXCEPTION TYPE cx_nwdemo_bp.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
