page 50104 "CategorieClient List"
{
    PageType = List;
    SourceTable = CategorieClient;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(CategorieClient; Rec.CategorieClient)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}