*&---------------------------------------------------------------------*
*& Report zdemo_ain_cl34
*&---------------------------------------------------------------------*
*& This is the demo program written for book:
*& ALV grid in nutshell by Łukasz Pęgiel
*&---------------------------------------------------------------------*
REPORT zdemo_ain_cl34.

INCLUDE zdemo_ain_include_screen.

PARAMETERS: p_tooltp TYPE lvc_s_fcat-tooltip LOWER CASE.

START-OF-SELECTION.

  SELECT * UP TO 50 ROWS FROM spfli
    INTO TABLE @DATA(flights).

  DATA(grid) = NEW cl_gui_alv_grid(
                    i_parent = NEW cl_gui_custom_container( container_name = 'CC' )
                                   ).
  DATA(fcat) = VALUE lvc_t_fcat(
                                 ( fieldname = 'CARRID' )
                                 ( fieldname = 'CONNID' tooltip = p_tooltp )
                                 ( fieldname = 'COUNTRYFR' )
                                 ( fieldname = 'CITYFROM' )
                                 ( fieldname = 'AIRPFROM' )
                                 ( fieldname = 'COUNTRYTO' )
                                 ( fieldname = 'CITYTO' )
                                 ( fieldname = 'FLTIME'  )
                                 ( fieldname = 'DEPTIME' )
                                 ( fieldname = 'FLTYPE' )
                               ).
  grid->set_table_for_first_display(
    EXPORTING
        is_layout = VALUE #( col_opt = abap_true )
    CHANGING
      it_fieldcatalog               = fcat
      it_outtab                     = flights
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      OTHERS                        = 4
  ).
  IF sy-subrc EQ 0.
    CALL SCREEN 0100.
  ENDIF.
