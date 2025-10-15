codeunit 50100 ItemCalculationHelper
{
    var
        IsRecalculating: Boolean;

    procedure RecalculateItemValues(var ItemRec: Record Item)
    var
        ItemCardPage: page "Item Card";
        BOMComponent: Record "BOM Component";
        TotalComponentCost: Decimal;
        NewUnitPrice: Decimal;
    begin
        if IsRecalculating then
            exit;
        IsRecalculating := true;
        // 1. Recalcul du coût composants
        TotalComponentCost := 0;
        BOMComponent.SetRange("Parent Item No.", ItemRec."No.");
        if BOMComponent.FindSet() then
            repeat
                TotalComponentCost += BOMComponent."UnitPrice" + BOMComponent.Frais;
            until BOMComponent.Next() = 0;

        // 2. Calcul du coût unitaire
        //ItemRec."Unit Cost" := ItemRec."Prix Achat" + TotalComponentCost;
        ItemRec.Validate("Unit Cost", ItemRec."Prix Achat" + TotalComponentCost);

        // 3. Recalcul selon la méthode de calcul prix/profit
        case ItemRec."Price/Profit Calculation" of

            ItemRec."Price/Profit Calculation"::"Profit=Price-Cost":
                begin
                    // Recalcul de la marge
                    if ItemRec."Unit Price" <> 0 then
                        ItemRec.Validate("Profit %", Round((1 - (ItemRec."Unit Cost" / ItemRec."Unit Price")) * 100, 0.01));
                end;

            ItemRec."Price/Profit Calculation"::"Price=Cost+Profit":
                begin
                    // Recalcul du prix de vente
                    if ItemRec."Profit %" <> 0 then begin
                        NewUnitPrice := Round(ItemRec."Unit Cost" / (1 - (ItemRec."Profit %" / 100)), 0.01);
                        ItemRec.Validate("Unit Price", NewUnitPrice);
                    end;
                end;
        end;
        IsRecalculating := false;

    end;
}