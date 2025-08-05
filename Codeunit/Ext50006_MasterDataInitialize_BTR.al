codeunit 50006 "Master Data Initialise"
{
    Subtype=Install;
    trigger OnInstallAppPerCompany();
    begin
        GetEndDate;
        IF Item.FindSet THEN  
            repeat
                ItemLedgerEntry.Reset;
                ItemLedgerEntry.setrange("Item No.",Item."No.");
                ItemLedgerEntry.setrange("Entry Type",ItemLedgerEntry."Entry Type"::Purchase);
                ItemLedgerEntry.setrange("Posting Date",0D,EndDate);
                if ItemLedgerEntry.FindLast THEN begin 
                    ValueEntry.Reset;
                    ValueEntry.SETRANGE("Item Ledger Entry No.",ItemLedgerEntry."Entry No.");
                    if ValueEntry.FindFirst then begin  
                        Item."Last Year Purchase Price" := ValueEntry."Cost per Unit";
                        Item.Modify;
                    end;                    
                end;
            until Item.Next=0;
    end;
    
    procedure GetEndDate()
    var 
        DateFound : Boolean;
    begin 
        DateFound := false;
        AccountingPeriod.reset;
        AccountingPeriod.setrange("Starting Date",0D,WorkDate);
        AccountingPeriod.Ascending(false);
        If AccountingPeriod.FindSet then  
            repeat
                IF AccountingPeriod."New Fiscal Year" THEN  begin 
                    //AccountingPeriod.Next;
                    EndDate := CalcDate('-1D',AccountingPeriod."Starting Date");
                    DateFound := true;
                end;
            until (AccountingPeriod.next=0) OR DateFound;
    end;

    var
        Item : Record Item;
        AccountingPeriod : Record "Accounting Period";
        EndDate : Date;
        ItemLedgerEntry : Record "Item Ledger Entry";
        ValueEntry : Record "Value Entry";
}