tableextension 50122 SalesShipmentLineTableExt extends "Sales Shipment Line"
{
    fields
    {
        field(50123; RefItem; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Référence Produit';
        }
    }
}