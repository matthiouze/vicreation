tableextension 50180 SalesInvoiceHeaderTableExt extends "Sales Invoice Header"
{
    fields
    {
        field(50181; ReferenceClient; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reference Client';
        }
    }
}