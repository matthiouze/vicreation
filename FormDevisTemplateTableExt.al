tableextension 50148 FormDevisTemplateTableExt extends "Sales Line"
{
    fields
    {
        field(50145; "AllSizes"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Taille Disponible';
        }
        field(50146; "CouleurFit"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Couleur';
        }
        field(50190; "DescriptionFieldFit"; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }

        field(50200; DesignationFit; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Designation';
        }
        field(50201; CompositionFit; Text[100])
        {
            DataClassification = ToBeClassified;
            caption = 'Composition';
        }
        field(50202; GrammageFit; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50203; EntretienFit; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50204; CertificationFit; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(50205; PictureItem; MediaSet)
        {
            DataClassification = ToBeClassified;
        }
        field(50206; RefItem; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50208; "ItemName"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Désignation souhaitée';
            NotBlank = true;
        }
        field(50209; "RefSouhaite"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Référence souhaitée';
        }

        field(50207; "Custom No."; Code[20])
        {
            NotBlank = true;
            Caption = 'No.';
            CaptionClass = GetCaptionClass(FieldNo("No."));
            ValidateTableRelation = false;


            TableRelation =
                if (Type = const(" ")) "Standard Text"
            else
            if (Type = const("G/L Account"), "System-Created Entry" = const(false)) "G/L Account" where("Direct Posting" = const(true), "Account Type" = const(Posting), Blocked = const(false))
            else
            if (Type = const("G/L Account"), "System-Created Entry" = const(true)) "G/L Account"
            else
            if (Type = const(Resource)) Resource
            else
            if (Type = const("Fixed Asset")) "Fixed Asset"
            else
            if (Type = const("Charge (Item)")) "Item Charge"
            else
            if (Type = const("Allocation Account")) "Allocation Account"
            else
            if (Type = const(Item)) Item where(Blocked = const(false), "Sales Blocked" = const(false)); // Filtrage dynamique dans OnLookup

            trigger OnLookup()
            var
                ItemRec: Record Item;
                SalesHeaderRec: Record "Sales Header";
                ItemChargeRec: Record "Item Charge";
                IsClientSpecific: Boolean;
            begin
                case Type of
                    Type::Item:
                        begin
                            // Récupération du Sales Header lié à la ligne
                            SalesHeaderRec.Reset();
                            SalesHeaderRec.SetRange("Document Type", "Document Type");
                            SalesHeaderRec.SetRange("No.", "Document No.");
                            if SalesHeaderRec.FindFirst() then begin
                                // Déterminer si le filtrage client doit être appliqué
                                IsClientSpecific :=
                                    (SalesHeaderRec."Document Type" = SalesHeaderRec."Document Type"::Order) or
                                    (SalesHeaderRec."EtatDocument" = SalesHeaderRec."EtatDocument"::Devis);
                            end;

                            ItemRec.Reset();
                            ItemRec.SetRange(Blocked, false);
                            ItemRec.SetRange("Sales Blocked", false);

                            if not IsClientSpecific then begin
                                ItemRec.SetRange("ClientRelation", '');
                                ItemRec.SetRange(ArticleClient, false);
                                ItemRec.SetRange("ArticleCopié", false);
                            end else begin
                                ItemRec.SetRange("ClientRelation", SalesHeaderRec."Sell-to Customer No.");
                                ItemRec.SetRange(ArticleClient, true);
                                ItemRec.SetRange("ArticleCopié", false);
                            end;

                            if PAGE.RunModal(PAGE::"Item List", ItemRec) = ACTION::LookupOK then
                                "Custom No." := ItemRec."No.";
                        end;

                    Type::"Charge (Item)":
                        begin
                            ItemChargeRec.Reset();
                            if PAGE.RunModal(PAGE::"Item Charges", ItemChargeRec) = ACTION::LookupOK then
                                "Custom No." := ItemChargeRec."No.";
                        end;
                end;

                Validate("Custom No.");
            end;

            trigger OnValidate()
            begin
                Rec.Validate("No.", "Custom No.");
            end;
        }


        modify("No.")
        {
            trigger OnAfterValidate()
            var
                ItemRec: Record Item;
                ItemChargeRec: Record "Item Charge";
                SalesHeaderRec: Record "Sales Header";
                IsOrder: Boolean;
            begin
                "Custom No." := "No.";

                if "No." <> '' then begin
                    if Type = Type::Item then begin
                        if ItemRec.Get("No.") then begin
                            CouleurFit := ItemRec.CouleurDispo;
                            AllSizes := ItemRec.TailleDispo;
                            DesignationFit := ItemRec.Description;
                            DescriptionFieldFit := ItemRec.DescriptionField;
                            CompositionFit := ItemRec.Composition;
                            GrammageFit := ItemRec.Grammage;
                            EntretienFit := ItemRec.Entretien;
                            CertificationFit := ItemRec.Certification;
                            PictureItem := ItemRec.Picture;
                            RefItem := ItemRec."Référence Produit";
                        end;
                    end;

                    if Type = Type::"Charge (Item)" then begin
                        if ItemChargeRec.Get("No.") then begin
                            DesignationFit := ItemChargeRec.Description;
                        end;
                    end;

                    SalesHeaderRec.SetRange("Document Type", "Document Type");
                    SalesHeaderRec.SetRange("No.", "Document No.");
                    if SalesHeaderRec.FindFirst() then begin
                        IsOrder := (SalesHeaderRec."Document Type" = SalesHeaderRec."Document Type"::Order);
                    end;

                    if not Rec.IsTemporary then begin
                        if Rec."Line No." <> 0 then begin
                            if IsOrder then begin
                                if Rec.Find('=') then
                                    Modify(true);
                            end else begin
                                Modify(true);
                            end;
                        end;
                    end;
                end;
            end;
        }
    }
}