table 50103 "CategorieClient"
{
    DataClassification = ToBeClassified;
    LookupPageId = "CategorieClient List";
    fields
    {
        field(1; CategorieClient; Code[50])
        {
            Caption = 'Categorie Client';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; CategorieClient)
        {
            Clustered = true;
        }
    }
}