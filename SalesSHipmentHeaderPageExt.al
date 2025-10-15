pageextension 50112 SalesSHipmentHeaderPageExt extends "Posted Sales Shipment"
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