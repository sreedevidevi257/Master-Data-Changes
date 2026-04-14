codeunit 50100 "Sales Events"
{
    trigger OnRun();
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterSalesInvHeaderInsert', '', false, false)]
    procedure UpdateSalesInvHeader(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header")
    begin
        IF SalesInvHeader."Use Bank Account" <> SalesHeader."Use Bank Account" THEN begin
            SalesInvHeader."Use Bank Account" := SalesHeader."Use Bank Account";
            SalesInvHeader.Modify;
        END;
    end;

    [EventSubscriber(ObjectType::Page, 26, 'OnQueryClosePageEvent', '', false, false)]
    procedure TestMandatoryVendorFields(var Rec: Record Vendor; var AllowClose: Boolean)
    Begin
        IF Rec."Trade License No." = '' THEN
            Error('Please specify a Trade License No.')
    End;

    [EventSubscriber(ObjectType::Page, 21, 'OnQueryClosePageEvent', '', false, false)]
    procedure TestMandatoryCustomerFields(var Rec: Record Customer; var AllowClose: Boolean)
    Begin
        IF Rec."Trade License No." = '' THEN
            Error('Please specify a Trade License No.')
    End;

    [EventSubscriber(ObjectType::Table, 38, 'OnBeforeInsertEvent', '', false, false)]
    procedure UpdateNewPurchaseDocuments(var Rec: Record "Purchase Header"; RunTrigger: Boolean)
    begin
        IF Rec."Document Type" IN [Rec."Document Type"::Order, Rec."Document Type"::Quote, Rec."Document Type"::Invoice] THEN
            IF Rec."Assigned User ID" = '' THEN
                Rec."Assigned User ID" := UserId;
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnBeforeInsertEvent', '', false, false)]
    procedure UpdateNewSalesDocuments(var Rec: Record "Sales Header"; RunTrigger: Boolean)
    begin
        //IF Rec."Document Type" IN [Rec."Document Type"::Order,Rec."Document Type"::Quote,Rec."Document Type"::Invoice] THEN  
        IF Rec."Assigned User ID" = '' THEN
            Rec."Assigned User ID" := UserId;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Dimension Set Entry", 'OnBeforeInsertEvent', '', true, true)]
    local procedure OnBeforeInsertEvent(var Rec: Record "Dimension Set Entry")
    begin
        if ((Rec."Dimension Code" = 'HFM ENTITY') and ((Rec."User ID" ='') or (Rec."User ID" <> '')))then
        begin
                Rec."User ID" := UserId;
                //Rec."Dimension Value DS" := Rec."Dimension Value Code";
        end;

    end;
        [EventSubscriber(ObjectType::Table, Database::"Dimension Set Entry", 'OnBeforeModifyEvent', '', true, true)]
    local procedure OnGetDimensionSetIDOnBeforeInsertTreeNode(var Rec: Record "Dimension Set Entry")
    begin
        if ((Rec."Dimension Code" = 'HFM ENTITY') and ((Rec."User ID" ='') or (Rec."User ID" <> '')))then
        begin
                Rec."User ID" := UserId;
                //Rec."Dimension Value DS" := Rec."Dimension Value Code";
        end;

    end;
      [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromSalesLine', '', false, false)]
    local procedure OnBeforeInsertItemJournalEvent(SalesLine: Record "Sales Line"; var ItemJnlLine: Record "Item Journal Line")
    var
    begin
        ItemJnlLine."Item Category PGR 1" := SalesLine."Item Category PGR 1";
        ItemJnlLine."Item Category PGR 2" := SalesLine."Item Category PGR 2";
        ItemJnlLine."Item Category PGR 3" := SalesLine."Item Category PGR 3";
        ItemJnlLine."Item Category PGR 4" := SalesLine."Item Category PGR 4";
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertItemLedgEntry', '', false, false)]
    local procedure OnBeforeInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line")
    var
    begin
        ItemLedgerEntry."Item Category PGR 1" := ItemJournalLine."Item Category PGR 1";
        ItemLedgerEntry."Item Category PGR 2" := ItemJournalLine."Item Category PGR 2";
        ItemLedgerEntry."Item Category PGR 3" := ItemJournalLine."Item Category PGR 3";
        ItemLedgerEntry."Item Category PGR 4" := ItemJournalLine."Item Category PGR 4";
    end;
    
[EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterSalesInvLineInsert', '', false, false)]
  procedure UpdateSalesInvoiceLine(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line"; ItemLedgShptEntryNo: Integer;WhseShip: Boolean; WhseReceive: Boolean)
  begin
   // SalesInvLine."Cust. Ref #" := SalesLine."Cust. Ref #";
    SalesInvLine."PDN  No.":= SalesLine."PDN  No.";
    SalesInvLine."Size_":= SalesLine."Size_";
    SalesInvLine."Door  Type/No.":=SalesLine."Door  Type/No.";
    SalesInvLine."Fire  Rating":=SalesLine."Fire  Rating";
    SalesInvLine."STC  Rating":=SalesLine."STC  Rating";
    SalesInvLine.Modify;
  end;
}
 