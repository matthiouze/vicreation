reportextension 50208 SalesShipmentTemplateReportExt extends "Sales - Shipment"
{
    WordLayout = 'ExtentedSalesShipment.docx';

    dataset
    {
        add("Sales Shipment Header")
        {
            column(ReferenceClient; ReferenceClient) { }
        }

        add("Sales Shipment Line")
        {
            column(RefItem; GetRefItem("No.")) { }
        }
    }

    local procedure GetRefItem(ItemNo: Code[20]): Text[100]
    var
        Item: Record Item;
        RefItem: Text[100];
    begin
        if ItemNo <> '' then begin
            if Item.Get(ItemNo) then
                RefItem := Item."Référence Produit";
        end;
        exit(RefItem);
    end;
}