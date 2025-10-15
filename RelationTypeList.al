page 50102 "Relation Type List"
{
    PageType = List;
    SourceTable = RelationType;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(RelationType; Rec.RelationType)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}