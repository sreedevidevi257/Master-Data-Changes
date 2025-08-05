report 50008 "Assa - Customer/Item Sales"
{
    // ApplicationArea = All;
    // DefaultLayout = RDLC;
    //RDLCLayout = './Report/Assa - CustomerItem Sales.rdl'; OLD
    RDLCLayout = 'CustomerItem-Adi.rdl';
    Caption = 'Customer/Item Sales';
    UsageCategory = ReportsAndAnalysis;
    //ProcessingOnly = true;
    Permissions = TableData "Sales Shipment Buffer" = rimd;
    PreviewMode = PrintLayout;

    dataset
    {

        dataitem(Customer; Customer)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Customer Posting Group";
            column(STRSUBSTNO_Text000_PeriodText_; STRSUBSTNO(Text000, PeriodText))
            {
            }
            column(CurrReport_PAGENO; _PageNo)
            {
            }
            column(COMPANYNAME; COMPANYPROPERTY.DISPLAYNAME)
            {
            }
            column(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
            {
            }
            column(Customer_TABLECAPTION__________CustFilter; TABLECAPTION + ': ' + CustFilter)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(Value_Entry__TABLECAPTION__________ItemLedgEntryFilter; "Value Entry".TABLECAPTION + ': ' + ValueEntryFilter)
            {
            }
            column(ItemLedgEntryFilter; ValueEntryFilter)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer__Phone_No__; "Phone No.")
            {
            }
            column(ValueEntryBuffer__Sales_Amount__Actual__; ValueEntryBuffer."Sales Amount (Actual)")
            {
            }
            column(ValueEntryBuffer__Discount_Amount_; -ValueEntryBuffer."Discount Amount")
            {
            }
            column(Profit; Profit)
            {
                AutoFormatType = 1;
            }
            column(ProfitPct; ProfitPct)
            {
                DecimalPlaces = 1 : 1;
            }
            column(Customer_Item_SalesCaption; Customer_Item_SalesCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(All_amounts_are_in_LCYCaption; All_amounts_are_in_LCYCaptionLbl)
            {
            }
            column(ValueEntryBuffer__Item_No__Caption; ValueEntryBuffer__Item_No__CaptionLbl)
            {
            }
            column(Item_DescriptionCaption; Item_DescriptionCaptionLbl)
            {
            }
            column(ValueEntryBuffer__Invoiced_Quantity_Caption; ValueEntryBuffer__Invoiced_Quantity_CaptionLbl)
            {
            }
            column(Item__Base_Unit_of_Measure_Caption; Item__Base_Unit_of_Measure_CaptionLbl)
            {
            }
            column(ValueEntryBuffer__Sales_Amount__Actual___Control44Caption; ValueEntryBuffer__Sales_Amount__Actual___Control44CaptionLbl)
            {
            }
            column(ValueEntryBuffer__Discount_Amount__Control45Caption; ValueEntryBuffer__Discount_Amount__Control45CaptionLbl)
            {
            }
            column(Profit_Control46Caption; Profit_Control46CaptionLbl)
            {
            }
            column(ProfitPct_Control47Caption; ProfitPct_Control47CaptionLbl)
            {
            }
            column(Customer__Phone_No__Caption; FIELDCAPTION("Phone No."))
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Customer_Name_Caption; CustomerNameCaptionLbl)
            {
            }
            column(Sales_OrderNo_Caption; SalesOrderNoCaptionLbl)
            {
            }
            column(Production_OrderNo_Caption; ProdOrderNoCaptionLbl)
            {
            }
            column(Description1_Caption; Description1CaptionLbl)
            {
            }
            column(Description2_Caption; Description2CaptionLbl)
            {
            }
            column(ProjectDimension_Caption; ProjectCaptionLbl)
            {
            }
            column(CountryDimension_Caption; CountryCaptionLbl)
            {
            }
            dataitem("Value Entry"; "Value Entry")
            {
                DataItemLink = "Source No." = FIELD("No."),
                               "Posting Date" = FIELD("Date Filter"),
                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Source Type", "Source No.", "Item No.", "Variant Code", "Posting Date")
                                    WHERE("Source Type" = CONST(Customer),
                                          "Item Charge No." = CONST(),
                                          "Expected Cost" = CONST(false),
                                          "Adjustment" = CONST(false));
                RequestFilterFields = "Item No.", "Posting Date";

                trigger OnAfterGetRecord();
                var
                    ValueEntry: Record "Value Entry";
                    Cust: Record Customer;
                    ProdOrder: Record "Production Order";
                    SalesShptHeader: Record "Sales Shipment Header";
                    EntryInBufferExists: Boolean;
                    DimensionSetEntry: Record "Dimension Set Entry";
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    Item.GET("Item No.");
                    if not Cust.Get("Source No.") THEN
                        Cust.Init;
                    CustomerItemSalesBuffer.RESET;
                    CustomerItemSalesBuffer.SETRANGE("Item No.", "Item No.");
                    CustomerItemSalesBuffer.SETRANGE("Customer No.", "Source No.");
                    CustomerItemSalesBuffer.SETRANGE("Sales Order No.", "Document No.");
                    IF NOT CustomerItemSalesBuffer.FINDFIRST THEN BEGIN
                        SalesInvHeader.reset;
                        SalesInvHeader.SETRANGE("No.", "Document No.");
                        If not SalesInvHeader.FindFirst THEN
                            SalesInvHeader.Init;
                        ProdOrder.Reset;
                        ProdOrder.SETRANGE("Source Type", ProdOrder."Source Type"::"Sales Header");
                        ProdOrder.SETRANGE("Source No.", SalesInvHeader."Order No.");
                        IF NOT ProdOrder.FindLast THEN
                            ProdOrder.Init;

                        CustomerItemSalesBuffer.INIT;
                        CustomerItemSalesBuffer."Customer No." := "Source No.";
                        CustomerItemSalesBuffer."Item No." := "Item No.";
                        CustomerItemSalesBuffer."Sales Order No." := "Document No.";
                        CustomerItemSalesBuffer."Customer Name" := Cust.Name;
                        CustomerItemSalesBuffer."Production Order No." := ProdOrder."No.";
                        CustomerItemSalesBuffer."Description 1" := Item.Description;
                        CustomerItemSalesBuffer."Description 2" := Item."Description 2";
                        CustomerItemSalesBuffer."PGR Code" := Item."Item Category Code";
                        //CustomerItemSalesBuffer."PGR Code 2" := Item.PGR2;//@@HA
                        CustomerItemSalesBuffer."Sub Category 1" := Item."Sub Category 1";
                        CustomerItemSalesBuffer."Sub Category 2" := Item."Sub Category 2";
                        CustomerItemSalesBuffer."Unit of Measure" := Item."Base Unit of Measure";

                        DimensionSetEntry.Reset;
                        DimensionSetEntry.SETRANGE("Dimension Set ID", "Dimension Set ID");
                        DimensionSetEntry.SETRANGE("Dimension Code", 'COUNTRY');
                        if DimensionSetEntry.FindFirst THEN
                            CustomerItemSalesBuffer."Global Dimension 1 Code" := DimensionSetEntry."Dimension Value Code";
                        DimensionSetEntry.SETRANGE("Dimension Code", 'PROJECTS');
                        if DimensionSetEntry.FindFirst THEN
                            CustomerItemSalesBuffer."Global Dimension 2 Code" := DimensionSetEntry."Dimension Value Code";

                        CustomerItemSalesBuffer.INSERT;
                    END;

                    CustomerItemSalesBuffer."Invoiced Quantity" += "Invoiced Quantity";
                    CustomerItemSalesBuffer."Cost Amount" += "Cost Amount (Actual)";
                    CustomerItemSalesBuffer."Discount Amount" += "Discount Amount";
                    CustomerItemSalesBuffer."Invoiced Amount" += "Sales Amount (Actual)";
                    //CustomerItemSalesBuffer."Profit Amount" += ("Sales Amount (Actual)"+"Cost Amount (Actual)");


                    // Add item charges regardless of their posting date
                    ValueEntry.SETRANGE("Item Ledger Entry No.", "Item Ledger Entry No.");
                    ValueEntry.SETFILTER("Item Charge No.", '<>%1', '');
                    ValueEntry.CALCSUMS("Sales Amount (Actual)", "Cost Amount (Actual)", "Cost Amount (Non-Invtbl.)", "Discount Amount");

                    CustomerItemSalesBuffer."Invoiced Quantity" += ValueEntry."Sales Amount (Actual)";
                    CustomerItemSalesBuffer."Discount Amount" += ValueEntry."Discount Amount";

                    // Add cost adjustments regardless of their posting date
                    ValueEntry.SETRANGE("Item Charge No.", '');
                    ValueEntry.SETRANGE(Adjustment, TRUE);
                    ValueEntry.CALCSUMS("Cost Amount (Actual)");
                    CustomerItemSalesBuffer."Cost Amount" += ValueEntry."Cost Amount (Actual)";


                    CustomerItemSalesBuffer."Profit Amount" := (CustomerItemSalesBuffer."Invoiced Amount" + CustomerItemSalesBuffer."Cost Amount");
                    //MESSAGE('Profit:  '+FORMAT(CustomerItemSalesBuffer."Profit Amount"));
                    CustomerItemSalesBuffer.MODIFY;
                end;

                trigger OnPreDataItem();
                begin
                    ValueEntryBuffer.RESET;
                    ValueEntryBuffer.DELETEALL;

                    CustomerItemSalesBuffer.RESET;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                TotalInvoiceQty := 0;
                TotalCostAmount := 0;
                TotalDiscountAmount := 0;
                TotalInvoiceAmount := 0;
                TotalProfitAmount := 0;
            end;

            trigger OnPreDataItem();
            begin
                EnterReportHeader;
                EnterColumnHeader;
            end;
        }
        dataitem(CustomerItemSales; Integer)
        {
            DataItemTableView = SORTING(Number);
            column(CustomerItemSales_CustomerNo; CustomerItemSalesBuffer."Customer No.")
            {
            }
            column(CustomerItemSales_CustomerName; CustomerItemSalesBuffer."Customer Name")
            {
            }
            column(CustomerItemSales_SalesOrderNo_; CustomerItemSalesBuffer."Sales Order No.")
            {
            }
            column(CustomerItemSales_ProdOrderNo; CustomerItemSalesBuffer."Production Order No.")
            {
            }
            column(CustomerItemSales_ItemNo; CustomerItemSalesBuffer."Item No.")
            {
            }
            column(CustomerItemSales_Description1; CustomerItemSalesBuffer."Description 1")
            {
            }
            column(CustomerItemSales_Description2; CustomerItemSalesBuffer."Description 2")
            {
            }
            column(CustomerItemSales_GlobalDimension1Code; CustomerItemSalesBuffer."Global Dimension 1 Code")
            {
            }
            column(CustomerItemSales_GlobalDimension2Code; CustomerItemSalesBuffer."Global Dimension 2 Code")
            {
            }
            column(CustomerItemSales_UOM; CustomerItemSalesBuffer."Unit of Measure")
            {
            }
            column(CustomerItemSales_InvoicedQuantity; CustomerItemSalesBuffer."Invoiced Quantity")
            {
            }
            column(CustomerItemSales_CostAmount; CustomerItemSalesBuffer."Cost Amount")
            {
            }
            column(CustomerItemSales_DiscountAmount; CustomerItemSalesBuffer."Discount Amount")
            {
            }
            column(CustomerItemSales_InvoicedAmount; CustomerItemSalesBuffer."Invoiced Amount")
            {
            }
            column(CustomerItemSales_ProfitAmount; CustomerItemSalesBuffer."Profit Amount")
            {
            }
            column(CustomerItemSales_ProfitPercentage; CustomerItemSalesBuffer."Profit %")
            {
            }
            Column(ItemBrand_Item; item2."Service Item Group")
            {
            }
            dataitem(DataItem5444; 2000000026)
            {
                DataItemTableView = SORTING(Number);
                column(ValueEntryBuffer__Item_No__; ValueEntryBuffer."Item No.")
                {
                }
                column(Item_Description; Item.Description)
                {
                }
                column(ValueEntryBuffer__Invoiced_Quantity_; -ValueEntryBuffer."Invoiced Quantity")
                {
                    //DecimalPlaces = 0:5;
                }
                column(ValueEntryBuffer__Sales_Amount__Actual___Control44; ValueEntryBuffer."Sales Amount (Actual)")
                {
                    AutoFormatType = 1;
                }
                column(ValueEntryBuffer__Discount_Amount__Control45; -ValueEntryBuffer."Discount Amount")
                {
                    AutoFormatType = 1;
                }
                column(Profit_Control46; Profit)
                {
                    AutoFormatType = 1;
                }
                column(ProfitPct_Control47; ProfitPct)
                {
                    DecimalPlaces = 1 : 1;
                }
                column(Item__Base_Unit_of_Measure_; Item."Base Unit of Measure")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    IF Number = 1 THEN
                        ValueEntryBuffer.FIND('-')
                    ELSE
                        ValueEntryBuffer.NEXT;

                    Profit :=
                      ValueEntryBuffer."Sales Amount (Actual)" +
                      ValueEntryBuffer."Cost Amount (Actual)" +
                      ValueEntryBuffer."Cost Amount (Non-Invtbl.)";

                    IF Item.GET(ValueEntryBuffer."Item No.") THEN;
                end;

                trigger OnPreDataItem();
                begin
                    ValueEntryBuffer.RESET;
                    SETRANGE(Number, 1, ValueEntryBuffer.COUNT);
                end;
            }

            trigger OnAfterGetRecord();
            begin
                IF Number = 1 THEN
                    CustomerItemSalesBuffer.FIND('-')
                ELSE
                    CustomerItemSalesBuffer.NEXT;

                IF CustNo <> CustomerItemSalesBuffer."Customer No." THEN BEGIN
                    IF CustNo <> '' THEN
                        LastEntry := TRUE;

                    CustNo := CustomerItemSalesBuffer."Customer No.";
                END;
                if Item2.Get(CustomerItemSalesBuffer."Item No.") then;

                //Add Total Line
                IF LastEntry THEN BEGIN
                    LastEntry := FALSE;

                    ExcelLineNo += 1;
                    EnterCell(ExcelLineNo, 13, 'TOTAL', TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    EnterCell(ExcelLineNo, 14, FORMAT(TotalInvoiceQty), TRUE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    EnterCell(ExcelLineNo, 15, FORMAT(TotalCostAmount), TRUE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    EnterCell(ExcelLineNo, 16, FORMAT(TotalDiscountAmount), TRUE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    EnterCell(ExcelLineNo, 17, FORMAT(TotalInvoiceAmount), TRUE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    EnterCell(ExcelLineNo, 18, FORMAT(TotalProfitAmount), TRUE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelLineNo += 2;
                    TotalInvoiceQty := 0;
                    TotalCostAmount := 0;
                    TotalDiscountAmount := 0;
                    TotalInvoiceAmount := 0;
                    TotalProfitAmount := 0;
                END ELSE BEGIN
                    TotalInvoiceQty += CustomerItemSalesBuffer."Invoiced Quantity";
                    TotalCostAmount += CustomerItemSalesBuffer."Cost Amount";
                    TotalDiscountAmount += CustomerItemSalesBuffer."Discount Amount";
                    TotalInvoiceAmount += CustomerItemSalesBuffer."Invoiced Amount";
                    TotalProfitAmount += CustomerItemSalesBuffer."Profit Amount";
                END;


                EnterCell(ExcelLineNo, 1, CustomerItemSalesBuffer."Customer No.", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(ExcelLineNo, 2, CustomerItemSalesBuffer."Customer Name", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(ExcelLineNo, 3, CustomerItemSalesBuffer."Sales Order No.", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(ExcelLineNo, 4, CustomerItemSalesBuffer."Production Order No.", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(ExcelLineNo, 5, CustomerItemSalesBuffer."Item No.", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(ExcelLineNo, 6, CustomerItemSalesBuffer."Description 1", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(ExcelLineNo, 7, CustomerItemSalesBuffer."Description 2", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(ExcelLineNo, 8, CustomerItemSalesBuffer."PGR Code", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(ExcelLineNo, 9, CustomerItemSalesBuffer."PGR Code 2", false, false, '', ExcelBuf."Cell Type"::Text);//@@HA
                EnterCell(ExcelLineNo, 10, CustomerItemSalesBuffer."Sub Category 1", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(ExcelLineNo, 11, CustomerItemSalesBuffer."Sub Category 2", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(ExcelLineNo, 12, CustomerItemSalesBuffer."Global Dimension 1 Code", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(ExcelLineNo, 13, CustomerItemSalesBuffer."Global Dimension 2 Code", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(ExcelLineNo, 14, CustomerItemSalesBuffer."Unit of Measure", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(ExcelLineNo, 15, FORMAT(CustomerItemSalesBuffer."Invoiced Quantity"), FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                EnterCell(ExcelLineNo, 16, FORMAT(CustomerItemSalesBuffer."Cost Amount"), FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                EnterCell(ExcelLineNo, 17, FORMAT(CustomerItemSalesBuffer."Discount Amount"), FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                EnterCell(ExcelLineNo, 18, FORMAT(CustomerItemSalesBuffer."Invoiced Amount"), FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                EnterCell(ExcelLineNo, 19, FORMAT(CustomerItemSalesBuffer."Profit Amount"), FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelLineNo += 1;
            end;

            trigger OnPostDataItem();
            begin
                ExcelLineNo += 1;
                EnterCell(ExcelLineNo, 13, 'TOTAL', TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(ExcelLineNo, 14, FORMAT(TotalInvoiceQty), TRUE, FALSE, '', ExcelBuf."Cell Type"::Number);
                EnterCell(ExcelLineNo, 15, FORMAT(TotalCostAmount), TRUE, FALSE, '', ExcelBuf."Cell Type"::Number);
                EnterCell(ExcelLineNo, 16, FORMAT(TotalDiscountAmount), TRUE, FALSE, '', ExcelBuf."Cell Type"::Number);
                EnterCell(ExcelLineNo, 17, FORMAT(TotalInvoiceAmount), TRUE, FALSE, '', ExcelBuf."Cell Type"::Number);
                EnterCell(ExcelLineNo, 18, FORMAT(TotalProfitAmount), TRUE, FALSE, '', ExcelBuf."Cell Type"::Number);

                ExcelBuf.CreateBook(ServerFileName, Customer_Item_SalesCaptionLbl);

                ExcelBuf.WriteSheet(
                  //PADSTR(STRSUBSTNO('%1 %2','Pitso','Pitso Test'),30),
                  Customer_Item_SalesCaptionLbl,
                  COMPANYNAME,
                  USERID);

                ExcelBuf.CloseBook;
                ExcelBuf.SetFriendlyFilename(Customer_Item_SalesCaptionLbl);
                ExcelBuf.OpenExcel;
                ExcelBuf.GiveUserControl;

                CurrReport.BREAK;
            end;

            trigger OnPreDataItem();
            begin
                CustomerItemSalesBuffer.RESET;
                SETRANGE(Number, 1, CustomerItemSalesBuffer.COUNT);
                ExcelLineNo := 8;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Page per Customer';
                        ToolTip = 'Specifies if each customer''s information is printed on a new page if you have chosen two or more customers to be included in the report.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport();
    var
        CaptionManagement: Codeunit "CaptionManagement";
    begin
        CustFilter := CaptionManagement.GetRecordFiltersWithCaptions(Customer);
        ValueEntryFilter := "Value Entry".GETFILTERS;
        PeriodText := "Value Entry".GETFILTER("Posting Date");
    end;

    var
    _PageNo:Text;
        Text000: Label 'Period: %1';
        Item: Record "Item";
        Item2: Record "Item";
        ValueEntryBuffer: Record "Value Entry" temporary;
        TempItemLedgerEntry: Record "Item Ledger Entry" temporary;
        CustomerItemSalesBuffer: Record "Customer Item Sales Buffer" temporary;
        ExcelBuf: Record "Excel Buffer" temporary;
        CustFilter: Text;
        ValueEntryFilter: Text;
        PeriodText: Text;
        PrintOnlyOnePerPage: Boolean;
        Profit: Decimal;
        ProfitPct: Decimal;
        Customer_Item_SalesCaptionLbl: Label 'Customer/Item Sales';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        All_amounts_are_in_LCYCaptionLbl: Label 'All amounts are in LCY';
        ValueEntryBuffer__Item_No__CaptionLbl: Label 'Item No.';
        Item_DescriptionCaptionLbl: Label 'Description';
        ValueEntryBuffer__Invoiced_Quantity_CaptionLbl: Label 'Invoiced Quantity';
        Item__Base_Unit_of_Measure_CaptionLbl: Label 'Unit of Measure';
        ValueEntryBuffer__Sales_Amount__Actual___Control44CaptionLbl: Label 'Amount';
        ValueEntryBuffer__Discount_Amount__Control45CaptionLbl: Label 'Discount Amount';
        Profit_Control46CaptionLbl: Label 'Profit';
        ProfitPct_Control47CaptionLbl: Label 'Profit %';
        TotalCaptionLbl: Label 'Total';
        CustomerNameCaptionLbl: Label 'Customer Name';
        SalesOrderNoCaptionLbl: Label 'Sales Order No.';
        ProdOrderNoCaptionLbl: Label 'Production Order No.';
        Description1CaptionLbl: Label 'Description 1';
        Description2CaptionLbl: Label 'Description 2';
        CountryCaptionLbl: Label 'Country';
        ProjectCaptionLbl: Label 'Project';
        InvoicedAmountCaptionLbl: Label 'Invoiced Amount';
        ColNo: Integer;
        HeaderRowNo: Integer;
        CustomerCodeCaptionLbl: Label 'Customer Code';
        CustomerName_CaptionLbl: Label 'Customer Name';
        ItemNoCaptionLbl: Label 'Item No.';
        QtyInvoicedCaptionLbl: Label 'Quantity Invoiced';
        CostAmountCaptionLbl: Label 'Cost Amount';
        DiscountAmtCaptionLbl: Label 'Discount Amount';
        AmtInvoiced: Label 'Amount Invoiced';
        ProfitAmtCaptionLbl: Label 'Profit Amount';
        ServerFileName: Text;
        ExcelLineNo: Integer;
        TotalInvoiceQty: Decimal;
        TotalCostAmount: Decimal;
        TotalDiscountAmount: Decimal;
        TotalInvoiceAmount: Decimal;
        TotalProfitAmount: Decimal;
        CustNo: Code[20];
        LastEntry: Boolean;
        PGRCodeLbl: Label 'PGR Code';
        PGRCodeLbl2: Label 'PGR Code 2';
        SubCategory1Lbl: Label 'Sub Category 1';
        SubCategory2Lbl: Label 'Sub Category 2';

    procedure InitializeRequest(NewPagePerCustomer: Boolean);
    begin
        PrintOnlyOnePerPage := NewPagePerCustomer;
    end;

    local procedure EnterColumnHeader();
    begin
        ExcelLineNo := 7;

        EnterCell(ExcelLineNo, 1, CustomerCodeCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(ExcelLineNo, 2, CustomerNameCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(ExcelLineNo, 3, SalesOrderNoCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(ExcelLineNo, 4, ProdOrderNoCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(ExcelLineNo, 5, ItemNoCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(ExcelLineNo, 6, Description1CaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(ExcelLineNo, 7, Description2CaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(ExcelLineNo, 8, PGRCodeLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(ExcelLineNo, 9, PGRCodeLbl2, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(ExcelLineNo, 10, SubCategory1Lbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(ExcelLineNo, 11, SubCategory2Lbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(ExcelLineNo, 12, CountryCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(ExcelLineNo, 13, ProjectCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(ExcelLineNo, 14, Item__Base_Unit_of_Measure_CaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(ExcelLineNo, 15, QtyInvoicedCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(ExcelLineNo, 16, CostAmountCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(ExcelLineNo, 17, DiscountAmtCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(ExcelLineNo, 18, InvoicedAmountCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(ExcelLineNo, 19, ProfitAmtCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
    end;

    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; UnderLine: Boolean; NumberFormat: Text[30]; CellType: Option);
    begin
        ExcelBuf.INIT;
        ExcelBuf.VALIDATE("Row No.", RowNo);
        ExcelBuf.VALIDATE("Column No.", ColumnNo);
        ExcelBuf."Cell Value as Text" := CellValue;
        ExcelBuf.Formula := '';
        ExcelBuf.Bold := Bold;
        ExcelBuf.Underline := UnderLine;
        ExcelBuf.NumberFormat := NumberFormat;
        ExcelBuf."Cell Type" := CellType;
        ExcelBuf.INSERT;

        ColumnNo += 1;
    end;

    local procedure EnterReportHeader();
    begin
        EnterCell(1, 1, Customer_Item_SalesCaptionLbl, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(2, 1, STRSUBSTNO(Text000, PeriodText), FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(3, 1, COMPANYNAME, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(5, 1, All_amounts_are_in_LCYCaptionLbl, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
    end;
}

