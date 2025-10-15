tableextension 50102 "Shipping Template Table Ext" extends "Ship-to Address"
{
    fields
    {
        field(50100; "Mobile Phone No."; Text[30])
        {
            Caption = 'N° téléphone mobile';
            ExtendedDatatype = PhoneNo;
        }
    }
}