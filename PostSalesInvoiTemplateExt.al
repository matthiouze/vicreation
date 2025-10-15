reportextension 50181 PostSalesInvoiTemplateExt extends "Standard Sales - Invoice"
{
    WordLayout = 'ExtentedStandardSalesInvoices.docx';

    dataset
    {
        add(Header)
        {
            column(ExonerationTVAText; GetExonerationText(TotalAmountVAT)) { }
            column(ReferenceClient; GetReferenceClientText("ReferenceClient")) { }
            column(FraisDePort; GetFraisDePort("No.")) { }
        }
        add(Line)
        {
            column(RefItem; GetRefItem("No.")) { }
        }
    }
    local procedure GetExonerationText(AmountTVA: Decimal): Text
    begin
        if AmountTVA = 0 then
            exit('Exonération TVA, art.262 ter-I du CGI')
        else
            exit('');
    end;

    local procedure GetReferenceClientText(ReferenceClient: Text[100]): Text
    begin
        if ReferenceClient <> '' then
            exit('Référence Client : ' + ReferenceClient)
        else
            exit('');
    end;

    local procedure GetFraisDePort(SalesHeaderNo: Code[20]): Decimal
    var
        SalesLine: Record "Sales Invoice Line";
        TotalFraisPort: Decimal;
    begin
        TotalFraisPort := 0;
        SalesLine.SetRange("Document No.", SalesHeaderNo);
        if SalesLine.FindSet() then
            repeat
                if SalesLine."No." = 'FRPORT' then
                    TotalFraisPort += SalesLine."Line Amount";
            until SalesLine.Next() = 0;
        exit(TotalFraisPort);
    end;

    local procedure GetRefItem(ItemNo: Code[20]): Text[100]
    var
        Item: Record Item;
        RefItem: Text[100];
    begin
        if ItemNo <> '' then begin
            if Item.Get(ItemNo) then
                RefItem := Item."Référence Produit";
        end;
        exit(RefItem);
    end;
}