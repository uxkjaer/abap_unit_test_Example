*&---------------------------------------------------------------------*
*& Report zabap_unit_demo
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_unit_demo.

*======================================================================
*
*   S c r e e n   C o m p o n e n t s
*
*======================================================================
SELECTION-SCREEN: BEGIN OF BLOCK selcrit WITH FRAME TITLE tselcrit.
  PARAMETERS: p_cust TYPE snwd_bpa-bp_id OBLIGATORY .
SELECTION-SCREEN: END OF BLOCK selcrit.

*======================================================================
*
*   Initialize dependent components
*
*======================================================================
INITIALIZATION.

  DATA(lo_sales) = NEW zcl_abap_unit_demo( ).


*======================================================================
*
*   Start of Selection
*
*======================================================================
START-OF-SELECTION.
  DATA(lt_output) = lo_sales->get_sales_orders( p_cust ).
  cl_demo_output=>display( lt_output ).
