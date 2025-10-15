pageextension 50100 "Custoemr Template Page Ext" extends "Customer Card"
{
    layout
    {

        addlast(General)
        {
            field("Relationship Type"; Rec."Relationship Type")
            {
                ApplicationArea = All;
            }

            field("SecteurActivite"; Rec.SecteurActivite)
            {
                ApplicationArea = All;
            }

            field("CategorieClient"; Rec.CategorieClient)
            {
                ApplicationArea = All;
            }
            group("Information Société-Mère")
            {
                Caption = 'Informations Société-Mère';
                field("Filliale"; Rec."Filliale")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        CustomerRec: Record Customer;
                    begin
                        if CustomerRec.Get(Rec.Filliale) then
                            Rec.NomFilliale := CustomerRec.Name;
                    end;

                }

                field("NomFilliale"; Rec."NomFilliale")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }

        // General

        movelast(General; Blocked)

        moveafter(CategorieClient; "Salesperson Code")


        modify("Salesperson Code")
        {
            Caption = 'Code Achat';
            Importance = Promoted;
        }

        addafter("Salesperson Code")
        {
            field("NomServiceAchat"; Rec."Nom Service Achat")
            {
                ApplicationArea = All;
            }
            field(CodeCommercial; Rec.CodeCommercial)
            {
                ApplicationArea = All;
            }
            field(NomCodeCommercial; Rec.NomCodeCommercial)
            {
                ApplicationArea = All;
            }
        }


        addafter(Name)
        {
            field("Commercial Name"; Rec."Commercial Name")
            {
                ApplicationArea = All;
            }
        }
        modify(Name)
        {
            Caption = 'Nom de société';
        }

        modify("IC Partner Code")
        {
            Visible = false;
        }
        modify("Balance (LCY)")
        {
            Visible = false;
        }
        modify(BalanceAsVendor)
        {
            Visible = false;
        }
        modify("Balance Due (LCY)")
        {
            Visible = false;
        }
        modify("Credit Limit (LCY)")
        {
            Visible = false;
        }
        modify("Privacy Blocked")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Document Sending Profile")
        {
            Visible = false;
        }
        modify(TotalSales2)
        {
            Visible = false;
        }
        modify("CustSalesLCY - CustProfit - AdjmtCostLCY")
        {
            Visible = false;
        }
        modify(AdjCustProfit)
        {
            Visible = false;
        }
        modify(AdjProfitPct)
        {
            Visible = false;
        }
        modify("Last Date Modified")
        {
            Visible = false;
        }
        modify("Disable Search by Name")
        {
            Visible = false;
        }

        // Contacts & Adress

        modify("Address & Contact")
        {
            CaptionML = FRA = 'Contacts';
        }

        modify("Primary Contact No.")
        {
            Importance = Promoted;
        }

        modify("Phone No.")
        {
            Editable = false;
        }

        modify("MobilePhoneNo")
        {
            Editable = false;
        }
        modify("E-Mail")
        {
            Editable = false;
        }

        addlast(ContactDetails)
        {
            field("Fonction"; Rec."Job Title")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Fonction';
                Importance = Promoted;
                Editable = false;

            }
        }


        movefirst("Address & Contact"; ContactDetails)

        // Adresse

        modify(AddressDetails)
        {
            Visible = false;
        }

        modify(ShowMap)
        {
            Visible = false;
        }
        modify("Fax No.")
        {
            Visible = false;
        }
        modify("Home Page")
        {
            Visible = false;
        }
        modify("Language Code")
        {
            Visible = false;
        }
        modify("Format Region")
        {
            Visible = false;
        }

        // Part Facturation
        modify("Bill-to Customer No.")
        {
            Visible = false;
        }

        modify(GLN)
        {
            Visible = false;
        }
        modify("Use GLN in Electronic Document")
        {
            Visible = false;
        }

        modify(PricesandDiscounts)
        {
            Visible = false;
        }

        addafter("VAT Registration No.")
        {
            group("Adresse de Facturation")
            {
                Caption = 'Informations de Facturation';
                field("Fact Address"; Rec."Fact-Address")
                {
                    ApplicationArea = all;
                }
                field("Fact Address 2"; Rec."Fact-Address 2")
                {
                    ApplicationArea = all;
                }
                field("Fact City"; Rec."Fact-Ville")
                {
                    ApplicationArea = all;
                }
                field("Fact Code Postal"; Rec."Fact-CP")
                {
                    ApplicationArea = all;
                }
                field("Fact CPR"; Rec."FACT-CPR")
                {
                    ApplicationArea = all;
                }
            }
        }

        // Paiements
        modify("Payment in progress (LCY)")
        {
            Visible = false;
        }
        modify("""Balance (LCY)"" - ""Payment in progress (LCY)""")
        {
            Visible = false;
        }
        modify("Reminder Terms Code")
        {
            Visible = false;
        }
        modify("Cash Flow Payment Terms Code")
        {
            Visible = false;
        }


        // Part Statistics
        modify(Statistics)
        {
            Visible = false;
        }

        // Part Echange de Biens
        modify(Intrastat)
        {
            Visible = false;
        }

        // Livraison
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Prepayment %")
        {
            Visible = false;
        }
        modify("Application Method")
        {
            Visible = false;
        }

        addafter("Ship-to Code")
        {
            field("Ship Name"; Rec."Ship-Name")
            {
                ApplicationArea = all;
            }
            field("Ship Adress"; Rec."Ship-Address")
            {
                ApplicationArea = all;
            }
            field("Ship-Adress 2"; Rec."Ship-Address 2")
            {
                ApplicationArea = All;
            }
            field("Ville"; Rec.Ville)
            {
                ApplicationArea = All;
            }
            field("code Postal"; Rec."Code Postal")
            {
                ApplicationArea = All;
            }
            field("Code Pays/région"; Rec."Code pays/région")
            {
                ApplicationArea = All;
            }
        }
        addafter("Code Pays/région")
        {
            group("Contact Livraison")
            {
                field("Ship Contact"; Rec."Ship Contact")
                {
                    ApplicationArea = All;
                }
                field("Ship Contact Mail"; Rec."Ship Contact Mail")
                {
                    ApplicationArea = All;
                }
                field("Ship Contact Phone No"; Rec."Ship Contact Phone No")
                {
                    ApplicationArea = All;
                }
                field("Ship Contact Mobile Phone No"; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        modify(Category_Category6)
        {
            Visible = false;
        }
        modify(Category_Category7)
        {
            Visible = false;
        }
        modify(ApplyTemplate_Promoted)
        {
            Visible = false;
        }
        modify(MergeDuplicate_Promoted)
        {
            Visible = false;
        }
    }
}
