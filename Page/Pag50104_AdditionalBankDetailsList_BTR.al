page 50104 "Additional Bank Account List"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    CardPageID = "Additional Bank Account Card2";
    PageType = List;
    SourceTable = "Additional Bank Account";
    Caption = 'Additional Bank Account List';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bank Name";"Bank Name")
                {
                }
                field("Bank Branch No.";"Bank Branch No.")
                {
                }
                field("Bank Account No.";"Bank Account No.")
                {
                }
                field("Payment Routing No.";"Payment Routing No.")
                {
                }
                field("Giro No.";"Giro No.")
                {
                }
                field("SWIFT Code";"SWIFT Code")
                {
                }
                field(IBAN;IBAN)
                {
                }
            }
        }
    }

    actions
    {
    }
}

