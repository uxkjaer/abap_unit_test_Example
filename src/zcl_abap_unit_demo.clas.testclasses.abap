*"* use this source file for your ABAP unit test classes
CLASS lcl_abap_unit_demo DEFINITION
FINAL
FOR TESTING
RISK LEVEL HARMLESS
DURATION SHORT.

  PUBLIC SECTION.
  PRIVATE SECTION.
    DATA mo_cut TYPE REF TO zcl_abap_unit_demo.
    DATA mo_db TYPE REF TO zif_abap_unit_demo.
    METHODS: setup,
      check_instance_of_cut FOR TESTING RAISING cx_static_check,
      get_customer FOR TESTING RAISING cx_static_check,
      get_not_customer FOR TESTING RAISING cx_static_check,
      get_gold_rating FOR TESTING RAISING cx_static_check,
      get_not_gold_rating FOR TESTING RAISING cx_static_check,
      get_silver_rating FOR TESTING RAISING cx_static_check,
      get_bronze_rating FOR TESTING RAISING cx_static_check,
      get_exception FOR TESTING RAISING cx_static_check,
      set_data IMPORTING iv_customer TYPE snwd_bpa-bp_id
                         it_orders   TYPE zif_abap_unit_demo=>tt_output.

ENDCLASS.

CLASS lcl_abap_unit_demo IMPLEMENTATION.
  METHOD setup.
    DATA: lt_output TYPE zif_abap_unit_demo=>tt_output.
    mo_db ?= cl_abap_testdouble=>create( 'zif_abap_unit_demo' ).

    mo_cut = NEW zcl_abap_unit_demo( mo_db ).

*    TEST-INJECTION get_sales.
*
*        lt_output = value zif_abap_unit_demo=>tt_output( ( company_name = 'QH' customer_id = '100000000' salesorder_id = '1' gross_amount = '100' net_amount = '70' currency_code = 'USD' ) ).
*    END-TEST-INJECTION.



  ENDMETHOD.



  METHOD check_instance_of_cut.
    cl_abap_unit_assert=>assert_bound( mo_cut ).
  ENDMETHOD.

  METHOD get_customer.
    DATA: lt_sales  TYPE zif_abap_unit_demo=>tt_output.
    lt_sales = VALUE zif_abap_unit_demo=>tt_output( ( company_name = 'QH' customer_id = '100000000' salesorder_id = '1' gross_amount = '100' net_amount = '70' currency_code = 'USD' ) ).
    set_data( iv_customer =  '100000000' it_orders = lt_sales ).

    cl_abap_unit_assert=>assert_not_initial( mo_cut->get_sales_orders( iv_customer = '100000000'  ) ).

  ENDMETHOD.

  METHOD get_not_customer.

    cl_abap_unit_assert=>assert_initial( mo_cut->get_sales_orders( iv_customer = '100000001'  ) ).

  ENDMETHOD.

  METHOD get_gold_rating.
    DATA: lt_sales  TYPE zif_abap_unit_demo=>tt_output.

    lt_sales = VALUE zif_abap_unit_demo=>tt_output( ( company_name = 'QH' customer_id = '100000000' salesorder_id = '1' gross_amount = '100' net_amount = '70' currency_code = 'USD' ) ).
    set_data( iv_customer =  '100000000' it_orders = lt_sales ).
    DATA(lt_output) = mo_cut->get_sales_orders( iv_customer = '100000000'  ).

    cl_abap_unit_assert=>assert_equals( act = lt_output[ 1 ]-rating exp = 'GOLD' ).
  ENDMETHOD.

  METHOD get_not_gold_rating.
    DATA: lt_sales  TYPE zif_abap_unit_demo=>tt_output.

    lt_sales = VALUE zif_abap_unit_demo=>tt_output( ( company_name = 'QH' customer_id = '100000000' salesorder_id = '1' gross_amount = '80' net_amount = '70' currency_code = 'USD' ) ).
    set_data( iv_customer =  '100000000' it_orders = lt_sales ).

    DATA(lt_output) = mo_cut->get_sales_orders( iv_customer = '100000000'  ).

    cl_abap_unit_assert=>assert_equals( act = lt_output[ 1 ]-rating exp = 'SILVER' ).
  ENDMETHOD.

  METHOD get_silver_rating.
    DATA: lt_sales  TYPE zif_abap_unit_demo=>tt_output.

    lt_sales = VALUE zif_abap_unit_demo=>tt_output( ( company_name = 'QH' customer_id = '100000000' salesorder_id = '1' gross_amount = '80' net_amount = '70' currency_code = 'USD' ) ).
    set_data( iv_customer =  '100000000' it_orders = lt_sales ).

    DATA(lt_output) = mo_cut->get_sales_orders( iv_customer = '100000000'  ).

    cl_abap_unit_assert=>assert_equals( act = lt_output[ 1 ]-rating exp = 'SILVER' ).
  ENDMETHOD.


  METHOD get_bronze_rating.
    DATA: lt_sales  TYPE zif_abap_unit_demo=>tt_output.

    lt_sales = VALUE zif_abap_unit_demo=>tt_output( ( company_name = 'QH' customer_id = '100000000' salesorder_id = '1' gross_amount = '75' net_amount = '70' currency_code = 'USD' ) ).
    set_data( iv_customer =  '100000000' it_orders = lt_sales ).

    DATA(lt_output) = mo_cut->get_sales_orders( iv_customer = '100000000'  ).

    cl_abap_unit_assert=>assert_equals( act = lt_output[ 1 ]-rating exp = 'BRONZE' ).
  ENDMETHOD.

  METHOD get_exception.
    DATA: lt_sales  TYPE zif_abap_unit_demo=>tt_output.
    TRY.
        lt_sales = VALUE zif_abap_unit_demo=>tt_output( ( company_name = 'QH' customer_id = '100000000' salesorder_id = '1' gross_amount = '50' net_amount = '70' currency_code = 'USD' ) ).
        set_data( iv_customer =  '100000000' it_orders = lt_sales ).
        DATA(lt_output) = mo_cut->get_sales_orders( iv_customer = '100000000'  ).
      CATCH cx_nwdemo_bp INTO DATA(cx).
        " handle error
        cl_abap_unit_assert=>assert_not_initial( cx ).
    ENDTRY.





  ENDMETHOD.
  METHOD set_data.
    " Step 1: Set the desired returning value for the called method
    "         of the test double:
    cl_abap_testdouble=>configure_call( mo_db )->returning( it_orders ).
    " Step 2: Specify the method to be called and the parameters
    "         associated with the call that will return the value
    "         configured in the previous step:
    mo_db->get_rating( iv_customer ).
  ENDMETHOD.

ENDCLASS.
