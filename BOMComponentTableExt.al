tableextension 50165 BOMComponentTableExt extends "BOM Component"
{
    fields
    {
        field(50160; BOMColorNbr; Enum NbrCouleur)
        {
            DataClassification = ToBeClassified;
            Caption = 'NBR Couleur';
        }
        field(50161; PostionMarquage; Enum PositionMarquage)
        {
            DataClassification = ToBeClassified;
            Caption = 'Position Marquage';
        }
        field(50162; UnitPrice; Decimal)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;
            AutoFormatType = 2;
            Caption = 'Prix d''Achat';
        }
        field(50163; Frais; Decimal)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;
            AutoFormatType = 2;
            Caption = 'Frais liés';
        }
    }
    trigger OnInsert()
    begin
        if "Line No." = 0 then begin
            "Line No." := GetNextLineNo("Parent Item No.");
        end;
    end;
    /*
        trigger OnAfterInsert()
        var
            ItemRec: Record Item;
            ItemHelper: Codeunit ItemCalculationHelper;
        begin
            if Rec."Parent Item No." <> '' then
                if ItemRec.Get(Rec."Parent Item No.") then
                    ItemHelper.RecalculateItemValues(ItemRec);
        end;

    trigger OnAfterModify()
    var
        ItemRec: Record Item;
        ItemHelper: Codeunit ItemCalculationHelper;
    begin
        if Rec."Parent Item No." <> '' then
            if ItemRec.Get(Rec."Parent Item No.") then
                ItemHelper.RecalculateItemValues(ItemRec);
    end;

        trigger OnAfterDelete()
        var
            ItemRec: Record Item;
            ItemHelper: Codeunit ItemCalculationHelper;
        begin
            if Rec."Parent Item No." <> '' then
                if ItemRec.Get(Rec."Parent Item No.") then
                    ItemHelper.RecalculateItemValues(ItemRec);

        end;
    */
    local procedure GetNextLineNo(ParentItemNo: Code[20]): Integer
    var
        BomComp: Record "BOM Component";
    begin
        BomComp.SetRange("Parent Item No.", ParentItemNo);
        if BomComp.FindLast() then
            exit(BomComp."Line No." + 10000)
        else
            exit(10000);
    end;

    var
        ItemHelper: Codeunit ItemCalculationHelper;
}