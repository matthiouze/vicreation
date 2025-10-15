pageextension 50104 "Contact Template Page Ext" extends "Contact Card"
{
    layout
    {
        modify("Job Title")
        {
            Visible = true;
        }

        modify("Privacy Blocked")
        {
            Visible = false;
        }

        modify(Minor)
        {
            Visible = false;
        }
        modify("Parental Consent Received")
        {
            Visible = false;
        }
        modify("Salesperson Code")
        {
            Visible = false;
        }
        modify("Salutation Code")
        {
            Visible = false;
        }


        addlast(General)
        {
            group("Configuration Envoi")
            {
                Caption = 'Paramètres d''envoi';

                field("Mail Tags"; Rec."Mail tags")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Pub Tags"; Rec."Factures Tags")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
            }
        }
    }
}