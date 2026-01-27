tableextension 50108 ItemCardTemplateTableExt extends Item
{
    fields
    {
        field(50130; "Nom Fournisseur"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nom Fournisseur';
            Editable = false;
        }
        field(50131; "Unité De Vente"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unité de Vente';
        }
        field(50132; "Sous Colisage"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sous Colisage';
        }
        field(50133; "Colisage"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Colisage';
        }

        field(50134; "Prix Achat"; Decimal)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;
            AutoFormatType = 2;
            Caption = 'Prix Achat Textile';
        }
        field(50135; "Prix Vente"; Text[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Prix Vente';
        }

        field(50136; "DescriptionField"; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(50137; "Référence Produit"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Référence Produit';
            NotBlank = true;
        }

        field(50150; "SKU Fournisseur"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'SKU Produit';
        }
        field(50899; "Vendor Item Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Designation Fournisseur';
            Editable = false;
        }

        modify("Vendor Item No.")
        {
            TableRelation = Item WHERE(ArticleClient = const(false), "ArticleCopié" = const(false));

            trigger OnAfterValidate()
            var
                ItemRec: Record "Item";
            begin
                if "Vendor Item No." <> '' then begin
                    if ItemRec.Get("Vendor Item No.") then begin
                        Rec."Vendor Item Name" := ItemRec.Description;
                    end;
                end;
            end;
        }

        modify("Vendor No.")
        {
            trigger OnAfterValidate();
            var
                VendorNoRec: Record "Vendor";
            begin
                if "Vendor No." <> '' then begin
                    if VendorNoRec.Get("Vendor No.") then begin
                        Rec."Nom Fournisseur" := VendorNoRec.Name;
                    end;
                    Modify;
                end;
            end;
        }

        field(50144; TailleDispo; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Taille(s) Disponible';
        }
        field(50152; Taille; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Taille';
        }

        field(50143; CouleurDispo; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Couleur(s) Disponible';
        }
        field(50151; Couleur; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Couleur';
        }
        field(50138; "Composition"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Composition';
        }

        field(50139; "Grammage"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Grammage';
        }

        field(50140; "Entretien"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Entretien';
        }
        field(50141; "Genre"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Homme,Femme,Unisexe;
        }
        field(50142; "Certification"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Certification';
        }

        field(50145; BOMComponents; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nomenclatures Articles';
        }

        modify(Description)
        {
            Caption = 'Designation';
            ToolTip = 'Indiquer la désignation du Produit';
        }
        field(50148; ArticleCopié; Boolean)
        {
            Caption = 'Article Copié';
            DataClassification = ToBeClassified;
        }
        field(50147; ArticleClient; Boolean)
        {
            Caption = 'Article Client';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if not Rec.ArticleClient then begin
                    Rec.ClientRelation := '';
                    Rec.NomClientRelation := '';
                end
            end;
        }
        field(50146; ClientRelation; Code[20])
        {
            Caption = 'N° Client';
            TableRelation = Customer;
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                CustomerRec: Record Customer;
            begin
                if Rec.ClientRelation <> '' then
                    Rec.Validate(ArticleClient, true);
                if CustomerRec.Get(Rec.ClientRelation) then
                    Rec.NomClientRelation := CustomerRec.Name;
            end;
        }
        field(50149; NomClientRelation; Text[100])
        {
            Caption = 'Nom Client';
            Editable = false;
        }
    }

    trigger OnAfterModify()
    var
        ItemHelper: Codeunit ItemCalculationHelper;
    begin
        ItemHelper.RecalculateItemValues(Rec);
    end;

    trigger OnAfterInsert()
    var
        ItemHelper: Codeunit ItemCalculationHelper;
    begin
        ItemHelper.RecalculateItemValues(Rec);
    end;

    trigger OnAfterDelete()
    var
        ItemHelper: Codeunit ItemCalculationHelper;
    begin
        ItemHelper.RecalculateItemValues(Rec);
    end;

    procedure ConcatBOMComponents(ItemNo: Code[20]): Text
    var
        BOMLine: Record "BOM Component";
        BOMText: Text;
    begin
        BOMText := '';
        BOMLine.SetRange("Parent Item No.", ItemNo);
        if BOMLine.FindSet() then begin
            repeat
                BOMText := BOMText + BOMLine.Description + '\n';
            until BOMLine.Next() = 0;
        end;
        exit(BOMText)
    end;
}