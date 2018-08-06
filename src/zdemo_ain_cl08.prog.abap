*&---------------------------------------------------------------------*
*& Report zdemo_ain_cl08
*&---------------------------------------------------------------------*
*& This is the demo program written for book:
*& ALV grid in nutshell by Łukasz Pęgiel
*&---------------------------------------------------------------------*
report zdemo_ain_cl08.
include zdemo_ain_include_screen.

parameters: currency type tcurr-fcurr default 'JPY'.


start-of-selection.

select * up to 50 rows from sflight into table @data(flights).

data(grid) = new cl_gui_alv_grid(
                  i_parent = new cl_gui_custom_container( container_name = 'CC' )
                                 ).
data(fcat) = value lvc_t_fcat(
                               ( fieldname = 'CARRID'  )
                               ( fieldname = 'CONNID' )
                               ( fieldname = 'PRICE' currency = currency )
                               ( fieldname = 'CURRENCY' )
                             ).

grid->set_table_for_first_display(
  changing
    it_fieldcatalog               = fcat
    it_outtab                     = flights
  exceptions
    invalid_parameter_combination = 1
    program_error                 = 2
    too_many_lines                = 3
    others                        = 4
).
if sy-subrc eq 0.
  call screen 0100.
endif.
