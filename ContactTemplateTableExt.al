tableextension 50101 "Contact Template Table Ext" extends Contact
{
    fields
    {
        field(50125; "Factures Tags"; Boolean)
        {
            Caption = 'Envoi de facture';
        }
        field(50127; "Mail tags"; Boolean)
        {
            Caption = 'Envoi de mailing';
        }
    }
}