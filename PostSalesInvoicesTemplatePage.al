pageextension 50180 PostSalesInvoicesTemplatePage extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field(ReferenceClient; Rec.ReferenceClient)
            {
                ApplicationArea = All;
                Caption = 'Référence Client';
            }
        }
    }
}