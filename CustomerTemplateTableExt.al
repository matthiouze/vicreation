tableextension 50100 "Customer Template Table Ext" extends Customer
{
    fields
    {
        field(50100; "Relationship Type"; Code[50])
        {
            Caption = 'Type de Relation';
            TableRelation = RelationType.RelationType;
        }

        field(50180; "Nom Commercial"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50122; "Nom Service Achat"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nom Service Achat';
            Editable = false;
        }
        field(50101; "Filliale"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = '(Code) Rattaché à';
            TableRelation = Customer."No.";

        }
        field(50102; "NomFilliale"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = '(Nom) Rattaché à';
            Editable = false;
        }
        field(50103; "SecteurActivite"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Secteur d''activité';
            TableRelation = SecteurActivite.SecteurActivite;
        }
        field(50104; "CategorieClient"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Catégorie de Client';
            TableRelation = CategorieClient.CategorieClient;
        }
        field(50105; "Job Title"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        modify("Salesperson Code")
        {
            Caption = 'Code Achat';
            trigger OnAfterValidate()
            var
                SalePersonRec: Record "Salesperson/Purchaser";
            begin
                if "Salesperson Code" <> '' then begin
                    if SalePersonRec.Get("Salesperson Code") then
                        "Nom Service Achat" := SalePersonRec.Name;
                end else
                    Clear("Nom Service Achat");
            end;
        }

        modify("Primary Contact No.")
        {
            trigger OnAfterValidate();
            var
                ContactRec: Record Contact;
            begin
                if "Primary Contact No." <> '' then begin
                    if ContactRec.Get("Primary Contact No.") then begin
                        "Job Title" := ContactRec."Job Title";
                        "Phone No." := ContactRec."Phone No.";
                        "Mobile Phone No." := ContactRec."Mobile Phone No.";
                        "E-Mail" := ContactRec."E-Mail";
                    end;
                    Modify;
                end;
            end;
        }

        field(50120; "Commercial Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nom Commercial';
        }

        modify(Name)
        {
            Caption = 'Nom de société';
        }
        // Part shipping Adress

        modify("Ship-to Code")
        {
            trigger OnAfterValidate();
            var
                ShippingRec: Record "Ship-to Address";
            begin
                if "Ship-to Code" <> '' then begin
                    if ShippingRec.Get("No.", "Ship-to Code") then begin
                        "Ship-Name" := ShippingRec.Name;
                        "Ship-Address" := ShippingRec.Address;
                        "Ship-Address 2" := ShippingRec."Address 2";
                        Ville := ShippingRec.City;
                        "Code Postal" := ShippingRec."Post Code";
                        "Code pays/région" := ShippingRec."Country/Region Code";
                        "Ship Contact" := ShippingRec."Contact";
                        "Ship Contact Mail" := ShippingRec."E-Mail";
                        "Ship Contact Phone No" := ShippingRec."Phone No.";
                        "Ship Contact MobilePhone No" := ShippingRec."Mobile Phone No.";
                    end;
                    Modify;
                end;
            end;
        }

        field(50121; "Ship-Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Nom de livraison';
        }
        field(50106; "Ship-Address"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Adresse de Livraison';
        }

        field(50107; "Ship-Address 2"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Adresse (2ème ligne)';
        }
        field(50108; "Ville"; text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Ville';
        }
        field(50109; "Code Postal"; text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Code Postal';
        }
        field(50110; "Code pays/région"; text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Code pays/region';
        }
        field(50116; "Ship Contact"; Text[100])
        {
            Caption = 'Contact';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50117; "Ship Contact Mail"; Text[80])
        {
            Caption = 'Email';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50118; "Ship Contact Phone No"; Text[30])
        {
            Caption = 'N° telephone';
            Editable = false;
            ExtendedDatatype = PhoneNo;
        }
        field(50119; "Ship Contact MobilePhone No"; text[30])
        {
            Caption = 'N° telephone Mobile';
            Editable = false;
            ExtendedDatatype = PhoneNo;
        }
        field(50111; "Fact-Address"; text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Adresse de Facturation';
        }
        field(50112; "Fact-Address 2"; text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Adresse (ligne 2)';
        }
        field(50113; "Fact-Ville"; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Ville';
        }
        field(50114; "Fact-CP"; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Code Postal';
        }
        field(50115; "FACT-CPR"; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Code pays/region';
        }
        field(50186; CodeCommercial; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Code Commercial';
            TableRelation = "Salesperson/Purchaser".Code;

            trigger OnValidate();
            var
                SalePersonRec: Record "Salesperson/Purchaser";
            begin
                if "Salesperson Code" <> '' then begin
                    if SalePersonRec.Get("Salesperson Code") then begin
                        "NomCodeCommercial" := SalePersonRec.Name;
                    end;
                    Modify;
                end;
            end;
        }
        field(50187; NomCodeCommercial; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nom du Commercial';
        }
    }
}