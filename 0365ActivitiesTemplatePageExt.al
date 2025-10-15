pageextension 50201 "0365ActivitiesTemplatePageExt" extends "O365 Activities"
{
    layout
    {
        modify("Ongoing Sales Quotes")
        {
            Visible = false;
        }
        addfirst("Ongoing Sales")
        {
            field("Ongoing Remise"; Rec."Ongoing Remise")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Remise de Prix';
                DrillDownPageId = "Sales Quotes";
            }
            field("Ongoing Devis"; Rec."Ongoing Devis")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Devis';
                DrillDownPageId = "Sales Quotes";
            }
        }
    }
}