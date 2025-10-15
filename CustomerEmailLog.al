table 50100 "Customer Email Log"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(2; "Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";
        }

        field(3; "Email Subject"; Text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Email Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Email Body"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Sent By"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }

        key(Customer; "Customer No.")
        {
        }
    }
}
