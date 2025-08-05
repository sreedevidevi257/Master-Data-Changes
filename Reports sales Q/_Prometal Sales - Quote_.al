report 50006 "Prometal Sales - Quote"
{
  // version T20190513.0006
  UsageCategory = ReportsAndAnalysis;
  ApplicationArea = All;
  DefaultLayout = RDLC;
  RDLCLayout = './ReportLayout/Prometal/Prometal Sales Quote.rdl';
  Caption = 'Sales Quote';

  dataset
  {
  dataitem(Header;
  "Sales Header")
  {
  DataItemTableView = SORTING("Document Type", "No.");
  RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";

  //ReqFilterHeading = 'Pro Forma Invoice';
  column(DocumentDate;
  FORMAT("Document Date", 0, 4))
  {
  }
  column(CompanyPicture;
  CompanyInformation.Picture)
  {
  }
  column(CompanyEMail;
  CompanyInformation."E-Mail")
  {
  }
  column(CompanyHomePage;
  CompanyInformation."Home Page")
  {
  }
  column(CompanyPhoneNo;
  CompanyInformation."Phone No.")
  {
  }
  column(CompanyVATRegNo;
  CompanyInformation."VAT Registration No.")
  {
  }
  column(CompanyAddress1;
  CompanyAddress[1])
  {
  }
  column(CompanyAddress2;
  CompanyAddress[2])
  {
  }
  column(CompanyAddress3;
  CompanyAddress[3])
  {
  }
  column(CompanyAddress4;
  CompanyAddress[4])
  {
  }
  column(CompanyAddress5;
  CompanyAddress[5])
  {
  }
  column(CompanyAddress6;
  CompanyAddress[6])
  {
  }
  column(CustomerAddress1;
  CustomerAddress[1])
  {
  }
  column(CustomerAddress2;
  CustomerAddress[2])
  {
  }
  column(CustomerAddress3;
  CustomerAddress[3])
  {
  }
  column(CustomerAddress4;
  CustomerAddress[4])
  {
  }
  column(CustomerAddress5;
  CustomerAddress[5])
  {
  }
  column(CustomerAddress6;
  CustomerAddress[6])
  {
  }
  column(CustomerAddress7;
  CustomerAddress[7])
  {
  }
  column(CustomerAddress8;
  CustomerAddress[8])
  {
  }
  column(YourReference;
  "Your Reference")
  {
  }
  column(ExternalDocumentNo;
  "External Document No.")
  {
  }
  column(DocumentNo;
  "No.")
  {
  }
  column(CompanyLegalOffice;
  CompanyInformation.GetLegalOffice)
  {
  }
  column(SalesPersonName;
  SalespersonPurchaserName)
  {
  }
  column(ShipmentMethodDescription;
  ShipmentMethodDescription)
  {
  }
  column(Currency;
  CurrencyCode)
  {
  }
  column(CustomerVATRegNo;
  CustomerVATRegistrationNo)
  {
  }
  column(PageLbl;
  PageLbl)
  {
  }
  column(DocumentTitleLbl;
  DocumentTitleLbl)
  {
  }
  column(YourReferenceLbl;
  FIELDCAPTION("Your Reference"))
  {
  }
  column(ExternalDocumentNoLbl;
  FIELDCAPTION("External Document No."))
  {
  }
  column(CompanyLegalOfficeLbl;
  CompanyInformation.GetLegalOfficeLbl)
  {
  }
  column(SalesPersonLbl;
  SalesPersonLblText)
  {
  }
  column(EMailLbl;
  CompanyInformation.FIELDCAPTION("E-Mail"))
  {
  }
  column(HomePageLbl;
  CompanyInformation.FIELDCAPTION("Home Page"))
  {
  }
  column(CompanyPhoneNoLbl;
  CompanyInformation.FIELDCAPTION("Phone No."))
  {
  }
  column(ShipmentMethodDescriptionLbl;
  DummyShipmentMethod.TABLECAPTION)
  {
  }
  column(CurrencyLbl;
  DummyCurrency.TABLECAPTION)
  {
  }
  column(ItemLbl;
  Item.TABLECAPTION)
  {
  }
  column(TariffLbl;
  Item.FIELDCAPTION("Tariff No."))
  {
  }
  column(UnitPriceLbl;
  Item.FIELDCAPTION("Unit Price"))
  {
  }
  column(CountryOfManufactuctureLbl;
  CountryOfManufactuctureLbl)
  {
  }
  column(AmountLbl;
  Line.FIELDCAPTION(Amount))
  {
  }
  column(VATPctLbl;
  Line.FIELDCAPTION("VAT %"))
  {
  }
  column(VATAmountLbl;
  DummyVATAmountLine.VATAmountText)
  {
  }
  column(TotalWeightLbl;
  TotalWeightLbl)
  {
  }
  column(TotalAmountLbl;
  TotalAmountLbl)
  {
  }
  column(TotalAmountInclVATLbl;
  TotalAmountInclVATLbl)
  {
  }
  column(QuantityLbl;
  Line.FIELDCAPTION(Quantity))
  {
  }
  column(NetWeightLbl;
  Line.FIELDCAPTION("Net Weight"))
  {
  }
  column(DeclartionLbl;
  DeclartionLbl)
  {
  }
  column(SignatureLbl;
  SignatureLbl)
  {
  }
  column(SignatureNameLbl;
  SignatureNameLbl)
  {
  }
  column(SignaturePositionLbl;
  SignaturePositionLbl)
  {
  }
  column(VATRegNoLbl;
  CompanyInformation.FIELDCAPTION("VAT Registration No."))
  {
  }
  column(BillToCust_Caption;
  BillToCustCaptionLbl)
  {
  }
  column(SN_Caption;
  SNCaptionLbl)
  {
  }
  column(No_Caption;
  NoCaptionLbl)
  {
  }
  column(ManufacturerCode_Caption;
  ManufactureCodeCaptionLbl)
  {
  }
  column(Brand_Caption;
  BrandCaptionLbl)
  {
  }
  column(Origin_Caption;
  OriginCaptionLbl)
  {
  }
  column(HSCode_Caption;
  HSCodeCaptionLbl)
  {
  }
  column(Qty_Caption;
  QtyCaptionLbl)
  {
  }
  column(UoM_Caption;
  UoMCaptionLbl)
  {
  }
  column(Amount_Caption;
  AmountCaptionLbl)
  {
  }
  column(CompanyInfo_Name;
  CompanyInformation.Name)
  {
  }
  column(Shipment_Date;
  FORMAT("Shipment Date", 0, 4))
  {
  }
  column(Document_Date;
  "Document Date")
  {
  }
  column(BillTo_Customer_No;
  "Bill-to Customer No.")
  {
  }
  column(Company_Detail_1;
  CompanyDetailsLine1)
  {
  }
  column(Company_Detail_2;
  CompanyDetailsLine2)
  {
  }
  column(Payment_Terms;
  PaymentTerms.Description)
  {
  }
  column(BankName;
  BankName)
  {
  }
  column(BankAccountNo;
  BankAccountNo)
  {
  }
  column(IBAN;
  Iban)
  {
  }
  column(SWIFT;
  Swift)
  {
  }
  column(BlanketSalesOrderNoLbl;
  BlanketSalesOrderNoLbl)
  {
  }
  column(ProjectNameCaptionLbl;
  ProjectNameCaptionLbl)
  {
  }
  column(ScopeOfWorkCaptionLbl;
  ScopeOfWorkCaptionLbl)
  {
  }
  column(ProjectName;
  "Project  Code")
  {
  }
  column(BlanketSalesOrderNo;
  "Blanket  Order No.")
  {
  }
  column(ScopeOfWork;
  "Scope of work")
  {
  }
  column(Cust_PhoneNo;
  CustRec."Phone No.")
  {
  }
  column(Cust_VATReg;
  CustRec."VAT Registration No.")
  {
  }
  column(PhoneNo_Caption;
  PhoneNoCaptionLbl)
  {
  }
  column(Email_Caption;
  EmailCaptionLbl)
  {
  }
  column(VATRegNo_Caption;
  VATRegNoCaptionLbl)
  {
  }
  column(InvoiceDate_Caption;
  InvoiceDateCaptionLbl)
  {
  }
  column(ExtDocNo_Caption;
  ExtDocNoCaptionLbl)
  {
  }
  column(DueDate_Caption;
  DueDateCaptionLbl)
  {
  }
  column(Company_Country;
  CompanyInformation."Country/Region Code")
  {
  }
  column(DueDate_;
  "Due Date")
  {
  }
  column(ProFormaInvNo;
  ProFormaInvNo)
  {
  }
  column(QuoteValidUntilDate;
  "Quote Valid Until Date")
  {
  }
  column(QuoteValidUntilCaptionLbl;
  QuoteValidUntilCaptionLbl)
  {
  }
  column(Assigned_User_ID;
  "Assigned User ID")
  {
  }
  column(TotalAmountCaptionLbl;
  STRSUBSTNO(TotalAmountCaptionLbl, CurrencyCodeVal))
  {
  }
  dataitem(Line;
  "Sales Line")
  {
  DataItemLink = "Document Type"=FIELD("Document Type"), "Document No."=FIELD("No.");
  DataItemLinkReference = Header;
  DataItemTableView = SORTING("Document No.", "Line No.");

  column(ItemDescription;
  Description)
  {
  }
  column(CountryOfManufacturing;
  Item."Country/Region of Origin Code")
  {
  }
  column(HS_Code;
  Item."Tariff No.")
  {
  }
  column(Quantity;
  Quantity)
  {
  }
  column(Price;
  LinePrice)
  {
  }
  column(NetWeight;
  "Net Weight")
  {
  }
  column(LineAmount;
  LineAmount)
  {
  }
  column(VATPct;
  "VAT %")
  {
  }
  column(VATAmount;
  VATAmount)
  {
  }
  column(SN_Number;
  SNNumberText)
  {
  }
  column(Item_No;
  "No.")
  {
  }
  column(Item_ManufacturerCode;
  Item."Vendor Item No.")
  {
  }
  column(Item_Brand;
  Item."Service Item Group")
  {
  }
  column(UOM_;
  "Unit of Measure Code")
  {
  }
  column(Qty_;
  Quantity)
  {
  }
  column(Item_Description;
  Description)
  {
  }
  column(Item_Description_Caption;
  DescriptionCaptionLbl)
  {
  }
  column(SalesLine_DoorType_;
  "Door  Type/No.")
  {
  }
  column(SalesLine_FireRAting_;
  "Fire  Rating")
  {
  }
  column(SalesLine_STCRating_;
  "STC  Rating")
  {
  }
  column(SalesLine_SizeCaption;
  SalesLineSizeCaptionLbl)
  {
  }
  column(SalesLine_DoorType_Caption;
  DoorTypeCaptionLbl)
  {
  }
  column(SalesLine_FireRating_Caption;
  FireRatingCaptionLbl)
  {
  }
  column(SalesLine_STCRAting_Caption;
  STCRatingCaptionLbl)
  {
  }
  column(SalesLine_DiscountCaption;
  DiscountPerentageCaptionLbl)
  {
  }
  column(SalesLine_DiscountPercent;
  Line."Line Discount %")
  {
  }
  column(SalesLine_Size;
  "Size_")
  {
  }
  column(Quote_Location;
  "Quote Location")
  {
  }
  column(Width;
  "Width_")
  {
  }
  column(Height;
  "Height_")
  {
  }
  column(Jamb__Depth;
  "Jamb  Depth")
  {
  }
  column(Leaf_Thickness;
  "Leaf Thickness")
  {
  }
  column(No__of_Leaves;
  "No. of Leaves")
  {
  }
  column(Access_Control;
  "Access  Control")
  {
  }
  column(Ironmongery_Set;
  "Ironmongery Set")
  {
  }
  column(Ironmongery_Rate;
  "Ironmongery Rate")
  {
  }
  column(Door_Frame_Price;
  "Door &  Frame Price")
  {
  }
  column(Installation_Price;
  "Installation  Price")
  {
  }
  column(Total_Amount;
  "Total  Amount")
  {
  }
  column(Frame_Sheet_Thickness;
  "Frame Sheet Thickness")
  {
  }
  column(Leaf_Sheet_Thickness;
  "Leaf Sheet Thickness")
  {
  }
  column(Infill;
  Infill)
  {
  }
  column(TotalLinePrices;
  TotalLinePrices)
  {
  }
  trigger OnAfterGetRecord();
  begin
    IF NOT Item.GET("No.")THEN Item.INIT;
    IF Quantity = 0 THEN BEGIN
      LinePrice:="Unit Price";
      LineAmount:=0;
      VATAmount:=0;
    END
    ELSE
    BEGIN
      //LinePrice := ROUND(Amount / Quantity);
      //LineAmount := ROUND(Amount * "Qty. to Invoice" / Quantity);
      //VATAmount := ROUND(("Amount Including VAT" - Amount) * "Qty. to Invoice" / Quantity);
      LinePrice:=ROUND(Amount / Quantity);
      LineAmount:=Amount; //ROUND(Amount * Quantity);
      VATAmount:=ROUND(("Amount Including VAT" - Amount)); // * "Qty. to Invoice" / Quantity);
      TotalAmount+=LineAmount;
      TotalWeight+=ROUND(Quantity * "Net Weight");
      TotalVATAmount+=VATAmount;
      TotalAmountInclVAT+=ROUND("Amount Including VAT"); // * Quantity);
    END;
    SNNumber+=1;
    SNNumberText:=FORMAT(SNNumber);
    IF "No." = '' THEN SNNumberText:='';
    DoorFrameRateVal:=0;
    IronmonRateVal:=0;
    InstallRateVal:=0;
    TotalLinePrices:=0;
    //Evaluate(DoorFrameRateVal,"Door &  Frame Price");
    //Evaluate(IronmonRateVal,"Ironmongery Rate");
    //Evaluate(InstallRateVal,"Installation  Price");
    TotalLinePrices+=(DoorFrameRateVal + IronmonRateVal + InstallRateVal);
  end;
  trigger OnPreDataItem();
  begin
    TotalWeight:=0;
    TotalAmount:=0;
    TotalVATAmount:=0;
    TotalAmountInclVAT:=0;
    //SETRANGE(Type,Type::Item);
    SNNumber:=0;
  //SETFILTER("Qty. to Invoice",'<>%1',0);
  end;
  }
  dataitem(Totals;
  Integer)
  {
  DataItemTableView = SORTING(Number);
  MaxIteration = 1;

  column(TotalWeight;
  TotalWeight)
  {
  }
  column(TotalValue;
  TotalAmount)
  {
  }
  column(TotalVATAmount;
  TotalVATAmount)
  {
  }
  column(TotalAmountInclVAT;
  TotalAmountInclVAT)
  {
  }
  }
  trigger OnAfterGetRecord();
  var RecBankAcc: Record "Additional Bank Account";
  lGLSetup: Record "General Ledger Setup";
  begin
    FormatDocumentFields(Header);
    IF NOT PaymentTerms.GET("Payment Terms Code")THEN PaymentTerms.INIT;
    BankAccountNo:=CompanyInformation."Bank Account No.";
    BankName:=CompanyInformation."Bank Name";
    Iban:=CompanyInformation.IBAN;
    Swift:=CompanyInformation."SWIFT Code";
    IF "Use Bank Account" <> '' THEN Begin
      RecBankAcc.SETRANGE("Bank Name", "Use Bank Account");
      IF RecBankAcc.FindFirst THEN BEGIN
        BankAccountNo:=RecBankAcc."Bank Account No.";
        BankName:=RecBankAcc."Bank Name";
        IBAN:=RecBankAcc.IBAN;
        SWIFT:=RecBankAcc."SWIFT Code";
      end;
    END;
    If not CustRec.get("Sell-to Customer No.")then CustRec.init;
    ProFormaInvNo:="No.";
    CurrencyCodeVal:='';
    if "Currency Code" <> '' THEN CurrencyCodeVal:="Currency Code"
    else
    begin
      lGLSetup.get;
      CurrencyCodeVal:=lGLSetup."Local Currency Symbol";
    end;
  end;
  }
  }
  requestpage
  {
  SaveValues = true;

  layout
  {
  }
  actions
  {
  }
  }
  labels
  {
  }
  trigger OnInitReport();
  begin
    CompanyInformation.GET;
    CompanyInformation.CALCFIELDS(Picture);
  end;
  var CompanyInformation: Record "Company Information";
  DocumentTitleLbl: Label 'Pro Forma Invoice';
  PageLbl: Label 'Page';
  Item: Record "Item";
  DummyVATAmountLine: Record "VAT Amount Line";
  DummyShipmentMethod: Record "Shipment Method";
  DummyCurrency: Record "Currency";
  PaymentTerms: Record "Payment Terms";
  CustRec: Record Customer;
  CompanyAddress: array[8]of Text[50];
  CustomerAddress: array[8]of Text[50];
  SalesPersonLblText: Text[50];
  CountryOfManufactuctureLbl: Label 'Country';
  TotalWeightLbl: Label 'Total Weight';
  SalespersonPurchaserName: Text;
  ShipmentMethodDescription: Text;
  CustomerVATRegistrationNo: Text;
  TotalAmountLbl: Text[50];
  TotalAmountInclVATLbl: Text[50];
  CurrencyCode: Code[10];
  TotalWeight: Decimal;
  TotalAmount: Decimal;
  DeclartionLbl: Label 'For customs purposes only.';
  SignatureLbl: Label 'For and on behalf of the above named company:';
  SignatureNameLbl: Label 'Name (in print) Signature';
  SignaturePositionLbl: Label 'Position in company';
  TotalVATAmount: Decimal;
  TotalAmountInclVAT: Decimal;
  LinePrice: Decimal;
  LineAmount: Decimal;
  VATAmount: Decimal;
  BillToCustCaptionLbl: Label 'Bill-to Customer No.';
  SNCaptionLbl: Label 'SI. No.';
  NoCaptionLbl: Label 'No.';
  ManufactureCodeCaptionLbl: Label 'Manufacturer Code';
  BrandCaptionLbl: Label 'Brand';
  OriginCaptionLbl: Label 'Origin';
  HSCodeCaptionLbl: Label 'HS Code';
  QtyCaptionLbl: Label 'Qty';
  UoMCaptionLbl: Label 'UoM';
  AmountCaptionLbl: Label 'Amount';
  SNNumber: Integer;
  DescriptionCaptionLbl: Label 'Description';
  CompanyDetailsLine1: Text[1024];
  CompanyDetailsLine2: Text[1024];
  BankAccountNo: Code[20];
  BankName: Text[50];
  Iban: Code[50];
  Swift: Code[20];
  SNNumberText: Text[10];
  BlanketSalesOrderNoLbl: Label 'Blanket Sales Order No.';
  ProjectNameCaptionLbl: Label 'Project Name';
  ScopeOfWorkCaptionLbl: Label 'Scope of work';
  PhoneNoCaptionLbl: Label 'Phone No.';
  EmailCaptionLbl: Label 'Email:';
  VATRegNoCaptionLbl: Label 'VAT Reg No.';
  InvoiceDateCaptionLbl: Label 'Invoice Date';
  ExtDocNoCaptionLbl: Label 'Ext. Doc No.';
  DueDateCaptionLbl: Label 'Due Date';
  CompanyCountry: Text[50];
  SalesLineSizeCaptionLbl: Label 'Size';
  DoorTypeCaptionLbl: Label 'Door Type';
  FireRatingCaptionLbl: Label 'Fire Rating';
  STCRatingCaptionLbl: Label 'STC Rating';
  DiscountPerentageCaptionLbl: Label 'Discount %';
  ProFormaInvNo: Code[20];
  FrameSheetThickness: Text[10];
  LeafSheetThickness: Text[10];
  InFill: Text[20];
  QuoteValidUntilDate: Date;
  QuoteValidUntilCaptionLbl: Label 'Quote Valid Until';
  TotalAmountCaptionLbl: Label 'Total Amount %1';
  TotalLinePrices: Decimal;
  DoorFrameRateVal: Decimal;
  IronmonRateVal: Decimal;
  InstallRateVal: Decimal;
  CurrencyCodeVal: Code[10];
  local procedure FormatDocumentFields(SalesHeader: Record "Sales Header");
  var GeneralLedgerSetup: Record "General Ledger Setup";
  SalespersonPurchaser: Record "Salesperson/Purchaser";
  ShipmentMethod: Record "Shipment Method";
  ResponsibilityCenter: Record "Responsibility Center";
  Customer: Record Customer;
  FormatDocument: Codeunit "Format Document";
  FormatAddress: Codeunit "Format Address";
  TotalAmounExclVATLbl: Text[50];
  begin
    WITH SalesHeader DO BEGIN
      Customer.GET("Sell-to Customer No.");
      CustomerVATRegistrationNo:=Customer."VAT Registration No.";
      FormatDocument.SetSalesPerson(SalespersonPurchaser, "Salesperson Code", SalesPersonLblText);
      SalespersonPurchaserName:=SalespersonPurchaser.Name;
      FormatDocument.SetShipmentMethod(ShipmentMethod, "Shipment Method Code", "Language Code");
      ShipmentMethodDescription:=ShipmentMethod.Description;
      FormatAddress.GetCompanyAddr("Responsibility Center", ResponsibilityCenter, CompanyInformation, CompanyAddress);
      FormatAddress.SalesHeaderBillTo(CustomerAddress, SalesHeader);
      CompanyDetailsLine1:=CompanyAddress[1] + ', ' + CompanyInformation."Address 2";
      IF "Currency Code" = '' THEN BEGIN
        GeneralLedgerSetup.GET;
        GeneralLedgerSetup.TESTFIELD("LCY Code");
        CurrencyCode:=GeneralLedgerSetup."LCY Code";
      END
      ELSE
        CurrencyCode:="Currency Code";
      FormatDocument.SetTotalLabels("Currency Code", TotalAmountLbl, TotalAmountInclVATLbl, TotalAmounExclVATLbl);
    END;
  end;
}
