tableextension 50510 SalesQuoteTemplateExt extends "Sales Header"
{
    fields
    {
        field(50170; "EtatDocument"; Enum "State Devis Document")
        {
            Caption = 'Etat du Document';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50171; DateValide; Date)
        {
            Caption = 'Date Validé';
            DataClassification = ToBeClassified;
        }
        field(50172; "InformationsAdd"; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Informations additionnelles';
        }
        field(50173; BATValide; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'BAT Validé';
        }
        field(50174; ExonerationTVA; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Exonération TVA';
        }

        field(50175; ReferenceClient; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reference Client';
        }
        modify("Salesperson Code")
        {
            Caption = 'Code Achat';
        }
    }
}