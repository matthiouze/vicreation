pageextension 50170 SalesOrderTemplatePageExt extends "Sales Order"
{
    layout
    {
        addafter("Due Date")
        {
            field(DateValide; Rec.DateValide)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Quote No.")
        {
            field(ReferenceClient; Rec.ReferenceClient)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}