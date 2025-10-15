page 50180 "Assembly BOM Part"
{
    PageType = ListPart;
    SourceTable = "BOM Component";
    ApplicationArea = Assembly;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Parent Item No."; Rec."Parent Item No.")
                {
                    ApplicationArea = Assembly;
                    ToolTip = 'Specifies the parent item for this BOM component.';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Assembly;
                    ToolTip = 'Specifies the type of the component.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Assembly;
                    ToolTip = 'Specifies the number of the component.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Assembly;
                    ToolTip = 'Specifies a description of the component.';
                }
                field(BOMColorNbr; Rec.BOMColorNbr)
                {
                    ApplicationArea = Assembly;
                }
                field(PostionMarquage; Rec.PostionMarquage)
                {
                    ApplicationArea = Assembly;
                }
                field(UnitPrice; Rec.UnitPrice)
                {
                    ApplicationArea = Assembly;
                    trigger OnValidate()
                    var
                        ItemRec: Record Item;
                    begin
                        Rec.Validate(UnitPrice, Rec.UnitPrice); // pour cohérence
                        Rec.Modify(true); // déclenche OnAfterModify() de la table
                        if Rec."Parent Item No." <> '' then
                            if ItemRec.Get(Rec."Parent Item No.") then
                                ItemHelper.RecalculateItemValues(ItemRec);
                        CurrPage.Update();
                    end;
                }
                field(Frais; Rec.Frais)
                {
                    ApplicationArea = Assembly;
                    trigger OnValidate()
                    var
                        ItemRec: Record Item;
                    begin
                        Rec.Validate(UnitPrice, Rec.UnitPrice); // pour cohérence
                        Rec.Modify(true); // déclenche OnAfterModify() de la table
                        CurrPage.Update();
                        if Rec."Parent Item No." <> '' then
                            if ItemRec.Get(Rec."Parent Item No.") then
                                ItemHelper.RecalculateItemValues(ItemRec);
                    end;
                }
            }
        }
    }
    var
        ItemHelper: Codeunit ItemCalculationHelper;
}