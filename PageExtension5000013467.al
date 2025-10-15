pageextension 50110 PageExtension50000_13467 extends Microsoft.Sales.Document."Sales Quotes"
{
    layout
    {
        modify("Sell-to Customer No.")
        {
            Caption = 'N° Client';
        }
        modify("Sell-to Customer Name")
        {
            Caption = 'Nom Client';
        }
        modify("Sell-to Contact")
        {
            Caption = 'Contact Client';
        }

        modify("External Document No.")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Quote Valid Until Date")
        {
            Visible = false;
        }
        addafter("Sell-to Customer Name")
        {
            field(EtatDocument45359; Rec.EtatDocument)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }

    }
}