pageextension 50101 ItemListTemplatePageExt extends "Item List"
{
    layout
    {
        addafter("No.")
        {
            field("Référence Produit"; Rec."Référence Produit")
            {
                Caption = 'Réf Produit';
                ApplicationArea = All;
            }
        }

        modify(Description)
        {
            Caption = 'Désignation';
        }

        modify(Type)
        {
            Visible = false;
        }
        modify("Substitutes Exist")
        {
            Visible = false;
        }
        modify("Base Unit of Measure")
        {
            Visible = false;
        }
        modify("Cost is Adjusted")
        {
            Visible = false;
        }
        modify("Vendor No.")
        {
            Visible = false;
        }
        modify("Default Deferral Template Code")
        {
            Visible = false;
        }
        addafter(InventoryField)
        {
            field(Couleur01151; Rec.Couleur)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Taille93331; Rec.Taille)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Nom Fournisseur74889"; Rec."Nom Fournisseur")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Unit Price")
        {
            field(DescriptionField69532; Rec.DescriptionField)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Composition71433; Rec.Composition)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Grammage93356; Rec.Grammage)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Entretien35134; Rec.Entretien)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Genre53610; Rec.Genre)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Certification80598; Rec.Certification)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Assembly BOM")
        {
            field(ArticleClient19393; Rec.ArticleClient)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(ClientRelation; Rec.ClientRelation)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(NomClientRelation; Rec.NomClientRelation)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            action(DeleteAllItems)
            {
                Caption = 'Supprimer tous les articles';
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ItemRec: Record Item;
                    Dialog: Dialog;
                begin
                    if not Confirm('Êtes-vous sûr de vouloir supprimer tous les articles ?', false) then
                        exit;

                    // Suppression de tous les articles
                    if ItemRec.FindSet(true) then begin
                        Dialog.Open('Suppression des articles... %1');
                        repeat
                            Dialog.Update(1, ItemRec."No.");
                            ItemRec.Delete();
                        until ItemRec.Next() = 0;
                        Dialog.Close();
                        Message('Tous les articles ont été supprimés.');
                    end else
                        Message('Aucun article à supprimer.');
                end;
            }
        }
    }
}