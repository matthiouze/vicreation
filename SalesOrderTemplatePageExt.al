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

    actions
    {
        addlast(Processing)
        {
            action(AssemblyOrderPromoted)
            {
                ApplicationArea = All;
                Caption = 'Ordre d''assemblage';
                Image = AssemblyBOM;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Créer ou afficher les ordres d''assemblage liés';

                trigger OnAction()
                var
                    AssemblyHeader: Record "Assembly Header";
                begin
                    AssemblyHeader.SetRange("Document Type", AssemblyHeader."Document Type"::Order);
                    Page.Run(Page::"Assembly Orders", AssemblyHeader);
                end;
            }
        }
    }
}
