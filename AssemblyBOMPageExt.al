pageextension 50161 "Assembly BOM Page Ext" extends "Assembly BOM"
{
    layout
    {
        addlast(Control1)
        {
            field(BOMColorNbr; Rec.BOMColorNbr)
            {
                ApplicationArea = All;
            }
            field(PostionMarquage; Rec.PostionMarquage)
            {
                ApplicationArea = All;
            }
        }

        modify(Position)
        {
            Visible = false;
        }
        modify("Assembly BOM")
        {
            Visible = false;
        }
        modify("Unit of Measure Code")
        {
            Visible = false;
        }
        modify("Installed in Item No.")
        {
            Visible = false;
        }
    }
}