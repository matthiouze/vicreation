tableextension 50110 SalesShipmentHeaderTableExt extends "Sales Shipment Header"
{
    fields
    {
        field(50111; ReferenceClient; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reference Client';
        }
    }
}