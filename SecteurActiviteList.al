page 50103 "Secteur Activite List"
{
    PageType = List;
    SourceTable = SecteurActivite;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(SecteurActivite; Rec.SecteurActivite)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}