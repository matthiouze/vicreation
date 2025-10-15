tableextension 50200 ActivitiesCueTableExt extends "Activities Cue"
{
    fields
    {
        field(50100; "Ongoing Remise"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type" = filter(Quote), "EtatDocument" = const(Remise)));
            Caption = 'Remise de Prix';
        }

        field(50101; "Ongoing Devis"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type" = filter(Quote), EtatDocument = const(Devis)));
            Caption = 'Devis';
        }
    }
}