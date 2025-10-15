pageextension 50190 PostSalesInvoiTemplatePageExt extends "Posted Sales Invoice Subform"
{
    layout
    {
        modify("Item Reference No.")
        {
            Visible = false;
        }
        addafter("No.")
        {
            field(RefItem; Rec.RefItem)
            {
                ApplicationArea = All;
                Caption = 'Référence Produit';
            }
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