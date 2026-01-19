pageextension 50108 SalesOrderSubFormPageExt extends "Sales Order Subform"
{
    layout
    {
        addafter("No.")
        {
            field("Custom No."; Rec."Custom No.")
            {
                ApplicationArea = All;
                NotBlank = true;

            }
            field(RefItem; Rec.RefItem)
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field(Couleur; Rec.CouleurFit)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Taille; Rec.AllSizes)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }

        modify("No.")
        {
            Visible = false;
        }
        modify("Item Reference No.")
        {
            Visible = false;
        }
        modify("Customer Contract No.")
        {
            Visible = false;
        }
        modify("Vendor Contract No.")
        {
            Visible = false;
        }
        modify(Description)
        {
            Caption = 'Désignation';
        }
    }
    actions
    {
        modify(SelectMultiItems)
        {
            Visible = false;
        }

        addlast(processing)
        {
            action(ItemView)
            {
                ApplicationArea = All;
                Caption = 'Voir l''article';
                Image = View;
                trigger OnAction()
                var
                    ItemRec: Record Item;
                begin
                    if ItemRec.Get(Rec."No.") then begin
                        Page.Run(Page::"Item Card", ItemRec)
                    end else
                        Error('Article %1 introuvable.', Rec."No.");
                end;
            }
            action(SelectClientArticles)
            {
                Caption = 'Sélectionner Plusieurs Articles';
                ApplicationArea = All;
                Image = Item;

                trigger OnAction()
                var
                    SelectorPage: Page "Client Item Selector";
                    SelectedItems: List of [Code[20]];
                    SalesLine: Record "Sales Line";
                    SalesHeader: Record "Sales Header";
                    ItemNo: Code[20];
                begin
                    CurrPage.SaveRecord();
                    Commit();
                    // Récupération de l'entête de vente pour le client
                    if not SalesHeader.Get(Rec."Document Type", Rec."Document No.") then
                        exit;

                    SelectorPage.SetCustomerFilter(SalesHeader."Sell-to Customer No.", SalesHeader."Document Type", SalesHeader.EtatDocument);
                    if SelectorPage.RunModal() = Action::OK then begin
                        SelectorPage.GetSelectedItems(SelectedItems);

                        foreach ItemNo in SelectedItems do begin
                            SalesLine.Init();
                            SalesLine.Validate("Document Type", Rec."Document Type");
                            SalesLine.Validate("Document No.", Rec."Document No.");
                            SalesLine."Line No." := GetNextLineNo(SalesLine);
                            SalesLine.Validate("Type", SalesLine.Type::Item);
                            SalesLine.Validate("No.", ItemNo);
                            SalesLine.Insert(true);
                        end;
                    end;
                end;
            }
        }
    }
    procedure GetNextLineNo(SalesLine: Record "Sales Line"): Integer
    var
        TempSalesLine: Record "Sales Line";
        MaxLineNo: Integer;
    begin
        TempSalesLine.SetRange("Document Type", SalesLine."Document Type");
        TempSalesLine.SetRange("Document No.", SalesLine."Document No.");
        if TempSalesLine.FindLast() then
            MaxLineNo := TempSalesLine."Line No."
        else
            MaxLineNo := 0;

        exit(MaxLineNo + 10000);
    end;
}