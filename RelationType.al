table 50101 "RelationType"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Relation Type List";
    fields
    {
        field(1; RelationType; Code[50])
        {
            Caption = 'Type de Relation';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; RelationType)
        {
            Clustered = true;
        }
    }
}