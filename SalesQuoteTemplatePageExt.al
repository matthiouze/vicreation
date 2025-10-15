pageextension 50501 SalesQuoteTemplatePageExt extends "Sales Quote"
{
    layout
    {
        addbefore("Sell-to Customer No.")
        {
            field(EtatDocument; Rec.EtatDocument)
            {
                ApplicationArea = All;
                Caption = 'Etat du Document';
                Editable = false;
            }
        }

        addafter("Document Date")
        {
            field(DateValide; Rec.DateValide)
            {
                ApplicationArea = All;
                Caption = 'Date Validé';
                Importance = Promoted;
            }
        }
        addbefore("Work Description")
        {
            group(InfoValide)
            {
                Caption = 'Documents Validés pour Devis';
                Visible = ShowInfoValide;
                field(ReferenceClient; Rec.ReferenceClient)
                {
                    ApplicationArea = All;
                }
                field(BATValide; Rec.BATValide)
                {
                    ApplicationArea = All;
                }
            }
        }

        addafter("Work Description")
        {
            group("Informations Additionnelles")
            {
                Caption = 'Informations Additionnelles';

                field(InformationsAdd; Rec.InformationsAdd)
                {

                    ApplicationArea = Basic, Suite;
                    MultiLine = true;
                    ShowCaption = false;

                }
            }
        }

        modify("Sell-to")
        {
            Caption = 'Informations Clients';
        }

        modify("Sell-to Contact")
        {
            Caption = 'Nom Client';
        }
        modify("Document Date")
        {
            Caption = 'Date Création';
        }
        modify("Salesperson Code")
        {
            Caption = 'Code Achat';
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Your Reference")
        {
            Visible = false;
        }
        modify("Order Date")
        {
            Visible = false;
        }
        modify("Quote Valid Until Date")
        {
            Visible = false;
        }
        modify("Requested Delivery Date")
        {
            Visible = false;
        }
        modify("Opportunity No.")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Sell-to Customer Templ. Code")
        {
            Visible = false;
        }
        modify("Transaction Type")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
    }
    trigger OnAfterGetRecord()
    begin
        ShowInfoValide := Rec.EtatDocument = Rec.EtatDocument::Devis;
    end;

    var
        ShowInfoValide: Boolean;

    trigger OnOpenPage()
    var
        SalesLines: Record "Sales Line";
        ItemRec: Record Item;
    begin
        if Rec.Status <> Rec.Status::Open then
            exit;

        SalesLines.SetRange("Document Type", SalesLines."Document Type"::Quote);
        SalesLines.SetRange("Document No.", Rec."No.");

        if SalesLines.FindSet() then
            repeat
                if ItemRec.Get(SalesLines."No.") then begin
                    SalesLines.DesignationFit := ItemRec.Description;
                    SalesLines.RefItem := ItemRec."Référence Produit";
                    SalesLines.Validate("Unit Price", ItemRec."Unit Price");

                    if not SalesLines.IsTemporary then
                        SalesLines.Modify(true);
                end;
            until SalesLines.Next() = 0;
    end;
}