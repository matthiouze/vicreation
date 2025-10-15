pageextension 50118 SalesCRMemoHeaderPageExt extends "Posted Sales Credit Memo"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field(ReferenceClient; Rec.ReferenceClient)
            {
                ApplicationArea = All;
            }
        }
    }
}