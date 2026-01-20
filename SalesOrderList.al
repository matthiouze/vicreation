pageextension 50181 SalesOrderListExt extends "Sales Order List"
{
    layout
    {
        modify("External Document No.")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
    }
}
