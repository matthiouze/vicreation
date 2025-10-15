pageextension 50106 "ContactList Template Page Ext" extends "Contact List"
{
    layout
    {
        modify("Job Title")
        {
            Visible = true;
        }

        modify("Salesperson Code")
        {
            Visible = false;
        }
        modify("Business Relation")
        {
            Visible = false;
        }
        modify("Territory Code")
        {
            Visible = false;
        }
        modify("Company Name")
        {
            Visible = false;
        }
        addafter("Job Title")
        {
            field("Mail tags"; Rec."Mail tags")
            {
                ApplicationArea = All;
            }
            field("Factures Tags"; Rec."Factures Tags")
            {
                ApplicationArea = All;
            }
        }
    }
}