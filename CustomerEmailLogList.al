page 50100 "Customer Email Log List"
{
    PageType = ListPart;
    SourceTable = "Customer Email Log";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Email Date"; Rec."Email Date")
                {
                    ApplicationArea = All;
                }

                field("Email Subject"; Rec."Email Subject")
                {
                    ApplicationArea = All;
                }

                field("Sent By"; Rec."Sent By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ShowEmailBody)
            {
                ApplicationArea = All;
                Caption = 'Voir le contenu';
                trigger OnAction()
                begin
                    Message(Rec."Email Body");
                end;
            }
        }
    }
}
