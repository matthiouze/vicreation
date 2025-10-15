pageextension 50123 SalesShipmentLinePageExt extends "Posted Sales Shpt. Subform"
{
    layout
    {
        addafter("No.")
        {
            field(RefItem; Rec.RefItem)
            {
                ApplicationArea = All;
            }
        }
        modify("Item Reference No.")
        {
            Visible = false;
        }
    }

    trigger OnAfterGetRecord()
    var
        Item: Record Item;
    begin
        Rec.RefItem := '';
        if Rec."No." <> '' then begin
            if Item.Get(Rec."No.") then
                Rec.RefItem := Item."Référence Produit";
        end;
    end;
}