pageextension 50107 ItemCardTemplatePageExt extends "Item Card"
{
    layout
    {
        addafter(Item)
        {
            group(CaractéristiquesProduit)
            {
                Caption = 'Caractéristiques Produits';
                field(Taille; Rec.Taille)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(TailleDispo; Rec.TailleDispo)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field(Couleur; Rec.Couleur)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(CouleurDispo; Rec.CouleurDispo)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field(Composition; Rec.Composition)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Grammage; Rec.Grammage)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Entretien; Rec.Entretien)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Genre; Rec.Genre)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Certification; Rec.Certification)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }

        addbefore("CaractéristiquesProduit")
        {
            group(DescriptionProduit)
            {
                Caption = 'Description Produit';
                field(DescriptionField; Rec.DescriptionField)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }

        addafter("No.")
        {
            field("Référence Produit"; Rec."Référence Produit")
            {
                ApplicationArea = All;
            }
            field(Designation; Rec.Description)
            {
                ApplicationArea = All;
                Caption = 'Designation Produit';
                NotBlank = true;
            }
        }
        moveafter(Description; "Vendor Item No.")
        addafter("Vendor Item No.")
        {
            field("Vendor Item Name"; Rec."Vendor Item Name")
            {
                ApplicationArea = All;
            }
            field("SKU Fournisseur"; Rec."SKU Fournisseur")
            {
                ApplicationArea = All;
                Caption = 'SKU Fournisseur';
            }
        }
        moveafter("SKU Fournisseur"; "Vendor No.")
        addafter("Vendor No.")
        {
            field("Nom Fournisseur"; Rec."Nom Fournisseur")
            {
                ApplicationArea = All;
            }
            field("Unité De Vente"; Rec."Unité De Vente")
            {
                ApplicationArea = All;
            }
            field("Sous Colisage"; Rec."Sous Colisage")
            {
                ApplicationArea = All;
            }
            field(Colisage; Rec.Colisage)
            {
                ApplicationArea = All;
            }

            field(ArticleClient; Rec.ArticleClient)
            {
                ApplicationArea = All;
                Editable = IsArticleClientEditable;
                
                trigger OnValidate()
                begin
                    CurrPage.Update(false);
                end;
            }
            group(RelationClient)
            {
                Visible = Rec.ArticleClient;
                Caption = 'Article Client';
                Editable = IsArticleClientEditable;
                field(ClientRelation; Rec.ClientRelation)
                {
                    ApplicationArea = All;
                    Editable = IsArticleClientEditable;
                }
                field(NomClientRelation; Rec.NomClientRelation)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

        }
        moveafter(Colisage; "Base Unit of Measure")

        addafter("Costs & Posting")
        {
            group(Nomenclatures)
            {
                Caption = 'Nomenclatures D''assemblage';
                Visible = Rec.ArticleClient;

                part(AssemblyBOMPart; "Assembly BOM Part")
                {
                    ApplicationArea = Assembly;
                    SubPageLink = "Parent Item No." = field("No.");
                }
            }
        }

        addbefore("Posting Details")
        {
            group("Détails Marge")
            {
                Caption = 'Détails Marge Produit';
            }
        }

        moveafter("Détails Marge"; "Price/Profit Calculation")
        moveafter("Price/Profit Calculation"; "Profit %")

        modify("Profit %")
        {
            trigger OnAfterValidate()
            begin
                ItemHelper.RecalculateItemValues(Rec);
            end;
        }
        modify("Price/Profit Calculation")
        {
            trigger OnAfterValidate()
            begin
                ItemHelper.RecalculateItemValues(Rec);
            end;
        }
        modify("Unit Price")
        {
            Caption = 'Prix de Vente';
            trigger OnAfterValidate()
            begin
                ItemHelper.RecalculateItemValues(Rec);
            end;
        }

        addbefore("Unit Cost")
        {
            field("Prix Achat"; Rec."Prix Achat")
            {
                ApplicationArea = All;
                Editable = true;

                trigger OnValidate()
                begin
                    ItemHelper.RecalculateItemValues(Rec);
                end;
            }
        }
        modify("Unit Cost")
        {
            Editable = false;
            trigger OnAfterValidate()
            begin
                ItemHelper.RecalculateItemValues(Rec);
            end;

        }
        modify("Qty. on Job Order")
        {
            Visible = false;
        }

        modify("Qty. on Assembly Order")
        {
            Visible = false;
        }

        modify("Standard Cost")
        {
            Visible = false;
        }

        modify(Description)
        {
            Visible = false;
        }

        modify(Blocked)
        {
            Visible = false;
        }

        modify(Type)
        {
            Visible = false;
        }
        modify("Base Unit of Measure")
        {
            Visible = true;
        }
        modify("Last Date Modified")
        {
            Visible = false;
        }
        modify(GTIN)
        {
            Visible = false;
        }
        modify("Item Category Code")
        {
            Visible = false;
        }

        modify("Automatic Ext. Texts")
        {
            Visible = false;
        }
        modify("Common Item No.")
        {
            Visible = false;
        }
        modify("Purchasing Code")
        {
            Visible = false;
        }
        modify(VariantMandatoryDefaultYes)
        {
            Visible = false;
        }
        modify(VariantMandatoryDefaultNo)
        {
            Visible = false;
        }
        modify("Service Commitment Option")
        {
            Visible = false;
        }
        modify("Created From Nonstock Item")
        {
            Visible = false;
        }
        modify("Qty. on Asm. Component")
        {
            Visible = false;
        }
        modify("Over-Receipt Code")
        {
            Visible = false;
        }
        modify(PreventNegInventoryDefaultNo)
        {
            Visible = false;
        }

        /*
                modify(InventoryGrp)
                {
                    Visible = false;
                }

                modify(Replenishment)
                {
                    Visible = false;
                }

                modify("Costs & Posting")
                {
                    Visible = false;
                }

                modify("Prices & Sales")
                {
                    Visible = false;
                }
    */
        modify(ItemTracking)
        {
            Visible = false;
        }
        modify(Sustainability)
        {
            Visible = false;
        }
        modify(Warehouse)
        {
            Visible = false;
        }
        modify(Planning)
        {
            Visible = false;
        }

        modify(ForeignTrade)
        {
            Visible = false;
        }

        modify(EntityTextFactBox)
        {
            Visible = false;
        }
        modify(ItemAttributesFactbox)
        {
            Visible = false;
        }

        modify("Replenishment System")
        {
            Visible = true;
        }
        modify(ItemForecastNoChart)
        {
            Visible = false;
        }
        modify(ItemServCommitmentsFactbox)
        {
            Visible = false;
        }
    }
    actions
    {
        modify(Category_Category6)
        {
            Visible = false;
        }
        modify(Category_Category4)
        {
            Visible = false;
        }
        modify(Category_Category8)
        {
            Visible = false;
        }
        modify(Category_Category7)
        {
            Visible = false;
        }
        modify(ApplyTemplate_Promoted)
        {
            Visible = false;
        }

        addbefore(Functions)
        {
            //Ajout d'une action manuelle de recalcul d'article
            action(RecalculateItem)
            {
                Caption = 'Recalculer l''article';
                ApplicationArea = Basic, Suite;
                Image = Calculate;

                trigger OnAction()
                begin
                    ItemHelper.RecalculateItemValues(Rec);
                    Message('Article recalculé avec succès.');
                end;
            }
        }
        addafter(CopyItem_Promoted)
        {
            actionref(RelcalculateItem; RecalculateItem)
            {
            }
        }
    }
    var
        ItemHelper: Codeunit ItemCalculationHelper;

    var
        IsArticleClientEditable: Boolean;

    trigger OnOpenPage()
    begin
        SetArticleClientEditable();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // Lors de la création d'un nouvel article, initialiser à true
        IsArticleClientEditable := true;
        CurrPage.Update(false);
    end;

    trigger OnAfterGetRecord()
    begin
        SetArticleClientEditable();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetArticleClientEditable();
    end;

    local procedure SetArticleClientEditable()
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        // Si le numéro est vide, c'est une création → éditable
        if Rec."No." = '' then begin
            IsArticleClientEditable := true;
            exit;
        end;

        // Vérifier s'il existe des écritures comptables pour cet article
        ItemLedgerEntry.SetRange("Item No.", Rec."No.");
        IsArticleClientEditable := ItemLedgerEntry.IsEmpty();
    end;
}