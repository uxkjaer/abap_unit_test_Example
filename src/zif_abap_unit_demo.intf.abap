INTERFACE zif_abap_unit_demo
  PUBLIC .
  TYPES: BEGIN OF ty_output,
  	salesorder_id TYPE snwd_so_id,
  	customer_id TYPE snwd_partner_id,
  	company_name TYPE snwd_company_name,
  	currency_code TYPE snwd_curr_code,
  	gross_amount TYPE snwd_ttl_gross_amount,
  	net_amount TYPE snwd_ttl_net_amount,
    rating TYPE char10,
  	END OF ty_output,
    ts_output TYPE ty_output,
    tt_output TYPE TABLE OF ty_output WITH KEY salesorder_id.

  METHODS get_rating
    IMPORTING iv_customer     TYPE snwd_bpa-bp_id
    RETURNING VALUE(et_sales_orders) TYPE zif_abap_unit_demo=>tt_output.

ENDINTERFACE.
