pageextension 50109 "Company Info" extends "Company Information"
{
    
    actions
    {
        addafter("Responsibility Centers")
        {
            action("Additional Bank Accounts")
            {
                Image = BankAccount;                
                RunObject = Page "Additional Bank Account List";
                //RunPageLink = "Company Name"=field(Name);
            }
        }
        addlast("Application Settings")
        {
            /*action("Backup HIP Extension Data")
            {
                Image = Export;
                Visible = ActionVisible;
                Promoted = true;
                trigger OnAction();
                begin                     
                    BackupCodeunit.BackupHIPData;
                end;
            }
            action("Backup Customer Channel Extension Data")
            {
                Image = Export;
                Visible = ActionVisible;
                Promoted = true;
                trigger OnAction();
                begin                     
                    BackupCodeunit.BackupCustomerChannelData;
                end;
            }
            action("Backup Vendor HFM Extension Data")
            {
                Image = Export;
                Visible = ActionVisible;
                Promoted = true;
                trigger OnAction();
                begin                     
                    BackupCodeunit.BackupVendorHFMData;;
                end;
            }

            action("Backup Additional Bank Extension Data")
            {
                Image = Export;
                Visible = ActionVisible;
                Promoted = true;
                trigger OnAction();
                begin                     
                    BackupCodeunit.BackupAdditionalBanks;
                end;
            }

            action("Backup Open Sales Order Extension Data")
            {
                Image = Export;
                Visible = ActionVisible;
                Promoted = true;
                trigger OnAction();
                begin                     
                    BackupCodeunit.BackupOpenSalesOrders;
                end;
            }

            action("Backup Pstd. Sales Invoice Extension Data")
            {
                Image = Export;
                Visible = ActionVisible;
                Promoted = true;
                trigger OnAction();
                begin                     
                    BackupCodeunit.BackupPostedSalesOrders;
                end;
            }







            action("Import Customer Channel Extension Data")
            {
                Image = Import;
                Visible = ImportActionVisible;
                Promoted = true;
                trigger OnAction();
                begin                     
                    ImportDataCodeunit.ImportCustomerChannelData;
                end;
            }
            action("Import Vendor HFM Extension Data")
            {
                Image = Import;
                Visible = ImportActionVisible;
                Promoted = true;
                trigger OnAction();
                begin                     
                    ImportDataCodeunit.ImportVendorHFMData;
                end;
            }
            action("Import Item HIP Extension Data")
            {
                Image = Import;
                Visible = ImportActionVisible;
                Promoted = true;
                trigger OnAction();
                begin                     
                    ImportDataCodeunit.ImportItemHIPData;
                end;
            }
            action("Import Additional BAnk Extension Data")
            {
                Image = Import;
                Visible = ImportActionVisible;
                Promoted = true;
                trigger OnAction();
                begin                     
                    ImportDataCodeunit.ImportAdditionalBankInfo;
                end;
            }
            action("Import Open Sales Orders Extension Data")
            {
                Image = Import;
                Visible = ImportActionVisible;
                Promoted = true;
                trigger OnAction();
                begin                     
                    ImportDataCodeunit.ImportOpenSalesOrders;
                end;
            }
           action("Import Pstd. Sales Invoice Extension Data")
            {
                Image = Import;
                Visible = ImportActionVisible;
                Promoted = true;
                trigger OnAction();
                begin                     
                    ImportDataCodeunit.ImportPostedSalesInv;
                end;
            } */
        }
    }
    trigger OnOpenPage();
    begin
        ActionVisible := false;
        ImportActionVisible := false; 

        if USERID = 'ZADUBS-NAVNEW1\ADMINISTRATOR' then 
            ActionVisible := true;
        if USERID = 'ZADUBS-NAVNEW1\ADMINISTRATOR' then 
            ImportActionVisible := true;
    end;
    var 
        //BackupCodeunit : Codeunit "Master Data Backup Procedure";
        //ImportDataCodeunit : Codeunit "Master Data Import";
        ActionVisible : Boolean;
        ImportActionVisible : Boolean;
}