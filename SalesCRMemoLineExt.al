tableextension 50115 SalesCRMemoLineExt extends "Sales Cr.Memo Line"
{
    fields
    {
        field(50248; RefItem; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Référence Produit';
        }
    }
}