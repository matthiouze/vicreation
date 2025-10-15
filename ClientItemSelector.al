page 50110 "Client Item Selector"
{
    PageType = List;
    SourceTable = Item;
    SourceTableTemporary = false;
    ApplicationArea = All;
    UsageCategory = None;
    Editable = false;
    MultipleNewLines = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field("Référence Produit"; Rec."Référence Produit") { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; Caption = 'Désignation'; }
                field(Inventory; Rec.Inventory) { ApplicationArea = All; }
                field(Couleur; Rec.Couleur) { ApplicationArea = All; }
                field(Taille; Rec.Taille) { ApplicationArea = All; }
                field("Nom Fournisseur"; Rec."Nom Fournisseur") { ApplicationArea = All; }
                field(BOMComponents; Rec.BOMComponents) { ApplicationArea = All; }
                field(ArticleClient; Rec.ArticleClient) { ApplicationArea = All; }
                field(ClientRelation; Rec.ClientRelation) { ApplicationArea = All; }
                field("Unit Cost"; Rec."Unit Cost") { ApplicationArea = All; }
                field("Unit Price"; Rec."Unit Price") { ApplicationArea = All; }
                field(DescriptionField; Rec.DescriptionField) { ApplicationArea = All; }
                field(Composition; Rec.Composition) { ApplicationArea = All; }
                field(Grammage; Rec.Grammage) { ApplicationArea = All; }
                field(Entretien; Rec.Entretien) { ApplicationArea = All; }
                field(Certification; Rec.Certification) { ApplicationArea = All; }

            }
        }
    }
    actions
    {
        area(processing)
        {
            action(ConfirmSelection)
            {
                ApplicationArea = All;
                Caption = 'Valider la sélection';
                Image = Approve;
                trigger OnAction()
                begin
                    CurrPage.Close();
                end;
            }
        }
    }
    procedure GetSelectedItems(var SelectedItemNos: List of [Code[20]])
    var
        ItemRec: Record Item;
    begin
        CurrPage.SetSelectionFilter(ItemRec);
        if ItemRec.FindSet() then
            repeat
                SelectedItemNos.Add(ItemRec."No.");
            until ItemRec.Next() = 0;
    end;

    procedure SetCustomerFilter(CustomerNo: Code[20]; DocumentType: Enum "Sales Document Type"; DocumentState: Enum "State Devis Document")
    var
        ItemRec: Record Item;
        IsClientSpecific: Boolean;
    begin
        IsClientSpecific := (DocumentType = DocumentType::Order) or (DocumentState = DocumentState::Devis);

        ItemRec.Reset();
        ItemRec.SetRange(Blocked, false);
        ItemRec.SetRange("Sales Blocked", false);

        if not IsClientSpecific then begin
            ItemRec.SetRange("ClientRelation", '');
            ItemRec.SetRange(ArticleClient, false);
            ItemRec.SetRange("ArticleCopié", false);
        end else begin
            ItemRec.SetRange("ClientRelation", CustomerNo);
            ItemRec.SetRange(ArticleClient, true);
            ItemRec.SetRange("ArticleCopié", false);
        end;

        CurrPage.SetTableView(ItemRec);
    end;
}
