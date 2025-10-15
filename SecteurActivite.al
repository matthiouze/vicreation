table 50102 "SecteurActivite"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Secteur Activite List";

    fields
    {
        field(1; SecteurActivite; Code[100])
        {
            Caption = 'Secteur d''activité';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; SecteurActivite)
        {
            Clustered = true;
        }
    }
}