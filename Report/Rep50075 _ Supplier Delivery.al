report 50075 "Supplier Performance Report"
{
    // version T20190513.0006
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1; Item)
        {
            RequestFilterFields = "No.", "Replenishment System";

            trigger OnAfterGetRecord();
            var
                PurchRcptLine: Record "Purch. Rcpt. Line";
                LYPurchRcptLine: Record "Purch. Rcpt. Line";
                ItemLedgerEntry: Record "Item Ledger Entry";
                Vendor: Record "Vendor";
                Vendor2: Record "Vendor";
                PurchaseLine: Record "Purchase Line";
                ItemRec: Record "Item";
                ReturnDocNo: Code[20];
            begin
                //RowNo += 1;
                //ColNo := 1;

                LYUnitCostLCY := 0;
                LYUnitCostFCY := 0;
                YTDUnitCostLCY := 0;
                YTDUnitCostFCY := 0;
                LastPurchVolume := 0;
                ConsumptionVolumeLY := 0;
                ConsumptionVolumeYTD := 0;

                POLineEarlyDelYTD := 0;
                POLineTimeDelYTD := 0;
                POLineLateDelYTD := 0;

                POLineEarlyConfirmYTD := 0;
                POLineTimeConfirmYTD := 0;
                POLineLateConfirmYTD := 0;

                POEarlyLeadTimeYTD := 0;
                POOnTimeLeadTimeYTD := 0;
                POLateLeadTimeYTD := 0;

                CurrencyCode := '';

                ItemRec.GET("No.");
                ItemRec.SETRANGE("Date Filter", 0D, LastFiscalYearEndDate);
                ItemRec.CALCFIELDS("Qty. on Purch. Return");
                LYQtyOnReturnOrder := ItemRec."Qty. on Purch. Return";
                ItemRec.SETRANGE("Date Filter", NewFiscalYearStartDate, EndDate);
                ItemRec.CALCFIELDS("Qty. on Purch. Return", Inventory);
                YTDQtyOnReturnOrder := ItemRec."Qty. on Purch. Return";
                SupplierDeliveryReportBuffer."Inventory Level End Of Month" := ItemRec.Inventory;

                //Find Last Purchase Vendor
                PurchRcptLine.RESET;
                PurchRcptLine.SETRANGE(Type, PurchRcptLine.Type::Item);
                PurchRcptLine.SETRANGE("No.", "No.");
                IF PurchRcptLine.FINDLAST THEN BEGIN
                    IF NOT Vendor.GET(PurchRcptLine."Buy-from Vendor No.") THEN
                        Vendor.INIT;
                    /*IF PurchRcptLine."Currency Code" <> '' THEN
                      CurrencyCode := PurchRcptLine."Currency Code"
                    ELSE BEGIN
                      GeneralLedgerSetup.GET;
                      CurrencyCode := GeneralLedgerSetup."LCY Code";
                    END;  */
                END;
                /*
                PurchRcptLine.RESET;
                PurchRcptLine.SETRANGE(Type,PurchRcptLine.Type::Item);
                PurchRcptLine.SETRANGE("Posting Date",0D,LastFiscalYearEndDate);
                PurchRcptLine.SETRANGE("No.","No.");
                IF PurchRcptLine.FINDLAST THEN BEGIN
                  //IF NOT Vendor.GET(PurchRcptLine."Buy-from Vendor No.") THEN
                  //  Vendor.INIT;
                  LYUnitCostLCY  := PurchRcptLine."Unit Cost (LCY)";
                  LYUnitCostFCY := PurchRcptLine."Unit Cost";
                END;
                */

                PurchRcptLine.RESET;
                PurchRcptLine.SETRANGE(Type, PurchRcptLine.Type::Item);
                PurchRcptLine.SETRANGE("Posting Date", NewFiscalYearStartDate, EndDate);
                //PurchRcptLine.SETRANGE("Buy-from Vendor No.",Vendor."No.");
                PurchRcptLine.SETRANGE("No.", "No.");
                IF PurchRcptLine.FINDSET THEN
                    REPEAT
                        Vendor2.GET(PurchRcptLine."Buy-from Vendor No.");

                        SupplierDeliveryReportBuffer.INIT;
                        IF NOT SupplierDeliveryReportBuffer.GET("No.", PurchRcptLine."Buy-from Vendor No.") THEN BEGIN
                            SupplierDeliveryReportBuffer."Item No." := "No.";
                            SupplierDeliveryReportBuffer."Vendor No." := PurchRcptLine."Buy-from Vendor No.";
                            SupplierDeliveryReportBuffer."Item Description" := Description;
                            //SupplierDeliveryReportBuffer."Product Group Code" := "Product Group Code";
                            SupplierDeliveryReportBuffer."Supplier Lead Time From Order" := "Lead Time Calculation";
                            SupplierDeliveryReportBuffer."Unit of Measure" := "Base Unit of Measure";
                            SupplierDeliveryReportBuffer."Vendor Name" := Vendor2.Name;
                            SupplierDeliveryReportBuffer."Supplier Country Code" := Vendor2."Country/Region Code";
                            SupplierDeliveryReportBuffer."Supplier City" := Vendor2.City;
                            SupplierDeliveryReportBuffer."Supplier Street Address" := Vendor2.Address;
                            SupplierDeliveryReportBuffer."Supplier Postal Code" := Vendor2."Post Code";
                            SupplierDeliveryReportBuffer."Supplier Phone No." := Vendor2."Phone No.";
                            SupplierDeliveryReportBuffer."Payment Terms" := Vendor2."Payment Terms Code";
                            SupplierDeliveryReportBuffer."Local ERP Supplier ID" := Vendor2."No.";
                            SupplierDeliveryReportBuffer.Incoterm := Vendor2."Shipment Method Code";
                            //  SupplierDeliveryReportBuffer."Incoterm Location" := Vendor2."Ship From Port";

                            LYPurchRcptLine.RESET;
                            LYPurchRcptLine.SETRANGE(Type, LYPurchRcptLine.Type::Item);
                            LYPurchRcptLine.SETRANGE("Posting Date", 0D, LastFiscalYearEndDate);
                            LYPurchRcptLine.SETRANGE("No.", "No.");
                            LYPurchRcptLine.SETRANGE("Buy-from Vendor No.", SupplierDeliveryReportBuffer."Vendor No.");
                            IF LYPurchRcptLine.FINDLAST THEN BEGIN
                                //IF NOT Vendor.GET(PurchRcptLine."Buy-from Vendor No.") THEN
                                //  Vendor.INIT;
                                //LYUnitCostLCY  := LYPurchRcptLine."Unit Cost (LCY)";
                                //LYUnitCostFCY := LYPurchRcptLine."Unit Cost";
                                SupplierDeliveryReportBuffer."Last Year Last Paid Price LCY" := LYPurchRcptLine."Unit Cost (LCY)";
                                SupplierDeliveryReportBuffer."Last Year Last Paid Price FCY" := LYPurchRcptLine."Unit Cost";
                            END;

                            //LY Number of Claims
                            ReturnShipmentLine.reset;
                            ReturnShipmentLine.SETRANGE(Type, ReturnShipmentLine.Type::Item);
                            ReturnShipmentLine.SETRANGE("No.", "No.");
                            ReturnShipmentLine.SETRANGE("Buy-from Vendor No.", SupplierDeliveryReportBuffer."Vendor No.");
                            ReturnShipmentLine.SETRANGE("Posting Date", 0D, LastFiscalYearEndDate);
                            if ReturnShipmentLine.FindSet then
                                repeat
                                    IF ReturnDocNo <> ReturnShipmentLine."Document No." THEN BEGIN
                                        ReturnDocNo := ReturnShipmentLine."Document No.";
                                        SupplierDeliveryReportBuffer."Number of claims LY" += 1;
                                    END;

                                until ReturnShipmentLine.Next = 0;

                            //YTD Number of Claims
                            ReturnShipmentLine.reset;
                            ReturnShipmentLine.SETRANGE(Type, ReturnShipmentLine.Type::Item);
                            ReturnShipmentLine.SETRANGE("No.", "No.");
                            ReturnShipmentLine.SETRANGE("Buy-from Vendor No.", SupplierDeliveryReportBuffer."Vendor No.");
                            ReturnShipmentLine.SETRANGE("Posting Date", NewFiscalYearStartDate, EndDate);
                            if ReturnShipmentLine.FindSet then
                                repeat
                                    IF ReturnDocNo <> ReturnShipmentLine."Document No." THEN BEGIN
                                        ReturnDocNo := ReturnShipmentLine."Document No.";
                                        SupplierDeliveryReportBuffer."Number of claims YTD" += 1;
                                    END;
                                until ReturnShipmentLine.Next = 0;

                            SupplierDeliveryReportBuffer.INSERT;
                        END;

                        PurchRcptLine.CALCFIELDS("Currency Code");
                        IF PurchRcptLine."Currency Code" <> '' THEN
                            SupplierDeliveryReportBuffer."Invoice Currency" := PurchRcptLine."Currency Code"
                        ELSE BEGIN
                            GeneralLedgerSetup.GET;
                            SupplierDeliveryReportBuffer."Invoice Currency" := GeneralLedgerSetup."LCY Code";
                        END;

                        // Requested
                        IF PurchRcptLine."Actual Received Date" < PurchRcptLine."Expected Receipt Date" THEN
                            SupplierDeliveryReportBuffer."Requested Early Delivery" += 1
                        ELSE
                            IF PurchRcptLine."Actual Received Date" = PurchRcptLine."Expected Receipt Date" THEN
                                SupplierDeliveryReportBuffer."Requested On Time Delivery" += 1
                            ELSE
                                IF PurchRcptLine."Actual Received Date" > PurchRcptLine."Expected Receipt Date" THEN
                                    SupplierDeliveryReportBuffer."Requested Late Delivery" += 1;

                        // Confirmed
                        IF PurchRcptLine."Actual Received Date" < PurchRcptLine."Promised Receipt Date" THEN
                            SupplierDeliveryReportBuffer."Confirmed Early Delivery" += 1
                        ELSE
                            IF PurchRcptLine."Actual Received Date" = PurchRcptLine."Promised Receipt Date" THEN
                                SupplierDeliveryReportBuffer."Confirmed On Time Delivery" += 1
                            ELSE
                                IF PurchRcptLine."Actual Received Date" > PurchRcptLine."Promised Receipt Date" THEN
                                    SupplierDeliveryReportBuffer."Confirmed Late Delivery" += 1;

                        // Agreed
                        IF PurchRcptLine."Actual Received Date" < PurchRcptLine."Planned Receipt Date" THEN
                            SupplierDeliveryReportBuffer."Agreed Early Delivery" += 1
                        ELSE
                            IF PurchRcptLine."Actual Received Date" = PurchRcptLine."Planned Receipt Date" THEN
                                SupplierDeliveryReportBuffer."Agreed On Time Delivery" += 1
                            ELSE
                                IF PurchRcptLine."Actual Received Date" > PurchRcptLine."Planned Receipt Date" THEN
                                    SupplierDeliveryReportBuffer."Agreed Late Delivery" += 1;

                        //YTDUnitCostLCY := PurchRcptLine."Unit Cost (LCY)";
                        //YTDUnitCostFCY := PurchRcptLine."Unit Cost";
                        SupplierDeliveryReportBuffer."YTD Last Paid Price (LCY)" := PurchRcptLine."Unit Cost (LCY)";
                        SupplierDeliveryReportBuffer."YTD Last Paid Price (FCY)" := PurchRcptLine."Unit Cost";


                        //ILE Calculations
                        ItemLedgerEntry.RESET;
                        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                        ItemLedgerEntry.SETRANGE("Item No.", "No.");
                        ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Vendor);
                        ItemLedgerEntry.SETRANGE("Source No.", SupplierDeliveryReportBuffer."Vendor No.");
                        ItemLedgerEntry.setfilter(Quantity, '>%1', 0);
                        IF ItemLedgerEntry.FINDLAST THEN
                            //LastPurchVolume := ItemLedgerEntry.Quantity;
                            SupplierDeliveryReportBuffer."Last Purchased Volume" := ItemLedgerEntry.Quantity;

                        //Last Year Volume
                        ItemLedgerEntry.RESET;
                        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                        ItemLedgerEntry.SETRANGE("Item No.", "No.");
                        ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Vendor);
                        ItemLedgerEntry.SETRANGE("Source No.", SupplierDeliveryReportBuffer."Vendor No.");
                        ItemLedgerEntry.SETRANGE("Posting Date", 0D, LastFiscalYearEndDate);
                        ItemLedgerEntry.SETFILTER(Quantity, '>%1', 0);
                        ItemLedgerEntry.CALCSUMS(Quantity);
                        SupplierDeliveryReportBuffer."Last Year Volume" := ItemLedgerEntry.Quantity;

                        //YTD Volume
                        ItemLedgerEntry.RESET;
                        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                        ItemLedgerEntry.SETRANGE("Item No.", "No.");
                        ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Vendor);
                        ItemLedgerEntry.SETRANGE("Source No.", SupplierDeliveryReportBuffer."Vendor No.");
                        ItemLedgerEntry.SETRANGE("Posting Date", NewFiscalYearStartDate, EndDate);
                        ItemLedgerEntry.CALCSUMS(Quantity);
                        SupplierDeliveryReportBuffer."YTD Volume" := ItemLedgerEntry.Quantity;

                        ItemLedgerEntry.RESET;
                        ItemLedgerEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
                        ItemLedgerEntry.SETRANGE("Item No.", "No.");
                        ItemLedgerEntry.SETRANGE(Positive, FALSE);
                        ItemLedgerEntry.SETRANGE("Posting Date", 0D, LastFiscalYearEndDate);
                        ItemLedgerEntry.SETRANGE("Document Type", ItemLedgerEntry."Document Type"::"Purchase Return Shipment");
                        ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Vendor);
                        ItemLedgerEntry.SETRANGE("Source No.", SupplierDeliveryReportBuffer."Vendor No.");
                        ItemLedgerEntry.CALCSUMS(Quantity);
                        //VolumeRejectedLY := -ItemLedgerEntry.Quantity;
                        SupplierDeliveryReportBuffer."Volume Rejected LY" := -ItemLedgerEntry.Quantity;


                        ItemLedgerEntry.RESET;
                        ItemLedgerEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
                        ItemLedgerEntry.SETRANGE("Item No.", "No.");
                        ItemLedgerEntry.SETRANGE(Positive, FALSE);
                        ItemLedgerEntry.SETRANGE("Posting Date", NewFiscalYearStartDate, EndDate);
                        ItemLedgerEntry.SETRANGE("Document Type", ItemLedgerEntry."Document Type"::"Purchase Return Shipment");
                        ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Vendor);
                        ItemLedgerEntry.SETRANGE("Source No.", SupplierDeliveryReportBuffer."Vendor No.");
                        ItemLedgerEntry.CALCSUMS(Quantity);
                        //VolumeRejectedYTD := -ItemLedgerEntry.Quantity;
                        SupplierDeliveryReportBuffer."Volume Rejected YTD" := -ItemLedgerEntry.Quantity;

                        SupplierDeliveryReportBuffer.MODIFY;

                    UNTIL PurchRcptLine.NEXT = 0;

                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
                ItemLedgerEntry.SETRANGE("Item No.", "No.");
                ItemLedgerEntry.SETRANGE(Positive, FALSE);
                ItemLedgerEntry.SETRANGE("Posting Date", 0D, LastFiscalYearEndDate);
                ItemLedgerEntry.CALCSUMS(Quantity);
                ConsumptionVolumeLY := -ItemLedgerEntry.Quantity;

                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
                ItemLedgerEntry.SETRANGE("Item No.", "No.");
                ItemLedgerEntry.SETRANGE(Positive, FALSE);
                ItemLedgerEntry.SETRANGE("Posting Date", NewFiscalYearStartDate, EndDate);
                ItemLedgerEntry.CALCSUMS(Quantity);
                ConsumptionVolumeYTD := -ItemLedgerEntry.Quantity;


                /*SupplierDeliveryReportBuffer.RESET;
                SupplierDeliveryReportBuffer.FINDSET;
                REPEAT
                  //ILE Calculations
                  ItemLedgerEntry.RESET;
                  ItemLedgerEntry.SETRANGE("Entry Type",ItemLedgerEntry."Entry Type"::Purchase);
                  ItemLedgerEntry.SETRANGE("Item No.","No.");
                  ItemLedgerEntry.SETRANGE("Source Type",ItemLedgerEntry."Source Type"::Vendor);
                  ItemLedgerEntry.SETRANGE("Source No.",SupplierDeliveryReportBuffer."Vendor No.");
                  IF ItemLedgerEntry.FINDLAST THEN
                    //LastPurchVolume := ItemLedgerEntry.Quantity;
                    SupplierDeliveryReportBuffer."Last Purchased Volume" := ItemLedgerEntry.Quantity;
                
                  ItemLedgerEntry.RESET;
                  ItemLedgerEntry.SETCURRENTKEY("Item No.",Open,"Variant Code",Positive,"Location Code","Posting Date");
                  ItemLedgerEntry.SETRANGE("Item No.","No.");
                  ItemLedgerEntry.SETRANGE(Positive,FALSE);
                  ItemLedgerEntry.SETRANGE("Posting Date",0D,LastFiscalYearEndDate);
                  ItemLedgerEntry.SETRANGE("Document Type",ItemLedgerEntry."Document Type"::"Purchase Return Shipment");
                  ItemLedgerEntry.CALCSUMS(Quantity);
                  VolumeRejectedLY := -ItemLedgerEntry.Quantity;
                
                  ItemLedgerEntry.RESET;
                  ItemLedgerEntry.SETCURRENTKEY("Item No.",Open,"Variant Code",Positive,"Location Code","Posting Date");
                  ItemLedgerEntry.SETRANGE("Item No.","No.");
                  ItemLedgerEntry.SETRANGE(Positive,FALSE);
                  ItemLedgerEntry.SETRANGE("Posting Date",NewFiscalYearStartDate,EndDate);
                  ItemLedgerEntry.SETRANGE("Document Type",ItemLedgerEntry."Document Type"::"Purchase Return Shipment");
                  ItemLedgerEntry.CALCSUMS(Quantity);
                  VolumeRejectedYTD := -ItemLedgerEntry.Quantity;
                
                
                  SupplierDeliveryReportBuffer.MODIFY;
                UNTIL SupplierDeliveryReportBuffer.NEXT=0;*/

            end;

            trigger OnPreDataItem();
            begin
                HeaderRowNo := 1;
                RowNo := 2;

                EnterHeader;
                CalculateDate;

                SupplierDeliveryReportBuffer.DELETEALL;
            end;
        }
        dataitem(DataItem2; Integer)
        {
            DataItemTableView = SORTING(Number);

            trigger OnAfterGetRecord();
            begin
                IF Number = 1 THEN
                    SupplierDeliveryReportBuffer.FINDSET
                ELSE
                    SupplierDeliveryReportBuffer.NEXT;

                RowNo += 1;
                ColNo := 1;

                EnterCell(RowNo, ColNo, SupplierDeliveryReportBuffer."Item No.", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, SupplierDeliveryReportBuffer."Item Description", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, SupplierDeliveryReportBuffer."Vendor Name", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, SupplierDeliveryReportBuffer."Product Group Code", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, FORMAT(SupplierDeliveryReportBuffer."Last Year Volume"), FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, FORMAT(SupplierDeliveryReportBuffer."YTD Volume"), FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, FORMAT(SupplierDeliveryReportBuffer."Last Year Last Paid Price LCY"), FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, FORMAT(SupplierDeliveryReportBuffer."YTD Last Paid Price (LCY)"), FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, FORMAT(SupplierDeliveryReportBuffer."Last Year Last Paid Price FCY"), FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, FORMAT(SupplierDeliveryReportBuffer."YTD Last Paid Price (FCY)"), FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //10

                EnterCell(RowNo, ColNo, SupplierDeliveryReportBuffer."Invoice Currency", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, FORMAT(SupplierDeliveryReportBuffer."Supplier Lead Time From Order"), FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, '', FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);  //Keep Blank
                EnterCell(RowNo, ColNo, FORMAT(SupplierDeliveryReportBuffer."Inventory Level End Of Month"), FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, SupplierDeliveryReportBuffer."Unit of Measure", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, FORMAT(SupplierDeliveryReportBuffer."Last Purchased Volume"), FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, FORMAT(ConsumptionVolumeLY), FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, FORMAT(ConsumptionVolumeYTD), FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, SupplierDeliveryReportBuffer."Supplier Country Code", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, SupplierDeliveryReportBuffer."Supplier City", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //20

                EnterCell(RowNo, ColNo, SupplierDeliveryReportBuffer."Supplier Street Address", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, SupplierDeliveryReportBuffer."Supplier Postal Code", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, SupplierDeliveryReportBuffer."Supplier Phone No.", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, '', FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);  //Keep Blank
                EnterCell(RowNo, ColNo, SupplierDeliveryReportBuffer."Payment Terms", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, SupplierDeliveryReportBuffer."Local ERP Supplier ID", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, SupplierDeliveryReportBuffer.Incoterm, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, SupplierDeliveryReportBuffer."Incoterm Location", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, FORMAT(SupplierDeliveryReportBuffer."Volume Rejected LY"), FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, FORMAT(SupplierDeliveryReportBuffer."Volume Rejected YTD"), FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);  //30

                EnterCell(RowNo, ColNo, FORMAT(SupplierDeliveryReportBuffer."Number of claims LY"), FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, FORMAT(SupplierDeliveryReportBuffer."Number of claims YTD"), FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, FORMAT(SupplierDeliveryReportBuffer."Requested Early Delivery"), FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, FORMAT(SupplierDeliveryReportBuffer."Requested On Time Delivery"), FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, FORMAT(SupplierDeliveryReportBuffer."Requested Late Delivery"), FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, FORMAT(SupplierDeliveryReportBuffer."Confirmed Early Delivery"), FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, FORMAT(SupplierDeliveryReportBuffer."Confirmed On Time Delivery"), FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, FORMAT(SupplierDeliveryReportBuffer."Confirmed Late Delivery"), FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, FORMAT(SupplierDeliveryReportBuffer."Agreed Early Delivery"), FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, FORMAT(SupplierDeliveryReportBuffer."Agreed On Time Delivery"), FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                EnterCell(RowNo, ColNo, FORMAT(SupplierDeliveryReportBuffer."Agreed Late Delivery"), FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            end;

            trigger OnPostDataItem();
            begin
                ExcelBuf.CreateBook(ServerFileName, 'Supplier Performance');

                ExcelBuf.WriteSheet(
                  //PADSTR(STRSUBSTNO('%1 %2','Pitso','Pitso Test'),30),
                  'Supplier Delivery Performance',
                  COMPANYNAME,
                  USERID);

                ExcelBuf.CloseBook;
                ExcelBuf.SetFriendlyFilename(ReportNameCaptionLbl);
                ExcelBuf.OpenExcel;
                ExcelBuf.GiveUserControl;
            end;

            trigger OnPreDataItem();
            begin
                SupplierDeliveryReportBuffer.RESET;
                SETRANGE(Number, 1, SupplierDeliveryReportBuffer.COUNT);
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
                    field(EndDate; EndDate)
                    {
                        Caption = 'Ending Date';
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

    var
        ReportNameCaptionLbl: Label 'Supplier Delivery Performance Report';
        PageCaptionLbl: Label 'Page';
        UserIDCaptionLbl: Label 'User ID';
        CompanyNameCaptionLbl: Label 'Company Name';
        ReportFiltersCaptionLbl: Label 'Report Filters:';
        ItemNoCaptionLbl: Label 'Item No.';
        DescriptionCaptionLbl: Label 'Description';
        LastPurchVendorCaptionLbl: Label 'Last Purchase Vendor';
        ProductGroupCodeCaptionLbl: Label 'Product Group Code';
        LastYearVolumeCaptionLbl: Label 'Last Year Volume';
        YTDVolumeCaptionLbl: Label 'YTD Volume';
        LastYearLastPaidCaptionLBl: Label 'Last Year Last Paid Price (LCY)';
        YTDLastPaidCaptionLbl: Label 'YTD Last Paid Price (LCY)';
        LYLastPaidPriceFCYCaptionLbl: Label 'Last Year Last Paid Price (FCY)';
        YTDLastPaidFCYCaptionLbl: Label 'YTD Last Paid Price (FCY)';
        InvoiceCaptionLbl: Label 'Invoice Currency';
        SupplierLeadTimeCaptionLbl: Label 'Supplier Lead Time From Order To Delivery';
        ArticleMinimumQtyCaptionnLbl: Label 'Article Minimum Order Quantity';
        InventoryLevelCaptionLbl: Label 'Inventory Level End of Month';
        UOMCaptionLbl: Label 'Unit of Measure';
        LastPurchVolumeCaptionLbl: Label 'Last Purchased Volume';
        ConsVolumeLYCaptionLbl: Label 'Consumption Volume Last Year';
        ConsVolumeYTDCaptionLBl: Label 'Consumption Volume YTD';
        SupplierCountryCodeCaptionLbl: Label 'Supplier Country Code';
        SupplierCityCaptionLbl: Label 'Supplier City';
        SupplierStreetCaptionLbl: Label 'Supplier Street Address';
        SupplierPostalCaptionLbl: Label 'Supplier Postal Code';
        SupplierPhoneCaptionLbl: Label 'Supplier Phone No.';
        MaterialStandardCodeCaptionLbl: Label 'Material Standard Code';
        PaymentTermsCaptionLbl: Label 'Payment Terms';
        LocalERPCaptionLbl: Label 'Local ERP Supplier ID';
        IncotermCaptionLbl: Label 'Incoterm';
        IncoTermLocationCaptionLbl: Label 'Incoterm Location';
        VolumeRejectedLYCaptionLbl: Label 'Volume Rejected LY';
        VolumeRejectedYTDCaptionLbl: Label 'Volume Rejected YTD';
        NumberOfClaimsLYCaptionLbl: Label 'Number of claims LY';
        NumberOfClaimsYTDCaptionL: Label 'Number of claims YTD';
        POLineEarly1Caption1Lbl: Label 'PO Line Count Early Delivery against Requested Date YTD';
        POLineTime1CaptionLbl: Label 'PO Line Count On Time Delivery against Requested Date YTD';
        POLineLateDelCaptionLbl: Label 'PO Line Count Late Delivery against Requested Date YTD';
        POEarlyDel1stDateCaptionLbl: Label 'PO Line Count Early Delivery against 1st Confirmed Date YTD';
        POTimeDel1stCaptionLbl: Label 'PO Line Count On Time Delivery against 1st Confirmed Date YTD';
        POLateDel1stCaptionLbl: Label 'PO Line Count Late Delivery against 1st Confirmed Date YTD';
        POEarlyDelAAgreedCaptionLbl: Label 'PO Line Count Early Delivery against Agreed Lead Time YTD';
        POTimeDelAgreedCaptionLbl: Label 'PO Line Count On Time Delivery against Agreed Lead Time YTD';
        POLateDelAgreedCaptionLbl: Label 'PO Line Count Late Delivery against Agreed Lead Time YTD';
        ExcelBuf: Record "Excel Buffer" temporary;
        GeneralLedgerSetup: Record "General Ledger Setup";
        SupplierDeliveryReportBuffer: Record "Supplier Delivery Report Buffe" temporary;
        ReturnShipmentLine: Record "Return Shipment Line";
        EndDate: Date;
        RowNo: Integer;
        HeaderRowNo: Integer;
        ColNo: Integer;
        ServerFileName: Text;
        LastFiscalYearEndDate: Date;
        NewFiscalYearStartDate: Date;
        LYUnitCostLCY: Decimal;
        LYUnitCostFCY: Decimal;
        YTDUnitCostLCY: Decimal;
        YTDUnitCostFCY: Decimal;
        LYQtyOnReturnOrder: Decimal;
        YTDQtyOnReturnOrder: Decimal;
        LastPurchVolume: Decimal;
        ConsumptionVolumeLY: Decimal;
        ConsumptionVolumeYTD: Decimal;
        VolumeRejectedLY: Decimal;
        VolumeRejectedYTD: Decimal;
        NoOfClaimsLY: Decimal;
        NoOfClaimsYTD: Decimal;
        POLineEarlyDelYTD: Integer;
        POLineTimeDelYTD: Integer;
        POLineLateDelYTD: Integer;
        POLineEarlyConfirmYTD: Decimal;
        POLineTimeConfirmYTD: Decimal;
        POLineLateConfirmYTD: Decimal;
        CurrencyCode: Code[10];
        POEarlyLeadTimeYTD: Decimal;
        POOnTimeLeadTimeYTD: Decimal;
        POLateLeadTimeYTD: Decimal;

    local procedure EnterHeader();
    begin
        ColNo := 1;

        EnterCell(HeaderRowNo, ColNo, ItemNoCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, DescriptionCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, LastPurchVendorCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, ProductGroupCodeCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, LastYearVolumeCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, YTDVolumeCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, LastYearLastPaidCaptionLBl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, YTDLastPaidCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, LYLastPaidPriceFCYCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, YTDLastPaidFCYCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, InvoiceCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);

        EnterCell(HeaderRowNo, ColNo, SupplierLeadTimeCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, ArticleMinimumQtyCaptionnLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, InventoryLevelCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, UOMCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, LastPurchVolumeCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, ConsVolumeLYCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, ConsVolumeYTDCaptionLBl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, SupplierCountryCodeCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, SupplierCityCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);

        EnterCell(HeaderRowNo, ColNo, SupplierStreetCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, SupplierPostalCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, SupplierPhoneCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, MaterialStandardCodeCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, PaymentTermsCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, LocalERPCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, IncotermCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, IncoTermLocationCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, VolumeRejectedLYCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, VolumeRejectedYTDCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);

        EnterCell(HeaderRowNo, ColNo, NumberOfClaimsLYCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, NumberOfClaimsYTDCaptionL, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, POLineEarly1Caption1Lbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, POLineTime1CaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, POLineLateDelCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, POEarlyDel1stDateCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, POTimeDel1stCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, POLateDel1stCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, POEarlyDelAAgreedCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, POTimeDelAgreedCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
        EnterCell(HeaderRowNo, ColNo, POLateDelAgreedCaptionLbl, TRUE, TRUE, '', ExcelBuf."Cell Type"::Text);
    end;

    local procedure EnterCell(RowNo: Integer; var ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; UnderLine: Boolean; NumberFormat: Text[30]; CellType: Option);
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

    local procedure CalculateDate();
    var
        AccountingPeriod: Record "Accounting Period";
    begin
        AccountingPeriod.RESET;
        AccountingPeriod.SETFILTER("Starting Date", '<%1', EndDate);
        AccountingPeriod.SETRANGE("New Fiscal Year", TRUE);
        AccountingPeriod.FINDLAST;

        NewFiscalYearStartDate := AccountingPeriod."Starting Date";
        LastFiscalYearEndDate := CALCDATE('-1D', AccountingPeriod."Starting Date");
    end;
}

