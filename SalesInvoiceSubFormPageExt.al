pageextension 50150 SalesInvoiceSubFormPageExt extends "Sales Invoice Subform"
{
    layout
    {
        modify("Item Reference No.")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
    }
}