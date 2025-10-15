pageextension 50149 FormDevisTemplatePageExt extends Microsoft.Sales.Document."Sales Quote Subform"
{
    layout
    {
        modify("No.")
        {
            Visible = false;
        }
        addafter("No.")
        {
            field("Custom No."; Rec."Custom No.")
            {
                ApplicationArea = All;
                Caption = 'No.';
                NotBlank = true;
            }
            field(RefItem; Rec.RefItem)
            {
                ApplicationArea = All;
                Caption = 'Référence Produit';
            }
            field(DesignationFit; Rec.DesignationFit)
            {
                ApplicationArea = All;
            }
            field(RefSouhaite; Rec.RefSouhaite)
            {
                ApplicationArea = All;
            }
            field(ItemName; Rec.ItemName)
            {
                ApplicationArea = All;
                NotBlank = true;
            }

            field(CouleurFit; Rec.CouleurFit)
            {
                ApplicationArea = All;
            }
            field(AllSizes; Rec.AllSizes)
            {
                ApplicationArea = All;
            }
        }
        modify(Description)
        {
            Visible = false;
        }
        modify("Item Reference No.")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Qty. to Assemble to Order")
        {
            Visible = false;
        }
        modify("Unit of Measure Code")
        {
            Visible = false;
        }

        modify("Service Commitments")
        {
            Visible = false;
        }
        modify("Customer Contract No.")
        {
            Visible = false;
        }
        modify("Vendor Contract No.")
        {
            Visible = false;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }

    }
    actions
    {
        modify(SelectMultiItems)
        {
            Visible = false;
        }

        modify(Dimensions)
        {
            Visible = false;
        }

        modify(InsertExtTexts)
        {
            Visible = false;
        }

        addlast(processing)
        {
            action(SelectClientArticles)
            {
                Caption = 'Sélectionner Plusieurs Articles';
                ApplicationArea = All;
                Image = Item;

                trigger OnAction()
                var
                    SelectorPage: Page "Client Item Selector";
                    SelectedItems: List of [Code[20]];
                    SalesLine: Record "Sales Line";
                    SalesHeader: Record "Sales Header";
                    ItemNo: Code[20];
                begin
                    CurrPage.SaveRecord();
                    Commit();
                    if not SalesHeader.Get(Rec."Document Type", Rec."Document No.") then
                        exit;

                    SelectorPage.SetCustomerFilter(SalesHeader."Sell-to Customer No.", SalesHeader."Document Type", SalesHeader.EtatDocument);
                    if SelectorPage.RunModal() = Action::OK then begin
                        SelectorPage.GetSelectedItems(SelectedItems);

                        foreach ItemNo in SelectedItems do begin
                            SalesLine.Init();
                            SalesLine."Document Type" := Rec."Document Type";
                            SalesLine."Document No." := Rec."Document No.";
                            SalesLine."Line No." := GetNextLineNo(SalesLine);
                            SalesLine.Type := SalesLine.Type::Item;
                            SalesLine."Custom No." := ItemNo;
                            SalesLine."No." := ItemNo;
                            SalesLine.Insert(true);
                            SalesLine.Validate("Custom No.");
                            SalesLine.Validate("No.");
                        end;
                    end;
                end;
            }
            action(ItemView)
            {
                ApplicationArea = All;
                Caption = 'Voir l''article';
                Image = View;
                trigger OnAction()
                var
                    ItemRec: Record Item;
                begin
                    if ItemRec.Get(Rec."No.") then begin
                        Page.Run(Page::"Item Card", ItemRec)
                    end else
                        Error('Article %1 introuvable.', Rec."No.");
                end;
            }

            action(CopyItemsFromQuote)
            {
                ApplicationArea = All;
                Caption = 'Créer Marquages';

                trigger OnAction()
                var
                    SalesLine: Record "Sales Line";
                    ItemRec: Record Item;
                    NewItemRec: Record Item;
                    NoSeriesMgt: Codeunit "No. Series";
                    ItemSetup: Record "Inventory Setup";
                    NewItemNo: Code[20];
                    IsNewItemValid: Boolean;
                    ItemUnitOfMeasure: Record "Item Unit of Measure";
                    SalesHeader: Record "Sales Header";
                    CustomerRec: Record "Customer";
                    OldItemRec: Record Item;
                begin
                    SalesLine.SetRange("Document Type", Rec."Document Type");
                    SalesLine.SetRange("Document No.", Rec."Document No.");

                    if SalesLine.FindSet() then begin
                        repeat
                            if ItemRec.Get(SalesLine."No.") then begin

                                if not ItemRec.ArticleClient then begin

                                    if not ItemSetup.Get() then
                                        Error('La configuration des articles est introuvable.');
                                    if ItemSetup."Item Nos." = '' then
                                        Error('Aucune série de numérotation définie pour les articles.');

                                    repeat
                                        NewItemNo := NoSeriesMgt.GetNextNo(ItemSetup."Item Nos.", Today, true);
                                        IsNewItemValid := not NewItemRec.Get(NewItemNo);
                                    until IsNewItemValid;

                                    NewItemRec := ItemRec;
                                    NewItemRec."No." := NewItemNo;
                                    NewItemRec.Picture := ItemRec.Picture;
                                    NewItemRec.ArticleClient := true;
                                    if SalesHeader.Get(Rec."Document Type", Rec."Document No.") then begin
                                        NewItemRec.ClientRelation := SalesHeader."Sell-to Customer No.";
                                        if CustomerRec.Get(SalesHeader."Sell-to Customer No.") then begin
                                            NewItemRec.NomClientRelation := CustomerRec.Name;
                                        end;
                                    end;
                                    NewItemRec."ArticleCopié" := true;
                                    NewItemRec.Insert();
                                    if SalesLine."Unit of Measure Code" <> '' then begin
                                        if not ItemUnitOfMeasure.Get(NewItemNo, SalesLine."Unit of Measure Code") then begin
                                            ItemUnitOfMeasure.Init();
                                            ItemUnitOfMeasure."Item No." := NewItemNo;
                                            ItemUnitOfMeasure.Code := SalesLine."Unit of Measure Code";
                                            ItemUnitOfMeasure.Insert();
                                        end;
                                    end;

                                    OldItemRec := ItemRec;

                                    SalesLine.Validate("No.", NewItemNo);
                                    SalesLine.Modify();

                                    if OldItemRec."ArticleCopié" then
                                        if OldItemRec.Delete() then;

                                    Message('Article %1 copié sous le numéro %2 et mis à jour dans le devis.', ItemRec."No.", NewItemNo);
                                end else begin
                                    Message('Article %1 est déja un article client. Pas de copie créée', ItemRec."No.");
                                end;
                            end;
                        until SalesLine.Next() = 0;
                    end else begin
                        Message('Aucun article trouvé dans ce devis.');
                    end;
                end;
            }
            action(DevelopLine)
            {
                ApplicationArea = All;
                Caption = 'Passage en Devis';

                trigger OnAction()
                var
                    SalesLine: Record "Sales Line";
                    TempSalesLine: Record "Sales Line" temporary;
                    NewSalesLine: Record "Sales Line";
                    ItemRec: Record Item;
                    SourceItem: Record Item;
                    OldItemRec: Record Item;
                    NewItemRec: Record Item;
                    NoSeriesMgt: Codeunit "No. Series";
                    ItemSetup: Record "Inventory Setup";
                    Sizes: List of [Text];
                    Colors: List of [Text];
                    Color: Text;
                    Size: Text;
                    LineNoIncrement: Integer;
                    MaxLineNo: Integer;
                    CurrentLineNo: Integer;
                    NewItemNo: Code[20];
                    IsNewItemValid: Boolean;
                    ItemUnitOfMeasure: Record "Item Unit of Measure";
                    AssemblyComp: Record "BOM Component";
                    NewAssemblyComp: Record "BOM Component";
                    RefFournisseur: Text;
                    SalesHeader: Record "Sales Header";
                    CustomerRec: Record "Customer";
                    ConfirmContinue: Boolean;
                    MaxBomLineNo: Integer;
                    BomLineIncrement: Integer;
                begin
                    SalesLine.SetRange("Document Type", Rec."Document Type");
                    SalesLine.SetRange("Document No.", Rec."Document No.");

                    if SalesLine.FindSet() then begin
                        repeat
                            if (SalesLine.ItemName = '') or (SalesLine.RefSouhaite = '') then begin
                                ConfirmContinue := Confirm('Des valeurs dans les champs "Désignation souhaitée" et "Référence souhaitée" sont manquantes.Voulez-vous continuer malgré tout ?',
                                    true,
                                    Rec.ItemName,
                                    Rec.RefSouhaite
                                );
                                if not ConfirmContinue then
                                    exit;
                            end;
                        until SalesLine.Next() = 0;
                    end;

                    if SalesLine.FindSet() then
                        repeat
                            TempSalesLine := SalesLine;
                            TempSalesLine.Insert();
                        until SalesLine.Next() = 0;

                    if TempSalesLine.FindSet() then begin
                        LineNoIncrement := 10000;

                        MaxLineNo := 0;
                        if SalesLine.FindLast() then
                            MaxLineNo := SalesLine."Line No.";

                        repeat
                            Sizes := TempSalesLine.AllSizes.Split(',');
                            Colors := TempSalesLine.CouleurFit.Split(',');
                            RefFournisseur := '';

                            if ItemRec.Get(TempSalesLine."No.") then
                                RefFournisseur := ItemRec."Vendor Item No.";

                            if (Sizes.Count > 0) and (Colors.Count > 0) and (RefFournisseur <> '') then begin
                                CurrentLineNo := TempSalesLine."Line No.";

                                SalesLine.SetRange("Document Type", TempSalesLine."Document Type");
                                SalesLine.SetRange("Document No.", TempSalesLine."Document No.");
                                SalesLine.SetRange("Line No.", CurrentLineNo);
                                if SalesLine.FindFirst() then begin
                                    if OldItemRec.Get(SalesLine."No.") then begin
                                        SalesLine.Delete();

                                        if OldItemRec."ArticleCopié" then
                                            OldItemRec.Delete();
                                    end else
                                        SalesLine.Delete();
                                end;


                                foreach Color in Colors do begin
                                    foreach Size in Sizes do begin

                                        SourceItem.Reset();
                                        SourceItem.SetRange("Vendor Item No.", RefFournisseur);
                                        SourceItem.SetRange(Taille, Size);
                                        SourceItem.SetRange(Couleur, Color);
                                        if not SourceItem.FindFirst() then
                                            Error('Aucun article trouvé pour la taille %1 et la couleur %2.', Size, Color);

                                        if not ItemSetup.Get() then
                                            Error('La configuration des articles est introuvable.');
                                        if ItemSetup."Item Nos." = '' then
                                            Error('Aucune série de numérotation définie pour les articles.');

                                        repeat
                                            NewItemNo := NoSeriesMgt.GetNextNo(ItemSetup."Item Nos.", Today, true);
                                            IsNewItemValid := not NewItemRec.Get(NewItemNo);
                                        until IsNewItemValid;

                                        NewItemRec := SourceItem;
                                        NewItemRec."No." := NewItemNo;
                                        NewItemRec."ArticleCopié" := false;
                                        NewItemRec.ArticleClient := true;
                                        if SalesHeader.Get(Rec."Document Type", Rec."Document No.") then begin
                                            NewItemRec.ClientRelation := SalesHeader."Sell-to Customer No.";
                                            if CustomerRec.Get(SalesHeader."Sell-to Customer No.") then begin
                                                NewItemRec.NomClientRelation := CustomerRec.Name;
                                            end;
                                        end;
                                        if TempSalesLine.RefSouhaite <> '' then begin
                                            NewItemRec."Référence Produit" := TempSalesLine.RefSouhaite;
                                        end else begin
                                            NewItemRec."Référence Produit" := 'VI' + NewItemNo;
                                        end;
                                        if TempSalesLine.ItemName <> '' then begin
                                            NewItemRec.Description := TempSalesLine.ItemName;
                                        end else begin
                                            NewItemRec.Description := SourceItem.Description;
                                        end;
                                        NewItemRec.TailleDispo := Size;
                                        NewItemRec.CouleurDispo := Color;
                                        NewItemRec."Profit %" := SalesLine."Profit %";
                                        NewItemRec."Unit Price" := SourceItem."Unit Price";
                                        NewItemRec."Unit Cost" := SourceItem."Unit Cost";
                                        NewItemRec."Prix Achat" := SourceItem."Prix Achat";
                                        NewItemRec.Insert();

                                        if SalesLine."Unit of Measure Code" <> '' then begin
                                            if not ItemUnitOfMeasure.Get(NewItemNo, SalesLine."Unit of Measure Code") then begin
                                                ItemUnitOfMeasure.Init();
                                                ItemUnitOfMeasure."Item No." := NewItemNo;
                                                ItemUnitOfMeasure.Code := SalesLine."Unit of Measure Code";
                                                ItemUnitOfMeasure.Insert();
                                            end;
                                        end;

                                        BomLineIncrement := 10000;
                                        MaxBomLineNo := 10000;

                                        AssemblyComp.SetRange("Parent Item No.", TempSalesLine."No.");
                                        if AssemblyComp.FindSet() then begin
                                            repeat
                                                NewAssemblyComp := AssemblyComp;
                                                NewAssemblyComp."Parent Item No." := NewItemNo;
                                                NewAssemblyComp."Quantity per" := 1;
                                                NewAssemblyComp.Insert();
                                                MaxBomLineNo += BomLineIncrement;
                                            until AssemblyComp.Next() = 0;
                                        end;

                                        NewAssemblyComp.Init();
                                        NewAssemblyComp."Line No." := MaxBomLineNo;
                                        NewAssemblyComp."Parent Item No." := NewItemNo;
                                        NewAssemblyComp.Type := NewAssemblyComp.Type::Item;
                                        NewAssemblyComp."No." := SourceItem."No.";
                                        NewAssemblyComp.Description := SourceItem.Description;
                                        NewAssemblyComp."Quantity per" := 1;
                                        NewAssemblyComp.Insert();

                                        MaxLineNo += LineNoIncrement;

                                        ItemHelper.RecalculateItemValues(NewItemRec);
                                        NewItemRec.Modify();

                                        NewSalesLine.Init();
                                        NewSalesLine.TransferFields(TempSalesLine);
                                        NewSalesLine."Line No." := MaxLineNo;
                                        NewSalesLine."No." := NewItemNo;
                                        NewSalesLine."Custom No." := NewItemNo;
                                        NewSalesLine.AllSizes := Size;
                                        NewSalesLine.CouleurFit := Color;
                                        NewSalesLine.Quantity := 0;
                                        NewSalesLine.Description := NewItemRec.Description;
                                        NewSalesLine.Insert();
                                    end;
                                end;
                            end;
                        until TempSalesLine.Next() = 0;
                    end;

                    if SalesHeader.Get(Rec."Document Type", Rec."Document No.") then begin
                        SalesHeader."EtatDocument" := SalesHeader."EtatDocument"::"Devis";

                        SalesHeader.Modify();
                    end;
                end;

            }
        }
    }
    procedure GetNextLineNo(SalesLine: Record "Sales Line"): Integer
    var
        TempSalesLine: Record "Sales Line";
        MaxLineNo: Integer;
    begin
        TempSalesLine.SetRange("Document Type", SalesLine."Document Type");
        TempSalesLine.SetRange("Document No.", SalesLine."Document No.");
        if TempSalesLine.FindLast() then
            MaxLineNo := TempSalesLine."Line No."
        else
            MaxLineNo := 0;

        exit(MaxLineNo + 10000);
    end;

    trigger OnAfterGetRecord()
    var
        ItemRec: Record Item;
        SalesHeader: Record "Sales Header";
    begin
        if SalesHeader.Get(Rec."Document Type", Rec."Document No.") then begin
            if SalesHeader.Status <> SalesHeader.Status::Open then
                exit;
        end;

        if Rec."No." <> '' then begin
            if ItemRec.Get(Rec."No.") then begin
                Rec.DesignationFit := ItemRec.Description;
                Rec.RefItem := ItemRec."Référence Produit";
                REc.Validate(Rec."Unit Price", ItemRec."Unit Price");
                Rec.Modify(true);
            end;
        end;
    end;

    var
        ItemHelper: Codeunit ItemCalculationHelper;
}