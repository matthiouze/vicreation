reportextension 50147 SalesQuoteTemplateReportExt extends "Standard Sales - Quote"
{
    WordLayout = 'ExtentedStandardSalesQuote.docx';

    dataset
    {
        add(Header)
        {
            column(DateValide; DateValide) { }
            column(SalespersonEmail; SalespersonPurchaser."E-Mail") { }
            column(InformationsAdd; InformationsAdd) { }
            column(ExonerationTVAText; GetExonerationText(TotalAmountVAT)) { }
            column(ReferenceClient; GetReferenceClientText("ReferenceClient")) { }
            column(FraisDePort; GetFraisDePort("No.")) { }
        }

        add(Line)
        {
            column(DescriptionFieldFit; DescriptionFieldFit) { }
            column(ColorLine; CouleurFit) { }
            column(TailleLine; AllSizes) { }
            column(DesignationFit; DesignationFit) { }
            column(CompositionFit; CompositionFit) { }
            column(GrammageFit; GrammageFit) { }
            column(EntretienFit; EntretienFit) { }
            column(CertificationFit; CertificationFit) { }
            column(PictureItem; PictureItem) { }
            column(RefItem; RefItem) { }
            column(BOMComponentsField; ConcatBOMComponents("No.")) { }
        }
    }

    procedure ConcatBOMComponents(ItemNo: Code[20]): Text
    var
        BOMLine: Record "BOM Component";
        BOMText: Text;
    begin
        BOMText := '';
        BOMLine.SetRange("Parent Item No.", ItemNo);
        if BOMLine.FindSet() then begin
            repeat
                BOMText := BOMText + BOMLine.Description + ' ' + Format(BOMLine.BOMColorNbr) + ' ' + Format(BOMLine.PostionMarquage) + ', ';
            until BOMLine.Next() = 0;
        end;
        exit(BOMText);
    end;

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
        SalesLine: Record "Sales Line";
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
}
