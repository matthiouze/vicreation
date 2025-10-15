pageextension 50111 ContactCardTemplateExt extends "Contact Card"
{
    layout
    {
        modify("Organizational Level Code")
        {
            Visible = false;
        }
        modify("Exclude from Segment")
        {
            Visible = false;
        }
        modify("Trade Register")
        {
            Visible = false;
        }
        modify("APE Code")
        {
            Visible = false;
        }
        modify("SIREN No.")
        {
            Visible = false;
        }
        modify("Legal Form")
        {
            Visible = false;
        }
        modify("Stock Capital")
        {
            Visible = false;
        }
        modify("Registration Number")
        {
            Visible = false;
        }

        modify("Foreign Trade")
        {
            Visible = false;
        }
        modify("Company No.")
        {
            Editable = false;
        }
        modify("Company Name")
        {
            Editable = false;
        }
        modify("Job Title")
        {
            Importance = Standard;
        }
    }
}