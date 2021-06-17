CLASS zcl_abap_unit_demo_db DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: zif_abap_unit_demo.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abap_unit_demo_db IMPLEMENTATION.
  METHOD zif_abap_unit_demo~get_rating.
*    TEST-SEAM get_sales.
    SELECT FROM snwd_so AS so
  	INNER JOIN snwd_bpa AS bpa
  	ON bpa~node_key = so~buyer_guid
  	FIELDS  gross_amount,
  		net_amount,
  		bpa~company_name,
  		bpa~bp_id AS customer_id,
      so~so_id AS salesorder_id,
      so~currency_code
  	WHERE bpa~bp_id = @iv_customer INTO TABLE @DATA(lt_rating)  .
*    end-test-SEAM.
    et_sales_orders = CORRESPONDING #( lt_rating ).
  ENDMETHOD.

ENDCLASS.
