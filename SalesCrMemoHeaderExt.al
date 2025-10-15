tableextension 50114 SalesCrMemoHeaderExt extends "Sales Cr.Memo Header"
{
    fields
    {
        field(50115; ReferenceClient; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reference Client';
        }
    }
}